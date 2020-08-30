int[][] mines = new int[10][10];
char[][] plateau = new char[10][10];
boolean gameOver = false;
int minesNumber = 0;
PImage mine;

void setup() {

  mine = loadImage("mine.png");
  size(1000, 800);

  initialize();
}

void draw() {
}

void mouseClicked() {
  if (!gameOver && mouseX<=800) {
    unveil(mouseX/100 +1, mouseY/100 +1);
    checkWin();
  } else if (mouseX>820 && mouseX<980 && mouseY>700 && mouseY<750) {
    initialize();
  }
}

void initialize() {

  // reset game properties
  minesNumber=0;
  gameOver = false;

  // clear screen
  background(150);

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
  fill(255, 0, 0); // red
  rect(820, 700, 160, 50);
  fill(255); // white
  text("Mines: " + minesNumber, 820, 50);
  text("Restart", 850, 735);
  textSize(50);
}


void unveil(int x, int y) {
  if (mines[y][x] != 1 && plateau[y][x] == ' ') {
    int minesAround = sum(x, y);
    plateau[y][x] = (char) ( minesAround + 48);
    text(plateau[y][x], (x-0.72)*100, (y-0.28)*100);
    if (minesAround == 0) unveil0(x,y);
  } else if (mines[y][x] == 1) {
    gameOver = true;
    displayMines();
    textSize(30);
    fill(255, 0, 0); // red
    text("¯\\_(°~°)_/¯", 820, 670);
  }
}

int sum(int x, int y) {
  return mines[y-1][x-1] + mines[y-1][x] + mines[y-1][x+1]+ mines[y][x-1] + mines[y][x+1] + mines[y+1][x-1] + mines[y+1][x] + mines[y+1][x+1];
}

void unveil0(int x, int y) {
  unveil(x-1, y-1);
  unveil(x-1, y);
  unveil(x-1, y+1);
  unveil(x, y-1);
  unveil(x, y+1);
  unveil(x+1, y-1);
  unveil(x+1, y);
  unveil(x+1, y+1);
}

void displayMines() {
  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      if ( mines[j][i] == 1) {
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
    fill(130, 255, 130); // green 
    displayMines();
    text("Bravo", 830, 670);
  }
}