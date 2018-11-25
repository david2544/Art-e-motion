class Particle2{
  PVector position;
  PVector velocity;
  PVector acceleration;
  int index;
  float mass;
  PVector force;
  int lifespan;  

  Particle2(){
    mass = random(10);
    position = new PVector(random(0, width), random(0, height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(-1,1), random(-1,1));
    lifespan = 255;
  }
  
  void applyForce(PVector f){
    PVector force = PVector.div(f, mass);
    acceleration.add(force);
  }

  PVector repulse(Particle2 part){
    float g = 5;
    force = PVector.sub(position, part.position);
    float distance = force.mag();

    force.normalize();
    float strength = (g * mass * part.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display(){
    fill(colour.R, colour.G, colour.B, lifespan);
    ellipse(position.x, position.y, mass * 2, mass * 2);
  }

  void move(){
    velocity.add(acceleration);
    velocity.limit(3);
    position.add(velocity);

    acceleration.mult(0);
    //lifespan -= 0.00005;
  }

  void checkEdges(){

    if(position.x < 0){
      position.x = 0.1;
      velocity.x *= -1;
    }
    if(position.x > width){
      position.x = width - 1;
      velocity.x *= -1;
    }
    if(position.y < 0){
      position.y = 0.1;
      velocity.y *= -1;
    }
    if(position.y > height){
      position.y = height - 1;
      velocity.y *= -1;
    }
  }

  void setIndex(int in){
    index = in;
  }

  int getIndex(){
    return index;
  }

  boolean isDead(){
    if(lifespan == 0){
      return true;
    }
    return false;
  }

  void run(){
    checkEdges();
    move();
    display();
  }
}