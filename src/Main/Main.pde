ArduinoController arduino;
GameController game;

void setup() {
  arduino = new ArduinoController(this, 0);
  game = new GameController();
}

void draw() {
  //SerialData inputData = arduino.read();
  SerialData inputData = new SerialData();
  System.out.println("Input: " + inputData.toString());
  
  game.checkStart(inputData);
  SerialData outputData = game.update(inputData);
  System.out.println("Output: " + outputData.toString());
  
  //arduino.write(outputData);
  game.render();
}
