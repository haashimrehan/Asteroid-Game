void init() {
  center = new PVector(width/2, height/2);
  texture = loadImage("texture4.jpg");
  rocket = loadShape("rocket.obj");
  model = loadShape("asteroid4.obj");
  model.setTexture(texture);

  initBackground();

  life = loadImage("life.png");

  main = new Asteroid(asteroids, 2500., model, center, new PVector(), false);
}

void initBackground() {
  for (int i = 1; i < maxSize; i++) {
    starPos[i] =  (PVector.random3D());
    starPos[i].mult(mult);
  }
}

void explosionInit() {
  imageMode(CENTER);
  //loading images   
  for (int i = 0; i < explosionImages.length; i ++) {
    explosionImages[i] = loadImage("explosion"+i+".png");
  }
}
