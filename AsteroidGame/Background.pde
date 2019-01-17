int maxSize = 200;

//variables for the stars
int mult = 1000;
float starSize = 2;//0.5; //size of the stars
PVector[] starPos = new PVector [maxSize]; //star positions

void starBackground() { //Populates ellipses in the background to act as stars
  for (int i=1; i < maxSize; i++) {
    pushMatrix();
    strokeWeight(0);
    fill(255. -(float)i/maxSize*255, 255, 255);
    translate(starPos[i].x, starPos[i].y, starPos[i].z);
    ellipse(random(starSize, starSize*2), random(starSize, starSize*2), random(starSize, starSize*2), random(starSize, starSize*2));
    popMatrix();
  }
}

void checkRogue() { // Checks for asteroids that go too far off screen and deletes them
    for (int i = 0; i < asteroids.size(); i++) {
      if (ship.detect(asteroids.get(i).pos, asteroids.get(0).pos, 3000)) {
        asteroids.remove(i);
      }
    }
  }
