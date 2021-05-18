import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import controlP5.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {





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
int tailColor = color(150,150,250);

public void setup(){
  //size(2400,1200, P3D); //<>//
  
  frameRate(120);
  

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
  
  solarSystem[0] = new Body("Sun",0,0,1.9891e30f,1.391684e9f/6,0,0,587.28f,0,0,sunTexture,sunText);
  solarSystem[1] = new Body("Mercury",0,0,0.330e24f,4.879e6f,4.6e10f,6.98e10f,88,1407.6f,0.03f,mercuryT,mercuryText);
  solarSystem[2] = new Body("Venus",0,0,4.87e24f,1.2104e7f,1.075e11f,1.089e11f,224.7f,-5832.5f,2.64f,venusT,venusText);
  solarSystem[3] = new Body("Earth",0,0,5.97e24f,1.2756e7f,1.471e11f,1.521e11f,365.2425f,23.9f,23.44f,earthT,earthText);
  solarSystem[4] = new Body("Mars",0,0,0.642e24f,6.792e7f,2.066e11f,2.492e11f,687.0f,24.6f,25.19f,marsT,marsText);
  solarSystem[5] = new Body("Jupiter",0,0,1898e24f,1.42984e8f,7.405e11f,8.166e11f,4331,9.9f,3.13f,jupiterT,jupiterText);
  solarSystem[6] = new Body("Saturn",0,0,568e24f,1.20536e8f,1.3526e12f,1.5145e12f  ,10747,10.7f,26.73f,saturnT,saturnText);
  solarSystem[7] = new Body("Uranus",0,0,86.8e24f,5.1118e7f,2.7413e12f,3.0036e12f,30589,-17.2f,82.23f,uranusT,uranusText);
  solarSystem[8] = new Body("Neptune",0,0,102e24f,4.9528e7f,4.4445e12f,4.5457e12f,59800,16.1f,28.32f,neptuneT,neptuneText);
  solarSystem[9] = new Body("Moon",0,0,0.073e24f,3.475e6f,0.363e9f,0.406e9f,27.3f,655.7f,6.68f,moonT,moonText);
  solarSystem[10] = new Body("Halley's comet",10e15f,1.2e7f,8.8e10f,5.3e12f/4);
    
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
     asteroidBelt[i] = new Body("a",1,5*randomGaussian()*random(1e5f,5e5f),0.6f*random(3.29e11f,4.28e11f),random(3.29e11f,4.28e11f));
  }
  for(int i=0; i< asteroidBelt.length; i++){
     asteroidBelt[i].initialPosition();
  }
}

public void draw(){
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
 
 public void GUI(){
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
 
public void timeAdjuster() {

  sliderOn = !sliderOn;
  if (sliderOn == false)
    cam.setActive(true);
}

public void timeScale(int t){
  if (mousePressed == true)
    cam.setActive(false);
  timestep = t;
}

public void speedUp(float theValue) {
  if(timestep < maxTimeStep)
    timestep = timestep + PApplet.parseInt(theValue);
    // When uesr use the button, the value of the slider changes as well
  //timeSlider.getController("timestep").setValue(timestep);
}

public void slowDown(float theValue) {
  if(timestep > minTimeStep)
    timestep = timestep - PApplet.parseInt(theValue);
    // When you use the button, the value of the slider changes as well
  //timeSlider.getController("timestep").setValue(timestep);
}

public void followSun(){
  solarSystem[0].turnFollowOff();
  solarSystem[0].follow = !solarSystem[0].follow;
}
public void followMercury(){
  solarSystem[1].turnFollowOff();
  solarSystem[1].follow = !solarSystem[1].follow;
}
public void followVenus(){
  solarSystem[2].turnFollowOff();
  solarSystem[2].follow = !solarSystem[2].follow;
}
public void followEarth(){
  solarSystem[3].turnFollowOff();
  solarSystem[3].follow = !solarSystem[3].follow;
}
public void followMars(){
  solarSystem[4].turnFollowOff();
  solarSystem[4].follow = !solarSystem[4].follow;
}
public void followJupiter(){
  solarSystem[5].turnFollowOff();
  solarSystem[5].follow = !solarSystem[5].follow;
}
public void followSaturn(){
  solarSystem[6].turnFollowOff();
  solarSystem[6].follow = !solarSystem[6].follow;
}
public void followUranus(){
  solarSystem[7].turnFollowOff();
  solarSystem[7].follow = !solarSystem[7].follow;
}
public void followNeptune(){
  solarSystem[8].turnFollowOff();
  solarSystem[8].follow = !solarSystem[8].follow;
}
public void followMoon(){
  solarSystem[9].turnFollowOff();
  solarSystem[9].follow = !solarSystem[9].follow;
}
public void followComet(){
  solarSystem[10].turnFollowOff();
  solarSystem[10].follow = !solarSystem[10].follow;
}

public void Sun(){
  solarSystem[0].turnFollowOff();
  solarSystem[0].camFollow();
}
public void Mercury(){
  solarSystem[1].turnFollowOff();
  solarSystem[1].camFollow();
} 
public void Venus(){
  solarSystem[2].turnFollowOff();
  solarSystem[2].camFollow();
}
public void Earth(){
  solarSystem[3].turnFollowOff();
  solarSystem[3].camFollow();
}
public void Mars(){
  solarSystem[4].turnFollowOff();
  solarSystem[4].camFollow();
}
public void Jupiter(){
  solarSystem[5].turnFollowOff();
  solarSystem[5].camFollow();
}
public void Saturn(){
  solarSystem[6].turnFollowOff();
  solarSystem[6].camFollow();
}
public void Uranus(){
  solarSystem[7].turnFollowOff();
  solarSystem[7].camFollow();
}
public void Neptune(){
  solarSystem[8].turnFollowOff();
  solarSystem[8].camFollow();
}
public void Moon(){
  solarSystem[9].turnFollowOff();
  solarSystem[9].camFollow();
}
public void HalleyComet(){
  solarSystem[10].turnFollowOff();
  solarSystem[10].camFollow();
}
public void TurnOnOrbit(){
  orbitOn = !orbitOn;
}
public void keyPressed() {
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
class Body {
    String name;
    float x;
    float y;
    float z;
    float mass; // (kg)
    float diam; // (meters)
    float perihelion; // (meters)
    float aphelion; // (meters)
    float orbPeriod; // (days)
    float rotationalPeriod; // (hours)
    float currentAngle; // (radian)
    float rotateAngle;
    float OrbitTilt; //(degree)
    PShape globe;
    boolean info; // turn on display information
    boolean follow; // turn on camera following
    String infoText;
    float [] xpos;
    float [] ypos;
    PShape[] tails;
    // constructor for asteroid belt and comet with less input parameters.
    Body(String name,float m, float diam, float perihelion, float aphelion){
        this.name = name;
        this.x = 0;
        this.y = 0;
        this.z = 0;
        this.mass = m;
        this.diam = diam;
        this.perihelion = perihelion;
        this.aphelion =  aphelion;
        this.orbPeriod = 1;
        this.rotationalPeriod = 1;
        this.OrbitTilt = 1;
        currentAngle = 1;
        rotateAngle = 1;
        info = false;
        noStroke();
        fill(150);
        
        if(name.equals("a")){
          float type = random(1);
          if(type > 0.4f){
          globe = createShape(RECT,0,0,diam/2/radiusLevel, diam/2/radiusLevel);
          }else{
          sphereDetail(3);
          globe = createShape(SPHERE, diam/2/radiusLevel);
        }
        }
        if(name.equals("Halley's comet")){
          xpos = new float[100];
          ypos = new float[100];
          tails = new PShape[100];
          for(int i = 0; i < xpos.length; i++){
            fill(50+2*i,50+2*i,100+1.5f*i,i*2+50);
            sphereDetail(6);
            tails[i] = createShape(SPHERE, i*diam/2/radiusLevel/xpos.length);
          }
          fill(tailColor);
          sphereDetail(24);
          globe = createShape(SPHERE, diam/2/radiusLevel);
        }
       
    }
    // constructor for planets
    Body(String name, float x, float y, float m, float diam, float perihelion, float aphelion, float orbPeriod, float rotationalPeriod, float OrbitTilt,PImage img, String infoText){
        this.name = name;
        this.x = x;
        this.y = y;
        this.z = 0;
        this.mass = m;
        this.diam = diam;
        this.perihelion = perihelion;
        this.aphelion =  aphelion;
        this.orbPeriod = orbPeriod;
        this.rotationalPeriod = rotationalPeriod;
        this.OrbitTilt = -OrbitTilt/180*PI;
        this.infoText = infoText;
        currentAngle = 0;
        rotateAngle = 0;
        info = false;
        noStroke();
        noFill();
        sphereDetail(60);
        globe = createShape(SPHERE, diam/2/radiusLevel);
        globe.setTexture(img);
    }
    public void display(){
        pushMatrix();
        noStroke();
        // The coordinates of some distant planets would shrink
        if (perihelion > 2e12f){
           translate(x/coordinateLevel/3,y/coordinateLevel/3,z/coordinateLevel/3);
        }else if (perihelion > 5e11f){
           translate(x/coordinateLevel/2,y/coordinateLevel/2,z/coordinateLevel/2);
        }else {
           translate(x/coordinateLevel,y/coordinateLevel,z/coordinateLevel);
        } 
        if (!name.equals( "a") && !name.equals("Halley's comet")){
          rot(timestep);
        }   
        rotateX(-PI/2); // rotate each planet to right angle for rotation
        fill(255);
        shape(globe);
        popMatrix();
        if(follow == true){
          camFollow();
        }
    }
    
    public void rot(float time){
    
    rotateY(OrbitTilt);
    if(!name.equals("Sun")){
      rotateZ(radians(rotateAngle));
    }
    rotateAngle = rotateAngle + time * 360/rotationalPeriod/3600;
    if (name.equals("Saturn")){
      shape(saturnRings);
    }
    
  }

    public void initialPosition(){
        // set random x and y
        // Or we find the actual position of planet later
        currentAngle = random(TWO_PI); // return a random angel within [0,2PI]
        float a = (perihelion+aphelion)/2; // a is semi-major axis
        float c = a - perihelion;
        float b = sqrt(a*a-c*c); // b is semi-minor axis
        if (name == "Moon"){
          x = 50*a*cos(currentAngle) + solarSystem[3].x;
          y = 50*b*sin(currentAngle) + solarSystem[3].y;
        } else if (name == "Halley's comet"){
          x = a*cos(currentAngle)-c;
          y = b*sin(currentAngle);
            for(int i =0 ; i < xpos.length ; i++){
              xpos[i] = x;
              ypos[i] = y;
            }
        } else{
          x = a*cos(currentAngle);
          y = b*sin(currentAngle);
        }

    }
    public void setPosition(float time){

        if (name.equals("Moon")){
          float angularVelocity = 2*PI/orbPeriod/24/3600;
          float angle = angularVelocity * time ; // 
          currentAngle = currentAngle + angle;
          float a = (perihelion+aphelion)/2; // a is semi-major axis
          float c = a - perihelion;
          float b = sqrt(a*a-c*c); // b is semi-minor axis
          x = 50*a*cos(currentAngle) + solarSystem[3].x;
          y = 50*b*sin(currentAngle) + solarSystem[3].y;
        }else if (name.equals("Halley's comet")){
          float dist = sqrt(x * x + y * y); // Distance between Sun and planet
          float G = 6.67e-11f; // Gravitation instance
          float M = 1.9891e30f; // Mass of Sun
          float angularVelocity = sqrt(G * M / pow(dist,3));
          float angle = angularVelocity * time ; // Radian
          // Now we have the angle of planet movement
          // Next we calculate the position fo planet
          //if(name =="a")
          //println(angularVelocity); //8.4856886E-8
          currentAngle = currentAngle + angle;
          float a = (perihelion+aphelion)/2; // a is semi-major axis
          float c = a - perihelion;
          float b = sqrt(a*a-c*c);
          x = a*cos(currentAngle)-c;
          y = b*sin(currentAngle);
        } else {
          // calculate the next position of planet after 1 second or 0.1 second
          float dist = sqrt(x * x + y * y); // Distance between Sun and planet
          float G = 6.67e-11f; // Gravitation instance
          float M = 1.9891e30f; // Mass of Sun
          float angularVelocity = sqrt(G * M / pow(dist,3));
          float angle = angularVelocity * time ; // Radian
          // Now we have the angle of planet movement
          // Next we calculate the position fo planet
          //if(name =="a")
          //println(angularVelocity); //8.4856886E-8
          currentAngle = currentAngle + angle;
          float a = (perihelion+aphelion)/2; // a is semi-major axis
          float c = a - perihelion;
          float b = sqrt(a*a-c*c); // b is semi-minor axis
          x = a*cos(currentAngle);
          y = b*sin(currentAngle);
        }

    }
    public void displayInfo(){
      if(info == true){
          cam.beginHUD();   
          fill(255, 140, 140, 100);     
          rect(1800, 60, 660, 660);
          fill(150);
          textSize(40);
          text(infoText, 1850, 160, 600,600);
          cam.endHUD();
          
      }
    }
    
    public void turnOnInfo(){
      this.info = !this.info;
    } 
    public void displayOrbit(){

        float a = (perihelion+aphelion)/2; // a is semi-major axis
        float c = a - perihelion;
        float b = sqrt(a*a-c*c); // b is semi-minor axis
        pushMatrix();
        stroke(50);
        noFill();
        if(name.equals("Halley's comet")){
          translate(-c/coordinateLevel,0,0);
          ellipse(0,0,2*a/coordinateLevel,2*b/coordinateLevel);
        }
        if(perihelion > 2e12f){
          ellipse(0,0,2*a/coordinateLevel/3,2*b/coordinateLevel/3);
        }else if (perihelion > 5e11f){
          ellipse(0,0,2*a/coordinateLevel/2,2*b/coordinateLevel/2);
        }else {
          ellipse(0,0,2*a/coordinateLevel,2*b/coordinateLevel);
        }
        if (name.equals("Earth")){
          float ma = (solarSystem[9].perihelion+solarSystem[9].aphelion)/2;
          float mc = ma - solarSystem[9].perihelion;
          float mb = sqrt(ma*ma-mc*mc);
          ellipse(x/coordinateLevel,y/coordinateLevel,2*ma/coordinateLevel*50,2*mb/coordinateLevel*50);
        }
        popMatrix();
    }
  
  public void camFollow(){
    int animationTime = 480; // millisecond
    if(follow == true)
      animationTime = 60;
    for(int i = 0; i < solarSystem.length; i++){
      solarSystem[i].info = false;
    }
    turnOnInfo();
    if( perihelion > 2e12f)
      cam.lookAt(x/coordinateLevel/3, y/coordinateLevel/3, z/coordinateLevel/3,10,animationTime);
    else if (perihelion > 5e11f)
      cam.lookAt(x/coordinateLevel/2, y/coordinateLevel/2, z/coordinateLevel/2,500,animationTime);
    else if (name.equals("Sun"))
      cam.reset();
    else if (name.equals("Halley's comet"))
      cam.lookAt(x/coordinateLevel, y/coordinateLevel, z/coordinateLevel,500,animationTime);
    else
      cam.lookAt(x/coordinateLevel, y/coordinateLevel, z/coordinateLevel,10,animationTime);
  }
  
  public void turnFollowOff(){
    for(int i = 0; i < solarSystem.length; i++){
      solarSystem[i].follow = false;
    }
  }
  
  public void cometTail(){
    
    for(int i =0 ; i < xpos.length-1 ; i++){
      xpos[i] = xpos[i+1];
      ypos[i] = ypos[i+1];
    }
    xpos[xpos.length - 1] = x;
    ypos[ypos.length - 1] = y;
    pushMatrix();
    noStroke();
    for(int i = 0; i < xpos.length; i++){
      shape(tails[i],xpos[i]/coordinateLevel,ypos[i]/coordinateLevel);
    }   
    popMatrix();
  }
  
  // draw rings of Saturn. There are 4 rings of Saturn, A, B, C, and D ring.
  // For each ring, there are two radius, for example , Ra1 and Ra2 
  // Ra1 is the inner radius of the ring, Ra2 is the outter radius.
  // bezierVertex can draw a annulus
  public void ringSetup(){
    final float h = 0.552284749831f; 
    float Ra1 = 2.03f*diam/2/radiusLevel;
    float Ra2 = 2.27f*diam/2/radiusLevel;
    float Rb1 = 1.526f*diam/2/radiusLevel;
    float Rb2 = 1.950f*diam/2/radiusLevel;
    float Rc1 = 1.239f*diam/2/radiusLevel;
    float Rc2 = 1.526f*diam/2/radiusLevel;
    float Rd1 = 1.11f*diam/2/radiusLevel;
    float Rd2 = 1.236f*diam/2/radiusLevel;
    int Acolor = color(93,90,90,0.8f*255); 
    int Bcolor = color(112,105,100,0.9f*255); 
    int Ccolor = color(128,116,104,0.49f*255); 
    int Dcolor = color(99,95,90,0.19f*255); 
    noStroke();
    saturnRings = createShape(GROUP);
    PShape D = createShape();
    D.beginShape();             
    D.fill(Dcolor);           
    D.vertex(X,Y-Rd1,Z);             
    D.bezierVertex((X-h*Rd1),Y-Rd1,Z,X-Rd1, (Y-h *Rd1),Z, X-Rd1, Y,Z);      //left-up 
    D.bezierVertex(X-Rd1, (Y+h*Rd1),Z,(X-h*Rd1), Y+Rd1,Z, X, Y+Rd1,Z);   //left-b
    D.bezierVertex((X+h*Rd1), Y+Rd1,Z, X+Rd1, (Y+h *Rd1),Z, X+Rd1, Y,Z);  //ritgt-b
    D.bezierVertex(X+Rd1, (Y-h*Rd1),Z, (X+h*Rd1), Y-Rd1,Z, X, Y-Rd1,Z);          //right-up
    D.vertex(X,Y-Rd2,Z);   
    D.bezierVertex((X+h*Rd2), Y-Rd2,Z,(X+Rd2), (Y-h*Rd2),Z, X+Rd2, Y,Z);  //right-up
    D.bezierVertex(X+Rd2, (Y+h *Rd2),Z,(X+h*Rd2), Y+Rd2,Z, X, Y+Rd2,Z);   //right-b
    D.bezierVertex((X-h*Rd2), Y+Rd2,Z,X-Rd2,(Y+h*Rd2),Z, X-Rd2, Y,Z);      //left-b 
    D.bezierVertex(X-Rd2, (Y-h *Rd2),Z,(X-h*Rd2), Y-Rd2,Z, X, Y-Rd2,Z);   //left-up  
    D.endShape(); 
    PShape C = createShape(); 
    C.beginShape(); 
    C.fill(Ccolor);           
    C.vertex(X,Y-Rc1,Z);             
    C.bezierVertex((X-h*Rc1),Y-Rc1,Z,X-Rc1, (Y-h *Rc1),Z, X-Rc1, Y,Z);      //left-up 
    C.bezierVertex(X-Rc1, (Y+h*Rc1),Z,(X-h*Rc1), Y+Rc1,Z, X, Y+Rc1,Z);   //left-b
    C.bezierVertex((X+h*Rc1), Y+Rc1,Z, X+Rc1, (Y+h *Rc1),Z, X+Rc1, Y,Z);  //ritgt-b
    C.bezierVertex(X+Rc1, (Y-h*Rc1),Z, (X+h*Rc1), Y-Rc1,Z, X, Y-Rc1,Z);          //right-up
    C.vertex(X,Y-Rc2,Z);   
    C.bezierVertex((X+h*Rc2), Y-Rc2,Z,(X+Rc2), (Y-h*Rc2),Z, X+Rc2, Y,Z);  //right-up
    C.bezierVertex(X+Rc2, (Y+h *Rc2),Z,(X+h*Rc2), Y+Rc2,Z, X, Y+Rc2,Z);   //right-b
    C.bezierVertex((X-h*Rc2), Y+Rc2,Z,X-Rc2,(Y+h*Rc2),Z, X-Rc2, Y,Z);      //left-b 
    C.bezierVertex(X-Rc2, (Y-h *Rc2),Z,(X-h*Rc2), Y-Rc2,Z, X, Y-Rc2,Z);   //left-up
    C.endShape();
    PShape B = createShape(); 
    B.beginShape(); 
    B.fill(Bcolor);           
    B.vertex(X,Y-Rb1,Z);             
    B.bezierVertex((X-h*Rb1),Y-Rb1,Z,X-Rb1, (Y-h *Rb1),Z, X-Rb1, Y,Z);      //left-up 
    B.bezierVertex(X-Rb1, (Y+h*Rb1),Z,(X-h*Rb1), Y+Rb1,Z, X, Y+Rb1,Z);   //left-b
    B.bezierVertex((X+h*Rb1), Y+Rb1,Z, X+Rb1, (Y+h *Rb1),Z, X+Rb1, Y,Z);  //ritgt-b
    B.bezierVertex(X+Rb1, (Y-h*Rb1),Z, (X+h*Rb1), Y-Rb1,Z, X, Y-Rb1,Z);          //right-up
    B.vertex(X,Y-Rb2,Z);   
    B.bezierVertex((X+h*Rb2), Y-Rb2,Z,(X+Rb2), (Y-h*Rb2),Z, X+Rb2, Y,Z);  //right-up
    B.bezierVertex(X+Rb2, (Y+h *Rb2),Z,(X+h*Rb2), Y+Rb2,Z, X, Y+Rb2,Z);   //right-b
    B.bezierVertex((X-h*Rb2), Y+Rb2,Z,X-Rb2,(Y+h*Rb2),Z, X-Rb2, Y,Z);      //left-b 
    B.bezierVertex(X-Rb2, (Y-h *Rb2),Z,(X-h*Rb2), Y-Rb2,Z, X, Y-Rb2,Z);   //left-up
    B.endShape();
    PShape A = createShape(); 
    A.beginShape(); 
    A.fill(Acolor);           
    A.vertex(X,Y-Ra1,Z);             
    A.bezierVertex((X-h*Ra1),Y-Ra1,Z,X-Ra1, (Y-h *Ra1),Z, X-Ra1, Y,Z);      //left-up 
    A.bezierVertex(X-Ra1, (Y+h*Ra1),Z,(X-h*Ra1), Y+Ra1,Z, X, Y+Ra1,Z);   //left-b
    A.bezierVertex((X+h*Ra1), Y+Ra1,Z, X+Ra1, (Y+h *Ra1),Z, X+Ra1, Y,Z);  //ritgt-b
    A.bezierVertex(X+Ra1, (Y-h*Ra1),Z, (X+h*Ra1), Y-Ra1,Z, X, Y-Ra1,Z);          //right-up
    A.vertex(X,Y-Ra2,Z);   
    A.bezierVertex((X+h*Ra2), Y-Ra2,Z,(X+Ra2), (Y-h*Ra2),Z, X+Ra2, Y,Z);  //right-up
    A.bezierVertex(X+Ra2, (Y+h *Ra2),Z,(X+h*Ra2), Y+Ra2,Z, X, Y+Ra2,Z);   //right-b
    A.bezierVertex((X-h*Ra2), Y+Ra2,Z,X-Ra2,(Y+h*Ra2),Z, X-Ra2, Y,Z);      //left-b 
    A.bezierVertex(X-Ra2, (Y-h *Ra2),Z,(X-h*Ra2), Y-Ra2,Z, X, Y-Ra2,Z);   //left-up
    A.endShape();
    saturnRings.addChild(D);
    saturnRings.addChild(C);
    saturnRings.addChild(B);
    saturnRings.addChild(A);
  }
}
  public void settings() {  fullScreen(P3D);  smooth(4); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
