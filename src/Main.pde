import peasy.*;

Planet sun = new Planet(100,0,0); 
//earth
//mars
//venus
//mercury
PeasyCam cam;

void setup(){
  size(1000,1000, P3D );
  cam = new PeasyCam(this,100);
  sun.spawn(2,1);
}

void draw(){
  background(0);
  lights();
  sun.show();
  sun.orbit();
 }
