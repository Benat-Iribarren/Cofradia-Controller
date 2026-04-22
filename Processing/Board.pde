class Board {
  private final int pixelsWidth;
  private final int pixelsHeight;
  private final int boardColor;
  
  public Board(int pixelsWidth, int pixelsHeight, int boardColor) {
    this.pixelsWidth = pixelsWidth;
    this.pixelsHeight = pixelsHeight;
    this.boardColor = boardColor;
  }
  
  public void draw() {
    rect(0, 0, this.pixelsWidth, this.pixelsHeight);
  }
}
