import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.FileOutputStream; 
import java.io.ObjectOutputStream; 
import java.io.FileInputStream; 
import java.io.ObjectInputStream; 
import java.io.EOFException; 
import java.io.Serializable; 
import java.io.Serializable; 
import java.io.Serializable; 
import java.util.Collections; 
import java.util.*; 
import java.io.Serializable; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class C2C extends PApplet {








int playerAmount = 2;
int gameSize = 5;
int mineFactor = 20; // 1 - 100

int GameWidth = 1024;
int GameHeight = 768;

int currentScreen = 0;
int setupProgress = 0;

int playerTyping = 1;
String currentPlayerName = "";
ArrayList<Integer> availableColors;
ArrayList<Player> players = new ArrayList<Player>();

Settings settings;
GameState gameState;

public void setup() {
  
  surface.setResizable(true);
  surface.setSize(GameWidth, GameHeight);
  //frameRate(60);
  noLoop();

  availableColors = new ArrayList<Integer>();
  availableColors.add(GREEN);
  availableColors.add(BLUE);
  availableColors.add(ORANGE);
  availableColors.add(BROWN);
  availableColors.add(PURPLE);
}



public void draw() {
  if (currentScreen == 0) {
    DrawStartScreen(setupProgress);
  } else if (currentScreen == 1) {
    DrawMainGame(gameState);
  } else {
    DrawMainGame(gameState);
    DrawScoreScreen(gameState);
  }
}

public void mouseClicked() {
  if (currentScreen == 0) {
    if (mouseX> 100 && mouseX < 300 && mouseY > 600 && mouseY < 700) {
      if (setupProgress == 0) {
        setupProgress++;
      } else {
        AddPlayer();
      }
      redraw();
    }
    if (mouseX> 700 && mouseX < 900 && mouseY > 600 && mouseY < 700) {
      File load = new File(sketchPath("")+"/*.sav");
      selectInput("What game do you want to load?", "loadGame", load);
    }
  } else if (currentScreen == 1) {
    gameState.CheckField(mouseX, mouseY);
    if (mouseX> 920 && mouseX < 1020 && mouseY > 700 && mouseY < 750) {
      File save = new File(sketchPath("")+"/C2C_"+ day() + "-" + month() + "-" + year() + "_" + hour() + "-" + minute() + "-" + second() + ".sav");
      selectOutput("Where do you want to save this game?", "saveGame", save);
    }
  } else {
    //button(220, 500, 200, 100, "Play Again", NOTWHITE, BLACK);
    //button(600, 500, 200, 100, "End Game", NOTWHITE, BLACK);
    if (mouseX> 220 && mouseX < 420 && mouseY > 500 && mouseY < 600) {
      gameState.GenerateGrid();
      currentScreen = 1;
      redraw();
    }
    if (mouseX> 600 && mouseX < 800 && mouseY > 500 && mouseY < 600) {
      exit();
    }
  }
}

public void AddPlayer() {
  int randomColor = (int)random(availableColors.size());
  int pickedColor = availableColors.get(randomColor);
  availableColors.remove(randomColor);
  Player player = new Player(currentPlayerName, pickedColor);
  players.add(player);
  currentPlayerName = ""; 

  if (playerTyping == playerAmount) {
    settings = new Settings(playerAmount, gameSize, mineFactor);
    gameState = new GameState(settings, players);
    currentScreen++;
  } else {
    playerTyping++;
  }
}

public void saveGame(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    try
    {
      FileOutputStream file = new FileOutputStream(selection.getAbsolutePath());
      ObjectOutputStream output = new ObjectOutputStream(file);
      output.writeObject(gameState); 
      output.close();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
}

public void loadGame(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    try {
      FileInputStream fis = new FileInputStream(selection.getAbsolutePath());
      ObjectInputStream ois = new ObjectInputStream(fis);
      gameState = (GameState) ois.readObject();
      fis.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    } 
    catch (ClassNotFoundException e) {
      e.printStackTrace();
    }
  }
}

public void keyReleased() {
  if (currentScreen == 0 && setupProgress == 0) {
    if (key == '1' ) {
      if (playerAmount == 5) {
        playerAmount = 2;
      } else {
        playerAmount++;
      }
    } else if (key == '2' ) {
      if (gameSize == 10) {
        gameSize = 5;
      } else {
        gameSize++;
      }
    } else if (key == '3' ) {
      if (mineFactor == 100) {
        mineFactor = 20;
      } else {
        mineFactor += 20;
      }
    }
  } else if (currentScreen == 0 && setupProgress == 1) {
    if (key == '\n' ) {
      AddPlayer();
    } else if (key == BACKSPACE) {
      if (currentPlayerName.length() > 0) {
        currentPlayerName = removeLastChar(currentPlayerName);
      }
    } else {
      if (key >= 'A' && key <= 'Z' || key >= 'a' && key <= 'z' || key >= '0' && key <= '9') {
        currentPlayerName = currentPlayerName + key;
      }
    }
  }
  redraw();
}

int GREEN = color(0,120,0);
int RED = color(200,0,0);
int BLUE = color(0,0,120);
int YELLOW = color(200,200,0);
int ORANGE = color(255,120,0);
int PURPLE = color(200,0,200);
int BROWN = color(120,60,0);
int BLACK = color(0);
int WHITE = color(255);
int NOTWHITE = color(200);
int GREY = color(120);
public void DrawStartScreen(int progress) {
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

public void DrawScoreScreen(GameState gameState) {
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

public void DrawMainGame(GameState gameState) {
  background(GREY);
  stroke(BLACK);
  textAlign(LEFT);
  DrawGrid(gameState);
  DrawHUD(gameState);
}

public void DrawHUD(GameState gameState) {
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

public void DrawGrid(GameState gameState) {
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



class Field implements Serializable {
  int X;
  int Y;
  int GridX;
  int GridY;
  int OwnedPlayerId = 0; // 0 is neutral territory
  int CurrentValue = 1;
  boolean HasMine;
  
  Field(int x, int y, int gridX, int gridY, int mineFactor){
    this.X = x;
    this.Y = y;
    this.GridX = gridX;
    this.GridY = gridY;
    
    if(random(100) < mineFactor){
      HasMine = true;
    }
  }
  
  public int Value(Field[][] grid){
    int value = 1;
    
    // Left
    if(GridX - 1 >= 0){
      if(grid[GridX - 1][GridY].OwnedPlayerId == OwnedPlayerId){
        value++;
      }
    }
    
    // Right
    if(GridX + 1 <= grid.length - 1){
      if(grid[GridX + 1][GridY].OwnedPlayerId == OwnedPlayerId){
        value++;
      }
    }
    
    // Up
    if(GridY - 1 >= 0){
      if(grid[GridX][GridY - 1].OwnedPlayerId == OwnedPlayerId){
        value++;
      }
    }
    
    // Down
    if(GridY + 1 <= grid.length - 1){
      if(grid[GridX][GridY + 1].OwnedPlayerId == OwnedPlayerId){
        value++;
      }
    }
    
    CurrentValue = value;
    return value;
  }
}



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

  public void GenerateGrid() {
    int gridSize = floor(GameHeight * 0.8f);

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

  public void CheckField(int mX, int mY) {
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

  public int CalculatePlayerScore(int playerId) {
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

  public int MinesLeft() {
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

  public void NextTurn() {
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
  
  public void ResetGame(){
    GenerateGrid();
    for (Player player : Players){
      player.ResetPoints();
    }
    WinnerId = 0;
  }

  public void EndGame() {
    WinnerId = GetWinnerId();
    currentScreen = 2;
  }

  public int GetWinnerId() {
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

  public ArrayList<Player> GetTop2Players() {
    ArrayList<Player> players = Players;
    Collections.sort(players, new SortPlayerPoints());
    return new ArrayList<Player>(players.subList(players.size() -2, players.size()));
  }
}



class Player implements Serializable  {
  int Color;
  String Name;
  int Points = 0;
  
  Player(String name, int pickedColor){
    this.Name = name;
    this.Color = pickedColor;
  }
  
  public void AwardPoints(int points){
    this.Points += points;
  }
  
  public void ResetPoints(){
    this.Points = 0;
  }
}

class SortPlayerPoints implements Comparator<Player>{
  public int compare(Player p1, Player p2){
    return p1.Points + p2.Points;
  }
}


class Settings implements Serializable {
  int PlayerAmount;
  int GameSize;
  int MineFactor;
  
  Settings(int playerAmount, int gameSize, int mineFactor){
    this.PlayerAmount = playerAmount;
    this.GameSize = gameSize;
    this.MineFactor = mineFactor;
  }
}
public void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -8, -8);
  line(0, 0, 8, -8);
  popMatrix();
}

public void button(int x, int y, int w, int h, String text, int buttonColor, int textColor){
  rectMode(CORNER);
  stroke(textColor);
  fill(buttonColor);
  rect(x, y, w, h);
  fill(textColor);
  textFont(createFont("Arial", h / 3, true));
  text(text, x + w / 10, y + h / 1.7f);
}

public void button2(int x, int y, int w, int h, String text, int buttonColor, int textColor){
  rectMode(CORNER);
  stroke(textColor);
  fill(buttonColor);
  rect(x, y, w, h);
  fill(textColor);
  textFont(createFont("Arial", h / 3, true));
  text(text, x, y + 5);
}

public String removeLastChar(String s) {
    return (s == null || s.length() == 0)
      ? null
      : (s.substring(0, s.length() - 1));
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "C2C" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
