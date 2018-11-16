class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int count = 0;
  
  ParticleSystem() { }
    
  void addParticle(PVector loc)
  {
    count++;
    if (particles.size() + SPAWN_COUNT < MAX_PARTICLES && count <= 24) {
      // for (int i = 0; i < SPAWN_COUNT; i++) {
        particles.add(new Particle(loc));
      // }
    }
  }
  
  void update()
  {
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