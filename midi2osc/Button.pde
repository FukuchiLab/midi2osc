class Button {
  int id;
  String name, label;
  int x, y; //中心座標
  int w, h;
  boolean status;

  Button(int id, String name, String label, int x, int y, int w, int h) {
    this.id = id;
    this.name = name;
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    status = false;
  }

  Button(int id, String name, int x, int y, int w, int h) {
    this(id, name, name, x, y, w, h);
  }

  void setStatus(boolean status) {
    this.status = status;

    OscMessage msg = new OscMessage("/button");
    msg.add(name);
    msg.add(id);
    msg.add(status ? 1 : 0);
    osc.send(msg, target);
  }

  void draw() {
    pushStyle();

    noStroke();
    if (status) {
      fill(0, 255, 255);
    } else {
      fill(0, 0, 255);
    }

    rect(x - w / 2, y - h / 2, w, h);

    textSize(20);
    textAlign(CENTER, CENTER);
    fill(255);
    text(label, x, y);
    textAlign(RIGHT, TOP);
    text(status ? 1 : 0, x + w / 2, y + h / 2 + 5);

    popStyle();
  }
}
