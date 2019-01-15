class Item {
  int type;
  PVector pos;
  float siz = 50;
  PImage image;
  long lastTime;
  boolean checkedTime = false;
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
    pos = new PVector(random(-1000, 1500), random(-1000, 1500));
    image = _image;
    siz = 40;
  }

  void newPos () {
    pos = new PVector(random(-900, 1200), random(-900, 1200));
  }
  
  void update() {
    fill(255);
    stroke(255);
    strokeWeight(2);
    image(image, pos.x, pos.y,siz,siz);
    //ellipse(pos.x, pos.y, siz, siz);
  }
}
