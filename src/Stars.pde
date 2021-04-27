class Star{
  
  float x, y, z, sx, sy, r, px, py, pz;
  
  Star(){
    //x = random(0, width);
    //y = random(0, height);
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    
    pz = z;
    
  }
  
  void update(){
    
    z = z-8;
    if(z<1){
      z=width;
      x = random(-width, width);
      y = random(-height, height);
      pz = z;
    }
    
  }
  
  void show() {
    fill(255);
    noStroke();
    //ellipse(x, y, 8, 8);
    
    sx = map(x/z, 0, 1, 0, width);
    sy = map(y/z, 0, 1, 0, height);
        
    //ellipse(sx, sy, 8, 8);
    
    r = map(z, 0, width, 13, 0);
    ellipse(sx, sy, r, r);
    
    px = map(x/pz, 0, 1, 0, width);
    py = map(y/pz, 0, 1, 0, height);
    
    stroke(255);
    line(px, py, sx, sy);
    

  }
  
  
}
