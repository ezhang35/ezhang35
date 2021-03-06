
// This is where your state machines and game logic lives


class Controller {

  Controller() {
  }


  void update() {

    // STATE MACHINE
    switch (gameState) {

    case "PLAY":

      // clear screen w frame rate so we can start fresh      
      display.clear();

      playerOne.blink();
      playerTwo.blink();

      // show all players in the right place, by adding them to display buffer
      display.setPixel(playerOne.position, playerOne.playerColor);
      display.setPixel(playerTwo.position, playerTwo.playerColor);
      //   display.setPixel(bomb.position, bomb.bombColor);

      // now add the target
      display.setPixel(target.position, target.targetColor);
      display.setPixel(dragon.position, dragon.dragonColor);
      //dragon.blink(); 


      // check if player has caught target
      if (playerOne.position == target.position) {
        playerOne.score++;
        gameState = "COLLISION";
      }

      // check if other player has caught target        
      if (playerTwo.position == target.position) {
        playerTwo.score++;
        gameState = "COLLISION";
      }

      if (playerOne.position == dragon.position) {
        playerOne.tempposition = playerOne.position;
        playerOne.free=false;
      }


      if (playerTwo.position == dragon.position) {
        playerTwo.tempposition = playerTwo.position;
        playerTwo.free=false;
      }

      if (playerOne.life >=  lifeMax) {
        score.scoreColor = playerTwo.originalColor;
        gameState = "SCORE";
      } else if (playerTwo.life >= lifeMax) {
        score.scoreColor = playerOne.originalColor;
        gameState = "SCORE";
      }


      // NOTE: if you have lots of players or targets, you could consider adding them to an array of objects
      // This page explains how: https://processing.org/tutorials/arrays/

      break;

      // This state is used to play an animation, after a target has been caught by a player 
    case "COLLISION":

      // play explosion animation one frame at a time
      int frameToShow = nextFrame(animation.length);
      //println(frameToShow);
      for (int i = 0; i < animation[0].width; i++) {            // looping through every pixel on a frame and adding to buffer
        display.setPixel(i, animation[frameToShow].pixels[i]);
      }  

      //  if animation is done playing, it's time to move on to another state
      if (frameToShow == animation.length-1) {          

        // We've hit score max, this player wins
        if (playerOne.score >=  scoreMax) {
          score.scoreColor = playerOne.originalColor;
          gameState = "SCORE";

          // We've hit score max, this player wins
        } else if (playerTwo.score >= scoreMax) {
          score.scoreColor = playerTwo.originalColor;
          gameState = "SCORE";

          // We haven't hit the limit yet, keep playing
        } else {  
          target.position = int(random(1, 30));
          gameState = "PLAY";
        }
      }

      break;


      // Game is over. Show winner and clean everything up so we can start a new game
    case "SCORE":

      playerOne.score = 0;
      playerTwo.score = 0;
      playerOne.life = 0;
      playerTwo.life = 0;        

      //light up w winner color by populating all pixels in buffer with their color
      display.setAllPixels(score.scoreColor);      

      break;
      
      case "RESET":

      target.position = int(random(1, displaySize-1));
      if(target.position == playerOne.position) {
        target.position = target.position+1;
      }      
       if(target.position == playerTwo.position) {
        target.position = target.position+1;
      } 
      
      dragon.position = int(random(1, displaySize-1));
      if(dragon.position == target.position) {
        dragon.position = dragon.position+1;
      }
      if(dragon.position == playerOne.position) {
        dragon.position = dragon.position+1;
      }      
       if(dragon.position == playerTwo.position) {
        dragon.position = dragon.position+1;
      }  
      gameState = "PLAY";
    

      break;

      // Not used, it's here just for code consistency
    default:
      break;
    }

    // Now that we are done populating the buffer, let's show it!
    display.show();
  }
}


// Helper function to advance animation frames 
int nextFrame(int _animationSize) {
  if (currentFrame < _animationSize-1) {
    currentFrame++;
  } else {
    currentFrame = 0;
  }
  return currentFrame;
}  



// All the keyboard  input goes here.
// If your game starts getting too complex, you could move the key detection events insde of the player class. 
// It's a more advanced ways of doing of the same thing. Example here: https://forum.processing.org/two/discussion/comment/34602/#Comment_34602
void keyPressed() {
  int keyIndex = -1;

  //println(key);

  if (key == 'A' || key == 'a') {
    playerOne.move(-1);
  }

  if (key == 'D' || key == 'd') {
    playerOne.move(1);
  }


  if (key == 'J' || key == 'j') {
    playerTwo.move(-1);
  }

  if (key == 'L' || key == 'l') {
    playerTwo.move(1);
  }

  if (key == 'R' || key == 'r') {
    gameState = "RESET";
  }
}
