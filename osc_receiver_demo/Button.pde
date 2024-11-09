class Button {
  int id;
  String label;
  int x, y; //中心座標
  int w, h;
  boolean status;

  Button(int id, String label, int x, int y, int w, int h) {
    this.id = id;
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    status = false;
  }

  Button setStatus(boolean status) {
    this.status = status;

    return this;
  }

  void draw() {
    pushStyle();

    noStroke();
    if (status) {
      fill(255, 0, 255);
    } else {
      fill(128, 0, 0);
    }

    rect(x - w / 2, y - h / 2, w, h);

    textSize(20);
    textAlign(CENTER, CENTER);
    fill(255);
    text(label, x, y);
    textAlign(RIGHT, TOP);
    text(status ? 1 : 0, x + w / 2, y + h / 2);

    popStyle();
  }
}
