class Items {
  int type;
  PVector pos;
  PVector siz = new PVector();//using this for the height and width
  PImage[] images;
  long lastTime;
  boolean checkedTime = false;

  public Items(PVector _pos, PImage[] _images, PVector _siz) {
    pos = _pos;
    images = _images;
    siz = _siz;
  }

  void update() {
    if (!checkedTime) {
      lastTime = millis();
    }
  }
}
