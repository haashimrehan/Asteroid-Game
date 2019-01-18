void init() {
  cameraInit();
  asteroidInit();
  initBackground();
  ship.initShip();
  ship2.initShip();
  audioInit();
  explosionInit();
  imageInit();
  itemInit();
}

void itemInit() {
  shieldItem = new Item(shield);
  doubleBullet = new Item(twoBullets);
  tripleBullet = new Item(threeBullets);
  laserItem = new Item(laser);
  healthItem = new Item(life);
  shieldItem.shield = true;
  doubleBullet.doubleB = true;
  tripleBullet.tripleB = true;
  laserItem.laser = true;
  healthItem.health = true;
}

void imageInit() {
  life = loadImage("life.png");
  shield = loadImage("shield.png");
  threeBullets = loadImage("3Bullet.png");
  twoBullets = loadImage("2Bullet.png");
  laser = loadImage("laser.png");
}

void asteroidInit() {
  texture = loadImage("texture4.jpg");
  rocket = loadShape("rocket.obj");
  model = loadShape("asteroid4.obj");
  model.setTexture(texture);
  center = new PVector(width/2, height/2, 0);
  main = new Asteroid(asteroids, 2500., model, center, new PVector(), false);
}

void initBackground() {
  for (int i = 1; i < maxSize; i++) {
    starPos[i] =  (PVector.random3D());
    starPos[i].mult(mult);
  }
}

void cameraInit() {
  cam = new PeasyCam(this, width/2, height/2, 0, 600);
}

void audioInit() {
  minim = new Minim(this);
  bulletSound = minim.loadSample("bullet.mp3", 512);
  thrust = minim.loadFile("ship.mp3", 2048);
  for (int i = 0; i < music.length; i++) {
    music[i] = minim.loadFile("Tetris" + (i+1) + ".mp3");
  }
  
  music[0].play();
}

void explosionInit() {
  imageMode(CENTER);
  //loading images   
  for (int i = 0; i < explosionImages.length; i ++) {
    explosionImages[i] = loadImage("explosion"+i+".png");
  }
}
