import java.util.Iterator;
import org.openkinect.processing.*;
// import processing.sound.*;

Kinect kinect;

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

int animation2Iterations = 20;
int ellapsedTime = millis();

float sumX = 0;
float sumY = 0;
float totalPixels = 0;
PVector lastAvgPos = new PVector(0, 0);

boolean initialStart = true;
boolean isPushing = false;
boolean shouldRenderAnimation1 = false;

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
}

void draw() 
{
  int[] depth = kinect.getRawDepth();
  
  if (shouldRenderAnimation1 == true) {
    renderAnimation1(depth);
  } else {
    secondScreen(depth);
  } 
}
