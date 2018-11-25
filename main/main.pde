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
float sumZ = 0;
float avgZ = 0;

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
<<<<<<< HEAD
  int[] depth = kinect.getRawDepth();
  
  if (startScreenDone == false) {
    firstScreen(depth);
  } else {
    secondScreen(depth);
  } 
  particleSystem.addParticle(new PVector(random(width), random(height)));
  frameRate(30);
=======
  // if (startScreenDone == false) {

  //   system.update();
  //   if(millis() > ellapsedTime + 2000) {
  //     system.clearCount();
  //     background(0);
  //     ready = true;
  //   }
  //   // Update our particle system each frame
  //   //   image(kinect.getVideoImage(), 640, 0);
  //   int[] depth = kinect.getRawDepth();
  //   if(initialStart == true) {
  //     initialStart = false;
  //     delay(2000);
  //   }
  //   for (int x = 0; x < kinect.width; x++) {
  //     for (int y = 0; y < kinect.height; y++) {
  //       int offset = x + y * kinect.width;
  //       int d = depth[offset];
  //       if (d > minThresh && d < maxThresh) {
  //         ellapsedTime = millis();
  //         if(ready == true) {
  //           ready = false;
  //           for(int i = 0; i < 24; i++) {
  //             system.addParticle(new PVector(random(x-50, x+50), random(y-50, y+50)));
  //           }
  //         }
  //       } else {
  //         if(millis() > ellapsedTime + 100) {
  //           ready = true;
  //         }
  //       }
  //     }
  //   }
  // } else {

    /***********Sitan's part************/
    background(0);

	  particleSystem.run();
	
    float sumX = 0;
    float sumY = 0;
    float sumZ = 0;
    float totalPixels = 0;
    float avgX = 0;
    float avgY = 0;
    float avgZ = 0;
    

    int[] depth = kinect.getRawDepth();

    for(int x = 0; x < kinect.width; x++){
      for(int y = 0; y < kinect.height; y++){
        
        int offset = x + y * kinect.width;
        int depthValue = depth[offset];
        int minTrash = 500;
        int maxTrash = 745;

        if(depthValue > minTrash && depthValue < maxTrash){
          sumX += x;
          sumY += y;
          sumZ += depthValue;
          totalPixels ++;
        }
      //}
    }

    // avgX = sumX / totalPixels;
    // avgY = sumY / totalPixels;
    // avgZ = Math.round(sumZ / (totalPixels * 10));
    // //println("depth: " + avgZ);
    // PVector avgPosition = new PVector(avgX, avgY);
    // //println("avgZ before: " + avgZ);
    // if(avgZ > 65 && avgZ <= 72){
    // 	//println(avgZ);
    // 	particleSystem.getAttracted(avgPosition);
    // }else if(avgZ > 72 && avgZ < 75){
    // 	particleSystem.getRepulsed(avgPosition);
    // }
  }
}

// void mousePressed()
// {
  
//   // print("Here");
//   background(0);
//   if (millis() > ellapsedTime + SPAWN_DELAY) {
//     for(int i = 0; i < 24; i++) {
//       background(0, 0.1);
//       system.addParticle(new PVector(x1[i], y1[i]));
//       ellapsedTime = millis();
//     }
//   }
// }

/************Sitan's part *****************/
void mouseDragged(){
	PVector mouse = new PVector(mouseX, mouseY);
	particleSystem.getAttracted(mouse);
}

void mousePressed(){
	PVector mouse = new PVector(mouseX,mouseY);
	particleSystem.getRepulsed(mouse);
>>>>>>> Sitan | changes main and Particle2 and ParticleSystem2 to current working stage
}