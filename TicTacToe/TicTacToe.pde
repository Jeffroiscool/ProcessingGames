int GameWidth = 1280;
int GameHeight = 720;

Game game = new Game(3);

void setup() {
  size(1280, 720);
  surface.setSize(GameWidth, GameHeight);

  ellipseMode(CORNER);

  noLoop();
}

void draw() {
  background(BLACK);
  game.DrawGrid();
}

void mousePressed() {
  game.CheckCellClicked(mouseX, mouseY);
}
