class Knob {
  int id;
  int x, y; //中心座標
  int r;
  int value;
  int value_max = 127;

  Knob(int id, int x, int y, int r) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.r = r;

    value = 0;
  }

  Knob setValue(int value) {
    this.value = value;

    OscMessage msg = new OscMessage("/knob");
    msg.add(id);
    msg.add(value);
    osc.send(msg, target);

    return this;
  }

  void draw() {
    pushMatrix();
    pushStyle();

    translate(x, y);
    noStroke();
    fill(0, 0, 255);
    circle(0, 0, r);
    float vr = (float)value * TWO_PI / value_max;
    fill(0, 255, 255);
    arc(0, 0, r, r, HALF_PI, HALF_PI + vr);

    textSize(20);
    textAlign(RIGHT);
    fill(255);
    text(value, r / 2 - 10, r);

    popMatrix();
    popStyle();
  }
}
