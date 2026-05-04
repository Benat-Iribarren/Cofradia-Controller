class BoardController {
  int flag1CheckCounter;
  int flag2CheckCounter;
  int flag3CheckCounter;
  boolean wasLdr1Dark = false;
  boolean wasLdr2Dark = false;
  boolean wasLdr3Dark = false;
  
  int lastTriggerTime1 = 0;
  int lastTriggerTime2 = 0;
  int lastTriggerTime3 = 0;
  int cooldownMillis = 500; 
  
  public BoardController() {
    this.flag1CheckCounter = 0;
    this.flag2CheckCounter = 0;
  }
  
  SerialData update(SerialData input) {
    SerialData output = input;
    
    /** SERVO */
    
    
    
    /** LDR */
    
    boolean isLdr1Dark = input.ldr1 < 100;
    
    if (isLdr1Dark && !wasLdr1Dark && (millis() - lastTriggerTime1 > cooldownMillis)) {
      
      if (flag1CheckCounter < 2) {
        output.ledStrip[flag1CheckCounter] = 1;
        flag1CheckCounter++;
        
        lastTriggerTime1 = millis(); 
      }
    }
    
    wasLdr1Dark = isLdr1Dark; 
    
    boolean isLdr2Dark = input.ldr2 < 100;
    
    if (isLdr2Dark && !wasLdr2Dark && (millis() - lastTriggerTime2 > cooldownMillis)) {
      
      if (flag2CheckCounter < 2) {
        output.ledStrip[2 + flag2CheckCounter] = 1;
        flag2CheckCounter++;
        
        lastTriggerTime2 = millis();
      }
    }
    
    wasLdr2Dark = isLdr2Dark;
    
    boolean isLdr3Dark = input.ldr3 < 100;
    
    if (isLdr3Dark && !wasLdr3Dark && (millis() - lastTriggerTime3 > cooldownMillis)) {
      
      if (flag3CheckCounter < 2) {
        output.ledStrip[4 + flag3CheckCounter] = 1;
        flag3CheckCounter++;
        
        lastTriggerTime3 = millis();
      }
    }
    
    wasLdr3Dark = isLdr3Dark;
  
    return output;
  }
}
