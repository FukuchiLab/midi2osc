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

  void setValue(int value) {
    this.value = value;
  }

  void draw() {
    pushMatrix();
    pushStyle();

    translate(x, y);
    noStroke();
    fill(128, 0, 0);
    circle(0, 0, r);
    float vr = (float)value * TWO_PI / value_max;
    fill(255, 0, 255);
    arc(0, 0, r, r, HALF_PI, HALF_PI + vr);

    textSize(20);
    textAlign(RIGHT, TOP);
    fill(255);
    text(value, r / 2 - 10, r / 2 + 5);

    popMatrix();
    popStyle();
  }
}
