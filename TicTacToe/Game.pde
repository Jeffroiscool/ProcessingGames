class Game { //<>//
  ArrayList<Cell> Grid = new ArrayList<Cell>();
  int GridSize;
  int CellSize;

  int CurrentPlayer = 1;

  Game(int gridSize) {
    GridSize = gridSize;
    PrepareGrid();
  }

  void PrepareGrid() {
    int canvasSize = floor(GameHeight * 0.8);
    CellSize = canvasSize / GridSize;

    int drawX = (GameWidth / 2) - (canvasSize / 2);
    int drawY = (GameHeight / 2) - (canvasSize / 2);

    for (int y = 0; y < GridSize; y++) {
      for (int x = 0; x < GridSize; x++) {
        Cell cell = new Cell(x, y, drawX, drawY);
        Grid.add(cell);

        drawX += CellSize;
        println(x + "," + y + " " + drawX + "," + drawY);
      }
      drawY += CellSize;
      drawX = (GameWidth / 2) - (canvasSize / 2);
    }
  }

  void DrawGrid() {
    fill(RED);
    stroke(WHITE);
    strokeWeight(3);

    for (Cell cell : Grid) {
      fill(RED);
      rect(cell.DrawX, cell.DrawY, CellSize, CellSize);
      if (cell.OwnedBy == 1) {
        fill(WHITE);
        line(cell.DrawX + 15, cell.DrawY + 15, cell.DrawX + CellSize - 20, cell.DrawY + CellSize - 20);
        line(cell.DrawX + CellSize - 20, cell.DrawY + 15, cell.DrawX + 15, cell.DrawY + CellSize - 20);
      } else if (cell.OwnedBy == 2) {
        noFill();
        ellipse(cell.DrawX + 10, cell.DrawY + 10, CellSize - 20, CellSize - 20);
      }
    }
  }

  void CheckCellClicked(int mX, int mY) {
    for (Cell cell : Grid) {
      if (mX > cell.DrawX && mX < cell.DrawX + CellSize && mY > cell.DrawY && mY < cell.DrawY + CellSize) {
        if (cell.OwnedBy == 0) {
          cell.OwnedBy = CurrentPlayer;
          CheckForWinner(CurrentPlayer);
          NextTurn();
        }
      }
    }
  }

  void CheckForWinner(int playerId) {
    int rStreak[] = new int[GridSize + 1];
    int dStreak = 0;
    int rdStreak = 0;
    int cStreak = 0;
    int x = 0;
    int y = 0;
    int cellId = 0;

    for (Cell cell : Grid) {
      if (cell.OwnedBy == playerId) {
        if (cellId == 0 || cellId == (GridSize * y) + 1) {
          dStreak++;
        }

        if (cellId == (GridSize - 1) * y) {
          rdStreak++;
        }

        cStreak++;
        rStreak[x]++;
      }

      if (y == GridSize) {
        y = 0;
      }

      if (x == GridSize) {
        x = 0;
        if (cStreak != GridSize) {
          cStreak = 0;
        }
        y++;
      }

      x++;
      cellId++;
    }
    for (int streak : rStreak) {
      if (streak == GridSize) {
        println("Winner winner, chicken dinner!");
      }
    }
    if (cStreak == GridSize || dStreak == GridSize || rdStreak == GridSize) {
      println("Winner winner, chicken dinner!");
    }
    //println(rStreak);
    println(cStreak, dStreak, rdStreak);
  }

  void NextTurn() {
    if (CurrentPlayer == 2) {
      CurrentPlayer = 1;
    } else {
      CurrentPlayer++;
    }
    redraw();
  }
}
