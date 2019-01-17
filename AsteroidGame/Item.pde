class Item {
  int type;
  PVector pos;
  float siz = 50;
  PImage image;

  boolean health = false;
  boolean doubleB = false;
  boolean tripleB = false;
  boolean laser = false;
  boolean shield = false;

  public Item(PVector _pos, float _siz) {
    pos = _pos;
    // image = image;
    siz = _siz;
  }

  public Item(PVector _pos, float _siz, PImage _image) {
    pos = _pos;
    image = _image;
    siz = _siz;
  }

  public Item(PImage _image) {
    pos = new PVector(random(-600, 1500), random(-450, 1150));
    image = _image;
    siz = 40;
  }
  void newPos () {
    pos = new PVector(random(-600, 1500), random(-450, 1150));
  }

  void update() {
    fill(255);
    stroke(255);
    strokeWeight(2);
    image(image, pos.x, pos.y, siz, siz);
    //ellipse(pos.x, pos.y, siz, siz);
  }
}
