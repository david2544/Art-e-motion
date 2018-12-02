void renderAnimation1(int[] depth) {
  // Update the particle system with each iteration
  drawBackground();
  system.update();
  pixelIterator(depth);
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
  if(animation2Iterations == 20) {
    if (lastAvgPos.x < avgPosition.x + 20 && lastAvgPos.x > avgPosition.x - 20 && lastAvgPos.y < avgPosition.y + 20 && lastAvgPos.y > avgPosition.y - 20) {
      shouldRenderAnimation1 = true;
      system.particles.clear();
    }

    lastAvgPos = avgPosition;
    animation2Iterations = 0;
  }

  animation2Iterations += 1;

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
        if (shouldRenderAnimation1 == true) {
          addParticlesAnimation1(d, x, y);
        } else {
          sumX += x;
          sumY += y;
          totalPixels ++;
        }
      } else {
        if(millis() > ellapsedTime + 100) {
          isPushing = false;
          system.clearCount();
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