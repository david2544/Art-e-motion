import org.openkinect.processing.*;

Kinect kinect;

void setup()
{
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  //kinect.initVideo();

  background(0);
  frameRate(20);
}

void draw() 
{
  system.update();
  // Update our particle system each frame
  //image(kinect.getVideoImage(), 640, 0);
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