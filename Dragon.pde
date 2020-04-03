class Dragon {

  color dragonColor;
  int position;
  int count; 
  boolean blinking; 
  //int time=0; 


  Dragon(color _c, int _displaySize) {
    dragonColor = _c;
    position = int(random(1, _displaySize));
  }


  void blink() {
    count++; 
    if ((count > 10)&(count<20)){
      dragonColor = color(0,0,0); }
    if (count>=20){
      dragonColor = color(255,0,0);
      count=0;}
  }
}
