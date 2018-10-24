class Block {
  int X;
  int Y;
  int Width;
  int Height;
  Type Type;

  boolean Destroyed = false;

  Block(int x, int y, int w, int h, Type type) {
    X = x;
    Y = y;
    Width = w;
    Height = h;
    Type = type;
  }
}
