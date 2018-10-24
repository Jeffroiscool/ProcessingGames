class Ball {
  int Speed;
  int Angle = 45;
  int CurrentX = (GameWidth / 2) - 10;
  int CurrentY = (GameHeight / 2 - 10);

  Ball(int speed) {
    Speed = speed;
  }

  void Move() {
    CurrentX += cos(Angle * PI / 180) * Speed;
    CurrentY += sin(Angle * PI / 180) * Speed;
    strokeWeight(10);
    ellipseMode(CENTER);
    ellipse(CurrentX, CurrentY, 10, 10);
  }
}
