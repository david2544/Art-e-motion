import java.util.*;


class ParticleSystem2{
  Particle2 particle;
  ArrayList<Particle2> particleList = new ArrayList<Particle2>();
  Attractor hand;
  PVector position;
  PVector force;
  int particleNumber = 500;
  
  void addParticle(){
    for(int i = 0 ; i < particleNumber; i++){
      particle = new Particle2();
      particleList.add(particle);
    }
  }

  void showParticle(){
    for(Particle2 part : particleList){
      part.run();
    }
  }

  void repulseParticle(){
    for(int i = 0; i < particleList.size(); i++){
      for(int j = 0; j< particleList.size(); j++){
        if(i != j){
          Particle2 p1 = particleList.get(i);
          Particle2 p2 = particleList.get(j);
          float distance = dist(p1.position.x, p1.position.y, p2.position.x, p2.position.y);

          if(distance < 10){
            force = p1.repulse(p2);
            p1.applyForce(force);
          }
        }
      }
    }
  }

	void getAttracted(PVector location){
    hand = new Attractor(location);

		for(Particle2 part : particleList){
			force = hand.attract(part);
			part.applyForce(force);
		}
	}

  void run(){
    repulseParticle();
    showParticle();
  }
}