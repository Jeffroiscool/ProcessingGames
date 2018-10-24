import java.util.*;

int gridSize = 20;
int GameWidth = 500;
int GameHeight = 500;

int GameState = 0;

Snake snake;
Food food;

void setup() {
  size(500, 500);
  surface.setResizable(true);
  surface.setSize(GameWidth, GameHeight);
  surface.setResizable(false);

  frameRate(10);
  //noLoop();
}

void draw() {
  background(BLACK);
  switch(GameState) {
  case 0:
    StartScreen();
    break;
  case 1:
    food.Draw();
    snake.Move(food);
    break;
  case 2:
    EndGame();
    break;
  }
}

void StartScreen() {
  noLoop();
  background(BLACK);
  fill(WHITE);
  textAlign(CENTER);
  textSize(30);
  text("Press any key to start the game!", GameWidth / 2, GameHeight / 2);
}

void StartGame() {
  loop();
  GameState = 1;
  snake = new Snake(WHITE, gridSize);
  food = new Food(RED, gridSize);
}

void EndGame() {
  GameState = 2;
  noLoop();
  background(BLACK);
  fill(WHITE);
  textAlign(CENTER);
  textSize(30);
  text("GAME OVER", GameWidth / 2, GameHeight / 2 - 30);
  text("Press any key to play again!", GameWidth / 2, GameHeight / 2);
  textSize(20);
  text("Final snake length: " + snake.Length, GameWidth / 2, GameHeight / 2 + 60);
}

void keyPressed() {
  switch(GameState) {
  case 0:
    StartGame();
    break;
  case 1:
    switch(keyCode) {
    case LEFT:
      if (snake.CurrentDirection != 2) {
        snake.CurrentDirection = 0;
      }
      break;
    case UP:
      if (snake.CurrentDirection != 3) {
        snake.CurrentDirection = 1;
      }
      break;
    case RIGHT:
      if (snake.CurrentDirection != 0) {
        snake.CurrentDirection = 2;
      }
      break;
    case DOWN:
      if (snake.CurrentDirection != 1) {
        snake.CurrentDirection = 3;
      }
      break;
    }
    break;
  case 2:
    GameState = 0;
    StartGame();
    break;
  }
}
