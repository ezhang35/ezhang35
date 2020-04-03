import processing.serial.*;


Serial myPort;                       // The serial port
int[] serialInArray = new int[4];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
boolean firstContact = false;        // Whether we've heard from the microcontroller
// The starting post
int old_pos1 = 0;
int old_pos2 = 0;
int buttonOne, buttonTwo, pos1, pos2;              

void startSerial() {

  // Print a list of the serial ports for debugging purposes
  printArray(Serial.list());

  // Open whatever port is the one you're using.
  int portNumber = 0;
  String portName = Serial.list()[portNumber];
  myPort = new Serial(this, portName, 57600);
}


// This gets called whenever the serial port gets new data
void serialEvent(Serial myPort) {

  int inByte = myPort.read();        // read a byte from the serial port...

  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from the microcontroller.
  // Otherwise, add the incoming byte to the array of sensor values
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      myPort.write('A');       // ask for more
    }

    // this piece of code captures the sensor data coming in
  } else {

    serialInArray[serialCount] = inByte;    // Add the latest byte from the serial port to array
    serialCount++;                          // Increment count of how many data we've already received

    if (serialCount > 3 ) {           // If we have 3 bytes, that means we got everything and we are ready to act on it.

      buttonOne = serialInArray[0];
      buttonTwo = serialInArray[1];
      pos1 = serialInArray[2];
      pos2 = serialInArray[3];

      // Output to Processing console so we can see what incoming data looks like
      //println(joyX + "\t" + joyY + "\t" + buttonOne + "\t" + buttonTwo + "\t" + buttonRe + "\t" + pos);
      println(buttonOne + "\t" + buttonTwo + "\t" +pos1 + "\t" + pos2);


      executeEncoderInput(pos1, pos2, buttonOne, buttonTwo);


      myPort.write('A');        // Send a capital A to request new sensor readings
      serialCount = 0;          // Reset serialCount, so we can get a new stream
    }
  }
} 


void executeEncoderInput(int _pos1, int _pos2, int _buttonOne, int _buttonTwo) {


  if (old_pos1 < _pos1 ||(old_pos1 == 255 && _pos1 == 0)) {
    playerOne.move(1);
  } else if (old_pos1 > _pos1 || (old_pos1 == 0 && _pos1 == 255)) {
    playerOne.move(-1);
  }

  old_pos1 = _pos1;


  if (old_pos2 < _pos2 ||(old_pos2 == 255 && _pos2 == 0)) {
    playerTwo.move(1);
  } else if (old_pos2 > _pos2 || (old_pos2 == 0 && _pos2 == 255)) {
    playerTwo.move(-1);
  }

  old_pos2 = _pos2;

  if (_buttonOne == 0 && _buttonTwo == 0) {
    gameState = "RESET";
  }
}
