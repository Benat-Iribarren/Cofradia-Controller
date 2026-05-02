int[] COLOR_SCHEME_1 = {
  color(137, 207, 240),   // Azul pastel
  color(255, 182, 193),   // Rosa Pastel
  color(152, 255, 152)    // Verde Menta
};

int[] COLOR_SCHEME_2 = {
  color(20, 0, 50),       // Morado Medianoche
  color(0, 255, 255),     // Cyan Neon
  color(255, 0, 255)      // Magenta Neon
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
  private int livesLeft;
  private Difficulty difficultyBuilder;
  private Difficulty difficulty;

  public GameController() {
    this.livesLeft = 3;
    this.difficultyBuilder = new Difficulty(1, 1, 1, new int[0]);
    this.difficulty = new Difficulty(1, 1, 1, new int[]{0});
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

  SerialData update(SerialData input) {
    SerialData output = input;

    if(input.gameState == 0 && input.button == 1) {

      /** El numero de flags viene definido por
          el valor del potenciometro (dificultad) */
      difficulty = difficultyBuilder.fromSensorValue(input.potentiometer, 4);

      for(int i=0; i<difficulty.getFlagIndexes().length; i++) {
        int flagIndex = difficulty.getFlagIndexes()[i];

        flags.add(new Flag(
          int(random(0, width)),
          int(random(0, height)),
          FLAG_COLORS[flagIndex % 3],
          15
        ));
      }

      flags.get(int(random(0, flags.size()))).makeTarget();
      output.gameState = 1;
      print("GAME STARTED\n");
    }

    if(input.gameState == 1) {
      difficulty = difficultyBuilder.fromSensorValue(input.potentiometer, 4);

      Flag target = null;
      for(Flag flag : flags) if(flag.isTarget()) target = flag;

      /** Movimiento con teclado
          TODO: Cambiar para mover segun datos de giroscopio */
      if(keyPressed && keyCode == UP) ball.accelerate(0, -difficulty.getSpeedMultiplier());
      if(keyPressed && keyCode == DOWN) ball.accelerate(0, difficulty.getSpeedMultiplier());
      if(keyPressed && keyCode == LEFT) ball.accelerate(-difficulty.getSpeedMultiplier(), 0);
      if(keyPressed && keyCode == RIGHT) ball.accelerate(difficulty.getSpeedMultiplier(), 0);

      float distance = dist(ball.getX(), ball.getY(), target.x, target.y);
      output.vibrationCoin = int(map(distance, 0, width, 1023, 0));

      for(int i=flags.size()-1; i>=0; i--) {
        Flag flag = flags.get(i);

        if(collision(ball.getX(), ball.getY(), ball.getSize()/2, flag)) {
          if(!flag.isTarget()) {
            livesLeft--;

            if(livesLeft == 0) {
              input.gameState = 3;
            }
          } else {
            flags.remove(i);

            if(flags.isEmpty() && livesLeft > 0) {
              input.gameState = 2;
            } else {
              flags.get(int(random(0, flags.size()))).makeTarget();
            }
          }
        }
      }
    }

    if(input.gameState == 2) {
      openVictoryWindow();
    }

    if(input.gameState == 3) {
      openDefeatWindow();
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

  void drawHeart(float centerX, float centerY, float radius, int c) {
    fill(c);
    beginShape();

    for(float t = 0; t <= TWO_PI; t += 0.05) {
      float x = 16 * pow(sin(t), 3);
      float y = -(13 * cos(t) - 5 * cos(2*t) - 2 * cos(3*t) - cos(4*t));

      vertex(centerX + (x * radius), centerY + (y * radius));
    }

    endShape(CLOSE);
  }

  void openVictoryWindow() {
    fill(colorScheme[2]);
    rect(width/2 - 250, height/2 - 75, 500, 150, 20);

    fill(0, 0, 0);
    textSize(50);
    text("Todas las banderas recogidas", width/2 - 125, height/2 - 25);

    fill(255);
    textSize(16);
    text("Ahora completa el tablero", width/2 - 50, height/2 + 50);
  }

  void openDefeatWindow() {
    fill(colorScheme[2]);
    rect(width/2 - 250, height/2 - 75, 500, 150, 20);

    fill(0, 0, 0);
    textSize(50);
    text("Game Over", width/2 - 125, height/2 - 25);

    fill(colorScheme[0]);
    rect(width/2 - 75, height/2 + 25, 120, 40, 5);

    fill(255);
    textSize(16);
    text("Reintentar", width/2 - 50, height/2 + 50);
  }
}
