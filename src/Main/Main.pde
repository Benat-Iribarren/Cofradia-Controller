ArduinoController arduino;
GameController game;
BoardController control;
SerialData inputData;
SerialData outputData;
SerialData previousState;

int lastMessageTime = 0;
boolean readyToSend = false;

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
  
  inputData = arduino.read(previousState);
  print("Input: " + inputData.toString() + '\n');
  
  if(inputData.gameState <= 3) {
    outputData = game.update(inputData); 
    print("Output: " + outputData.toString() + '\n');
    game.render(inputData.gameState);                       
  } else {
    outputData = control.update(inputData);
  }
  
  if (readyToSend == true) {
    arduino.write(outputData);
    readyToSend = false; 
    lastMessageTime = millis();
  }
  
  if (millis() - lastMessageTime > 500) {
    println("Handshake dropped! Restarting communication...");
    if (arduino != null && outputData != null) {
      arduino.write(outputData); 
    }
    lastMessageTime = millis(); 
  }
}

void serialEvent(Serial p) {
  if (arduino == null || game == null || control == null) return;

  String input = p.readStringUntil('\n');
  
  if (input != null) {
    arduino.parseData(input);
    readyToSend = true;
  }
}

void keyPressed() {
  if (key == ' ' && inputData.gameState == 0) {
    inputData.button = 1; 
  }
}
