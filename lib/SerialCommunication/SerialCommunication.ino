#include <Wire.h>
#include <Adafruit_NeoPixel.h>
#include <Servo.h> // Bring the standard servo library back!

// --- Pin Definitions ---
#define NEOPIXEL_PIN 2
#define NUMPIXELS 9
#define VIBRATION_PIN 6
#define SERVO1_PIN 3
#define SERVO2_PIN 5
#define LDR1_PIN A0
#define LDR2_PIN A1
#define LDR3_PIN A2
#define POT_PIN A3

// MPU6050 I2C PINS
// SDA -> A4
// SCL -> A5
#define MPU_ADDR 0x68

// --- Objects ---
Adafruit_NeoPixel pixels(NUMPIXELS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);
Servo servo1, servo2;

// We expect 1 byte for the LED, 1 byte for the Servo, and 3 bytes per NeoPixel
int expectedBytes = 3 + (NUMPIXELS * 3); 

void setup() {
  Serial.begin(115200); 
  
  // Setup Basic Hardware
  //pinMode(BASIC_LED_PIN, OUTPUT);
  servo1.attach(SERVO1_PIN);
  servo2.attach(SERVO2_PIN);
  
  // Setup NeoPixels
  pixels.begin();
  pixels.clear();
  pixels.show();

  // Setup MPU6050
  Wire.begin();

  Wire.beginTransmission(MPU_ADDR);
  Wire.write(0x6B);      // Power management register
  Wire.write(0);         // Wake up MPU6050
  Wire.endTransmission(true);
  
  // Say hello to Processing to start the loop
  Serial.println("READY"); 
}

void loop() {
  // Wait until Processing sends the full packet of instructions
  if (Serial.available() >= expectedBytes) {

    int vibrationSpeed = Serial.read();
    int servo1Angle = Serial.read();
    int servo2Angle = Serial.read();

    analogWrite(VIBRATION_PIN, vibrationSpeed);
    servo1.write(servo1Angle);
    servo2.write(servo2Angle);
    
    // 3. EXECUTE NEOPIXELS
    for (int i = 0; i < NUMPIXELS; i++) {
      int r = Serial.read();
      int g = Serial.read();
      int b = Serial.read();
      pixels.setPixelColor(i, pixels.Color(r, g, b));
    }
    pixels.show(); 
  }

  // 4. READ MPU6050
  Wire.beginTransmission(MPU_ADDR);
  Wire.write(0x3B);      // Start accelerometer registers
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_ADDR, 6, true);

  int16_t accX = Wire.read() << 8 | Wire.read();
  int16_t accY = Wire.read() << 8 | Wire.read();
  int16_t accZ = Wire.read() << 8 | Wire.read();

  int gyroXValue = map(accX, -17000, 17000, 0, 1023);
  int gyroYValue = map(accY, -17000, 17000, 0, 1023);
  int gyroZValue = map(accZ, -17000, 17000, 0, 1023);

  gyroXValue = constrain(gyroXValue, 0, 1023);
  gyroYValue = constrain(gyroYValue, 0, 1023);
  gyroZValue = constrain(gyroZValue, 0, 1023);

  // 5. READ OTHER SENSORS
  int ldr1Value = analogRead(LDR1_PIN);
  int ldr2Value = analogRead(LDR2_PIN);
  int ldr3Value = analogRead(LDR3_PIN);
  int potValue  = analogRead(POT_PIN);
  
  // 6. SEND ALL SENSOR DATA BACK TO PROCESSING
  // Format: gyroX,gyroY,gyroZ,ldr1,ldr2,ldr3,pot
  Serial.print(gyroXValue);
  Serial.print(",");
  Serial.print(gyroYValue);
  Serial.print(",");
  Serial.print(gyroZValue); 
  Serial.print(",");
  Serial.print(ldr1Value);
  Serial.print(",");
  Serial.print(ldr2Value);
  Serial.print(",");
  Serial.print(ldr3Value);
  Serial.print(",");
  Serial.println(potValue);

  delay(50);
}