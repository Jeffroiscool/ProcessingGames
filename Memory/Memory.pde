import java.io.File; //<>//
import java.util.Random;

Game game;

int GameWidth = 1280;
int GameHeight = 720;
boolean GotMatch = false;

void setup() {
  size(1280, 720);
  surface.setSize(GameWidth, GameHeight);
  noLoop();
  
  game = new Game(4, 4);
}

void draw() {
  stroke(255);
  game.DrawCards();
  //point(GameWidth / 2, GameHeight / 2);
}

void mousePressed() {
  game.ProcessCardClick(mouseX, mouseY);  
}
