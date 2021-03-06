int state = 0;//used to determine which state the program is in; 0 = pregame, 1 = game, 2 = pause, 3 = instructions, 4 = endgame 
boolean paused = false;

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
  music();
  if (multiplayer) {
    ship2.update();
  }
  cameraZoom();
  starBackground();

  itemUpdate();
  for (int i = 0; i < items.size(); i++) {
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
  music1.pause();
  music2.pause();
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



void endgame() {
  endScreen();
}
