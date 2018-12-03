void firstScreen(int[] depth) {
  system.update();
  if(millis() > ellapsedTime + 2000) {
    system.clearCount();
    background(0);
    ready = true;
    //mute all sounds when animation is done
    busDavid.sendControllerChange(1,123,0);
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

  if(avgPosition.x > 0 && avgPosition.y > 0){
    particleSystem.getAttracted(avgPosition);
  }
}

void pixelParser(int[] depth) {
  for(int x = 0; x < kinect.width; x++){
    for(int y = 0; y < kinect.height; y++){
      int offset = x + y * kinect.width;
      int d = depth[offset];

      if(d > MIN_THRESH && d < MAX_THRESH) {
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

void mouseDragged(){
  // addParticlesFirstScreen(int(random(100)),mouseX, mouseY);
  // system.addParticle(new PVector(mouseX, mouseY));
  // system.update();

	PVector mouse = new PVector(mouseX, mouseY);
	particleSystem.getAttracted(mouse);
}

void keyPressed(){
	if(key == 'A' || key =='a'){
		startBus.sendControllerChange(1,7,0);
		exit();
	}
}