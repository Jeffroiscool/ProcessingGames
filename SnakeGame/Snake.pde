class Snake {
  int Length = 1;
  Point CurrentPosition;
  int CurrentDirection; // 0 LEFT, 1 UP, 2 RIGHT, 3 DOWN
  int GridSize;
  ArrayList<Point> SnakeArray = new ArrayList<Point>();
  color Color;


  Snake(color selectedColor, int gridSize) {
    Color = selectedColor;
    GridSize = gridSize;

    CurrentPosition = new Point(GridSize / 2, GridSize / 2);
    CurrentDirection = new Random().nextInt(4);
    SnakeArray.add(CurrentPosition);
  }

  void NextPosition() {
    switch(CurrentDirection) {
    case 0:
      CurrentPosition.X--;
      break;
    case 1:
      CurrentPosition.Y--;
      break;
    case 2:
      CurrentPosition.X++;
      break;
    case 3:
      CurrentPosition.Y++;
      break;
    }
  }

  void Move(Food food) {
    fill(Color);
    rectMode(CORNER);
    Point tail = new Point(SnakeArray.get(0).X, SnakeArray.get(0).Y);
    this.NextPosition();
    Point head = new Point(CurrentPosition.X, CurrentPosition.Y);
    SnakeArray.add(head);
    println("Head: " + head + " Tail: " + tail);

    if (food.CurrentPosition.X == head.X && food.CurrentPosition.Y == head.Y) {
      println("Food: " + food.CurrentPosition + " Head: " + head + " Tail: " + tail);
      food.Eat();
      Length++;
    } else {
      SnakeArray.remove(0);
    }

    for (Point position : SnakeArray) {
      int x = GameWidth / GridSize * position.X;
      int y = GameWidth / GridSize * position.Y;
      int size = GameWidth / GridSize;
      rect(x, y, size, size);
    }

    int i = 1;
    int arrayLength = SnakeArray.size();
    for (Point position : SnakeArray) {
      if (position.X == head.X && position.Y == head.Y && i != arrayLength) {
        println(i + " " + head.X + " " + position.X + " " + head.Y + " " + position.Y + " " + arrayLength);
        EndGame();
      }
      i++;
    }

    if(head.X == -1 || head.Y == -1 || head.X >= gridSize || head.Y >= gridSize){
      EndGame();
    }
    
    printArray(SnakeArray);
    println();
  }
}
