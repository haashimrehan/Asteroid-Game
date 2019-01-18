boolean checkScore = false;


// Button and mouse hit detection
boolean buttonHit(float rBorder, float lBorder, float tBorder, float bBorder) {
  if (mouseX < rBorder && mouseX > lBorder && mouseY < bBorder && mouseY > tBorder) {
    return true;
  }
  return false;
}

void startScreen() {
  cam.beginHUD();
  textSize(30);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  println(new PVector(mouseX, mouseY));
  background(150, 100, 50);
  fill(255);
  text("Asteroid Game", width/2, height/5);
  text("Press enter to continue", width/2, height/2+125);

  text("Press 'i' for instructions", width/2, height/2+225);

  // Single player button
  if (buttonHit(600, 400, 195+50, 270+ 50)) { 
    fill(220);
    if (mousePressed) {
      multiplayer = false;
      state = 1;
    }
  } else {
    fill(255);
  }
  rect(width/2, height/3 + 50, 200, 75, 10);

  // Multiplayer button
  if (buttonHit(600, 400, 195 + 150, 270 + 150)) {  
    fill(220);
    if (mousePressed) {
      multiplayer = true;
      state = 1;
    }
  } else {
    fill(255);
  }
  rect(width/2, height/3 + 150, 200, 75, 10);

  fill(0);
  text("Single Player", width/2, height/3 + 50);
  text("Multiplayer", width/2, height/3 + 150);
  cam.endHUD();
}

void endScreen() {
  cam.beginHUD();
  textSize(30);
  background(150, 100, 50);
  text("Score " + ship.score, width/2, (height/5));
  text("Game Over", width/2, (height/5) * 2);
  text("Press 'r' to restart", width/2, (height/5) * 3);

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
    for (int i = 1; i < asteroids.size(); i++) {
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

void instructions() {
  cam.beginHUD();
  textSize(15);
  background(150, 100, 50);
  textAlign(CENTER);
  text("Welcome to the Asteroid Game! Shoot the asteroids, collect points and try out different weapons! \nBe carefull though, shooting the main asteroid will cause it to get larger \nand more mini asteroids to spawn.", width/2, 50);
  text("use arrow keys and  space for player one and wasd and 'q' for player two to move and shoot", width/2, 130);
  textAlign(LEFT, CENTER);
  image(life, width/5, 200, 75, 75);
  text("Extra Life: If you have less than 3 lives left, you can pickup this item to get an extra life", width/5 + 50, 200);
  image(shield, width/5, 200 +100, 75, 75);
  text("Shield: Pickup the shield for added protection and to be sure you will not get hit by asteroids", width/5 + 50, 200+100);
  image(twoBullets, width/5, 200 +200, 75, 75);
  text("Double Bullets: This automaticaly shoots another bullet after the first one so you can shoot more\nasteroids", width/5 + 50, 200+200);
  image(threeBullets, width/5, 200 +300, 75, 75);
  text("Triple Bullets: Every shot shoots two other bullets at different angles to get more asteroids", width/5 + 50, 200+300);
  image(laser, width/5, 200 +400, 75, 75);
  text("Laser: The elaser destroys everything in its path. No skill needed", width/5 + 50, 200+400);
  cam.endHUD();
}

void hud() {
  cam.beginHUD();
  strokeWeight(0);
  rectMode(CORNER);
  imageMode(CORNER);
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
