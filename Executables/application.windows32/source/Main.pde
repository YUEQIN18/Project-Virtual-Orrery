import peasy.*;
import controlP5.*;
import processing.opengl.*;

PShape saturnRings;
PImage starBackground,sunTexture,mercuryT,venusT,earthT,moonT,marsT,jupiterT,saturnT,saturnRingT,uranusT,neptuneT;
String sunText, mercuryText, venusText, earthText,moonText, marsText, jupiterText, saturnText, uranusText, neptuneText,halleyText;
PeasyCam cam;
ControlP5 time, timeSlider, planetInfo, planetFollow;

Body[] solarSystem = new Body[11];
Body[] asteroidBelt = new Body[1666];
  
int timestep = 5000;
int maxTimeStep = 50000;
int minTimeStep = 1000;
int radiusLevel = 500000;
int coordinateLevel = 200000000; //<>//
boolean sliderOn = false;
boolean orbitOn = true;
color tailColor = color(150,150,250);

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
  halleyText = "";
  
  solarSystem[0] = new Body("Sun",0,0,1.9891e30,1.391684e9/6,0,0,587.28,0,0,sunTexture,sunText);
  solarSystem[1] = new Body("Mercury",0,0,0.330e24,4.879e6,4.6e10,6.98e10,88,1407.6,0.03,mercuryT,mercuryText);
  solarSystem[2] = new Body("Venus",0,0,4.87e24,1.2104e7,1.075e11,1.089e11,224.7,-5832.5,2.64,venusT,venusText);
  solarSystem[3] = new Body("Earth",0,0,5.97e24,1.2756e7,1.471e11,1.521e11,365.2425,23.9,23.44,earthT,earthText);
  solarSystem[4] = new Body("Mars",0,0,0.642e24,6.792e7,2.066e11,2.492e11,687.0,24.6,25.19,marsT,marsText);
  solarSystem[5] = new Body("Jupiter",0,0,1898e24,1.42984e8,7.405e11,8.166e11,4331,9.9,3.13,jupiterT,jupiterText);
  solarSystem[6] = new Body("Saturn",0,0,568e24,1.20536e8,1.3526e12,1.5145e12  ,10747,10.7,26.73,saturnT,saturnText);
  solarSystem[7] = new Body("Uranus",0,0,86.8e24,5.1118e7,2.7413e12,3.0036e12,30589,-17.2,82.23,uranusT,uranusText);
  solarSystem[8] = new Body("Neptune",0,0,102e24,4.9528e7,4.4445e12,4.5457e12,59800,16.1,28.32,neptuneT,neptuneText);
  solarSystem[9] = new Body("Moon",0,0,0.073e24,3.475e6,0.363e9,0.406e9,27.3,655.7,6.68,moonT,moonText);
  solarSystem[10] = new Body("Halley's comet",10e15,1.2e7,8.8e10,5.3e12/4);
    
  cam = new PeasyCam(this,5000);
  cam.rotateX(-PI*3/8);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(8000);
  
  PFont p = createFont("Verdana", 20,true);
  ControlFont font = new ControlFont(p);
  
  // Actually, timeAdjuster and timeSlider do the same thing.
  // we keep both of them because user will know what the number of timestep is 
  // from timeSlider when you use that buttons
  time = new ControlP5(this);
  time.setFont(font);
  time.addButton("timeAdjuster").setPosition(0,720).setSize(180,60);
  time.addButton("slowDown").setValue(1000).setPosition(0,780).setSize(180,60);
  time.addButton("speedUp").setValue(1000).setPosition(0,840).setSize(180,60);
  time.setAutoDraw(false);
  timeSlider = new ControlP5(this);
  timeSlider.setFont(font);
  timeSlider.addSlider("timestep").setPosition(180,720).setSize(360,60).setRange(minTimeStep,maxTimeStep).setValue(5000);
  timeSlider.setAutoDraw(false);
    
  planetInfo = new ControlP5(this);
  planetInfo.addButton("Sun").setPosition(0,60).setSize(180,60);
  planetInfo.addButton("Mercury").setPosition(0,120).setSize(180,60);
  planetInfo.addButton("Venus").setPosition(0,180).setSize(180,60);
  planetInfo.addButton("Earth").setPosition(0,240).setSize(180,60);
  planetInfo.addButton("Mars").setPosition(0,300).setSize(180,60);
  planetInfo.addButton("Jupiter").setPosition(0,360).setSize(180,60);
  planetInfo.addButton("Saturn").setPosition(0,420).setSize(180,60);
  planetInfo.addButton("Uranus").setPosition(0,480).setSize(180,60);
  planetInfo.addButton("Neptune").setPosition(0,540).setSize(180,60);
  planetInfo.addButton("Moon").setPosition(0,600).setSize(180,60);
  planetInfo.addButton("HalleyComet").setPosition(0,660).setSize(180,60);
  planetInfo.addButton("TurnOnOrbit").setPosition(0,900).setSize(180,60);
  planetInfo.setFont(font);
  planetInfo.setAutoDraw(false);
  
  planetFollow = new ControlP5(this);
  planetFollow.addButton("followSun").setPosition(180,60).setSize(180,60);
  planetFollow.addButton("followMercury").setPosition(180,120).setSize(180,60);
  planetFollow.addButton("followVenus").setPosition(180,180).setSize(180,60);
  planetFollow.addButton("followEarth").setPosition(180,240).setSize(180,60);
  planetFollow.addButton("followMars").setPosition(180,300).setSize(180,60);
  planetFollow.addButton("followJupiter").setPosition(180,360).setSize(180,60);
  planetFollow.addButton("followSaturn").setPosition(180,420).setSize(180,60);
  planetFollow.addButton("followUranus").setPosition(180,480).setSize(180,60);
  planetFollow.addButton("followNeptune").setPosition(180,540).setSize(180,60);
  planetFollow.addButton("followMoon").setPosition(180,600).setSize(180,60);
  planetFollow.addButton("followComet").setPosition(180,660).setSize(180,60);
  planetFollow.setFont(font);
  planetFollow.setAutoDraw(false);
  
  for(int i = 0; i < solarSystem.length; i++){
    solarSystem[i].initialPosition();
  }

  // Setup the ring of Saturn
  solarSystem[6].ringSetup();
  
  // Setup asteroid belt
  for(int i=0; i< asteroidBelt.length; i++){
     asteroidBelt[i] = new Body("a",1,5*randomGaussian()*random(1e5,5e5),0.6*random(3.29e11,4.28e11),random(3.29e11,4.28e11));
  }
  for(int i=0; i< asteroidBelt.length; i++){
     asteroidBelt[i].initialPosition();
  }
}

void draw(){
  background(starBackground); 
  pointLight(250, 250, 250, 0, 0, 0); //for the normal behaviour of the sun light 
  ambientLight(50, 50, 50, 0, 0, 0); 
  for(int i = 1; i < solarSystem.length; i++){
    solarSystem[i].setPosition(timestep);
    solarSystem[i].display();
    if (orbitOn)
      solarSystem[i].displayOrbit();
  } 
  
  for(int i=0; i< asteroidBelt.length; i++){
     asteroidBelt[i].setPosition(timestep);
     asteroidBelt[i].display();
  }
  
  ambientLight(255, 255, 255, 0, 0, 0); //ambientLight in the center of the sun
  solarSystem[0].display();
  solarSystem[10].cometTail();

  GUI();
 }
 
 void GUI(){
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  time.draw();
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
  planetFollow.draw();
  if(sliderOn == true){
    timeSlider.draw();
  }
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
 }
 
void timeAdjuster() {

  sliderOn = !sliderOn;
  if (sliderOn == false)
    cam.setActive(true);
}

void timeScale(int t){
  if (mousePressed == true)
    cam.setActive(false);
  timestep = t;
}

void speedUp(float theValue) {
  if(timestep < maxTimeStep)
    timestep = timestep + int(theValue);
    // When uesr use the button, the value of the slider changes as well
  //timeSlider.getController("timestep").setValue(timestep);
}

void slowDown(float theValue) {
  if(timestep > minTimeStep)
    timestep = timestep - int(theValue);
    // When you use the button, the value of the slider changes as well
  //timeSlider.getController("timestep").setValue(timestep);
}

void followSun(){
  solarSystem[0].turnFollowOff();
  solarSystem[0].follow = !solarSystem[0].follow;
}
void followMercury(){
  solarSystem[1].turnFollowOff();
  solarSystem[1].follow = !solarSystem[1].follow;
}
void followVenus(){
  solarSystem[2].turnFollowOff();
  solarSystem[2].follow = !solarSystem[2].follow;
}
void followEarth(){
  solarSystem[3].turnFollowOff();
  solarSystem[3].follow = !solarSystem[3].follow;
}
void followMars(){
  solarSystem[4].turnFollowOff();
  solarSystem[4].follow = !solarSystem[4].follow;
}
void followJupiter(){
  solarSystem[5].turnFollowOff();
  solarSystem[5].follow = !solarSystem[5].follow;
}
void followSaturn(){
  solarSystem[6].turnFollowOff();
  solarSystem[6].follow = !solarSystem[6].follow;
}
void followUranus(){
  solarSystem[7].turnFollowOff();
  solarSystem[7].follow = !solarSystem[7].follow;
}
void followNeptune(){
  solarSystem[8].turnFollowOff();
  solarSystem[8].follow = !solarSystem[8].follow;
}
void followMoon(){
  solarSystem[9].turnFollowOff();
  solarSystem[9].follow = !solarSystem[9].follow;
}
void followComet(){
  solarSystem[10].turnFollowOff();
  solarSystem[10].follow = !solarSystem[10].follow;
}

void Sun(){
  solarSystem[0].turnFollowOff();
  solarSystem[0].camFollow();
}
void Mercury(){
  solarSystem[1].turnFollowOff();
  solarSystem[1].camFollow();
} 
void Venus(){
  solarSystem[2].turnFollowOff();
  solarSystem[2].camFollow();
}
void Earth(){
  solarSystem[3].turnFollowOff();
  solarSystem[3].camFollow();
}
void Mars(){
  solarSystem[4].turnFollowOff();
  solarSystem[4].camFollow();
}
void Jupiter(){
  solarSystem[5].turnFollowOff();
  solarSystem[5].camFollow();
}
void Saturn(){
  solarSystem[6].turnFollowOff();
  solarSystem[6].camFollow();
}
void Uranus(){
  solarSystem[7].turnFollowOff();
  solarSystem[7].camFollow();
}
void Neptune(){
  solarSystem[8].turnFollowOff();
  solarSystem[8].camFollow();
}
void Moon(){
  solarSystem[9].turnFollowOff();
  solarSystem[9].camFollow();
}
void HalleyComet(){
  solarSystem[10].turnFollowOff();
  solarSystem[10].camFollow();
}
void TurnOnOrbit(){
  orbitOn = !orbitOn;
}
void keyPressed() {
  if (key == '1') {
    Sun();
  }
  if (key == '2') {
    Mercury();
  }
  if (key == '3') {
    Venus();
  }
  if (key == '4') {
    Earth();
  }
  if (key == '5') {
    Mars();
  }
  if (key == '6') {
    Jupiter();
  }
  if (key == '7') {
    Saturn();
  }
  if (key == '8') {
    Uranus();
  }
  if (key == '9') {
    Neptune();
  }
  if (key == '0') {
    Moon();
  }
 
}
