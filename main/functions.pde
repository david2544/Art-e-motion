void renderAnimation1(int[] depth) {
  // Update the particle system with each iteration
  drawBackground();
  system.update();
  pixelIterator(depth);
}

void renderAnimation2(int[] depth) {
  background(0);
  particleSystem.run();

  float avgX = 0;
  float avgY = 0;

  sumX = 0;
  sumY = 0;
  totalPixels = 0;
  
  pixelIterator(depth);

  avgX = sumX / totalPixels;
  avgY = sumY / totalPixels;
  PVector avgPosition = new PVector(avgX, avgY);
  if(animation2Iterations == 40) {
    if (lastAvgPos.x < avgPosition.x + 20 && lastAvgPos.x > avgPosition.x - 20 && lastAvgPos.y < avgPosition.y + 20 && lastAvgPos.y > avgPosition.y - 20) {
      shouldRenderAnimation1 = true;
      system.particles.clear();
    }

    lastAvgPos = avgPosition;
    animation2Iterations = 0;
  }

  animation2Iterations += 1;

  if(avgPosition.x > 0 && avgPosition.y > 0) {
    particleSystem.getAttracted(avgPosition);
  }
}

void pixelIterator(int[] depth) {
  for(int x = 0; x < kinect.width; x++){
    for(int y = 0; y < kinect.height; y++){
      // Iterates over each pixel and gets its depth value
      int offset = x + y * kinect.width;
      int d = depth[offset];

      // If the depth value is between a certain threshold...
      if(d > MIN_THRESH && d < MAX_THRESH) {
        if (shouldRenderAnimation1 == true) {
          addParticlesAnimation1(d, x, y);
        } else {
          sumX += x;
          sumY += y;
          totalPixels ++;
        }
      // if not, we probably ended a push so we update the variable isPushing
      } else {
        if(millis() > ellapsedTime + 100) {
          isPushing = false;
          system.clearCount();
          // busDavid.sendControllerChange(1,123,0);
        }
      }
    }
  }
}

// Gives us the fading away background
void drawBackground() {
  // noStroke();
  fill(0, 20);
  rect(0, 0, width, height);
}

void addParticlesAnimation1(int d, int x, int y) {
  // Add particles to random locations around the position where the user pushed
  ellapsedTime = millis();
  if(isPushing == false) {
    isPushing = true;
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
		//startBus.sendControllerChange(1,7,0);
		exit();
	}
}