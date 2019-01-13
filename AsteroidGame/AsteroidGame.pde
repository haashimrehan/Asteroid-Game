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

color colour1 = color(0, 255, 0);
color colour2 = color(0, 0, 255);

Ship ship = new Ship(colour1);
//Ship ship2 = new Ship(colour2);


//Explosion
ArrayList<Explosion> explosions = new ArrayList<Explosion>();//need this to hold all explosions
PImage[] explosionImages = new PImage[8];//to hold the images of the explosion



void setup() {
  size(1000, 700, P3D);
  // frameRate(60);
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

  explosionInit();
}



void draw() {

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
