ArduinoController arduino;
GameController game;

void setup() {
  arduino = new ArduinoController(this, 0);
  game = new GameController();
}

void draw() {
  SerialData inputData = arduino.read();
  System.out.println("Input: " + inputData);
  
  SerialData outputData = game.update(inputData);
  System.out.println("Output: " + outputData);
  
  arduino.write(outputData);
  game.render();
}
