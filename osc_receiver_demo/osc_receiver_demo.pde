// midi2osc からの OSC メッセージを受信するサンプルプログラム。

import netP5.*;
import oscP5.*;

// 受信ポート番号
int listening_port = 8888;

OscP5 osc;
NetAddress target;

Slider[] sliders;
Knob[] knobs;

void setup() {
  size(850, 500);

  osc = new OscP5(this, listening_port);

  sliders = new Slider[8];
  knobs = new Knob[8];

  for (int i=0; i<8; i++) {
    knobs[i] = new Knob(i, i * 100 + 80, 170, 50);
    sliders[i] = new Slider(i, i * 100 + 60, 240, 40, 200);
  }
}

void draw() {
  background(0);

  for (int i=0; i<8; i++) {
    sliders[i].draw();
    knobs[i].draw();
  }
}

// 受信した OSC メッセージの処理はここで行う
void oscEvent(OscMessage msg) {
  String addr = msg.addrPattern();
  
  // midi2osc では OSC メッセージは必ず2個の整数が引数として渡されるので、typetag は "ii" となる
  if (msg.checkTypetag("ii")) {
    int id = msg.get(0).intValue();
    int val = msg.get(1).intValue();
    if (addr.equals("/slider")) {
      sliders[id].setValue(val);
    } else if (addr.equals("/knob")) {
      knobs[id].setValue(val);
    }
  }
}
