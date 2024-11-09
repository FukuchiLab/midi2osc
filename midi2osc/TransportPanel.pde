class TransportPanel {
  Button[] buttons;
  int x, y;
  final String[] buttonNames = {"rewind", "fastforward", "stop", "play", "rec"};
  final String[] buttonLabels = {"<<", ">>", "■", "▶", "◉"};
  final int[] buttonNumbers = {11, 12, 10, 9, 13};

  TransportPanel(int x, int y) {
    this.x = x;
    this.y = y;

    buttons = new Button[5];

    for (int i = 0; i < 5; i++) {
      buttons[i] = new Button(8, buttonNames[i], buttonLabels[i], 60 * i, 20, 40, 40);
    }
  }

  void setStatus(int num, boolean status) {
    for (int i = 0; i < 5; i++) {
      if (buttonNumbers[i] == num) {
        buttons[i].setStatus(status);
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
