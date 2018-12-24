int maxSize = 200;

//variables for the stars
int mult = 1000;
float starSize = 2;//0.5; //size of the stars
PVector[] starPos = new PVector [maxSize]; //star positions

void initBackground() {
  for (int i = 1; i < maxSize; i++) {
    starPos[i] =  (PVector.random3D());
    starPos[i].mult(mult);
  }
}

void starBackground() {
  for (int i=1; i < maxSize; i++) {  //Background stars
    pushMatrix();
    fill(255. -(float)i/maxSize*255, 255, 255);
    translate(starPos[i].x, starPos[i].y, starPos[i].z);
    ellipse(random(starSize, starSize*2), random(starSize, starSize*2), random(starSize, starSize*2), random(starSize, starSize*2));
    popMatrix();
  }
}
