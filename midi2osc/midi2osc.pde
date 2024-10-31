// KORG nanoKONTROL2 のノブ・スライダーの値を OSC で送信するプログラム。
// OSC アドレスおよびデータは以下の通り。
// ノブ
//   /knob ID VALUE…IDは左から0〜7。VALUE は 0〜127 の整数
// スライダー
//   /slider ID VALUE…IDは左から0〜7。VALUE は 0〜127 の整数

import netP5.*;
import oscP5.*;

import themidibus.*;
import javax.sound.midi.MidiMessage;
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;

// 送信先アドレス
String target_host = "127.0.0.1";

// 送信先ポート番号
int target_port = 8888;

// midi2osc 側の受信ポート番号
// midi2osc を複数立ち上げるときは、この番号を1ずつ変えていくとよい
int listening_port = 12000;

// MIDI デバイス名。Windows では下記の通り。他の環境では変わるかもしれない。
// コンソールに認識されたデバイス一覧が表示されているので参考にせよ。
String device_name = "nanoKONTROL2";

OscP5 osc;
NetAddress target;

Slider[] sliders;
Knob[] knobs;

MidiBus midiBus;

void setup() {
  size(850, 500);

  osc = new OscP5(this, listening_port);
  target = new NetAddress(target_host, target_port);

  sliders = new Slider[8];
  knobs = new Knob[8];

  for (int i=0; i<8; i++) {
    knobs[i] = new Knob(i, i * 100 + 80, 170, 50);
    sliders[i] = new Slider(i, i * 100 + 60, 240, 40, 200);
  }

  MidiBus.list();
  midiBus = new MidiBus();
  midiBus.registerParent(this);
  midiBus.addInput(device_name);

  background(0);
  textSize(20);
  fill(255);
  noStroke();
  text(String.format("Target: %s:%d", target_host, target_port), 10, 20);
  text("OSC address:", 10, 50);
  text("/knob ID VALUE", 20, 70);
  text("/slider ID VALUE", 20, 90);
}

void draw() {
  noStroke();
  fill(0);
  rect(0, 140, width, height - 140);

  for (int i=0; i<8; i++) {
    sliders[i].draw();
    knobs[i].draw();
  }
}

void midiMessage(MidiMessage message) {
  byte[] msg = message.getMessage();
  int id = (int)msg[1];
  int val = (int)msg[2];

  if (id >= 16 && id < 24) {
    id = id - 16;
    knobs[id].setValue(val);
  } else if (id >= 0 && id < 8) {
    sliders[id].setValue(val);
  }
}
