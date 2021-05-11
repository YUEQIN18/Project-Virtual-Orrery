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
    boolean info;
    String infoText;
    // constructor
    Body(float m, float diam, float perihelion){
        this.name = "a";
        this.x = 0;
        this.y = 0;
        this.z = 0;
        this.mass = m;
        this.diam = diam;
        this.perihelion = perihelion;
        this.aphelion =  perihelion;
        this.orbPeriod = 1;
        this.rotationalPeriod = 1;
        this.OrbitTilt = 1;
        currentAngle = 1;
        rotateAngle = 1;
        info = false;
        noStroke();
        fill(150);
        float type = random(1);
        if(type > 0.4){
          globe = createShape(RECT,0,0,diam/2/radiusLevel, diam/2/radiusLevel);
        }else{
          globe = createShape(SPHERE, diam/2/radiusLevel);
        }

        
    }
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
        if (name != "a"){
          rot(timestep);
        }   
        rotateX(-PI/2); // rotate each planet to right angle for rotation
        fill(255);
        shape(globe);
        popMatrix();

    }
    
    void rot(float time){
    
    rotateY(OrbitTilt);
    if(name != "Sun"){
      rotateZ(radians(rotateAngle));
    }
    rotateAngle = rotateAngle + time * 360/rotationalPeriod/3600;
    if (name == "Saturn"){
      shape(SaturnRings);
    }
    
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

        if (name == "Earth"){
          float ma = (solarSystem[9].perihelion+solarSystem[9].aphelion)/2;
          float mc = ma - solarSystem[9].perihelion;
          float mb = sqrt(ma*ma-mc*mc);
          ellipse(x/coordinateLevel,y/coordinateLevel,2*ma/coordinateLevel*50,2*mb/coordinateLevel*50);
        }
        popMatrix();
    }

  void ringSetup(){
    final float h = 0.552284749831; 
    float Ra1 = 2.03*diam/2/radiusLevel;
    float Ra2 = 2.27*diam/2/radiusLevel;
    float Rb1 = 1.526*diam/2/radiusLevel;
    float Rb2 = 1.950*diam/2/radiusLevel;
    float Rc1 = 1.239*diam/2/radiusLevel;
    float Rc2 = 1.526*diam/2/radiusLevel;
    float Rd1 = 1.11*diam/2/radiusLevel;
    float Rd2 = 1.236*diam/2/radiusLevel;
    color Acolor = color(93,90,90,0.8*255); 
    color Bcolor = color(112,105,100,0.9*255); 
    color Ccolor = color(128,116,104,0.49*255); 
    color Dcolor = color(99,95,90,0.19*255); 
    noStroke();
    SaturnRings = createShape(GROUP);
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
    SaturnRings.addChild(D);
    SaturnRings.addChild(C);
    SaturnRings.addChild(B);
    SaturnRings.addChild(A);
  }
}
