class Flag {
  private final int x;
  private final int y;
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
