void DrawStartScreen(int progress) {
  background(BLACK);
  textAlign(LEFT);
  textFont(createFont("Arial", 60, true));
  fill(WHITE);
  text("Command 2 Conquer!", 400, 100);
  textFont(createFont("Arial", 30, true));
  text("The amazing game for all ages!", 565, 140);

  if (progress == 1 && playerAmount == playerTyping) {
    button(100, 600, 200, 100, "Start Game", GREY, WHITE);
  } else {
    button(100, 600, 200, 100, "Next Step", GREY, WHITE);
  }

  button(700, 600, 200, 100, "Load Game", GREY, WHITE);

  if (progress == 0) {
    textFont(createFont("Arial", 20, true));
    text("Change game options by hitting the corresponding number on your keyboard.", 60, 240);
    text("1. Amount of players: " + playerAmount, 60, 280);
    text("2. The size of the battlefield: " + gameSize + " x " + gameSize, 60, 300);
    text("3. Percentage chance for mines to spawn: " + mineFactor + "%", 60, 320);
  } else {
    textAlign(CENTER);
    text("Player " + playerTyping + ": Type in your name!", GameWidth / 2, 240);
    textFont(createFont("Arial", 50, true));
    text(currentPlayerName, GameWidth / 2, 300);
  }
}

void DrawScoreScreen(GameState gameState) {
  textAlign(CENTER);
  textFont(createFont("Arial", 50, true));
  fill(NOTWHITE);
  rect(220, 180, 580, 300);
  fill(BLACK);
  text(gameState.Players.get(gameState.WinnerId - 1).Name, GameWidth / 2, 240);
  text("Wins the match!", GameWidth / 2, 280);
  
  ArrayList<Player> topTwo = gameState.GetTop2Players();
  Player p1 = topTwo.get(0);
  Player p2 = topTwo.get(1);
  textFont(createFont("Arial", 20, true));
  text(p1.Name + " beats " + p2.Name + " by " + (p1.Points - p2.Points) + " points!", GameWidth / 2, 320);

  textAlign(LEFT);
  button(220, 500, 200, 100, "Play Again", NOTWHITE, BLACK);
  button(600, 500, 200, 100, "End Game", NOTWHITE, BLACK);
}

void DrawMainGame(GameState gameState) {
  background(GREY);
  stroke(BLACK);
  textAlign(LEFT);
  DrawGrid(gameState);
  DrawHUD(gameState);
}

void DrawHUD(GameState gameState) {
  int scoreX = 40;
  int scoreY = 40;
  int currentPlayer = 1;
  rectMode(CENTER);
  textAlign(LEFT);
  textFont(createFont("Arial", 16, true));
  for (Player player : gameState.Players) {
    fill(player.Color);
    rect(scoreX, scoreY, 20, 20);
    fill(BLACK);
    text(player.Name + ": " + gameState.CalculatePlayerScore(currentPlayer), scoreX + 15, scoreY + 6);

    if (currentPlayer == gameState.CurrentPlayerTurn) {
      arrow(scoreX - 35, scoreY, scoreX - 15, scoreY);
    }

    scoreY += 25;
    currentPlayer++;
  }

  text("Mines left: " + gameState.MinesLeft(), GameWidth - 150, 46);
  textAlign(LEFT);
  button(920, 700, 100, 50, "Save Game", NOTWHITE, BLACK);
}

void DrawGrid(GameState gameState) {
  Field[][] grid = gameState.FieldGrid;

  rectMode(CORNER);
  fill(WHITE);

  for (int y = 0; y < grid.length; y++) {
    for (int x = 0; x < grid.length; x++) {
      if (grid[x][y].HasMine && grid[x][y].OwnedPlayerId != 0) {
        fill(RED);
      } else if (grid[x][y].OwnedPlayerId == 0) {
        fill(NOTWHITE);
      } else {
        fill(gameState.Players.get(grid[x][y].OwnedPlayerId - 1).Color);
      }
      rect(grid[x][y].X, grid[x][y].Y, gameState.FieldSize, gameState.FieldSize);
      if (grid[x][y].HasMine && grid[x][y].OwnedPlayerId != 0) {
        fill(0, 0, 0);
        line(grid[x][y].X, grid[x][y].Y, grid[x][y].X + gameState.FieldSize, grid[x][y].Y + gameState.FieldSize);
        line(grid[x][y].X, grid[x][y].Y + gameState.FieldSize, grid[x][y].X + gameState.FieldSize, grid[x][y].Y);
      }
    }
  }
}
