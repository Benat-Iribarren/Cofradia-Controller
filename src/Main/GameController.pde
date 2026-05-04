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

class GameController {
  
  private Board board;
  private Ball ball;
  private CopyOnWriteArrayList<Flag> flags;
  private int livesLeft;
  
  private int[] FLAG_COLORS;
  private int[] colorScheme = COLOR_SCHEME_3;
  
  private Difficulty difficultyBuilder;
  private Difficulty difficulty;
  
  public GameController() {
    this.livesLeft = 3;
    FLAG_COLORS = new int[]{color(0, 255, 0), color(255, 204, 0), color(255, 0, 0)};
    
    int boardColor = colorScheme[0];
    int ballColor = colorScheme[1];
    board = new Board(width, height, boardColor);
    ball = new Ball(width/2, height/2, width/25, ballColor);
    flags = new CopyOnWriteArrayList<Flag>();
    this.difficultyBuilder = new Difficulty(1, 1, 1, new int[0]);
    this.difficulty = new Difficulty(1, 1, 1, new int[]{0});
    setup();
  }

  SerialData update(SerialData input) {
    // --- STATE 0: START MENU ---
    if(input.gameState == 0 && input.button == 1) {
      
      int flagNum = int(random(3, 6)); // Will use potentiometer later
      
      for(int i = 0; i < flagNum; i++) {
        flags.add( new Flag(int(random(0, width)), int(random(0, height)), FLAG_COLORS[i%3], 15) );
      }
      
      flags.get(int(random(flags.size()))).makeTarget(); 
      
      input.gameState = 1;
      println("GAME STARTED");
    }
    
    // --- STATE 1: GAMEPLAY ---
    if(input.gameState == 1) {
      difficulty = difficultyBuilder.fromSensorValue(input.potentiometer, 4);

      Flag target = null;
      for(Flag flag : flags) {
        if(flag.isTarget()) target = flag;
      }
      
      if (target != null) { 
        float distance = dist(ball.getX(), ball.getY(), target.x, target.y);
        input.vibrationCoin = int(map(distance, 0, width, 1023, 0));
      }
      
      // Keyboard simulation (To be replaced by Gyro)
      if(keyPressed && keyCode == UP) ball.accelerate(0, -1);
      if(keyPressed && keyCode == DOWN) ball.accelerate(0, 1);
      if(keyPressed && keyCode == LEFT) ball.accelerate(-1, 0);
      if(keyPressed && keyCode == RIGHT) ball.accelerate(1, 0);
      
      // Collision Loop
      for(int i = flags.size()-1; i >= 0; i--) {
        Flag flag = flags.get(i);
        
        if( collision(ball.getX(), ball.getY(), ball.getSize()/2, flag) ) {
          
          if(!flag.isTarget()) {
            //livesLeft--;
            if(livesLeft <= 0) {
              input.gameState = 3;
            }
          } else {
            flags.remove(i);
            if(flags.isEmpty() && livesLeft > 0) {
              input.gameState = 2;
            } else {
              flags.get(int(random(flags.size()))).makeTarget();
            }
          }
        }
      }
    }
    
    // --- STATE 2 & 3: WIN/LOSS ---
    if(input.gameState == 2) {
      input.vibrationCoin = 0;
    }

    if(input.gameState == 3) {
      input.vibrationCoin = 0;
    }

    return input; 
  }
  
  boolean collision(float x1, float y1, float rad1, Flag flag) {
    float distance = dist(x1, y1, flag.x, flag.y);
    return distance < (rad1 + flag.getSize()/2);
  }
  
  void render(int currentState) {
    board.draw();
    ball.update();

    for(Flag flag : flags) {
      flag.draw();
    }
    for(int i = 0; i < livesLeft; i++) {
      drawHeart(40*(i+1), 30, 1, colorScheme[2]); 
    }
    
    if (currentState == 2) {
      openVictoryWindow();
    } else if (currentState == 3) {
      openDefeatWindow();
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
