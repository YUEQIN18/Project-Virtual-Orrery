import peasy.*;

Planet sun;

PeasyCam cam;

PImage sunTexture;
PImage[] textures = new PImage[8];

void setup()
{
  size(2500, 2500, P3D);
  sunTexture = loadImage("Sun.jpg");
  textures[0] = loadImage("Mercury.jpg");
  textures[1] = loadImage("Venus.jpg");
  textures[2] = loadImage("Earth.jpg");
  textures[3] = loadImage("Mars.jpg");
  textures[4] = loadImage("Jupiter.jpg");
  textures[5] = loadImage("Saturn.jpg");
  textures[6] = loadImage("Uranus.jpg");
  textures[7] = loadImage("Neptune.jpg");
  
  
  cam = new PeasyCam(this, 5000); //the camera looks at the center(0,0,0) from 2000 units away
  sun = new Planet(200, 0, 0, sunTexture);
  sun.SpawnMoons(8, 1); //sets number of planets
  //sun.SpawnMoons(1, 1);
}

void draw()
{
  background(0);
  //pointLight(255, 255, 255, 0, 0, 0); //to have the light coming only from sun (each planet will be half lit and half dark) 
  lights(); //to have the lights in an uniform manner from all the planets
  //translate(width/2, height/2); //bringing sun to the center of the screen
  sun.disp();
  sun.orbit();
}
