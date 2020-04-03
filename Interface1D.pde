
/* /////////////////////////////////////

  4.043 / 4.044 Design Studio: Advanced Interactions
  February  5, 2020
  Marcelo Coelho

  Note:
  - Don't forget to install gif library provided

*/ /////////////////////////////////////

import gifAnimation.*;                      // library for playing animated gifs

final static int displaySize = 30;          // how many pixels are visible in the game
final static int displayPixelSize = 20;     // how big should they look on screen


DisplayBuffer display = new DisplayBuffer(displaySize);    // aggregates our final visual output


Player playerOne = new Player(color(255,220,0), displaySize);             // Adding 2 players to the game
Player playerTwo = new Player(color(0,210,255),displaySize);
//Bomb bomb = new Bomb(color(0,0,0),displaySize);

Target target = new Target(color(0,255,0), displaySize);              // and one target for players to catch.
Dragon dragon = new Dragon(color(0,0,0), displaySize); 

Score score = new Score(color(0,0,0));   // Used to display winner's color                  
int scoreMax = 3;                        // Maximum number of points before game ends

Life life = new Life(color(0,0,0));   // Used to display winner's color                  
int lifeMax = 3;   

Controller controller = new Controller();   // this is where the state machine and software logic lives
String gameState = "PLAY";

PImage[] animation;



int currentFrame = 0;
int appFramerate = 30;
int numFrames =  30;



void settings() {
  
  size((displaySize*displayPixelSize), displayPixelSize);    // dynamically sets canvas size

}


void setup() {
    
  frameRate(appFramerate);     //  important to lock the framerate, so animations are smooth
  
  animation = Gif.getPImages(this, "Animation.gif");
  startSerial();  
}


void draw() { 

   // Not used, but you might find helpful to count frames for animations or synchronization
   //currentFrame = (currentFrame+1) % numFrames; 
   //println(currentFrame);
  
    // Runs state machine at determined framerate
  	controller.update();
}
