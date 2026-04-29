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

class GameController {
  private int gameState; // 0: Sin empezar | 1: En curso | 2: Ganada | 3: Perdida
  private int livesLeft;
  
  public GameController() {
    this.gameState = 0;
    this.livesLeft = 3;
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
  }
  
  void checkStart(SerialData input) {
    if(input.gameStart == 1) this.gameState = 1;;
  }
  
  SerialData update(SerialData input) {
    SerialData output = input;
    /** La partida no cambia de estado
        hasta que no se pulse comenzar */
    
    /** El numero de flags viene definido por
        el valor del potenciometro (dificultad) */
    //int flagNum = input.potentiometer%6;
    if(this.gameState == 0) {
      if(flags.size() > Config.MAX_FLAGS) {
        int flagNum = int(random(1, 6));
        for(int i=0; i<flagNum; i++) {
          flags.add( new Flag(int(random(0, width)), int(random(0, height)), FLAG_COLORS[i%3], 15) );
        }
        flags.get(int(random(0, flagNum))).makeTarget();
      }
    }
    
    if(this.gameState == 1) {
      output = new SerialData();
      
      /** LOGICA DEL JUEGO 
     
          Movimiento con teclado
          TODO: Cambiar para mover segun datos de giroscopio */
      if(keyPressed && keyCode == UP) ball.accelerate(0, -1);
      if(keyPressed && keyCode == DOWN) ball.accelerate(0, 1);
      if(keyPressed && keyCode == LEFT) ball.accelerate(-1, 0);
      if(keyPressed && keyCode == RIGHT) ball.accelerate(1, 0);
      
      for(int i=flags.size()-1; i>=0; i--) {
        Flag flag = flags.get(i);
        if( collision(ball.getX(), ball.getY(), ball.getSize()/2, flag) ) {
          if(!flag.isTarget()) {
            livesLeft--;
            if(livesLeft == 0) {
              this.gameState = 3;
            }
          } else {
            flags.remove(i);
            flags.get(int(random(0, flags.size()-1))).makeTarget();
          }
        }
      }
    }
    
    if(this.gameState == 2) {
    
    }
    
    if(this.gameState == 3) {
    
    }

    return output;
  }
  
  // Efecto de colision de prueba
  // TODO: Cambiar a implementación con bitmap
  boolean collision(float x1, float y1, float rad1, Flag flag) {
    float distance = dist(x1, y1, flag.x, flag.y);
    if(distance < rad1 + flag.getSize()/2) {
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
    for(int i=0; i<livesLeft; i++) {
      drawHeart(40*(i+1), 30, 1, colorScheme[2]);
    }
  }
  
  void changeGameState() {
    this.gameState = (this.gameState + 1)%3;
  }
  
  void drawHeart(float centerX, float centerY, float radius, int c) {
    fill(c);
    beginShape();
    
    // Iterate through the angle 't' from 0 to 2*PI
    for (float t = 0; t <= TWO_PI; t += 0.05) {
      
      // Calculate the base x and y coordinates
      float x = 16 * pow(sin(t), 3);
      float y = -(13 * cos(t) - 5 * cos(2*t) - 2 * cos(3*t) - cos(4*t));
      
      // Scale by the radius and translate to the center point
      vertex(centerX + (x * radius), centerY + (y * radius));
    }
    
    endShape(CLOSE);
  }
}
