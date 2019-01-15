int state = 0;//used to determine which state the program is in; 0 = pregame, 1 = game, 2 = endgame 
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
  ship.update(); 
  ship2.update();
  cameraZoom();
  starBackground();

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
