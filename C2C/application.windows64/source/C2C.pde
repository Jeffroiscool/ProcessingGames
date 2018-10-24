import java.io.FileOutputStream;
import java.io.ObjectOutputStream;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.EOFException;
import java.io.Serializable;

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

void setup() {
  size(800, 600);
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



void draw() {
  if (currentScreen == 0) {
    DrawStartScreen(setupProgress);
  } else if (currentScreen == 1) {
    DrawMainGame(gameState);
  } else {
    DrawMainGame(gameState);
    DrawScoreScreen(gameState);
  }
}

void mouseClicked() {
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

void AddPlayer() {
  int randomColor = (int)random(availableColors.size());
  color pickedColor = availableColors.get(randomColor);
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

void saveGame(File selection) {
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

void loadGame(File selection) {
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

void keyReleased() {
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
