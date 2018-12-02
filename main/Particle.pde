class Particle {
  PVector loc;
  PVector vel;
  PVector acc;

  int size = START_SIZE;
  float angle;
  float lifespan;
  
  Particle(PVector pos) {
    loc = new PVector(pos.x, pos.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    lifespan = 255.0;
  }
  
  void update() {
    // Calculate the direction the particle is going to turn
    angle = random(0, TWO_PI);
    
    // Cos and Sin are complementary and setting the x and y values gives us the beautiful smooth turns. 
    acc.x += cos(angle) * 5;
    acc.y += sin(angle) * 5;
    
    // Limit result
    acc.limit(PARTICLE_MAX_ACC);
    
    // Add acceleration to current velocity and then limit result
    vel.add(acc);
    vel.limit(PARTILE_MAX_VEL);
    
    // Appy velocity to current location
    loc.add(vel);

    // Decrease the lifespan slowly over time.
    lifespan -= 2.0;
    
    // Wrap around the screen, https://processing.org/tutorials/pvector/
    if (loc.x > width)
      loc.x -= width;
     if (loc.x < 0)
       loc.x += width;
     if(loc.y > height)
       loc.y -= height;
     if(loc.y < 0)
       loc.y += height;
    
    // If the user stopped pushing, start shrinking the particles.
    if(isPushing == false) {
      size -= SHRINK_RATE;
    }

    // If the lifespan reaches 0, we move to the enxt animation.
    if(lifespan <= 0) {
      shouldRenderAnimation1 = false;
      animation2Iterations = 20;
    }
  }
  
  void display() {
    colour.update();
    fill(colour.R, colour.G, colour.B, lifespan);
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