int state = 0;//used to determine which state the program is in; 0 = pregame, 1 = game, 2 = endgame 

void pregame() {
  startScreen();
  if (keyPressed && keyCode == ENTER) {
    state = 1;
  }
}

void game() {
  background(0);
  noStroke();
  ship.update(); 
  cameraZoom();
  starBackground();
  
  asteroids.get(0).update(center);
  
  for (int i = 0; i < asteroids.size() -1; i++) {
    asteroids.get(i+1).update();
  }

  hud();
}

void endgame() {
  endScreen();
}
