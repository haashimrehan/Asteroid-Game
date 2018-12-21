void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY, 0);
  if (mouseButton == LEFT) {
    asteroids.add(new Asteroid(main, mouse));
  }
}

void keyPressed() {
  if (key == ' ') {
    //position where the bullet starts
    ship.posB.add(new PVector(ship.sPos.x, ship.sPos.y, ship.sPos.z));
    //speed and direction of bullet
    PVector tempv = new PVector(ship.sDir.x, ship.sDir.y, ship.sDir.z).mult(ship.bulletSpeed);
    ship.velB.add(tempv);
    bullet.trigger(); //Play bullet Sound
  }

  if (key == 'r') {
    ship.respawn();  
  }

  //Driving Controls
  if (keyCode == LEFT) {
    ship.leftBool = true;
  }
  if (keyCode == RIGHT) {
    ship.rightBool = true;
  }
  if (keyCode == UP) {
    ship.thrustBool = true;
  }
}

void keyReleased() { //Better control for ship (multiple keys at once without confusing keys for others)
  if (keyCode == LEFT) {
    ship.leftBool = false;
  }
  if (keyCode == RIGHT) {
    ship.rightBool = false;
  }
  if (keyCode == UP) {
    ship.thrustBool = false;
  }
}
