class ParticleSystem {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int count = 0;

  void clearCount() {
    count = 0;
  }
    
  void addParticle(PVector loc) {
    if (particles.size() + SPAWN_COUNT < MAX_PARTICLES && count <= 24) {
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
      
      // update position and lifespan
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