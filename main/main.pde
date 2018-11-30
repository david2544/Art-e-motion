import java.util.Iterator;
import org.openkinect.processing.*;
// import processing.sound.*;

Kinect kinect;

float minThresh = 600;
float maxThresh = 725;
boolean initialStart = true;

final int PARTICLE_START_FORCE = 100;
final int PARTILE_MAX_VEL = 20; ///7;//4;
final int PARTICLE_MAX_ACC = 10; // Max particle acceleration
final int SPAWN_COUNT = 2; // Number of particles to spawn at once
final float LIFESPAN_DECREMENT = 2.0;
final int START_SIZE = 30;//100;//175;
final float SHRINK_RATE = 1;//2;//5;
final int MAX_PARTICLES = 100;
final int SPAWN_DELAY = 50; //ms

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
float sumX = 0;
float sumY = 0;
float totalPixels = 0;

void setup()
{
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  background(0);
  frameRate(30);
}

void draw() 
{
  int[] depth = kinect.getRawDepth();
  
  if (startScreenDone == false) {
    firstScreen(depth);
  } else {
    secondScreen(depth);
  } 
}

void firstScreen(int[] depth) {
  system.update();
  if(millis() > ellapsedTime + 2000) {
    system.clearCount();
    background(0);
    ready = true;
  }

  // Update the particle system each frame
  if(initialStart == true) {
    initialStart = false;
    delay(2000);
  }

  pixelParser(depth);
}

void secondScreen(int[] depth) {
  background(0);
  particleSystem.addParticle(new PVector(random(width), random(height)));
  particleSystem.run();

  float avgX = 0;
  float avgY = 0;

  sumX = 0;
  sumY = 0;
  totalPixels = 0;
  
  pixelParser(depth);

  avgX = sumX / totalPixels;
  avgY = sumY / totalPixels;
  PVector avgPosition = new PVector(avgX, avgY);

  if(totalPixels > 4500){
    particleSystem.getAttracted(avgPosition);
  } else if (totalPixels > 0 && totalPixels < 4000){
    particleSystem.getRepulsed(avgPosition);
  }
}

void pixelParser(int[] depth) {
  for(int x = 0; x < kinect.width; x++){
    for(int y = 0; y < kinect.height; y++){
      int offset = x + y * kinect.width;
      int d = depth[offset];

      if(d > minThresh && d < maxThresh) {
        if (startScreenDone == false) {
          addParticlesFirstScreen(d, x, y);
        } else {
          sumX += x;
          sumY += y;
          totalPixels ++;
        }
      } else {
        if(millis() > ellapsedTime + 100) {
          ready = true;
        }
      }
    }
  }
}

void addParticlesFirstScreen(int d, int x, int y) {
  ellapsedTime = millis();
  if(ready == true) {
    ready = false;
    for(int i = 0; i < 24; i++) {
      system.addParticle(new PVector(random(x-50, x+50), random(y-50, y+50)));
    }
  }
}
