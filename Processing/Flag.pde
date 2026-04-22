class Flag {
  public final int x;
  public final int y;
  private final int flagColor;
  
  public Flag(int x, int y, int flagColor) {
    this.x = x;
    this.y = y;
    this.flagColor = flagColor;
  }
  
  void draw() {
    fill(flagColor);
    circle(this.x, this.y, 10);  
  }
}
