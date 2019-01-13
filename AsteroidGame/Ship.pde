//includes ship driving, thrust animation, and stars
// for laser, find distance from point and line less than radius.
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
  int[] scores = new int[]{0, 5, 10, 14, 21};
  int score = 0;

  boolean laser = false;
  boolean threeBullets = false;
  boolean bullet = true;
  color colour;


  public Ship(color _colour) {
  colour = _colour;
  }

  void initShip() {
    sPos = new PVector(0, 0, 0); //position of the ship
    new Asteroid(main, new PVector(random(300, 1000), random(300, 1000)));

    for (int i = 0; i < maxSize; i++) {
      posh[i] = new PVector(-1000, -1000);
      velh[i] = PVector.random2D();
      velh[i].mult(velscale);
      acch[i] = new PVector(0, 0);

      sizes[i] = startSize;
    }
  }

  void bullet() { 
    //position where the bullet starts
    ship.posB.add(new PVector(ship.sPos.x, ship.sPos.y, ship.sPos.z));

    //speed and direction of bullet
    PVector tempv = new PVector(ship.sDir.x, ship.sDir.y, ship.sDir.z).mult(ship.bulletSpeed);
    ship.velB.add(tempv);
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

  PVector end = new PVector();
  PVector start = new PVector();
  void laser () {
    end = new PVector(sDir.x, sDir.y, sDir.z).mult(2000);
    start = new PVector(sPos.x, sPos.y);
    fill(255);
    strokeWeight(5);
    stroke(255);
    line(sPos.x, sPos.y, end.x, end.y);
    laserHitDetect(5, asteroids.get(1).mass);
  }

  void laserHitDetect(float lineThickness, float rad) {
    for (int i = 1; i < asteroids.size(); i++) {
      // println(pointLineDist(asteroids.get(i).pos, sPos, end));
      if (pointLineDist(asteroids.get(i).pos, sPos, end) < lineThickness + rad) {

        explosions.add(new Explosion(asteroids.get(i).pos, exSize, explosions, explosionImages, 5)); 
        asteroids.remove(i);
        new Asteroid(main, new PVector(random(0, 1500), random(0, 1500)));
        score += 5;
      }
    }
  }

  // returns distance between point and line
  float pointLineDist(PVector pt, PVector start, PVector end) {
    PVector closest;

    float dx = end.x - start.x; 
    float dy = end.y - start.y;

    if ((dx == 0) && (dy == 0))
    {
      // It's a point not a line segment.
      closest = start;
      dx = pt.x - start.x;
      dy = pt.y - start.y;
      return sqrt(dx * dx + dy * dy);
    }

    // Calculate the t that minimizes the distance.
    float t = ((pt.x - start.x) * dx + (pt.y - start.y) * dy) /
      (dx * dx + dy * dy);

    // See if this represents one of the segment's
    // end points or a point in the middle.
    if (t < 0)
    {
      closest = new PVector(start.x, start.y);
      dx = pt.x - start.x;
      dy = pt.y - start.y;
    } else if (t > 1)
    {
      closest = new PVector(end.x, end.y);
      dx = pt.x - end.x;
      dy = pt.y - end.y;
    } else
    {
      closest = new PVector(start.x + t * dx, start.y + t * dy);
      dx = pt.x - closest.x;
      dy = pt.y - closest.y;
    }

    return sqrt(dx * dx + dy * dy);
  }

  void threeBullets() {
    for (int i = -1; i < 2; i ++) {
      //position where the bullet starts
      posB.add(new PVector(sPos.x, sPos.y, sPos.z));

      //speed and direction of bullet
      PVector v1 = new PVector(sDir.x, sDir.y, sDir.z).mult(ship.bulletSpeed);
      v1.rotate(PI/.1+i*50);
      velB.add(v1);
    }

    //  PVector v2 = new PVector(ship.sDir.x, ship.sDir.y, ship.sDir.z).mult(ship.bulletSpeed);
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

          explosions.add(new Explosion(posB.get(i), exSize, explosions, explosionImages, 5)); 
          asteroids.remove(j);
          posB.remove(i); 
          velB.remove(i);
          new Asteroid(main, new PVector(random(0, 1500), random(0, 1500)));
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

  void drawShip() {
    fill(colour);
    strokeWeight(1);
    stroke(1);
    pushMatrix();
    translate(sPos.x, sPos.y);
    rotate(sDir.heading());
    stroke(1);
    box(30, 10, 10);
    popMatrix();
  }

  void shipDriving() {
    sVel.add(sAcc);
    sPos.add(sVel);
    sAcc.set(0, 0, 0);

    drawShip();

    if (leftBool) { //add to rotation
      sDir.rotate(-0.1);
    }
    if (rightBool) {
      sDir.rotate(0.1);
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
