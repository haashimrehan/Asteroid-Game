//includes ship driving, thrust animation, and stars

class Ship {
  int maxSize = 200;
  //variables for the ship
  PVector sPos = new PVector();
  PVector sVel = new PVector(); //velocity of the ship
  PVector sAcc = new PVector(); //acceleration of the ship
  PVector sDir = new PVector(0, 1, 0); //direction of the ship
  float speedLimit = 12; //maximum speed for the ship
  boolean leftBool, rightBool, thrustBool; 

  //variables for the tracers(animation)
  float startSize = 30; // this is the tracers starting size
  PVector[] posh = new PVector[maxSize];
  PVector[] velh = new PVector[maxSize];
  PVector[] acch = new PVector[maxSize];
  float [] sizes = new float[maxSize];
  float shrinkscale = 0.99;
  float velscale = 2;

  PVector midPoint = new PVector();

  //Bullets
  ArrayList <PVector> posB = new ArrayList <PVector>();
  ArrayList <PVector> velB = new ArrayList <PVector>();
  float bulletSize = 5;
  float bulletSpeed = 20;

  int lives = 3;
  int score = 0;

  void initShip() {
    sPos = new PVector(0, 0, 0); //position of the ship
    asteroids.add(new Asteroid(main, new PVector(random(300, 1000), random(300, 1000))));

    for (int i = 0; i < maxSize; i++) {
      posh[i] = new PVector(-1000, -1000);
      velh[i] = PVector.random2D();
      velh[i].mult(velscale);
      acch[i] = new PVector(0, 0);

      sizes[i] = startSize;
    }
  }

  void checkRogue() {
    for (int i = 0; i < asteroids.size(); i++) {
      if (detect(asteroids.get(i).pos, asteroids.get(0).pos, 3000)) {
        asteroids.remove(i);
      }
    }
  }

  void respawn() {
    initShip();
    sPos = new PVector(width*0.75, height*0.75, 0); //position of the ship
    sVel = new PVector(); //velocity of the ship
    sAcc = new PVector(); //acceleration of the ship
    sDir = new PVector(0, 1, 0); //direction of the ship
  }

  void offEdge() {
    if (sPos.x > 1650) {
      sPos.x = -650;
    } else if (sPos.x < -650) {
      sPos.x = 1650;
    } else if (sPos.y > 1150) {
      sPos.y = -450;
    } else if (sPos.y < -450) {
      sPos.y = 1150;
    }
  }

  void bulletControl() {
    for (int i = 0; i < posB.size(); i++) {
      PVector p = posB.get(i);
      PVector v = velB.get(i);
      p.add(v);
      noStroke();
      pushMatrix();
      fill(255, 0, 0);
      translate(p.x, p.y, p.z);
      sphere(bulletSize);
      popMatrix();
      //detects if the bullet is outside the screen
      if (detect(p, asteroids.get(0).pos, 1500)) {
        posB.remove(p); 
        velB.remove(v);
      }

      if (hitTarget(asteroids.get(0).pos, asteroids.get(0).mass/20, p, bulletSize)) {
        println("Hit");
        posB.remove(p); 
        velB.remove(v);
        asteroids.get(0).mass+=50;
        asteroids.get(0).siz+=10;
        score --;
      }
    }
  }

  void asteroidHitDetection() {
    for (int i = 0; i < posB.size(); i++) {
      for (int j = 1; j < asteroids.size(); j++) {
        if (hitTarget(asteroids.get(j).pos, asteroids.get(j).siz*0.66, posB.get(i), bulletSize)) {

          asteroids.remove(j);
          posB.remove(i); 
          velB.remove(i);
          asteroids.add(new Asteroid(main, new PVector(random(0, 1500), random(0, 1500))));
          score += 5;
          break;
        }
      }
    }
  }

  void shipHitDetection() {
    for (int i = 0; i < asteroids.size(); i++) {
      if (hitTarget(asteroids.get(i).pos, asteroids.get(i).siz*0.7, sPos, bulletSize)) {
        lives --;
        respawn();
        break;
      }
    }
  }

  void tracers() {
    noStroke();
    for (int i = maxSize -1; i > 0; i--) { //Move each tracer back in array

      posh[i] = posh[i-1];

      sizes[i] = sizes[i-1]*shrinkscale;  //Shrink tracer as moving through array

      velh[i] = velh[i-1];
    }

    if (thrustBool) {
      thrust.play();
      posh[0] = new PVector(sPos.x, sPos.y);

      velh[0] = PVector.random2D();

      velh[0].mult(velscale);

      sizes[0] = startSize;
    } else { // If not pressing thrust, Then spawn Tracers out of screen
      posh[0] = new PVector(-1000, -1000);
      thrust.pause();
    }

    for (int i = 0; i < maxSize; i++) {
      posh[i].add(velh[i]);
      fill(255, 100 - (float)i/maxSize*254., 0, 255. - (float)i/15*254.);
      //fill(50 + (float)i/maxSize*205, 128+127*sin((float)frameCount* PI/60), 127. - cos((float)frameCount*PI/30), 255. - (float)i/maxSize*254.);
      pushMatrix();
      //potential angle of the tracers error?
      translate(cos(sDir.x)*sAcc.x, sin(sDir.y)*sAcc.y);

      ellipse(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);

      popMatrix();
      //sphere(posh[i].x, posh[i].y, sizes[i]/3, sizes[i]/3);
    }
  }

  void shipDriving() {

    sVel.add(sAcc);
    sPos.add(sVel);
    sAcc.set(0, 0, 0);

    fill(255);
    pushMatrix();
    translate(sPos.x, sPos.y);
    rotate(sDir.heading());
    stroke(1);
    //  scale(0.1);
    box(30, 10, 10);
    popMatrix();

    if (leftBool) { //add to rotation
      sDir.rotate(-0.3);
    }
    if (rightBool) {
      sDir.rotate(0.3);
    } 

    if (thrustBool) { //Increase Speed
      sAcc = sDir.copy().mult(0.1);
    } else { //Decrease Speed
      sVel.mult(0.98);
    }
    sVel.limit(speedLimit);
  }

  boolean detect(PVector pos1, PVector pos2, float rad) { // detect if bullets outside of screen
    boolean isFar =  PVector.dist(pos1, pos2) > rad;
    return isFar;
  }

  boolean hitTarget(PVector pos1, float rad1, PVector pos2, float rad2) { // Hit detection
    return pos1.dist(pos2) < rad1 + rad2;
  }

  void update() {
    shipDriving();
    tracers();
    bulletControl();
    asteroidHitDetection();
    shipHitDetection();
    offEdge();
    checkRogue();
  }
}
