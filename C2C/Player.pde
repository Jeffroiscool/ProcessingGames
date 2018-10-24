import java.util.*;

class Player implements Serializable {
  color Color;
  String Name;
  int Points = 0;

  Player(String name, color pickedColor) {
    this.Name = name;
    this.Color = pickedColor;
  }

  void AwardPoints(int points) {
    this.Points += points;
  }

  void ResetPoints() {
    this.Points = 0;
  }
}

class SortPlayerPoints implements Comparator<Player> {
  public int compare(Player p1, Player p2) {
    return p1.Points + p2.Points;
  }
}
