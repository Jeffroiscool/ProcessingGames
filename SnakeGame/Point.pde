class Point {
  int X;
  int Y;

  Point(int x, int y) {
    this.X = x;
    this.Y = y;
  }
  
  @Override
  public String toString() {
    return X + "," + Y;
  }
}
