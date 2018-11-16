import java.util.Iterator;
import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

float minThresh = 500;
float maxThresh = 640;
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

void setup()
{
  size(1280, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();

  background(0);
  frameRate(20);
}

void draw() 
{
  // Update our particle system each frame
  image(kinect.getVideoImage(), 640, 0);
  int[] depth = kinect.getRawDepth();

  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];
      // print(d, " this:");
      if (d > minThresh && d < maxThresh) {
        //print(d, "\n");
         print("Here");
         background(0);
      }
    }
  }
}