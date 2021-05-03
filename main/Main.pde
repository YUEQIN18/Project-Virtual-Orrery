import peasy.*;
PImage sunTexture,mercuryT,venusT,earthT,moonT,marsT,jupiterT,saturnT,uranusT,neptuneT;
Body Sun,Mercury,Venus,Earth,Moon,Mars,Jupiter,Saturn,Uranus,Neptune,Pluto;

PeasyCam cam;
cam.setMinimumDistance(600);
cam.setMaximumDistance(5000);

void setup(){
  size(2400,1200, P3D ); //<>//
  noStroke();
  sunTexture = loadImage("sun.jpg");
  mercuryT = loadImage("mercury.jpg");
  venusT = loadImage("venus.jpg");
  earthT = loadImage("earth.jpg");
  marsT = loadImage("mars.jpg");
  jupiterT = loadImage("jupiter.jpg");
  saturnT = loadImage("saturn.jpg");
  uranusT = loadImage("uranus.jpg");
  neptuneT = loadImage("neptune.jpg");
  
  Sun = new Body("Sun",0,0,1.9891e30,1.391684e9/6,0,0,587.28,0,sunTexture);
  Mercury = new Body("Mercury",0,0,0.330e24,4.879e6,4.6e10,6.98e10,88,1407.6,mercuryT);
  Venus = new Body("Venus",0,0,4.87e24,1.2104e7,1.075e11,1.089e11,224.7,-5832.5,venusT);
  Earth = new Body("Earth",0,0,5.97e24,1.2756e7,1.471e11,1.521e11,365.2425,23.9,earthT);
  Mars = new Body("Mars",0,0,0.642e24,6.792e7,2.066e11,2.492e11,687.0,24.6,marsT);
  Jupiter = new Body("Jupiter",0,0,1898e24,1.42984e8,7.405e11,8.166e11,4331,9.9,jupiterT);
  Saturn = new Body("Saturn",0,0,568e24,1.20536e8,1.3526e12,1.5145e12  ,10747,10.7,saturnT);
  Uranus = new Body("Uranus",0,0,86.8e24,5.1118e7,2.7413e12,3.0036e12,30589,-17.2,uranusT);
  Neptune = new Body("Neptune",0,0,102e24,4.9528e7,4.4445e12,4.5457e12,59800,16.1,neptuneT);
  
  
  cam = new PeasyCam(this,5000);
  Sun.initialPosition();
  Mercury.initialPosition();
  Venus.initialPosition();
  Earth.initialPosition();
  Mars.initialPosition();
  Jupiter.initialPosition();
  Saturn.initialPosition();
  Uranus.initialPosition();
  Neptune.initialPosition();
}

void draw(){
  pointLight(255, 255, 255, 0, 0, 0); //for the normal behaviour of the sun light 
  int timestep = 10000;
  Mercury.setPosition(timestep);
  Venus.setPosition(timestep);
  Earth.setPosition(timestep);
  Mars.setPosition(timestep);
  Jupiter.setPosition(timestep);
  Saturn.setPosition(timestep);
  Uranus.setPosition(timestep);
  Neptune.setPosition(timestep);
  Mercury.display();
  Venus.display();
  Earth.display();
  Mars.display();
  Jupiter.display();
  Saturn.display();
  Uranus.display();
  Neptune.display();
  ambientLight(255, 255, 255, 0, 0, 0); //ambientLight in the center of the sun
  Sun.display();
 }
