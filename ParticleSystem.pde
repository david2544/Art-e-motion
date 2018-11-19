class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int count = 0;
  
  ParticleSystem() { }

  void clearCount() {
    count = 0;
  }
    
  void addParticle(PVector loc)
  {
    // print(count, "\n");
    if (particles.size() + SPAWN_COUNT < MAX_PARTICLES && count <= 24) {
        count++;
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
      // print(p.size);
      if (p.isDead()) {
        i.remove();
        // print("decreasing count:", count, "/n");
        count--;
      } else {
        p.display();
      }
    }
  }
}