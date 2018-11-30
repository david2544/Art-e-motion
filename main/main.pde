import java.util.Iterator;
import org.openkinect.processing.*;
import themidibus.*;

Kinect kinect;
// MidiBus startBus = new MidiBus(this, "startBus", "startBus");


final int PARTICLE_START_FORCE = 100;
final int PARTILE_MAX_VEL = 20; ///7;//4;
final int PARTICLE_MAX_ACC = 10; // Max particle acceleration
final int SPAWN_COUNT = 2; // Number of particles to spawn at once
final int START_SIZE = 30;//100;//175;
final int MAX_PARTICLES = 100;
final int SPAWN_DELAY = 50; //ms
final float LIFESPAN_DECREMENT = 2.0;
final float SHRINK_RATE = 1;//2;//5;
final float MIN_THRESH = 600;
final float MAX_THRESH = 725;

int ellapsedTime = millis();

float sumX = 0;
float sumY = 0;
float totalPixels = 0;

boolean initialStart = true;
boolean ready = true;
boolean startScreenDone = false;

Attractor hand;

ParticleSystem system = new ParticleSystem();
ColourGenerator colour = new ColourGenerator();
ParticleSystem2 particleSystem = new ParticleSystem2();

void setup()
{
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.enableMirror(true);
  background(0);
  frameRate(30);
  particleSystem.addParticle();

  // startBus.sendControllerChange(1,122,120); // starts the first clip(baseLine)
  // startBus.sendControllerChange(1,7,127);

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