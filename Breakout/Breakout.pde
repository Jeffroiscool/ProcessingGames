import java.lang.Math.*;
import java.util.Random;

int GameWidth = 1280;
int GameHeight = 720;

Game game = new Game(6, 14);

void setup() {
  size(1280, 720);
  surface.setResizable(true);
  surface.setSize(GameWidth, GameHeight);
  surface.setResizable(false);
  
  frameRate(120);
}

void draw() {
  background(BLACK);
  game.Progress();
}

void keyPressed() {
  game.Player.Move(keyCode, true);
}

void keyReleased() {
  game.Player.Move(keyCode, false);
}
