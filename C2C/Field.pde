import java.io.Serializable;

class Field implements Serializable {
  int X;
  int Y;
  int GridX;
  int GridY;
  int OwnedPlayerId = 0; // 0 is neutral territory
  int CurrentValue = 1;
  boolean HasMine;

  Field(int x, int y, int gridX, int gridY, int mineFactor) {
    this.X = x;
    this.Y = y;
    this.GridX = gridX;
    this.GridY = gridY;

    if (random(100) < mineFactor) {
      HasMine = true;
    }
  }

  int Value(Field[][] grid) {
    int value = 1;

    // Left
    if (GridX - 1 >= 0) {
      if (grid[GridX - 1][GridY].OwnedPlayerId == OwnedPlayerId) {
        value++;
      }
    }

    // Right
    if (GridX + 1 <= grid.length - 1) {
      if (grid[GridX + 1][GridY].OwnedPlayerId == OwnedPlayerId) {
        value++;
      }
    }

    // Up
    if (GridY - 1 >= 0) {
      if (grid[GridX][GridY - 1].OwnedPlayerId == OwnedPlayerId) {
        value++;
      }
    }

    // Down
    if (GridY + 1 <= grid.length - 1) {
      if (grid[GridX][GridY + 1].OwnedPlayerId == OwnedPlayerId) {
        value++;
      }
    }

    CurrentValue = value;
    return value;
  }
}
