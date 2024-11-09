class Slider {
  int id;
  int x, y; // 左上隅の座標
  int value;
  int w;
  int h;
  int value_max = 127;

  Slider(int id, int x, int y, int w, int h) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    value = 0;
  }

  void setValue(int value) {
    this.value = value;

    OscMessage msg = new OscMessage("/slider");
    msg.add(id);
    msg.add(value);
    osc.send(msg, target);
  }

  void draw() {
    pushMatrix();
    pushStyle();

    translate(x, y);
    noStroke();
    fill(0, 0, 255);
    rect(0, 0, w, h);
    int vh = h * value / value_max;
    fill(0, 255, 255);
    rect(0, h - vh, w, vh);

    textSize(20);
    textAlign(RIGHT);
    fill(255);
    text(value, w - 5, h + 20);

    popMatrix();
    popStyle();
  }
}
