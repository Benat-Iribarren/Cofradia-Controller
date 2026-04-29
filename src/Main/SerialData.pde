class SerialData {
  public int gameStart;
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
    this.gameStart = 0;
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
            "servo1=" + servo1 +
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
