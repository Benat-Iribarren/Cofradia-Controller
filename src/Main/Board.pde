/**
 * Representa el tablero o fondo del juego.
 * Esta clase almacena las dimensiones y el color del área de juego, 
 * y se encarga de dibujarse a sí misma en la pantalla.
 */
class Board {
  
  /** El ancho del tablero en píxeles. */
  private final int pixelsWidth;
  
  /** La altura del tablero en píxeles. */
  private final int pixelsHeight;
  
  /** El color del tablero, almacenado como un número entero (formato de color de Processing). */
  private final int boardColor;
  
  /**
   * Construye un nuevo objeto Board.
   * * @param pixelsWidth  El ancho total del tablero.
   * @param pixelsHeight La altura total del tablero.
   * @param boardColor   El color de fondo del tablero.
   */
  public Board(int pixelsWidth, int pixelsHeight, int boardColor) {
    this.pixelsWidth = pixelsWidth;
    this.pixelsHeight = pixelsHeight;
    this.boardColor = boardColor;
  }
  
  /**
   * Dibuja el tablero en la pantalla.
   * Rellena el área con el color especificado y dibuja un rectángulo 
   * que comienza desde la esquina superior izquierda (0, 0) cubriendo 
   * el ancho y alto definidos.
   */
  public void draw() {
    fill(this.boardColor);
    rect(0, 0, this.pixelsWidth, this.pixelsHeight);
  }
}
