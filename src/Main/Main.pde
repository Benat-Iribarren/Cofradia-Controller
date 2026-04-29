ArduinoController arduino;
GameController game;
BoardController control;
SerialData inputData;
SerialData outputData;

void setup() {
  //arduino = new ArduinoController(this, 0);
  game = new GameController();
  control = new BoardController(); 
  inputData = new SerialData();
}

void draw() {
  if(frameCount == 60 * 3) inputData.button = 1;
  
  //SerialData inputData = arduino.read();
  System.out.println("Input: " + inputData.toString());

  if(inputData.gameState < 2) {
    outputData = game.update(inputData);
    System.out.println("Output: " + outputData.toString());
    
    if(inputData.gameState < 2) game.render();
  } else {
    outputData = control.update(inputData);
    System.out.println("Output: " + outputData.toString());
  }
  
  //arduino.write(outputData);
  
  if(outputData.gameState == 2 && control == null) {
    control = new BoardController();
  }
  
  inputData = outputData;
}
