class SerialData {
  public int gameState; // 0: Sin empezar | 1: Juego digital | 2: Juego físico | 3: Perdida
  public int button; 
  public int servo1, servo2;
  public color[] ledStrip = new color[Config.NUM_LEDS];
  public int vibrationCoin;
  public int ldr1, ldr2, ldr3;
  public int potentiometer;
  public int gyroX, gyroY, gyroZ;
  
  public SerialData() {
    this.gameState= 0;
    this.button = 0;
    this.servo1 = 0;
    this.servo2 = 0;
    for (int i = 0; i < Config.NUM_LEDS; i++) {
      ledStrip[i] = color(0, 0, 0); // Start all LEDs off
    }
    this.vibrationCoin = 0;
    this.ldr1 = 0;
    this.ldr2 = 0;
    this.ldr3 = 0;
    this.potentiometer = 0;
    this.gyroX = 0;
    this.gyroY = 0;
    this.gyroZ = 0;
  }
  
  @Override
  public String toString() {
    return "SerialData{" +
            "gameSate=" + gameState +
            ", potentiometer=" + potentiometer +
            ", button=" + button +
            ", servo1=" + servo1 +
            ", servo2=" + servo2 +
            ", ledStrip=" + java.util.Arrays.toString(ledStrip) +
            ", vibrationCoin=" + vibrationCoin +
            ", ldr1=" + ldr1 +
            ", ldr2=" + ldr2 +
            ", ldr3=" + ldr3 +
            ", gyroX=" + gyroX +
            ", gyroY=" + gyroY +
            ", gyroZ=" + gyroZ +
            '}';
  }
}
