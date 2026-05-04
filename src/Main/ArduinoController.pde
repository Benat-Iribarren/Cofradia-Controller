import processing.serial.*;
import cc.arduino.*;
import java.util.concurrent.CopyOnWriteArrayList;

class ArduinoController {
  int gyroX, gyroY, gyroZ;
  int ldr1, ldr2, ldr3;
  int pot;
  
  Serial serialPort;
  
  public ArduinoController(PApplet parent, int portIndex) {
    serialPort = new Serial(parent, Serial.list()[portIndex], 115200);
    serialPort.bufferUntil('\n');
  }
  
  SerialData read(SerialData previous) {
    SerialData in = previous;
    in.gyroX = this.gyroX;
    in.gyroY = this.gyroY;
    in.gyroZ = this.gyroZ;
    
    in.ldr1 = this.ldr1;
    in.ldr2 = this.ldr2;
    in.ldr3 = this.ldr3;
    
    in.potentiometer = this.pot; 
    
    return in;
  }
  
  void write(SerialData out) {
    byte[] packet = new byte[3 + (Config.NUM_LEDS * 3)];
    
    // Pack the individual actuators first
    packet[0] = (byte) out.vibrationCoin;
    packet[1] = (byte) out.servo1;
    packet[2] = (byte) out.servo2;
    
    // Pack the LED array
    for (int i = 0; i < Config.NUM_LEDS; i++) {
      int offset = 3 + (i * 3); 
      packet[offset]     = (byte) red(out.ledStrip[i]);
      packet[offset + 1] = (byte) green(out.ledStrip[i]);
      packet[offset + 2] = (byte) blue(out.ledStrip[i]);
    }
    
    serialPort.write(packet);
  }
  
  void parseData(String data) {
    data = trim(data); 
    
    if (data.equals("READY")) {
      return;
    }
    
    String[] values = split(data, ',');
    
    if (values.length == 7) { 
      try{
        this.gyroX = int(values[0]);
        this.gyroY = int(values[1]);
        this.gyroZ = int(values[2]);
        this.ldr1  = int(values[3]);
        this.ldr2  = int(values[4]);
        this.ldr3  = int(values[5]);
        this.pot   = int(values[6]); 
      } catch(Exception e) {
        println("Corrupted serial data received, ignoring frame.");
      }
    } 
  }
}
