class Flag {
  public final int x;
  public final int y;
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
  
  public void makeTarget() {
    this.targetState = true;
  }
  
  public boolean isTarget() {
    return this.targetState;
  }
  
  public float getSize() {
    return this.size; 
  }
}
