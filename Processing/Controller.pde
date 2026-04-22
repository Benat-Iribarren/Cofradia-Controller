//CONSTANTS DEFINITION
int[] COLOR_SCHEME_1 = {0, 155, 3};

int[] colorScheme = COLOR_SCHEME_1;
boardColor = colorScheme[0];
ballColor = colorScheme[1];

Board board = new Board(displayWidth, displayHeight, boardColor);
Ball ball = new Ball(displayWidth/2, displayHeight/2, displayWidth/25, ballColor);

void setup() {
    fullScreen();
    board.draw();
    ball.draw();
}

void draw() {

}
