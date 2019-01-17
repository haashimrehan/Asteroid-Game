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

long m1 = 5000;

void itemUpdate() {
  if (millis() - m1 > 15000) {

    switch (int(random(0, 5))) {
    case 0: 
      healthItem.newPos();    
      items.add(healthItem);
      println("health" + healthItem.pos);
      break;
    case 1: 
      shieldItem.newPos();    
      items.add(shieldItem);
      println("shield"+shieldItem.pos);
      break;    
    case 2: 
      doubleBullet.newPos();    
      items.add(doubleBullet);
      println("double"+doubleBullet.pos);
      break;    
    case 3: 
      tripleBullet.newPos();    
      items.add(tripleBullet);
      println("triple" + tripleBullet.pos);
      break;    
    case 4: 
      laserItem.newPos();    
      items.add(laserItem);
      println("laser" + laserItem.pos);
      break;
    }

    m1 = millis();
  }
}

boolean musicCheck = false;
void music() {
  if (music1.isPlaying() && !musicCheck) {
    musicCheck = true;
  } else if (!music1.isPlaying() && musicCheck) {
    music2.play();
    musicCheck = false;
  } else if (music2.isPlaying() && !musicCheck) {
    musicCheck = true;
  } else if (!music2.isPlaying() && musicCheck) {
    music1.play();
    musicCheck = false;
  }
}
