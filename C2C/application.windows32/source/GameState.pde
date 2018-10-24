import java.io.Serializable;
import java.util.Collections;

class GameState implements Serializable {
  Settings GameSettings;
  ArrayList<Player> Players;
  int CurrentPlayerTurn = 1; // Make this random
  Field[][] FieldGrid;
  int FieldSize;
  int FieldsLeft;
  int WinnerId = 0;

  GameState(Settings settings, ArrayList<Player> players) {
    this.GameSettings = settings;
    this.Players = players;

    GenerateGrid();
  }

  void GenerateGrid() {
    int gridSize = floor(GameHeight * 0.8);

    FieldGrid = new Field[GameSettings.GameSize][GameSettings.GameSize];
    FieldsLeft = GameSettings.GameSize * GameSettings.GameSize;
    FieldSize = gridSize / FieldGrid.length;

    int currentX = (GameWidth / 2) - (gridSize / 2);
    int currentY = (GameHeight / 2) - (gridSize / 2);

    for (int y = 0; y < FieldGrid.length; y++) {
      for (int x = 0; x < FieldGrid.length; x++) {
        int drawX = currentX;
        int drawY = currentY;

        FieldGrid[x][y] = new Field(drawX, drawY, x, y, GameSettings.MineFactor);
        currentX += FieldSize;
      }
      currentX = (GameWidth / 2) - (gridSize / 2);
      currentY += FieldSize;
    }
  }

  void CheckField(int mX, int mY) {
    for (int y = 0; y < FieldGrid.length; y++) {
      for (int x = 0; x < FieldGrid.length; x++) {
        Field field = FieldGrid[x][y];
        if (mX > field.X && mX < field.X + FieldSize && mY > field.Y && mY < field.Y + FieldSize) {
          if (!field.HasMine && field.OwnedPlayerId == 0) {
            field.OwnedPlayerId = CurrentPlayerTurn;

            Players.get(gameState.CurrentPlayerTurn - 1).AwardPoints(1);
            NextTurn();
          }
          if (field.HasMine && field.OwnedPlayerId == 0) {
            field.OwnedPlayerId = CurrentPlayerTurn;
            NextTurn();
          }
        }
      }
    }
  }

  int CalculatePlayerScore(int playerId) {
    int score = 0;
    for (int y = 0; y < FieldGrid.length; y++) {
      for (int x = 0; x < FieldGrid.length; x++) {
        Field field = FieldGrid[x][y];
        if (!field.HasMine && field.OwnedPlayerId == playerId) {
          score += field.Value(FieldGrid);
        }
      }
    }
    Players.get(playerId - 1).Points = score;
    return score;
  }

  int MinesLeft() {
    int mines = 0;
    for (int y = 0; y < FieldGrid.length; y++) {
      for (int x = 0; x < FieldGrid.length; x++) {
        Field field = FieldGrid[x][y];
        if (field.HasMine && field.OwnedPlayerId == 0) {
          mines++;
        }
      }
    }
    return mines;
  }

  void NextTurn() {
    int tempTurn = CurrentPlayerTurn;
    tempTurn++;

    if (tempTurn > Players.size()) {
      CurrentPlayerTurn = 1;
    } else {
      CurrentPlayerTurn++;
    }
    FieldsLeft--;
    redraw();

    if (FieldsLeft == 0) {
      EndGame();
    }
  }
  
  void ResetGame(){
    GenerateGrid();
    for (Player player : Players){
      player.ResetPoints();
    }
    WinnerId = 0;
  }

  void EndGame() {
    WinnerId = GetWinnerId();
    currentScreen = 2;
  }

  int GetWinnerId() {
    int currentWinnerId = 0;
    int winnerPoints = 0;
    for (int i = 0; i < Players.size(); i++) {
      Player player = Players.get(i);
      if (player.Points > winnerPoints) {
        winnerPoints = player.Points;
        currentWinnerId = i + 1;
      }
    }
    return currentWinnerId;
  }

  ArrayList<Player> GetTop2Players() {
    ArrayList<Player> players = Players;
    Collections.sort(players, new SortPlayerPoints());
    return new ArrayList<Player>(players.subList(players.size() -2, players.size()));
  }
}
