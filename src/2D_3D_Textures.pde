class Planet{
  float radius, angle, distance, orbitspeed;
  Planet[] planets;
  PVector v;
  
  PShape globe;
  
  
  Planet(float r, float d, float o, PImage img) 
  {
    v = PVector.random3D();
    radius = r;
    distance = d;
    v.mult(distance);
    angle = random(TWO_PI);
    //orbitspeed = random(0.01, 0.1); //controls the orbital speed of each planet
    orbitspeed = o;
    
    noStroke();
    noFill();
    //fill(255, 128, 64);
    globe = createShape(SPHERE, radius);
    globe.setTexture(img);
  }
  
  void SpawnMoons(int total, int level)
  {
    planets = new Planet[total];
    for(int i = 0; i<planets.length; i++)
    {
      //float r=radius*0.25;
      float r=radius/(level*2);
      float d=random((radius+r), (radius+r)*6); //for distance
      float o=random(0.01, 0.02); //for the speed
      int index = int(random(0, textures.length));
      planets[i]=new Planet(r, d/level, o, textures[index]);
      if(level<2)
      {
        int num = int(random(0,3)); //num decides the number of moons each planet will have
        planets[i].SpawnMoons(num, level+1);
      }
    }
  }
  
  void orbit()
  {
    angle = angle + orbitspeed;
    if(planets!=null) 
    {
      for(int i = 0; i<planets.length; i++)
      {
        planets[i].orbit();
      }
    }
  }
  
  void disp()
  {
    pushMatrix();
    noStroke();
    fill(255);
    //rotate(angle);
    PVector v2 = new PVector(1,1,1);
    PVector perp = v.cross(v2);
    rotate(angle, perp.x, perp.y, perp.z);
    
    stroke(255);
    //line(0 ,0 ,0 ,v.x ,v.y ,v.z); //line of axis for the planet (only for the reference)
    //line(0 ,0 ,0 ,perp.x ,perp.y ,perp.z); // perpendicular vector (only for the reference)
    
    //translate(distance, 0);
    translate(v.x, v.y, v.z);
    noStroke();
    fill(255);
    
    shape(globe);
    if(distance==0) //this condition makes the sun radiate the light on all the planets
      pointLight(255, 255, 255, 0, 0, 0); 
    //sphere(radius);
    ellipse(0, 0, radius*2, radius*2);
    if(planets!=null) //proceed only if the planet has moon(s) 
    {
      for(int i = 0; i<planets.length; i++)
      {
        planets[i].disp();
      }
    }
    popMatrix();
  }

}
