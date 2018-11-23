import java.util.*;


class ParticleSystem2{
  Particle2 particle;
  ArrayList<Particle2> particleList = new ArrayList<Particle2>();
  Iterator<Particle2> itr = particleList.iterator();
  Attractor hand;
  PVector position;
  PVector force;
	PVector handPosition;
  float time = 0;

  int index;
  int particleNumber = 500;
  
  ParticleSystem2(){
  }

  void addParticle(PVector location){
    position = location.get();
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

  // void showParticle(){
  //   for(int i = particleList.size() - 1; i >= 0; i--){
  //     Particle part = particleList.get(i);
  //     part.run();
  //     if(part.isDead()){
  //       particleList.remove(part);
  //     }
  //   }
  // }

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

	void getRepulsed(PVector handPos){
		hand = new Attractor(handPos);

		for(Particle2 part : particleList){
			force = hand.repulse(part);
      //force = force.add(force);
			part.applyForce(force);
		}

	}

  void run(){
    repulseParticle();
    showParticle();
  }
}
