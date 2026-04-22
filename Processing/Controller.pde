int[] COLOR_SCHEME_1 = {0, 255, 3};
int[] FLAG_COLORS;

int[] colorScheme = COLOR_SCHEME_1;

Board board;
Ball ball;
ArrayList<Flag> flags;
int flagNum = 4;

void setup() {
    fullScreen();
    FLAG_COLORS = new int[]{color(0, 255, 0), color(255, 204, 0), color(255, 0, 0)};
    
    //BOARD AND BALL INITIALIZATION
    int boardColor = colorScheme[0];
    int ballColor = colorScheme[1];
    board = new Board(width, height, boardColor);
    ball = new Ball(displayWidth/2, displayHeight/2, displayWidth/25, ballColor);
    
    //FLAG SETUP
    flags = new ArrayList<>();
    for(int i=0; i<flagNum; i++) {
      flags.add( new Flag(int(random(0, width)), int(random(0, height)), FLAG_COLORS[i%3]) );
    }
}

void draw() {
  board.draw();
  if(keyPressed && keyCode == UP) ball.accelerate(0, -1);
  if(keyPressed && keyCode == DOWN) ball.accelerate(0, 1);
  if(keyPressed && keyCode == LEFT) ball.accelerate(-1, 0);
  if(keyPressed && keyCode == RIGHT) ball.accelerate(1, 0);
  ball.update();
  collision();
  for(Flag flag : flags) {
    flag.draw();
  }
}

void collision() {
  
}
