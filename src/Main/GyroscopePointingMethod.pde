class GyroscopePointingMethod {
  private final float deadZone;
  private final float maxTilt;
  private final float sensitivity;

  private boolean calibrated;
  private float centerX;
  private float centerY;

  public GyroscopePointingMethod() {
    this.deadZone = 0.12;
    this.maxTilt = 350;
    this.sensitivity = 0.60; // velocidad de aeleracion
    this.calibrated = false;
    this.centerX = 512;
    this.centerY = 512;
  }

  public void move(Ball ball, SerialData input, Difficulty difficulty) {
    if(!calibrated && input.gyroX != 0 && input.gyroY != 0) {
      centerX = input.gyroX;
      centerY = input.gyroY;
      calibrated = true;

      println("Gyro calibrated -> X: " + centerX + " Y: " + centerY);
    }

    float movementX = (centerX - input.gyroX) / maxTilt;
    float movementY = (input.gyroY - centerY) / maxTilt;

    movementX = constrain(movementX, -1, 1);
    movementY = constrain(movementY, -1, 1);

    movementX = applyDeadZone(movementX);
    movementY = applyDeadZone(movementY);

    ball.accelerate(
      movementX * difficulty.getSpeedMultiplier() * sensitivity,
      movementY * difficulty.getSpeedMultiplier() * sensitivity
    );
  }

  private float applyDeadZone(float value) {
    if(abs(value) < deadZone) {
      return 0;
    }

    float sign = value > 0 ? 1 : -1;

    float normalized = map(abs(value), deadZone, 1, 0, 1);
    normalized = constrain(normalized, 0, 1);

    return sign * normalized;
  }
}
