import java.io.Serializable;

class Settings implements Serializable {
  int PlayerAmount;
  int GameSize;
  int MineFactor;

  Settings(int playerAmount, int gameSize, int mineFactor) {
    this.PlayerAmount = playerAmount;
    this.GameSize = gameSize;
    this.MineFactor = mineFactor;
  }
}
