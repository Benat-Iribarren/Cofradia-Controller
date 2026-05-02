ArduinoController arduino;
GameController game;
BoardController control;
SerialData inputData;
SerialData outputData;

void setup() {
  arduino = new ArduinoController(this, 0);
  game = new GameController();
  control = new BoardController(); 
  inputData = new SerialData();
}

void draw() {
  SerialData sensorData = arduino.read();

  inputData.potentiometer = sensorData.potentiometer;
  inputData.ldr1 = sensorData.ldr1;
  inputData.ldr2 = sensorData.ldr2;
  inputData.ldr3 = sensorData.ldr3;

  if(frameCount == 60 * 3) inputData.button = 1;
  
  System.out.println("Input: " + inputData.toString());

  if(inputData.gameState < 2) {
    outputData = game.update(inputData);
    System.out.println("Output: " + outputData.toString());
    
    if(inputData.gameState < 2) game.render();
  } else {
    outputData = control.update(inputData);
    System.out.println("Output: " + outputData.toString());
  }
  
  arduino.write(outputData);
  
  if(outputData.gameState == 2 && control == null) {
    control = new BoardController();
  }
  
  inputData = outputData;
}
