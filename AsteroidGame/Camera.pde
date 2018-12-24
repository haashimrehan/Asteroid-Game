float shipDist;

void cameraZoom() {
  shipDist = PVector.dist(ship.sPos, main.pos);
 // println(shipDist);
  if (shipDist < 300) {
    cam.lookAt(asteroids.get(0).pos.x, asteroids.get(0).pos.y, asteroids.get(0).pos.z, 600, 50);
  } else if (shipDist > 700) {
    cam.lookAt(asteroids.get(0).pos.x, asteroids.get(0).pos.y, asteroids.get(0).pos.z, 1400, 50);
  } else {
    cam.lookAt(asteroids.get(0).pos.x, asteroids.get(0).pos.y, asteroids.get(0).pos.z, shipDist*2, 50);  
  }
}
