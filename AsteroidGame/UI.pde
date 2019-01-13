boolean checkScore = false;

void startScreen() {
  cam.beginHUD();
  background(150, 100, 50);
  text("Asteroid Game", width/2, height/2);
  text("Press enter to continue", width/2, height/2+200);
  cam.endHUD();
}

void endScreen() {
  cam.beginHUD();
  textSize(30);
  background(150, 100, 50);
  text("Score " + ship.score, width/2, (height/5));
  text("Game Over", width/2, (height/5)*2);
  text("Press 'r' to restart", width/2, (height/5)*3);

  ship.scores = sort(ship.scores);
  //if score is larger than smallest score in array overwrite it
  if (ship.scores[0] < ship.score && !checkScore) { 
    ship.scores[0] = ship.score;
    ship.scores = sort(ship.scores);
    checkScore = true;
  }
  ship.scores = reverse(ship.scores);

  for (int i = 0; i < ship.scores.length; i++) {
    text("" + ship.scores[i], width/2, (height/4)*3+i*30);
  }

  if (keyPressed && key == 'r') {
    checkScore = false;
    ship.lives = 3;
    ship.respawn();
    ship.score = 0;
    for (int i = 0; i < asteroids.size(); i++) {
      asteroids.remove(i);
    }
    state = 1;
  }
  cam.endHUD();
}


void pauseHUD() {
  fill(255);
  cam.beginHUD();
  textSize(50);
  text("Paused", width/2, height/4);
  cam.endHUD();
}

void hud() {
  cam.beginHUD();
  rectMode(CORNER);
  textSize(15);
  fill(50, 250, 150, 128);
  rect(0, 0, width, 30);
  fill(255);
  text("" + nfc(frameRate, 2), 25, 15);
  text("Score: " + ship.score, width - 60, 15);
  if (ship.lives <= 0) {
    println("Game Over");
    state = 100;
  }

  if (ship.lives > 0) {
    image(life, width/2 - 50, 5, 25, 25);
  } 
  if (ship.lives > 1) {
    image(life, width/2-25, 5, 25, 25);
  } 
  if (ship.lives > 2) {
    image(life, width/2, 5, 25, 25);
  }
  cam.endHUD();
}
