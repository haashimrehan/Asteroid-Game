PVector exSize = new PVector(100, 100);//need this for how big of an explosion

void mousePressed() {
  PVector mouse = new PVector(mouseX, mouseY, 0);
  if (mouseButton == LEFT) {
    new Asteroid(main, mouse);
  }
}

void keyPressed() {
  if (key == 'q') {
    ship.laser = false;
    ship.threeBullets = false;
    ship.bullet = true;
    ship.doubleShot = false;
  }
  if (key == 'w') {
    ship.laser = false;
    ship.threeBullets = true;
    ship.bullet = false;
    ship.doubleShot = false;
}
  if (key == 'e') {
    ship.laser = true;
    ship.threeBullets = false;
    ship.bullet = false;
    ship.doubleShot = false;
} if (key == 't') {
    ship.laser = false;
    ship.threeBullets = false;
    ship.bullet = false;
    ship.doubleShot = true;
}


  if (key == ' ') {
    if (ship.bullet) {
      ship.bullet();
    }
    if (ship.laser) {
      ship.laser();
    }
    if (ship.threeBullets) {
      ship.threeBullets();
    }     
    if (ship.doubleShot) {
      ship.pressed = false;
      ship.doubleShot();
      

    }
    bullet.trigger(); //Play bullet Sound
  }

  if (key == 'r') {
    ship.respawn();
  }

  if (key == 'p') {
    if (paused) {
      state = 1;
    } else {
      state = 2;
    }
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
  /*
 //Driving Controls
   if (key == 'a') {
   ship2.leftBool = true;
   }
   if (key == 'd') {
   ship2.rightBool = true;
   }
   if (key == 'w') {
   ship2.thrustBool = true;
   }*/
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

  /*
 if (key == 'a') {
   ship2.leftBool = false;
   }
   if (key == 'd') {
   ship2.rightBool = false;
   }
   if (key == 'w') {
   ship2.thrustBool = false;
   }*/
}
