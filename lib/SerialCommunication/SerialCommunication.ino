#include <Wire.h>
#include <Adafruit_NeoPixel.h>
#include <MPU6050.h>
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

// --- Objects ---
Adafruit_NeoPixel pixels(NUMPIXELS, NEOPIXEL_PIN, NEO_GRB + NEO_KHZ800);
MPU6050 mpu;
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
  Wire.setClock(400000);
  mpu.initialize();
  
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
    
    // 4. READ SENSORS (Gyro + LDR)
    int16_t ax, ay, az, gx, gy, gz;
    mpu.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
    int ldr1Value = analogRead(LDR1_PIN);
    int ldr2Value = analogRead(LDR2_PIN);
    int ldr3Value = analogRead(LDR3_PIN);
    int potValue  = analogRead(POT_PIN);
    
    // 5. SEND ALL SENSOR DATA BACK TO PROCESSING
    // Format: gyroX,gyroY,gyroZ,ldrValue
    Serial.print(gx);
    Serial.print(",");
    Serial.print(gy);
    Serial.print(",");
    Serial.print(gz); 
    Serial.print(",");
    Serial.print(ldr1Value);
    Serial.print(",");
    Serial.print(ldr2Value);
    Serial.print(",");
    Serial.print(ldr3Value);
    Serial.print(",");
    Serial.println(potValue);
  }
}