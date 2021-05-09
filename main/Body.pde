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
    PShape globe;
    boolean info;
    String infoText;
    // constructor
    Body(String name, float x, float y, float m, float diam, float perihelion, float aphelion, float orbPeriod, float rotationalPeriod, PImage img, String infoText){
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
        this.infoText = infoText;
        currentAngle = 0;
        rotateAngle = 0;
        info = false;
        noStroke();
        noFill();
        globe = createShape(SPHERE, diam/2/radiusLevel);
        globe.setTexture(img);
    }
    void display(){
        pushMatrix();
        noStroke();
        if (name == "Moon"){
          translate(x/coordinateLevel,y/coordinateLevel,z/coordinateLevel);
        }else if (perihelion > 2e12){
           translate(x/coordinateLevel/3,y/coordinateLevel/3,z/coordinateLevel/3);
        }else if (perihelion > 5e11){
           translate(x/coordinateLevel/2,y/coordinateLevel/2,z/coordinateLevel/2);
        }else {
           translate(x/coordinateLevel,y/coordinateLevel,z/coordinateLevel);
        }      
        if(name != "Sun"){
          rot(timestep);
        }
        rotateX(-PI/2); // rotate each planet to right angle for rotation
        fill(255);
        shape(globe);
        popMatrix();

    }
    void displayInfo(){
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
    
    void turnOnInfo(){
      this.info = !this.info;
    } 
    void initialPosition(){
        // set random x and y
        // Or we find the actual position of planet later
        currentAngle = random(TWO_PI); // return a random angel within [0,2PI]
        float a = (perihelion+aphelion)/2; // a is semi-major axis
        float c = a - perihelion;
        float b = sqrt(a*a-c*c); // b is semi-minor axis
        if (name == "Moon"){
          x = 50*a*cos(currentAngle) + solarSystem[3].x;
          y = 50*b*sin(currentAngle) + solarSystem[3].y;
        } else{
          x = a*cos(currentAngle);
          y = b*sin(currentAngle);
        }

    }
    void setPosition(float time){

        if (name == "Moon"){
          float angularVelocity = 2*PI/orbPeriod/24/3600;
          float angle = angularVelocity * time ; // 
          currentAngle = currentAngle + angle;
          float a = (perihelion+aphelion)/2; // a is semi-major axis
          float c = a - perihelion;
          float b = sqrt(a*a-c*c); // b is semi-minor axis
          x = 50*a*cos(currentAngle) + solarSystem[3].x;
          y = 50*b*sin(currentAngle) + solarSystem[3].y;
        } else {
          // calculate the next position of planet after 1 second or 0.1 second
          float dist = sqrt(x * x + y * y); // Distance between Sun and planet
          float G = 6.67e-11; // Gravitation instance
          float M = 1.9891e30; // Mass of Sun
          float angularVelocity = sqrt(G * M / pow(dist,3));
          float angle = angularVelocity * time ; // Radian
          // Now we have the angle of planet movement
          // Next we calculate the position fo planet
          currentAngle = currentAngle + angle;
          float a = (perihelion+aphelion)/2; // a is semi-major axis
          float c = a - perihelion;
          float b = sqrt(a*a-c*c); // b is semi-minor axis
          x = a*cos(currentAngle);
          y = b*sin(currentAngle);
        }

    }
    void displayOrbit(){
        float a = (perihelion+aphelion)/2; // a is semi-major axis
        float c = a - perihelion;
        float b = sqrt(a*a-c*c); // b is semi-minor axis
        pushMatrix();
        stroke(50);
        noFill();

        if(perihelion > 2e12){
          ellipse(0,0,2*a/coordinateLevel/3,2*b/coordinateLevel/3);
        }else if (perihelion > 5e11){
          ellipse(0,0,2*a/coordinateLevel/2,2*b/coordinateLevel/2);
        }else {
          ellipse(0,0,2*a/coordinateLevel,2*b/coordinateLevel);
        }
        //if (name == "Saturn"){
        //  PShape ring = createShape(ELLIPSE, x/coordinateLevel/2,y/coordinateLevel/2,diam/2/radiusLevel+250,diam/2/radiusLevel+250);
        //  ring.setTexture(saturnRingT);  
        //  shape(ring);
        //}
        if (name == "Earth"){
          float ma = (solarSystem[9].perihelion+solarSystem[9].aphelion)/2;
          float mc = ma - solarSystem[9].perihelion;
          float mb = sqrt(ma*ma-mc*mc);
          ellipse(x/coordinateLevel,y/coordinateLevel,2*ma/coordinateLevel*50,2*mb/coordinateLevel*50);
        }
        popMatrix();
    }
    void rot(float time){
    //rotateY(axial_tilt);
    rotateZ(radians(rotateAngle));
    rotateAngle = rotateAngle + time * 360/rotationalPeriod/3600;
  }
}
