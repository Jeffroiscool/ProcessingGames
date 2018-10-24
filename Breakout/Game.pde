class Game {
  Player Player = new Player(100, 4);
  Ball Ball = new Ball(4);
  ArrayList<Type> Types = new ArrayList<Type>();
  ArrayList<Block> Blocks = new ArrayList<Block>();

  int BlockRows;
  int BlockColumns;

  int Points = 0;

  Game(int bRows, int bColumns) {
    BlockRows = bRows;
    BlockColumns = bColumns;

    AddTypes();
    GenerateBlocks();
  }

  void CheckCollide() {
    if (Ball.CurrentX > GameWidth || Ball.CurrentX < 0) {
      Ball.Angle = 180 - Ball.Angle;
    }

    if (Ball.CurrentY < 0) {
      Ball.Angle = 360 - Ball.Angle;
    }

    if (Ball.CurrentY > GameHeight) {
      EndGame();
    }

    if (Ball.CurrentY > Player.CurrentY && Ball.CurrentX > Player.CurrentX && Ball.CurrentX < Player.CurrentX + Player.Width) {
      Ball.Angle = 360 - Ball.Angle;
    }
    for (Block block : Blocks) {
      if (Ball.CurrentY < block.Y && Ball.CurrentX > block.X && Ball.CurrentX < block.X + block.Width && !block.Destroyed) {
        block.Destroyed = true;
        Points += block.Type.PointValue;
        Ball.Angle = 360 - Ball.Angle;
      }
    }
  }

  void AddTypes() {
    Types.add(new Type(1, 100, color(120)));
    Types.add(new Type(5, 50, color(0, 120, 0)));
    Types.add(new Type(10, 25, color(220, 220, 0)));
    Types.add(new Type(15, 10, color(220, 0, 0)));
  }

  void GenerateBlocks() {
    int blockWidth = (GameWidth / BlockColumns) - 4;
    int blockHeight = 20;
    int x = 2;
    int y = 2;
    Random rand = new Random();

    for (int r = 0; r < BlockRows; r++) {
      x = 2;
      for (int c = 0; c < BlockColumns; c++) {
        int type = 0;
        int typeId = 0;
        for (Type t : Types) {
          if (rand.nextInt(100) <= t.Rarity) {
            type = typeId;
          }
          typeId++;
        }
        println(type);
        Blocks.add(new Block(x, y, blockWidth, blockHeight, Types.get(type)));
        x += blockWidth + 4;
      }
      y += blockHeight + 4;
    }
  }

  void DrawBlocks() {
    strokeWeight(1);
    for (Block block : Blocks) {
      fill(block.Type.Color);
      if (!block.Destroyed) {
        rect(block.X, block.Y, block.Width, block.Height);
      }
    }
  }

  void Progress() {
    DrawBlocks();
    CheckCollide();
    Player.DrawMove();
    Ball.Move();
  }

  void EndGame() {
    println("REEEE");
  }
}
