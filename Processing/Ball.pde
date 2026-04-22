class Ball {
  private float x;
  private float y;
  private final float size;
  private final int ballColor;
  
  public Ball(float x, float y, float size, int ballColor) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.ballColor = ballColor;
  }
  
  public void draw() {
    circle(this.x, this.y, this.size);
  }
}
