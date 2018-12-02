class ParticleSystem {
  // Initialize our particles array list
  ArrayList<Particle> particles = new ArrayList<Particle>();

  // Counter to keep track of the amount of particles on the screen
  int count = 0;

  void clearCount() {
    count = 0;
  }
    
  // Adds a new particle if there are less than 24 particles on the screen.
  void addParticle(PVector loc) {
    if (count <= 24) {
      count++;
      particles.add(new Particle(loc));
    }
  }

  void update() {
    // Use an iterator to loop through active particles
    Iterator<Particle> i = particles.iterator();
    
    while(i.hasNext()) {
      // Get next particle
      Particle p = i.next();
      
      // update position, size and lifespan
      p.update();
      // Remove particle if dead
      if (p.isDead()) {
        i.remove();
        count--;
      } else {
        p.display();
      }
    }
  }
}