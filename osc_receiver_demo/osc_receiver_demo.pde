// midi2osc からの OSC メッセージを受信するサンプルプログラム。

import netP5.*;
import oscP5.*;

// 受信ポート番号
int listening_port = 8888;

OscP5 osc;
NetAddress target;

Slider[] sliders;
Knob[] knobs;
ButtonGroup[] bgroups;
TransportPanel transportPanel;

void setup() {
  size(1000, 500);

  osc = new OscP5(this, listening_port);

  sliders = new Slider[8];
  knobs = new Knob[8];
  bgroups = new ButtonGroup[8];
  transportPanel = new TransportPanel(300, 75);

  for (int i=0; i<8; i++) {
    knobs[i] = new Knob(i, i * 120 + 100, 200, 50);
    sliders[i] = new Slider(i, i * 120 + 80, 260, 40, 200);
    bgroups[i] = new ButtonGroup(i, i * 120 + 50, 280);
  }

  textSize(20);
}

void draw() {
  background(0);
  fill(255);
  text("Listening port: " + listening_port, 10, 20);

  for (int i=0; i<8; i++) {
    sliders[i].draw();
    knobs[i].draw();
    bgroups[i].draw();
  }
  transportPanel.draw();
}

// 受信した OSC メッセージの処理はここで行う
void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();

  if (addr.equals("/slider")) {
    if (msg.checkTypetag("ii")) {
      int id = msg.get(0).intValue();
      int val = msg.get(1).intValue();
      sliders[id].setValue(val);
    }
  } else if (addr.equals("/knob")) {
    if (msg.checkTypetag("ii")) {
      int id = msg.get(0).intValue();
      int val = msg.get(1).intValue();
      knobs[id].setValue(val);
    }
  } else if (addr.equals("/button")) {
    if (msg.checkTypetag("sii")) {
      String name = msg.get(0).stringValue();
      int id = msg.get(1).intValue();
      int val = msg.get(2).intValue();
      if (id < 8) {
        bgroups[id].setStatus(name, val > 0);
      } else if (id == 8) {
        transportPanel.setStatus(name, val > 0);
      }
    }
  }
}
