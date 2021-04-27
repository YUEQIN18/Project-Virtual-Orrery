class Planet {
  float radius;
  float angle;
  float distance;
  Planet[] planets;
  float orbitspeed;
  PVector v;
  
  Planet(float r, float d, float o){
    distance = d;
    radius = r;
    angle = random(TWO_PI);
    orbitspeed = o;
    v = PVector.random3D();
    v.mult(distance);
  }
  
  void orbit(){
    angle = angle + orbitspeed;
    if (planets != null){
      for(int i = 0; i< planets.length; i++){
        planets[i].orbit();
     }
    }
  }
  
   void spawn(int total, int level){
    planets = new Planet[total];
    for(int i = 0; i< planets.length; i++){
      float r = radius/(level*2);
      float d = random((radius + r + 100), ((radius + r) *2));
      float o = random(-0.03,0.08);
      planets[i] = new Planet(r,d/level,o); 
      if(level < 2){
        planets[i].spawn(2 ,level+1);
      }
      
    }
  }
  void show(){
    pushMatrix();
    noStroke();
    //rotate(angle);
    translate(v.x,v.y,v.z);
    fill(255);
    sphere(radius);
    if(planets !=null) {
      for(int i = 0; i< planets.length; i++){
      planets[i].show();
    }
   }
   popMatrix();
  }
  

}
