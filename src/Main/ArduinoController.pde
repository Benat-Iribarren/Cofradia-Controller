import processing.serial.*;
import cc.arduino.*;

class ArduinoController {
  Arduino arduino;
  
  public ArduinoController(PApplet parent, int portIndex) {
    arduino = new Arduino(parent, Arduino.list()[portIndex], 57600);
    
    // SERVOS
    arduino.pinMode(Config.SERVO1_PIN, Arduino.SERVO);
    arduino.pinMode(Config.SERVO2_PIN, Arduino.SERVO);
    
    // POTENTIOMETER
    arduino.pinMode(Config.POT_PIN, Arduino.ANALOG);
    
    // LED STRIP
    
    // VIBRATION COIN
    arduino.pinMode(Config.VC_PIN, Arduino.OUTPUT);
    
    // LDRs
    arduino.pinMode(Config.LDR1_PIN, Arduino.ANALOG);
    arduino.pinMode(Config.LDR2_PIN, Arduino.ANALOG);
    arduino.pinMode(Config.LDR3_PIN, Arduino.ANALOG);
    
    // GYRO
    arduino.pinMode(Config.GYRO_PIN, Arduino.ANALOG);
  }
  
  SerialData read() {
    SerialData in = new SerialData();
    
    // Devuelve entero entre 0 y 1023
    // TODO: mapear a escala
    in.ldr1 = arduino.analogRead(Config.LDR1_PIN);
    in.ldr2 = arduino.analogRead(Config.LDR2_PIN);
    in.ldr3 = arduino.analogRead(Config.LDR3_PIN);
    
    in.potentiometer = arduino.analogRead(Config.POT_PIN);
    
    // ¡Con esta libreria no se puede
    // hacer funcionar las tiras LED!
    return in;
  }
  
  void write(SerialData out) {
    arduino.analogWrite(Config.SERVO1_PIN, out.servo1);
    arduino.analogWrite(Config.SERVO2_PIN, out.servo2);
    
    arduino.analogWrite(Config.VC_PIN, out.vibrationCoin);
  }
}
