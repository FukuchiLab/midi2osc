class ButtonGroup {
  Button[] buttons;
  int id;
  int x, y;

  ButtonGroup(int id, int x, int y) {
    this.id = id;
    this.x = x;
    this.y = y;
    buttons = new Button[3];
    buttons[0] = new Button(id, "R", 0, 160, 30, 30);
    buttons[1] = new Button(id, "M", 0, 80, 30, 30);
    buttons[2] = new Button(id, "S", 0, 0, 30, 30);
  }

  void setStatus(int num, boolean status) {
    if (num >= 0 && num < 3) {
      buttons[num].setStatus(status);
    }
  }

  void setStatus(String label, boolean status) {
    for (Button button : buttons) {
      if (button.label.equals(label)) {
        button.setStatus(status);
        break;
      }
    }
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    for (Button button : buttons) {
      button.draw();
    }
    popMatrix();
  }
}
