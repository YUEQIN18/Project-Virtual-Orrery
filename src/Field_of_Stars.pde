//Starfield effect
Star[] stars = new Star[1500];

void setup() {
  size(1800, 1800);
  for(int i=0; i<stars.length; i++){
    stars[i] = new Star();
  }
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  
  for(int i=0; i<stars.length; i++){
    stars[i].update();
    stars[i].show();
  }
  
}
