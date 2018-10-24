class Food {
  Point CurrentPosition = new Point(0,0);
  int GridSize;
  color Color;
  
  Food(color selectedColor, int gridSize){
    Color = selectedColor;
    GridSize = gridSize;
    NewSpot();
  }
  
  void Eat(){
    NewSpot();
  }
  
  void NewSpot(){
    CurrentPosition.X = new Random().nextInt(GridSize);
    CurrentPosition.Y = new Random().nextInt(GridSize);
  }
  
  void Draw(){
    fill(Color);
    rectMode(CORNER);
    int x = GameWidth / GridSize * CurrentPosition.X;
    int y = GameWidth / GridSize * CurrentPosition.Y;
    int size = GameWidth / GridSize;
    rect(x, y, size, size);
  }
}
