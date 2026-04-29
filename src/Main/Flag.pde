class Flag {
  public final float x;
  public final float y;
  private final int flagColor;
  private final float size;
  private boolean targetState;
  
  public Flag(int x, int y, int flagColor, int size) {
    this.x = x;
    this.y = y;
    this.flagColor = flagColor;
    this.size = size;
    this.targetState = false;
  }
  
  void draw() {
    if(this.isTarget()) fill(color(128, 0, 128));
    else fill(flagColor);
    circle(this.x, this.y, 10);  
  }
  
  public Flag makeTarget() {
    this.targetState = true;
    return this;
  }
  
  public boolean isTarget() {
    return this.targetState;
  }
  
  public float getSize() {
    return this.size; 
  }
}
