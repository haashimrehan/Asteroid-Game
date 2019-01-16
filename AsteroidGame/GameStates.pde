int state = 0;//used to determine which state the program is in; 0 = pregame, 1 = game, 2 = endgame 
boolean paused = false;
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

void pregame() {
  startScreen();
  if (keyPressed && keyCode == ENTER) {
    state = 1;
  }
}

void game() {
  paused = false;
  background(0);
  noStroke();
  checkRogue();
  ship.update(); 
  ship2.update();
  cameraZoom();
  starBackground();

  itemUpdate();
  for (int i = 0; i< items.size(); i++) {
    items.get(i).update();
  }

  asteroids.get(0).update(center);

  for (int i = 0; i < asteroids.size() -1; i++) {
    asteroids.get(i+1).update();
  }

  //update explosion
  for (int i = 0; i < explosions.size(); i++) {
    explosions.get(i).draw();
  }

  hud();
}

void pauseGame() {
  paused = true;

  background(0);

  ship.drawShip();
  starBackground();

  asteroids.get(0).drawA();

  for (int i = 0; i < asteroids.size() -1; i++) {
    asteroids.get(i+1).drawA();
  }

  pauseHUD();

  hud();
}

void instructions() {
  cam.beginHUD();
  textSize(30);
  background(150, 100, 50);

  text("Instri", width/2, (height/5));
  text("Game Over", width/2, (height/5)*2);
  text("Press 'r' to restart", width/2, (height/5)*3);

  cam.endHUD();
}

void endgame() {
  endScreen();
}
