import peasy.*;
PImage starBackground,sunTexture,mercuryT,venusT,earthT,moonT,marsT,jupiterT,saturnT,uranusT,neptuneT;
Body Sun,Mercury,Venus,Earth,Moon,Mars,Jupiter,Saturn,Uranus,Neptune,Pluto;
PeasyCam cam;
CameraState state;

Body[] solarSystem = new Body[10];

int timestep = 5000;
int radiusLevel = 500000;
int coordinateLevel = 200000000;

//void keyPressed() {
//  if (key == '1') {
//    cam.reset(600);
//    timestep = 10000;
//    Mercury.info = false;
//    Venus.info = false;
//    Earth.info = false;
//    Mars.info = false;
//    Jupiter.info = false;
//    Saturn.info = false;
//    Uranus.info = false;
//    Neptune.info = false;
//  }
//  if (key == '2') {
//    cam.lookAt(Mercury.x/(10000*10000), Mercury.y/(10000*10000), Mercury.z/(10000*10000),10.0,600);
//    timestep = 100;
//    Mercury.turnOnInfo();
//  }
//    if (key == '3') {
//    cam.lookAt(Venus.x/(10000*10000), Venus.y/(10000*10000), Venus.z/(10000*10000),10.0,600);
//    timestep = 100;
//    Venus.turnOnInfo();
//  }
//  if (key == '4') {
//    cam.lookAt(Earth.x/(10000*10000), Earth.y/(10000*10000), Earth.z/(10000*10000),10.0,600);
//    timestep = 100;
//    Earth.turnOnInfo();
//  }
//  if (key == '5') {
//    cam.lookAt(Mars.x/(10000*10000), Mars.y/(10000*10000), Mars.z/(10000*10000),10.0,600);
//    timestep = 100;
//    Mars.turnOnInfo();
//  }
//  if (key == '6') {
//    cam.lookAt(Jupiter.x/(10000*10000), Jupiter.y/(10000*10000), Jupiter.z/(10000*10000),1000.0,600);
//    timestep = 100;
//    Jupiter.turnOnInfo();
//  }
//  if (key == '7') {
//    cam.lookAt(Saturn.x/(10000*10000), Saturn.y/(10000*10000), Saturn.z/(10000*10000),1000.0,600);
//    timestep = 100;
//    Saturn.turnOnInfo();
//  }
//  if (key == '8') {
//    cam.lookAt(Uranus.x/(10000*10000), Uranus.y/(10000*10000), Uranus.z/(10000*10000),200.0,600);
//    timestep = 100;
//    Uranus.turnOnInfo();
//  }
//  if (key == '9') {
//    cam.lookAt(Neptune.x/(10000*10000), Neptune.y/(10000*10000), Neptune.z/(10000*10000),10.0,600);
//    timestep = 100;
//    Neptune.turnOnInfo();
//  }
 
//}

void setup(){
  size(displayWidth,displayHeight, P3D); //<>//
  frameRate(120);
  smooth(4);
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
  starBackground = loadImage("stars.jpg");
  starBackground.resize(width, height);
  
  
  solarSystem[0] = new Body("Sun",0,0,1.9891e30,1.391684e9/6,0,0,587.28,0,sunTexture);
  solarSystem[1] = new Body("Mercury",0,0,0.330e24,4.879e6,4.6e10,6.98e10,88,1407.6,mercuryT);
  solarSystem[2] = new Body("Venus",0,0,4.87e24,1.2104e7,1.075e11,1.089e11,224.7,-5832.5,venusT);
  solarSystem[3] = new Body("Earth",0,0,5.97e24,1.2756e7,1.471e11,1.521e11,365.2425,23.9,earthT);
  solarSystem[4] = new Body("Mars",0,0,0.642e24,6.792e7,2.066e11,2.492e11,687.0,24.6,marsT);
  solarSystem[5] = new Body("Jupiter",0,0,1898e24,1.42984e8,7.405e11,8.166e11,4331,9.9,jupiterT);
  solarSystem[6] = new Body("Saturn",0,0,568e24,1.20536e8,1.3526e12,1.5145e12  ,10747,10.7,saturnT);
  solarSystem[7] = new Body("Uranus",0,0,86.8e24,5.1118e7,2.7413e12,3.0036e12,30589,-17.2,uranusT);
  solarSystem[8] = new Body("Neptune",0,0,102e24,4.9528e7,4.4445e12,4.5457e12,59800,16.1,neptuneT);
  
  
  //Sun = new Body("Sun",0,0,1.9891e30,1.391684e9/6,0,0,587.28,0,sunTexture);
  //Mercury = new Body("Mercury",0,0,0.330e24,4.879e6,4.6e10,6.98e10,88,1407.6,mercuryT);
  //Venus = new Body("Venus",0,0,4.87e24,1.2104e7,1.075e11,1.089e11,224.7,-5832.5,venusT);
  //Earth = new Body("Earth",0,0,5.97e24,1.2756e7,1.471e11,1.521e11,365.2425,23.9,earthT);
  //Mars = new Body("Mars",0,0,0.642e24,6.792e7,2.066e11,2.492e11,687.0,24.6,marsT);
  //Jupiter = new Body("Jupiter",0,0,1898e24,1.42984e8,7.405e11,8.166e11,4331,9.9,jupiterT);
  //Saturn = new Body("Saturn",0,0,568e24,1.20536e8,1.3526e12,1.5145e12  ,10747,10.7,saturnT);
  //Uranus = new Body("Uranus",0,0,86.8e24,5.1118e7,2.7413e12,3.0036e12,30589,-17.2,uranusT);
  //Neptune = new Body("Neptune",0,0,102e24,4.9528e7,4.4445e12,4.5457e12,59800,16.1,neptuneT);
  
  cam = new PeasyCam(this,5000);
  cam.rotateX(-PI*3/8);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(8000);

  for(int i = 0; i < 9; i++){
    solarSystem[i].initialPosition();
  }
  //Sun.initialPosition();
  //Mercury.initialPosition();
  //Venus.initialPosition();
  //Earth.initialPosition();
  //Mars.initialPosition();
  //Jupiter.initialPosition();
  //Saturn.initialPosition();
  //Uranus.initialPosition();
  //Neptune.initialPosition();

}

void draw(){
  background(starBackground);  
  pointLight(255, 255, 255, 0, 0, 0); //for the normal behaviour of the sun light 
  for(int i = 1; i < 9; i++){
    solarSystem[i].setPosition(timestep);
    solarSystem[i].display();
    solarSystem[i].displayOrbit();
  }

  //Mercury.setPosition(timestep);
  //Venus.setPosition(timestep);
  //Earth.setPosition(timestep);
  //Mars.setPosition(timestep);
  //Jupiter.setPosition(timestep);
  //Saturn.setPosition(timestep);
  //Uranus.setPosition(timestep);
  //Neptune.setPosition(timestep);

  //Mercury.display();
  //Venus.display();
  //Earth.display();
  //Mars.display();
  //Jupiter.display();
  //Saturn.display();
  //Uranus.display();
  //Neptune.display();
  ambientLight(255, 255, 255, 0, 0, 0); //ambientLight in the center of the sun
  solarSystem[0].display();
  //Sun.display();
  
  cam.beginHUD();   
  fill(255, 140, 0);     
  rect(0, 0, 350, 60);   
  fill(255);
  textSize(40);
  text("Virtual Orrery", 40, 40);
  cam.endHUD();

 }
