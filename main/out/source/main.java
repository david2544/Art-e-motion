import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Iterator; 
import org.openkinect.processing.*; 
import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {



// import processing.sound.*;

Kinect kinect;

float minThresh = 600;
float maxThresh = 725;
boolean initialStart = true;

final int PARTICLE_START_FORCE = 100;
final int PARTILE_MAX_VEL = 20; ///7;//4;
final int PARTICLE_MAX_ACC = 10; // Max particle acceleration
final int SPAWN_COUNT = 2; // Number of particles to spawn at once
final float LIFESPAN_DECREMENT = 2.0f;
final int START_SIZE = 30;//100;//175;
final float SHRINK_RATE = 1;//2;//5;
final int MAX_PARTICLES = 100;
final int SPAWN_DELAY = 50; //ms

int[] x1 = {320, 335, 350, 360, 372, 378, 380, 378, 372, 360, 350, 335, 320, 305, 290, 280, 272, 262, 260, 262, 268, 280, 290, 305};
int[] y1 = {180, 182, 190, 200, 215, 228, 240, 252, 270, 280, 290, 298, 300, 298, 290, 280, 270, 256, 240, 228, 215, 200, 190, 182};
int backgroundCounter = 10;

boolean displayColour = true;
int ellapsedTime = millis();
boolean ready = true;
boolean startScreenDone = false;

ParticleSystem system = new ParticleSystem();
ColourGenerator colour = new ColourGenerator();
ParticleSystem2 particleSystem = new ParticleSystem2();
// Sound sound;
Attractor hand;
float time = 0;

public void setup()
{
  
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  background(0);
  particleSystem.addParticle(new PVector(random(width), random(height)));
  frameRate(30);
}

public void draw() 
{
  if (startScreenDone == false) {

    system.update();
    if(millis() > ellapsedTime + 2000) {
      system.clearCount();
      background(0);
      ready = true;
    }
    // Update our particle system each frame
    //   image(kinect.getVideoImage(), 640, 0);
    int[] depth = kinect.getRawDepth();
    if(initialStart == true) {
      initialStart = false;
      delay(2000);
    }
    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        int offset = x + y * kinect.width;
        int d = depth[offset];
        if (d > minThresh && d < maxThresh) {
          ellapsedTime = millis();
          if(ready == true) {
            ready = false;
            for(int i = 0; i < 24; i++) {
              system.addParticle(new PVector(random(x-50, x+50), random(y-50, y+50)));
            }
          }
        } else {
          if(millis() > ellapsedTime + 100) {
            ready = true;
          }
        }
      }
    }
  } else {
    background(0);
    particleSystem.addParticle(new PVector(random(width), random(height)));

    image(kinect.getDepthImage(), 640, 0);

    particleSystem.run();
    float sumX = 0;
    float sumY = 0;
    float totalPixels = 0;
    float avgX = 0;
    float avgY = 0;

    int[] depth = kinect.getRawDepth();

    for(int x = 0; x < kinect.width; x++){
		  for(int y = 0; y < kinect.height; y++){
			
			  int offset = x + y * kinect.width;
        int depthValue = depth[offset];
        int minTrash = 500;
        int maxTrash = 740;

        if(depthValue > minTrash && depthValue < maxTrash){
          //img.pixels[offset] = color(255,0, 150);
          sumX += x;
          sumY += y;
          totalPixels ++;
        }
  		}
	  }
    avgX = sumX / totalPixels;
    avgY = sumY / totalPixels;

  	//img.updatePixels();
	
	  PVector avgPosition = new PVector(avgX, avgY);

    if(totalPixels > 4500){
      particleSystem.getAttracted(avgPosition);
    } else if (totalPixels > 0 && totalPixels < 4000){
      particleSystem.getRepulsed(avgPosition);
    }
  } 
}

public void mousePressed()
{
  
  // print("Here");
  background(0);
  if (millis() > ellapsedTime + SPAWN_DELAY) {
    for(int i = 0; i < 24; i++) {
      background(0, 0.1f);
      system.addParticle(new PVector(x1[i], y1[i]));
      ellapsedTime = millis();
    }
  }
}
class Attractor{
	Particle2 particle;
	float mass;
	PVector location;
	float g;
	float strength;
	float distance;

	Attractor(PVector position){
		location = position.get();
		mass = 20; // later one try with depthvalue
		g = 5;
	}

	public PVector attract(Particle2 particle){
		PVector force = PVector.sub(location, particle.position);
		distance = force.mag();
		force.normalize();
		//strength = (g * mass * particle.mass) * (distance * distance);
		strength = g / distance * distance;
		force.mult(strength);
		ColourGenerator colour = new ColourGenerator();
    colour.update();
		return force;
	}

	public PVector repulse(Particle2 particle){
		PVector force = PVector.sub(location, particle.position);
		distance = force.mag();
		force.normalize();
		strength = -1 * g / distance* distance;//
		//strength = (g * mass * particle.mass) * (distance * distance); 
		force.mult(strength);
    colour.update();
		
		return force;
	}
}
class ColourGenerator
{
  final static float MIN_SPEED = 0.2f;
  final static float MAX_SPEED = 0.7f;
  float R, G, B;
  float Rspeed, Gspeed, Bspeed;
  
  ColourGenerator()
  {
    init();  
  }
  
  public void init()
  {
    // Starting colour
    R = random(255);
    G = random(255);
    B = random(255);
    
    // Starting transition speed
    Rspeed = (random(1) > 0.5f ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Gspeed = (random(1) > 0.5f ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
    Bspeed = (random(1) > 0.5f ? 1 : -1) * random(MIN_SPEED, MAX_SPEED);
  }
  
  public void update()
  {
    // Use transition to alter original colour (Keep within RGB bounds)
    Rspeed = ((R += Rspeed) > 255 || (R < 0)) ? -Rspeed : Rspeed;
    Gspeed = ((G += Gspeed) > 255 || (G < 0)) ? -Gspeed : Gspeed;
    Bspeed = ((B += Bspeed) > 255 || (B < 0)) ? -Bspeed : Bspeed;
  }
  
}
class Particle
{
  PVector loc;
  PVector vel;
  PVector acc;

  
  int size = START_SIZE;
  float angle;
  float lifespan;
  
  Particle(PVector loc2) 
  {
    loc = new PVector(loc2.x, loc2.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    lifespan = 255.0f;
  }
  
  public void update()
  {
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
    
    // Wrap around the screen
    if (loc.x > width)
      loc.x -= width;
     if (loc.x < 0)
       loc.x += width;
     if(loc.y > height)
       loc.y -= height;
     if(loc.y < 0)
       loc.y += height;
    
    lifespan -= 2.0f;
    if(ready == true) {
      size -= SHRINK_RATE;
    }

    if(lifespan <= 0) {
      startScreenDone = true;
    }
    
  }
  
  public void display() 
  {
     if (displayColour) {
       //colour = new ColourGenerator();
        colour.update();
        fill(colour.R, colour.G, colour.B, lifespan);
        stroke(colour.R, colour.G, colour.B, lifespan);
     } else {
         fill(255);
     }
     ellipse(loc.x, loc.y, size, size);
  }
  
  public boolean isDead()
  {
    if (size < 0) {
      return true;
    } else {
      return false;
    }
  }
}
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
    
  public void applyForce(PVector f){
    PVector force = PVector.div(f, mass);
    acceleration.add(force);
  }

  public PVector repulse(Particle2 part){
    float g = 5;
    force = PVector.sub(position, part.position);
    float distance = force.mag();

    force.normalize();
    float strength = (g * mass * part.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  public void display(){
    fill(colour.R, colour.G, colour.B, lifespan);
    ellipse(position.x, position.y, mass * 2, mass * 2);
  }

  public void move(){
    //println("partPosition: " + position);
    velocity.add(acceleration);
    velocity.limit(3);
    position.add(velocity);

    acceleration.mult(0);
    lifespan -= 0.005f;
  }

  public void checkEdges(){

    if(position.x < 0){
      position.x = 0.1f;
      velocity.x *= -1;
    }
    if(position.x > width){
      position.x = width - 1;
      velocity.x *= -1;
    }
    if(position.y < 0){
      position.y = 0.1f;
      velocity.y *= -1;
    }
    if(position.y > height){
      position.y = height - 1;
      velocity.y *= -1;
    }
  }

  public void setIndex(int in){
    index = in;
  }

  public int getIndex(){
    return index;
  }

  public boolean isDead(){
    if(lifespan == 0){
      return true;
    }
    return false;
  }

  // void changeColor(){
  // //fillColor = color(random(255), random(255), random(255));
  // fillColor = color(0,160, random(255));
  // }


  public void run(){
    checkEdges();
    move();
    display();
  }
}
class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int count = 0;
  
  ParticleSystem() { }

  public void clearCount() {
    count = 0;
  }
    
  public void addParticle(PVector loc)
  {
    // print(count, "\n");
    if (particles.size() + SPAWN_COUNT < MAX_PARTICLES && count <= 24) {
        count++;
      // for (int i = 0; i < SPAWN_COUNT; i++) {
        particles.add(new Particle(loc));
      // }
    }
  }

  public void update()
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
  int particleNumber = 1000;
  
  ParticleSystem2(){
  }

  public void addParticle(PVector location){
    position = location.get();
    for(int i = 0 ; i < particleNumber; i++){
      particle = new Particle2();
      if(millis() > time + 10){
        particleList.add(particle);
        time = millis();
      }
      // particleList.add(index, particle);
      // particle.setIndex(index);
      // index = i;
    }
  }

  // void addParticle(PVector location){
  //   position = location.get();
  //   if(particleList.size() < 500){
  //     particleList.add(new Particle());
  //   }
  // }

  public void showParticle(){
    for(int i = particleList.size() -1; i >= 0; i--){
      Particle2 part = particleList.get(i);
      part.run();
      if(part.isDead()){
        particleList.remove(part);
      }
    }
  }

  public void repulseParticle(){
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

	public void getAttracted(PVector location){
    handPosition = location.get();
		hand = new Attractor(handPosition);

		for(Particle2 part : particleList){
			force = hand.attract(part);
			part.applyForce(force);
		}
	}

	public void getRepulsed(PVector handpos){
		handPosition = handpos.get();
		hand = new Attractor(handPosition);

		for(Particle2 part : particleList){
			force = hand.repulse(part);
			part.applyForce(force);
		}

	}

  public void run(){
    repulseParticle();
    showParticle();
  }
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}