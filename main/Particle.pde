class Particle {
  PVector loc;
  PVector vel;
  PVector acc;

  int size = START_SIZE;
  float angle;
  float lifespan;
  
  Particle(PVector loc2) {
    loc = new PVector(loc2.x, loc2.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    lifespan = 255.0;
  }
  
  void update() {
    // Move in random direction with random speed
    angle += random(0, TWO_PI);
    float magnitude = random(0, PARTICLE_START_FORCE); //3
    
    // Work out force 
    acc.x += cos(angle) * magnitude;
    acc.y += sin(angle) * magnitude;
    
    // limit result
    acc.limit(PARTICLE_MAX_ACC);
    
    // Add to current velocity
    vel.add(acc);
    vel.limit(PARTILE_MAX_VEL);
    
    // Appy result to current location
    loc.add(vel);
    lifespan -= 2.0;
    
    // Wrap around the screen
    if (loc.x > width)
      loc.x -= width;
     if (loc.x < 0)
       loc.x += width;
     if(loc.y > height)
       loc.y -= height;
     if(loc.y < 0)
       loc.y += height;
    
    if(ready == true) {
      size -= SHRINK_RATE;
    }

    if(lifespan <= 0) {
      shouldRenderAnimation1 = false;
      animation2Iterations = 20;
    }
  }
  
  void display() {
    colour.update();
    fill(colour.R, colour.G, colour.B, lifespan);
    stroke(colour.R, colour.G, colour.B, lifespan);
    ellipse(loc.x, loc.y, size, size);
  }
  
  boolean isDead() {
    if (size < 0) {
      return true;
    } else {
      return false;
    }
  }
}