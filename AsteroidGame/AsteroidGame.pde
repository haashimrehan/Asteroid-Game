/*
 Asteroid Game
 Haashim Rehan
 */

// Camera
import peasy.PeasyCam;
import ddf.minim.*;

// Audio
PeasyCam cam;
Minim minim;
AudioSample bullet;
AudioPlayer thrust;

// Asteroids
Asteroid main;
ArrayList<Asteroid> asteroids = new ArrayList<Asteroid>();
PVector center;
PShape model;
PImage texture;
PShape rocket;

// Images
PImage life;
PImage shield;

// Explosions
ArrayList<Explosion> explosions = new ArrayList<Explosion>();//need this to hold all explosions
PImage[] explosionImages = new PImage[8];//to hold the images of the explosion

// Items
ArrayList<Items> items = new ArrayList<Items>();// Holds all Items
PImage[] itemImages = new PImage[4]; // Holds images for items

// Ship
color colour1 = color(0, 255, 0);
color colour2 = color(0, 0, 255);
Ship ship = new Ship(colour1);
//Ship ship2 = new Ship(colour2);

void settings() {
  size(1000, 700, P3D);
  // frameRate(60);
  smooth(8);
}

void setup() {
  cursor(CROSS);
  textSize(30);
  textAlign(CENTER, CENTER);
  init();
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
