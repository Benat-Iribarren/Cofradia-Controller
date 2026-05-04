ArduinoController arduino;
GameController game;
BoardController control;
SerialData inputData;
SerialData outputData;
SerialData previousState;

int lastMessageTime = 0;

void setup() {
  fullScreen();
  
  game = new GameController();
  control = new BoardController(); 
  inputData = new SerialData();
  outputData = new SerialData();
  previousState = new SerialData();
  arduino = new ArduinoController(this, 0);
}

void draw() {
  previousState = outputData;
  
  arduino.updateSerial();
  inputData = arduino.read(previousState);
  print("Input: " + inputData.toString() + '\n');
  
  if(inputData.gameState <= 3) {
    outputData = game.update(inputData); 
    print("Output: " + outputData.toString() + '\n');
    game.render(inputData.gameState);                       
  } else {
    outputData = control.update(inputData);
  }
  
  if (millis() - lastMessageTime > 50) {
    arduino.write(outputData);
    lastMessageTime = millis();
  }
}

void keyPressed() {
  if (key == ' ' && inputData.gameState == 0) {
    inputData.button = 1; 
  }
}
