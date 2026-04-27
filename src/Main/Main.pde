ArduinoController arduino;
GameController game;

void setup() {
  arduino = new ArduinoController();
  game = new GameController();
}

void draw() {
  SerialData inputData = arduino.read();
  
  SerialData outputData = game.update(inputData);
  
  arduino.write(outputData);
  
  game.render();
}
