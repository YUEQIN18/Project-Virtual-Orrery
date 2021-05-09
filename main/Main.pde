import peasy.*;
import controlP5.*;
import processing.opengl.*;

PImage starBackground,sunTexture,mercuryT,venusT,earthT,moonT,marsT,jupiterT,saturnT,saturnRingT,uranusT,neptuneT;
String sunText, mercuryText, venusText, earthText,moonText, marsText, jupiterText, saturnText, uranusText, neptuneText;
PeasyCam cam;
ControlP5 time, timeslider, planetInfo;

Body[] solarSystem = new Body[10];
  
int timestep = 5000;
int radiusLevel = 500000;
int coordinateLevel = 200000000;
boolean sliderOn = false;

void setup(){
  //size(2400,1200, P3D); //<>//
  fullScreen(P3D);
  frameRate(120);
  smooth(4);

  sunTexture = loadImage("sun.jpg");
  mercuryT = loadImage("mercury.jpg");
  venusT = loadImage("venus.jpg");
  earthT = loadImage("earth.jpg");
  moonT = loadImage("moon.jpg");
  marsT = loadImage("mars.jpg");
  jupiterT = loadImage("jupiter.jpg");
  saturnT = loadImage("saturn.jpg");
  saturnRingT = loadImage("saturn_ring.png");
  uranusT = loadImage("uranus.jpg");
  neptuneT = loadImage("neptune.jpg");
  starBackground = loadImage("stars.jpg");
  starBackground.resize(width, height);
  
  sunText = "The Sun is a yellow dwarf star, a hot ball of glowing gases at the heart of our solar system. Its gravity holds everything from the biggest planets to tiny debris in its orbit.";
  mercuryText = "Mercury—the smallest planet in our solar system and closest to the Sun—is only slightly larger than Earth's Moon. Mercury is the fastest planet, zipping around the Sun every 88 Earth days.";
  venusText = "Venus is the second planet from the Sun. It is named after the Roman goddess of love and beauty. Venus spins slowly in the opposite direction from most planets.";
  earthText= "Earth—our home planet—is the only place we know of so far that’s inhabited by living things. It's also the only planet in our solar system with liquid water on the surface.";
  moonText = "Earth's Moon is the only place beyond Earth where humans have set foot, so far. The Moon makes our planet more livable by moderating how much it wobbles on its axis.";
  marsText= "Mars is a dusty, cold, desert world with a very thin atmosphere. There is strong evidence Mars was—billions of years ago—wetter and warmer, with a thicker atmosphere.";
  jupiterText= "Jupiter is more than twice as massive than the other planets of our solar system combined. The giant planet's Great Red spot is a centuries-old storm bigger than Earth.";
  saturnText= "Adorned with a dazzling, complex system of icy rings, Saturn is unique in our solar system. The other giant planets have rings, but none are as spectacular as Saturn's.";
  uranusText= "Uranus—seventh planet from the Sun—rotates at a nearly 90-degree angle from the plane of its orbit. This unique tilt makes Uranus appear to spin on its side.";
  neptuneText= "Neptune—the eighth and most distant major planet orbiting our Sun—is dark, cold and whipped by supersonic winds. It was the first planet located through mathematical calculations, rather than by telescope.";
  
  solarSystem[0] = new Body("Sun",0,0,1.9891e30,1.391684e9/6,0,0,587.28,0,sunTexture,sunText);
  solarSystem[1] = new Body("Mercury",0,0,0.330e24,4.879e6,4.6e10,6.98e10,88,1407.6,mercuryT,mercuryText);
  solarSystem[2] = new Body("Venus",0,0,4.87e24,1.2104e7,1.075e11,1.089e11,224.7,-5832.5,venusT,venusText);
  solarSystem[3] = new Body("Earth",0,0,5.97e24,1.2756e7,1.471e11,1.521e11,365.2425,23.9,earthT,earthText);
  solarSystem[4] = new Body("Mars",0,0,0.642e24,6.792e7,2.066e11,2.492e11,687.0,24.6,marsT,marsText);
  solarSystem[5] = new Body("Jupiter",0,0,1898e24,1.42984e8,7.405e11,8.166e11,4331,9.9,jupiterT,jupiterText);
  solarSystem[6] = new Body("Saturn",0,0,568e24,1.20536e8,1.3526e12,1.5145e12  ,10747,10.7,saturnT,saturnText);
  solarSystem[7] = new Body("Uranus",0,0,86.8e24,5.1118e7,2.7413e12,3.0036e12,30589,-17.2,uranusT,uranusText);
  solarSystem[8] = new Body("Neptune",0,0,102e24,4.9528e7,4.4445e12,4.5457e12,59800,16.1,neptuneT,neptuneText);
  solarSystem[9] = new Body("Moon",0,0,0.073e24,3.475e6,0.363e9,0.406e9,27.3,655.7,moonT,moonText);
  
  cam = new PeasyCam(this,5000);
  cam.rotateX(-PI*3/8);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(8000);
  
  //create button for user to adjust time scale --
  //addButton(theName, theValue, theX, theY, theW, theH);
  PFont p = createFont("Verdana", 20);
  ControlFont font = new ControlFont(p);
  cp5.setFont(font);
  cp5.addButton("slowDown", 1000, 0, 120, 180, 60).setId(1);
  cp5.addButton("speedUp", 1000, 180, 120, 180, 60).setId(2);
  cp5.setAutoDraw(false);
  
  
  time = new ControlP5(this);
  time.addButton("TimeAdjuster").setPosition(0,660).setSize(360,60);
  time.setAutoDraw(false);
  timeslider = new ControlP5(this);
  timeslider.addSlider("timestep").setPosition(400,660).setSize(360,60).setRange(100,10000).setValue(5000);
  timeslider.setAutoDraw(false);

  planetInfo = new ControlP5(this);
  planetInfo.addButton("Sun").setPosition(0,60).setSize(100,60);
  planetInfo.addButton("Mercury").setPosition(0,120).setSize(100,60);
  planetInfo.addButton("Venus").setPosition(0,180).setSize(100,60);
  planetInfo.addButton("Earth").setPosition(0,240).setSize(100,60);
  planetInfo.addButton("Mars").setPosition(0,300).setSize(100,60);
  planetInfo.addButton("Jupiter").setPosition(0,360).setSize(100,60);
  planetInfo.addButton("Saturn").setPosition(0,420).setSize(100,60);
  planetInfo.addButton("Uranus").setPosition(0,480).setSize(100,60);
  planetInfo.addButton("Neptune").setPosition(0,540).setSize(100,60);
  planetInfo.addButton("Moon").setPosition(0,600).setSize(100,60);
  planetInfo.setAutoDraw(false);
  
  for(int i = 0; i < 10; i++){
    solarSystem[i].initialPosition();
  }

}

void draw(){
  background(starBackground); 
  pointLight(255, 255, 255, 0, 0, 0); //for the normal behaviour of the sun light 
  for(int i = 1; i < 10; i++){
    solarSystem[i].setPosition(timestep);
    solarSystem[i].display();
    solarSystem[i].displayOrbit();
  } 
  
  ambientLight(255, 255, 255, 0, 0, 0); //ambientLight in the center of the sun
  solarSystem[0].display();
  
  GUI();
 }
 
void speedUp(float theValue) {
  if(timestep < 25000){
    timestep = timestep + int(theValue);
  }
  //println("a button event. "+theValue);
}

void slowDown(float theValue) {
  if(timestep > 2000){
    timestep = timestep - int(theValue);
  }
  //println("a button event. "+theValue);
}

void controlEvent(ControlEvent theEvent) {
  println("Button " + theEvent.getController().getId() + " pressed");
}

 void GUI(){
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  for(int i = 1; i < 10; i++){
    solarSystem[i].displayInfo();
  }
  fill(255, 140, 0);     
  rect(0, 0, 360, 60); 
  fill(255);
  textSize(40);
  text("Virtual Orrery", 40, 45);
  time.draw();
  planetInfo.draw();
  if(sliderOn == true){
    timeslider.draw();
  }
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
 }
 
void TimeAdjuster() {
  sliderOn = !sliderOn;
}


void Sun(){
  cam.reset();
  cam.lookAt(solarSystem[0].x/coordinateLevel, solarSystem[0].y/coordinateLevel, solarSystem[0].z/coordinateLevel,1000,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[0].turnOnInfo();
}

void Mercury(){
  cam.lookAt(solarSystem[1].x/coordinateLevel, solarSystem[1].y/coordinateLevel, solarSystem[1].z/coordinateLevel,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[1].turnOnInfo();
}
 
void Venus(){
  cam.lookAt(solarSystem[2].x/coordinateLevel, solarSystem[2].y/coordinateLevel, solarSystem[2].z/coordinateLevel,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[2].turnOnInfo();
}
void Earth(){
  cam.lookAt(solarSystem[3].x/coordinateLevel, solarSystem[3].y/coordinateLevel, solarSystem[3].z/coordinateLevel,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[3].turnOnInfo();
}
void Mars(){
  cam.lookAt(solarSystem[4].x/coordinateLevel, solarSystem[4].y/coordinateLevel, solarSystem[4].z/coordinateLevel,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[4].turnOnInfo();
}
void Jupiter(){
  cam.lookAt(solarSystem[5].x/coordinateLevel/2, solarSystem[5].y/coordinateLevel/2, solarSystem[5].z/coordinateLevel/2,500,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[5].turnOnInfo();
}
void Saturn(){
  cam.lookAt(solarSystem[6].x/coordinateLevel/2, solarSystem[6].y/coordinateLevel/2, solarSystem[6].z/coordinateLevel/2,500,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[6].turnOnInfo();
}
void Uranus(){
  cam.lookAt(solarSystem[7].x/coordinateLevel/3, solarSystem[7].y/coordinateLevel/3, solarSystem[7].z/coordinateLevel/3,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[7].turnOnInfo();
}
void Neptune(){
  cam.lookAt(solarSystem[8].x/coordinateLevel/3, solarSystem[8].y/coordinateLevel/3, solarSystem[8].z/coordinateLevel/3,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[8].turnOnInfo();
}
void Moon(){
  cam.lookAt(solarSystem[9].x/coordinateLevel, solarSystem[9].y/coordinateLevel, solarSystem[9].z/coordinateLevel,10,600);
  timestep = 100;
  for(int i = 0; i < 10; i++){
    solarSystem[i].info = false;
  }
  solarSystem[9].turnOnInfo();
}
