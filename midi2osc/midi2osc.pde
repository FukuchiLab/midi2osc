// KORG nanoKONTROL2 のノブ・スライダーの値を OSC で送信するプログラム。
// OSC アドレスおよびデータは以下の通り。
// ノブ
//   /knob ID VALUE…IDは左から0〜7。VALUE は 0〜127 の整数
// スライダー
//   /slider ID VALUE…IDは左から0〜7。VALUE は 0〜127 の整数
// ボタン
//   /button LABEL ID VALUE`: LABEL は文字列として渡される。VALUE は 0 or 1
//    - コントロールグループのボタンの場合は、LABEL は S / M / R。ID は左から 0〜7。
//    - 再生・停止ボタン類の場合は、ID は 8 となる。LABEL は下記
//      - rewind / fastforward / stop / play / rec

import netP5.*;
import oscP5.*;

import themidibus.*;
import javax.sound.midi.MidiMessage;

// 送信先アドレス
String target_host = "127.0.0.1";

// 送信先ポート番号
int target_port = 8888;

// midi2osc 側の受信ポート番号
// midi2osc を複数立ち上げるときは、この番号を1ずつ変えていくとよい
int listening_port = 12000;

// MIDI デバイス名。ここで指定した文字列を含む、最初に見付かったものを使用する
String device_pattern = "nanoKONTROL2";

OscP5 osc;
NetAddress target;

Slider[] sliders;
Knob[] knobs;
ButtonGroup[] bgroups;
TransportPanel transportPanel;

MidiBus midiBus;

void setup() {
  size(1000, 500);

  osc = new OscP5(this, listening_port);
  target = new NetAddress(target_host, target_port);

  sliders = new Slider[8];
  knobs = new Knob[8];
  bgroups = new ButtonGroup[8];
  transportPanel = new TransportPanel(300, 75);

  for (int i=0; i<8; i++) {
    knobs[i] = new Knob(i, i * 120 + 100, 200, 50);
    sliders[i] = new Slider(i, i * 120 + 80, 260, 40, 200);
    bgroups[i] = new ButtonGroup(i, i * 120 + 50, 280);
  }

  String[] devices = MidiBus.availableInputs();
  boolean found = false;
  String device_name = "";
  if (devices != null) {
    println("Device matching...");
    for (int i = 0; i < devices.length; i++) {
      println(i + ": " + devices[i]);
      if (devices[i].contains(device_pattern)) {
        device_name = devices[i];
        found = true;
        println("This device has been matched.");
        break;
      }
    }
  }
  if (!found) {
    println("No device has been matched to \"" + device_pattern + "\".");
  } else {
    midiBus = new MidiBus();
    midiBus.registerParent(this);
    midiBus.addInput(device_name);
  }

  background(0);
  textSize(20);
  fill(255);
  noStroke();
  text(String.format("Target: %s:%d", target_host, target_port), 10, 20);
  text("OSC address:", 10, 50);
  text("/knob ID VALUE", 20, 70);
  text("/slider ID VALUE", 20, 90);
  text("/button LABEL ID VALUE", 20, 110);
}

void draw() {
  if (midiBus == null) {
    background(128, 0, 0);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("No device found.", width / 2, height / 2);
    return;
  }
  noStroke();
  fill(0);
  rect(0, 140, width, height - 140);
  rect(240, 0, width - 240, 140);

  for (int i=0; i<8; i++) {
    sliders[i].draw();
    knobs[i].draw();
    bgroups[i].draw();
  }
  transportPanel.draw();
}

void midiMessage(MidiMessage message) {
  byte[] msg = message.getMessage();
  int id = (int)msg[1];
  int val = (int)msg[2];

  int type = (int)(id / 16);
  int num = id % 16;
  println(type, num, val);

  if (num < 8) {
    switch(type) {
    case 0:
      sliders[num].setValue(val);
      break;
    case 1:
      knobs[num].setValue(val);
      break;
    case 2:
      bgroups[num].setStatus(2, val > 0);
      break;
    case 3:
      bgroups[num].setStatus(1, val > 0);
      break;
    case 4:
      bgroups[num].setStatus(0, val > 0);
      break;
    default:
      break;
    }
  } else if (type == 2) {
    if (num >= 9 && num < 14) {
      transportPanel.setStatus(num, val > 0);
    }
  }
}
