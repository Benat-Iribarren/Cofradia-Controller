/**
 * Representa la dificultad del juego.
 * La dificultad define el nivel, la velocidad de movimiento,
 * el número de repeticiones y las banderas que deben seleccionarse.
 */
class Difficulty {
  private final int level;
  private final int speedMultiplier;
  private final int repetitions;
  private final int[] flagIndexes;

  /**
   * Construye un nuevo objeto Difficulty.
   *
   * @param level           El nivel de dificultad.
   * @param speedMultiplier El multiplicador de velocidad.
   * @param repetitions     El número de repeticiones.
   * @param flagIndexes     Los índices de las banderas seleccionadas.
   */
  public Difficulty(int level, int speedMultiplier, int repetitions, int[] flagIndexes) {
    this.level = level;
    this.speedMultiplier = speedMultiplier;
    this.repetitions = repetitions;
    this.flagIndexes = flagIndexes;
  }

  /**
   * Construye una dificultad a partir del valor recibido por el sensor.
   *
   * @param value      Valor del sensor entre 0 y 1023.
   * @param totalFlags Número total de banderas disponibles.
   * @return La dificultad calculada.
   */
  public Difficulty fromSensorValue(int value, int totalFlags) {
    int calculatedLevel = constrain(floor(map(value, 0, 1024, 1, 5)), 1, 4);

    return new Difficulty(
      calculatedLevel,
      calculatedLevel,
      calculatedLevel,
      buildFlagIndexes(totalFlags, calculatedLevel)
    );
  }

  /**
   * Construye un array con los índices de las banderas seleccionadas.
   *
   * @param totalFlags Número total de banderas disponibles.
   * @param amount     Número de banderas a seleccionar.
   * @return Array con los índices de las banderas.
   */
  private int[] buildFlagIndexes(int totalFlags, int amount) {
    int size = min(totalFlags, amount);
    int[] indexes = new int[size];

    for (int i = 0; i < size; i++) {
      indexes[i] = i;
    }

    return indexes;
  }

  /**
   * Obtiene el nivel de dificultad.
   *
   * @return El nivel de dificultad.
   */
  public int getLevel() {
    return this.level;
  }

  /**
   * Obtiene el multiplicador de velocidad.
   *
   * @return El multiplicador de velocidad.
   */
  public int getSpeedMultiplier() {
    return this.speedMultiplier;
  }

  /**
   * Obtiene el número de repeticiones.
   *
   * @return El número de repeticiones.
   */
  public int getRepetitions() {
    return this.repetitions;
  }

  /**
   * Obtiene los índices de las banderas seleccionadas.
   *
   * @return Los índices de las banderas seleccionadas.
   */
  public int[] getFlagIndexes() {
    return this.flagIndexes;
  }
}
