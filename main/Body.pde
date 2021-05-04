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
    PShape globe;
    boolean info;
    // constructor
    Body(String name, float x, float y, float m, float diam, float perihelion, float aphelion, float orbPeriod, float rotationalPeriod, PImage img){
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
        currentAngle = 0;
        info = false;
        noStroke();
        noFill();
        globe = createShape(SPHERE, diam/(2*radiusLevel*radiusLevel));
        globe.setTexture(img);
    }
    void display(){
        pushMatrix();
        noStroke();
        rotateX(PI/4); // change the cam view and make cam more comfortable
        translate(x/(coordinateLevel*coordinateLevel),y/(coordinateLevel*coordinateLevel),z/(coordinateLevel*coordinateLevel));
        fill(255);
        rotateX(-PI/2); // rotate each planet to right angle
        shape(globe);
        
        popMatrix();
        if(info == true){
          cam.beginHUD();   
            fill(255, 140, 0);     
            rect(0, 60, 350, 60);   
            fill(255);
            textSize(40);
            text(name, 100, 100);
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
        x = a*cos(currentAngle);
        y = b*sin(currentAngle);
    }
    void setPosition(float time){
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
