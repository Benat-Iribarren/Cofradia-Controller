/**
 * Representa una Pelota (Ball) con física 2D básica, incluyendo velocidad, aceleración y fricción.
 * La pelota gestiona su propio movimiento, las restricciones de los límites de la pantalla y su renderizado.
 */
class Ball {
  private float x;
  private float y;
  private final float size;
  private float speedX;
  private float speedY;
  
  /** El coeficiente de fricción que se aplica a la velocidad de la pelota en cada fotograma. */
  private final float friction = 0.95f;
  
  /** La velocidad máxima que la pelota puede alcanzar en cualquiera de los ejes. */
  private final float maxSpeed = 100;
  
  /** El color de la pelota, almacenado como un número entero (formato de color de Processing). */
  private final int ballColor;
  
  /**
   * Construye un nuevo objeto Ball.
   * * @param initialX  La coordenada x inicial de la pelota.
   * @param initialY  La coordenada y inicial de la pelota.
   * @param size      El diámetro de la pelota.
   * @param ballColor El color de la pelota.
   */
  public Ball(float initialX, float initialY, float size, int ballColor) {
    this.x = initialX;
    this.y = initialY;
    this.size = size;
    this.speedX = 0;
    this.speedY = 0;
    this.ballColor = ballColor;
  }
  
  /**
   * Dibuja la pelota en la pantalla utilizando su posición, tamaño y color actuales.
   */
  public void draw() {
    fill(this.ballColor);
    circle(this.x, this.y, this.size);
  }
  
  /**
   * Incrementa la velocidad actual de la pelota sumando las cantidades de aceleración dadas.
   * * @param accelerationX La cantidad de aceleración a aplicar en el eje x.
   * @param accelerationY La cantidad de aceleración a aplicar en el eje y.
   */
  public void accelerate(float accelerationX, float accelerationY) {
    this.speedX += accelerationX;
    this.speedY += accelerationY;
  }
  
  /**
   * Actualiza el estado físico de la pelota. Este método aplica los límites de velocidad, 
   * calcula la fricción, actualiza la posición actual basándose en la velocidad, 
   * restringe la pelota para que no salga de los límites y la vuelve a dibujar.
   */
  public void update() {
    // Limita la velocidad máxima para que no se mueva infinitamente rápido
    this.speedX = constrain(this.speedX, -maxSpeed, maxSpeed);
    this.speedY = constrain(this.speedY, -maxSpeed, maxSpeed);
    
    // Aplica fricción para que la pelota vaya frenando gradualmente
    this.speedX *= friction;
    this.speedY *= friction;
    
    // Actualiza la posición en X y la restringe a los límites definidos
    this.x += this.speedX;
    this.x = constrain(this.x, (size/2), width - (size/2));
    
    // Actualiza la posición en Y y la restringe a los límites definidos
    this.y += this.speedY;
    this.y = constrain(this.y, (size/2), height - size);
    
    // Dibuja la pelota en su nueva posición
    draw();
  }
  
  /**
   * Obtiene la coordenada x actual de la pelota.
   * * @return La coordenada x.
   */
  public float getX() {
    return this.x;
  }
  
  /**
   * Obtiene la coordenada y actual de la pelota.
   * * @return La coordenada y.
   */
  public float getY() {
    return this.y;
  }
}
