class Player {
  int Width;
  int Speed;
  int CurrentX = (GameWidth / 2) - (Width / 2);
  int CurrentY = GameHeight - 50;

  int HeadingLeft = 0;
  int HeadingRight = 0;

  Player(int w, int speed) {
    Width = w;
    Speed = speed;
  }

  void Move(int keyCode, boolean keyPressed) {
    switch(keyCode) {
    case LEFT:
      HeadingLeft = keyPressed ? 1 : 0;
      break;
    case RIGHT:
      HeadingRight = keyPressed ? 1 : 0;
      break;
    }
  }

  void DrawMove() {
    stroke(WHITE);
    strokeWeight(8);
    CurrentX += (HeadingRight - HeadingLeft) * Speed;
    line(CurrentX, CurrentY, CurrentX + Width, CurrentY);
  };
}
