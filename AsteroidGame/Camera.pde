float shipDist;
float shipDist2;
float farthest;

void cameraZoom() {
  shipDist = PVector.dist(ship.sPos, main.pos);
  shipDist2 = PVector.dist(ship.sPos, main.pos);
  if (multiplayer) {
    if (shipDist > shipDist2) {
      farthest = shipDist;
    } else { 
      farthest = shipDist2;
    }
  } else {
    farthest = shipDist;
  }
  // println(shipDist);
  if (farthest < 300) {
    cam.lookAt(asteroids.get(0).pos.x, asteroids.get(0).pos.y, asteroids.get(0).pos.z, 600, 50);
  } else if (farthest > 700) {
    cam.lookAt(asteroids.get(0).pos.x, asteroids.get(0).pos.y, asteroids.get(0).pos.z, 1400, 50);
  } else {
    cam.lookAt(asteroids.get(0).pos.x, asteroids.get(0).pos.y, asteroids.get(0).pos.z, farthest*2, 50);
  }
}
