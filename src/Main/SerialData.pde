class SerialData {
  public int gameState; // 0: Sin empezar | 1: Juego digital | 2: Juego físico | 3: Perdida
  public int button; 
  public int servo1;
  public int servo2;
  public int[] ledStrip;
  public int vibrationCoin;
  public int ldr1;
  public int ldr2;
  public int ldr3;
  public int potentiometer;
  public int gyroscope;
  
  public SerialData() {
    this.gameState= 0;
    this.button = 0;
    this.servo1 = 0;
    this.servo2 = 0;
    this.ledStrip = new int[Config.NUM_LEDS];
    this.vibrationCoin = 0;
    this.ldr1 = 0;
    this.ldr2 = 0;
    this.ldr3 = 0;
    this.potentiometer = 0;
    this.gyroscope = 0;
  }
  
  @Override
  public String toString() {
    return "SerialData{" +
            "gameSate=" + gameState +
            ", button=" + button +
            ", servo1=" + servo1 +
            ", servo2=" + servo2 +
            ", ledStrip=" + java.util.Arrays.toString(ledStrip) +
            ", vibrationCoin=" + vibrationCoin +
            ", ldr1=" + ldr1 +
            ", ldr2=" + ldr2 +
            ", ldr3=" + ldr3 +
            ", potentiometer=" + potentiometer +
            ", gyroscope=" + gyroscope +
            '}';
  }
}
