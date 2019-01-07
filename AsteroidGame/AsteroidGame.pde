/*
 Asteroid Game
 Haashim Rehan
 */

import peasy.PeasyCam;
import ddf.minim.*;

PeasyCam cam;
Minim minim;

AudioSample bullet;
AudioPlayer thrust;

Asteroid main;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
PVector center;
PShape model;
PImage texture;
PImage life;
PShape rocket;

Ship ship = new Ship();

void setup() {
  size(1000, 700, P3D);
  // frameRate(50);
  smooth(8);
  center = new PVector(width/2, height/2, 0);

  cam = new PeasyCam(this, width/2, height/2, 0, 600);
  cursor(CROSS);
  textSize(30);
  textAlign(CENTER, CENTER);
  init();  
  ship.initShip();
  minim = new Minim(this);
  bullet = minim.loadSample("bullet.mp3", 512);
  thrust = minim.loadFile("ship.mp3", 2048);
}

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

void draw() {
  println(paused);
  if (state == 0) {
    pregame();
  } else if (state == 1) {
    game();
  } else if (state == 2) {
    pauseGame();
  } else {
    endgame();
  }
}
