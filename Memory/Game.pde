class Game {
  int Rows = 5;
  int Columns = 8;
  int CardAmount;
  int CardSize = 100;

  PImage[] Images;

  Card[] Cards;
  ArrayList<PickedImages> Picked = new ArrayList<PickedImages>();

  int[] PreviousCardIDs = new int[2];
  int CardsOpened = 0;

  Game(int rows, int columns) {
    Rows = rows;
    Columns = columns;
    CardAmount = Rows * Columns;
    Cards = new Card[CardAmount];

    LoadImages();
    GenerateCards();
  }

  boolean CheckWinner() {
    int i = 0;
    for (Card card : Cards) {
      if (card.Opened) {
        i++;
      }
    }
    if (i == CardAmount) {
      return true;
    } else {
      return false;
    }
  }

  int GenerateCardSize(int w, int h, int space) {
    w = (w / Columns) - space;
    h = (h / Rows) - space;
    if (w <= h) {
      return w;
    } else {
      return h;
    }
  }

  void GenerateCards() {
    int canvasWidth = floor(GameWidth * 0.7);
    int canvasHeight = floor(GameHeight * 0.7);

    CardSize = GenerateCardSize(canvasWidth, canvasHeight, 5);
    int rSpace = CardSize + 5;
    int cSpace = CardSize + 5;
    
    int x = 0;
    int y = 0;

    int card = 0;
    for (int row = 0; row < Rows; row++) {
      if (row == 0) {
        y = (GameHeight / 2) - (canvasHeight / 2);
      } else {
        y += rSpace;
      }
      for (int column = 0; column < Columns; column++) {
        if (column == 0) {
          x = (GameWidth / 2) - (rSpace * (Columns / 2));
        } else {
          x += cSpace;
        }

        Random rand = new Random();
        int pickedCard = rand.nextInt(Picked.size());
        Cards[card] = new Card(x, x + CardSize, y, y + CardSize, Picked.get(pickedCard).ImageID);
        Picked.remove(pickedCard);
        card++;
      }
    }
  }

  void DrawCards() {
    for (Card card : Cards) {
      if (!card.Opened) {
        fill(BLACK);
        rectMode(CORNER);
        rect(card.X, card.Y, CardSize, CardSize);
      } else {
        image(Images[card.ImageID], card.X, card.Y, CardSize, CardSize);
      }
    }
    if (CheckWinner()) {
      textAlign(CENTER);
      textSize(30);
      text("WINNER WINNER, CHICKEN DINNER!", GameWidth / 2, GameHeight / 2);
    }
  }

  void ProcessCardClick(int mX, int mY) {
    int cardID = 0;
    if (!GotMatch && CardsOpened == 2) {
      Cards[game.PreviousCardIDs[0]].Opened = false;
      Cards[game.PreviousCardIDs[1]].Opened = false;
      CardsOpened = 0;
    } else if (CardsOpened == 2) {
      PreviousCardIDs[0] = -1;
      PreviousCardIDs[1] = -1;
      GotMatch = false;
      CardsOpened = 0;
    } else {
      GotMatch = false;
    }

    for (Card card : Cards) {
      if (mX > card.X && mX < card.X2 && mY > card.Y && mY < card.Y2) {
        if (!card.Opened) {

          if (CardsOpened == 0) {
            PreviousCardIDs[0] = cardID;
          } else {
            PreviousCardIDs[1] = cardID;
          }

          CardsOpened++;
          card.Opened = true;
          if (CardsOpened == 2) {
            if (card.ImageID == Cards[PreviousCardIDs[0]].ImageID) {
              GotMatch = true;
            }
          }
        }
      }
      cardID++;
    }
    redraw();
  }

  void LoadImages() {
    File[] files = listFiles(sketchPath() + "\\data\\images");
    Images = new PImage[files.length];
    ArrayList<String> tempNames = new ArrayList<String>();
    int i = 0;
    int picked = 0;
    Random rand = new Random();
    for (File file : files) {
      println(file.getName());
      Images[i] = loadImage("images\\" + file.getName());

      if (picked < CardAmount / 2) {
        if (rand.nextDouble() < 0.75) {
          if (!tempNames.contains(file.getName())) {
            tempNames.add(file.getName());
            Picked.add(new PickedImages(i));
            Picked.add(new PickedImages(i));
            picked++;
          }
        }
      }
      i++;
    }
  }
}
