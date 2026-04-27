import processing.serial.*;
import cc.arduino.*;

class ArduinoController {
  Arduino arduino;
  
  public ArduinoController() {
    
  }
  
  SerialData read() {
    SerialData in = new SerialData();
    return in;
  }
  
  void write(SerialData out) {
    
  }
}
