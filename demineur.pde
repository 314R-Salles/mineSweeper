int[][] mines = new int[10][10];
char[][] plateau = new char[10][10];
boolean gameOver = false;
int minesNumber = 0;
PImage mine;

void setup() {
  background(150);
  mine = loadImage("mine.png");
  size(1000, 800);


  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      mines[j][i] = random(1)>0.8 ? 1 : 0;
      plateau[j][i] = ' ';
      line(j*100, 0, j*100, 800);
      line(0, j*100, 800, j*100);
    }
  }
  mines[1][1] = mines[8][8] = mines[8][1] = mines[1][8] = 0 ;

  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      minesNumber += mines[j][i];
    }
  }
  textSize(30);
  text("Mines: " + minesNumber, 820, 50);
  textSize(50);
}

void draw() {
}

void mouseClicked() {
  if (!gameOver && mouseX<=800) {
    unveil(mouseX/100 +1, mouseY/100 +1);
    checkWin();
  }
}

void unveil(int x, int y) {
  if (mines[y][x] != 1) {
    plateau[y][x] = (char) (sum(x, y) + 48);
    text(plateau[y][x], (x-0.72)*100, (y-0.28)*100);
  } else {
    gameOver = true;
    displayMines(255, 0, 0);
    textSize(30);
    text("¯\\_(°~°)_/¯", 820, 700);
  }
}

int sum(int x, int y) {
  return mines[y-1][x-1] + mines[y-1][x] + mines[y-1][x+1]+ mines[y][x-1] + mines[y][x+1] + mines[y+1][x-1] + mines[y+1][x] + mines[y+1][x+1];
}

void displayMines(int r, int g, int b) {
  fill(r, g, b);
  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      if ( mines[j][i] == 1) {
        //text('X', (i-0.72)*100, (j-0.28)*100);
        image(mine, (i-1)*100+25, (j-1)*100+25, 50, 50);
      }
    }
  }
}

void checkWin() {
  int sum = minesNumber;
  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      sum += plateau[j][i] != ' ' ? 1 : 0;
    }
  }
  if (sum == 64) { 
    displayMines(130, 255, 130);
    text("Bravo", 820, 700);
  }
}