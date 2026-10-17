class Button {
  int x;
  int y;
  int sizex;
  int sizey;
  float alpha;
  boolean extended;
  boolean activated;
  float strokeweight;
  color baseGray;
  color overGray;
  color pressGray;
  color stroke;
  boolean over = false;
  boolean pressed = false;

  Button(int xp, int yp, int s, int r, color b, color o, color p, float stw, float alp, boolean e) {
    x = xp;
    y = yp;
    alpha=alp;
    sizex=s;
    sizey=r;
    stroke= color(0);
    strokeweight=stw;
    baseGray = b;
    overGray = o;
    pressGray = p;
    activated=false;
    extended =e;
  }

  void display() {
    if ((rmouseX >= x) && (rmouseX <= x+sizex) &&
      (rmouseY >= y) && (rmouseY <= y+sizey)) {
      over = true;
    } else {
      over = false;
    }
    if (pressed == true || activated) {
      fill(pressGray);
    } else if (over == true) {
      fill(overGray);
    } else {
      fill(baseGray);
    }
    int ex =0;
    if (over && extended) {
      strokeWeight(strokeweight + 1);
      ex = 2;
    } else
      strokeWeight(strokeweight);
    stroke(stroke);
    rect(x - ex, y - 0.25, sizex + 2 * ex, sizey + 0.5, alpha);
    strokeWeight(strokeweight);
  }

  boolean press() {
    if (over == true) {
      pressed = true;
      return true;
    } else {
      return false;
    }
  }
  void release() {
    pressed = false;
  }
  void setText(String txt, float a) {
    fill(0);
    text(txt, x + (sizex - textWidth(txt))/2, y + sizey * a);
  }


  void setSideText(String txt, float a, float b) {
    fill(0);
    text(txt, x + sizex + b, y + sizey * a);
  }


  void ArrowUp() {
    fill(0);
    strokeWeight(3);
    line(x + sizex *0.5, y + sizey *0.2, x + sizex *0.5, y + sizey *0.8);
    triangle(x + sizex *0.2, y + sizey *0.5,
      x + sizex * 0.8, y + sizey*0.5,
      x + sizex * 0.5, y + sizey*0.2);
    strokeWeight(1);
  }

  void ArrowDown() {
    fill(0);
    strokeWeight(3);
    line(x + sizex *0.5, y + sizey *0.2, x + sizex *0.5, y + sizey *0.8);
    triangle(x + sizex *0.2, y + sizey *0.5,
      x + sizex * 0.8, y + sizey*0.5,
      x + sizex * 0.5, y + sizey*0.8);
    strokeWeight(1);
  }


  void setplus(float r) {
    stroke(0);
    line(x + r, y + sizey /2, x + sizex -r, y + sizey /2);
    line(x + sizex/2, y + r, x + sizex/2, y + sizey -r);
  }

  void setminus(float r) {
    stroke(0);
    line(x + r, y + sizey /2, x + sizex -r, y + sizey /2);
  }

  void setUp(float r, color Col) {
    fill(Col);
    triangle(x + r, y + sizey - r, x+ sizex - r, y + sizey - r, x + sizex/2, y +r);
  }

  void setDown(float r, color Col) {
    fill(Col);
    triangle(x + r, y + r, x + sizex - r, y + r, x + sizex/2, y + sizey - r);
  }

  void setRight(float r, color Col) {
    fill(Col);
    triangle(x + r, y + r, x + r, y + sizey - r, x + sizex - r, y + sizey/2);
  }

  void setLeft(float r, color Col) {
    fill(Col);
    triangle(x + sizex - r, y + r, x + sizex - r, y + sizey - r, x + r, y + sizey/2);
  }




  void Play(boolean FILL) {
    if (FILL)
      fill(0);
    if (!activated)
      triangle(x + sizex *0.3, y + sizey *0.2,
        x + sizex * 0.3, y + sizey*0.8,
        x + sizex * 0.7, y + sizey*0.5);
    else {
      rect(x + sizex *0.2, y + sizey *0.2, sizex*0.25, sizey*0.6);
      rect(x + sizex *0.55, y + sizey *0.2, sizex*0.25, sizey*0.6);
    }
  }

  void StopPlay(boolean FILL) {
    if (FILL)
      fill(0);
    rect(x + sizex *0.2, y + sizey *0.2, sizex*0.6, sizey*0.6, alpha*0.6);
  }

  void speedUp(boolean FILL) {
    if (FILL)
      fill(0);
    triangle(x + sizex *0.2, y + sizey *0.2,
      x + sizex * 0.2, y + sizey*0.8,
      x + sizex * 0.6, y + sizey*0.5);
    triangle(x + sizex *0.4, y + sizey *0.2,
      x + sizex * 0.4, y + sizey*0.8,
      x + sizex * 0.8, y + sizey*0.5);
  }

  void speedDown(boolean FILL) {
    if (FILL)
      fill(0);
    triangle(x + sizex *0.8, y + sizey *0.2,
      x + sizex * 0.8, y + sizey*0.8,
      x + sizex * 0.4, y + sizey*0.5);

    triangle(x + sizex *0.6, y + sizey *0.2,
      x + sizex * 0.6, y + sizey*0.8,
      x + sizex * 0.2, y + sizey*0.5);
  }
}
