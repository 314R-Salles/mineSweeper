int[][] mines = new int[10][10];
char[][] plateau = new char[10][10];
boolean gameOver = false;

void setup() {
  size(800, 800);
  textSize(50);

  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      mines[j][i] = random(1)>0.8 ? 1 : 0;
      plateau[j][i] = ' ';
      line(j*100, 0, j*100, 800);
      line(0, j*100, 800, j*100);
    }
  }
  mines[1][1] = mines[8][8] = mines[8][1] = mines[1][8] = 0 ;
}

void draw() {}

void mouseClicked() {
  if (!gameOver) {
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
    displayMines(255,0,0);
  }
}

int sum(int x, int y) {
  return mines[y-1][x-1] + mines[y-1][x] + mines[y-1][x+1]+ mines[y][x-1] + mines[y][x+1] + mines[y+1][x-1] + mines[y+1][x] + mines[y+1][x+1];
}

void displayMines(int r, int g, int b) {
  fill(r, g, b);
  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      if ( mines[j][i] == 1)
        text('X', (i-0.72)*100, (j-0.28)*100);
    }
  }
}

void checkWin() {
  int sum = 0;
  for (int j=1; j<9; j++) {
    for (int i=1; i<9; i++) {
      sum += mines[j][i];
      sum += plateau[j][i] != ' ' ? 1 : 0;
    }
  }
  if (sum == 64) { 
    displayMines(0,255,0);
  }
}