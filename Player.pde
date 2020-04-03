// This holds some player information, like color and position.
// It also has some player methods for managing how a player moves.


class Player {

  color playerColor; 
  color originalColor; 
  int position;
  int score;
  int life; 
  int distance; 
  float pulserate;
  int pulsecount;
  int time; 
  int tempposition;
  boolean free=true; 
  boolean control;
  int colorcount; 
  int option; 



  Player(color playerColor, int _displaySize) { 
    originalColor=playerColor;
    position = int(random(1, _displaySize));
      
  }

  void blink() {
    updateDistance();
    pulseincrement();
    displaypulse();
    if (free==false) {
      dragon.dragonColor = color(255,0,0); 
      dragon.blink(); 
      position = tempposition; 
      playerColor = color(0, 0, 0); 
      time++;
    
    if (time>100) {
      position = tempposition;
      dragon.position = int(random(1, displaySize-1));
      if(dragon.position == target.position) {
        target.position = int(random(1, displaySize-1));
      }
      time=0;
      playerColor=originalColor; 
      dragon.dragonColor = color(0,0,0);
      life++;
      free=true;
    }
    }
  }

  void updateDistance() {
    distance = abs(dragon.position-position); 
    //pulserate = 0.25* distance * distance+6;
    pulserate = 2*distance+1;
  }

  void pulseincrement() {
    pulsecount++;
  }

  void displaypulse() {
    if (originalColor==color(255,220,0)) { 
     

      if (distance <=3) { 
        if (control) {
          if (pulsecount>=pulserate) {
            playerColor = color(255, 255, 230);
            control=false; 
            pulsecount=0;} 
            else {
            playerColor = color(255,220,0);}
        } else {
          if (pulsecount>=pulserate) {
            playerColor = color(255,220,0);
            control=true;
            pulsecount=0;
          } else {
            playerColor = color(255, 255, 230);}
        }
      }
    
    else {
        if (control) {
          if (pulsecount<pulserate) {
            playerColor = color(255, 255, 255/pulserate*pulsecount);}
          else{
            control=false; 
            pulsecount=0;}
          }
        else {
          if (pulsecount<pulserate) {
             playerColor = color(255, 255, 255-255/pulserate*pulsecount);}            
          else {   
            control=true;
            pulsecount=0;}
          }
        }
      }
    
    
    
    else { 
      
      if (distance <=3) { 
        if (control) {
          if (pulsecount>=pulserate) {
            playerColor = color(230, 255, 255);
            control=false; 
            pulsecount=0;} 
            else {
            playerColor = color(0,210,255);}
        } else {
          if (pulsecount>=pulserate) {
            playerColor = color(0,210,255);
            control=true;
            pulsecount=0;
          } else {
            playerColor = color(230, 255, 255);}
        }
      }
    
    else {
        if (control) {
          if (pulsecount<pulserate) {
            playerColor = color(255/pulserate*pulsecount, 255, 255);}
          else{
            control=false; 
            pulsecount=0;}
          }
        else {
          if (pulsecount<pulserate) {
             playerColor = color(255-255/pulserate*pulsecount, 255, 255);}            
          else {            
            control=true;
            pulsecount=0;}
          }
        }
      
  }
  }


    // Move player based on keyboard input
    void move(int _direction) {
      position = position + _direction;

      if (position == -1) {
        position = displaySize - 1;
      } else if (position == displaySize) {
        position = 0;
      }
    }
  }
