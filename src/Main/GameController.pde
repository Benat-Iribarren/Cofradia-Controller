int[] COLOR_SCHEME_1 = {
  color(137, 207, 240),   // Azul pastel
  color(255, 182, 193),   // Rosa Pastel
  color(152, 255, 152)    // Verde Menta
};
int[] COLOR_SCHEME_2 = {
    color(20, 0, 50),      // Morado Medianoche
    color(0, 255, 255),    // Cyan Neon
    color(255, 0, 255)     // Magenta Neon
};
int[] COLOR_SCHEME_3 = {
  color(34, 139, 34),     // Verde Bosque
  color(238, 214, 175),   // Arena
  color(204, 85, 0)       // Terracota
};
int[] FLAG_COLORS;

int[] colorScheme = COLOR_SCHEME_3;

Board board;
Ball ball;
ArrayList<Flag> flags;
int flagNum = 4;

class GameController extends Thread {
  public GameController() {
    setup();
  }
  
  void setup() {
      fullScreen();
      FLAG_COLORS = new int[]{color(0, 255, 0), color(255, 204, 0), color(255, 0, 0)};
      
      // Inicializacion del juego
      int boardColor = colorScheme[0];
      int ballColor = colorScheme[1];
      board = new Board(width, height, boardColor);
      ball = new Ball(width/2, height/2, width/25, ballColor);
      flags = new ArrayList<>();
      for(int i=0; i<flagNum; i++) {
        flags.add( new Flag(int(random(0, width)), int(random(0, height)), FLAG_COLORS[i%3]) );
      }
  }
  
  SerialData update(SerialData input) {
    SerialData output = new SerialData();
    
    // Movimiento con teclado
    // Se cambiara para mover con giroscopio
    if(keyPressed && keyCode == UP) ball.accelerate(0, -1);
    if(keyPressed && keyCode == DOWN) ball.accelerate(0, 1);
    if(keyPressed && keyCode == LEFT) ball.accelerate(-1, 0);
    if(keyPressed && keyCode == RIGHT) ball.accelerate(1, 0);
    
    for(int i=flags.size()-1; i>=0; i--) {
      Flag flag = flags.get(i);
      if( collision(ball.getX(), ball.getY(), flag.x, flag.y) )
        flags.remove(i);
    }
    
    return output;
  }
  
  // Efecto de colision de prueba, más tarde será implementado
  // con un bitmap
  boolean collision(float x1, float y1, float x2, float y2) {
    float distance = dist(x1, y1, x2, y2);
    if(distance < (ball.getSize()/2) + 5) {
      return true;
    }
    return false;
  }
  
  void render() {
    board.draw();
    ball.update();
    for(Flag flag : flags) {
      flag.draw();
    }
  }
}
