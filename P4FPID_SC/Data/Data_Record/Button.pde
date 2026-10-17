class Button__ {
  int x;
  int y;
  int sizex;
  int sizey;
  int alpha;
  boolean extended;
  boolean activated;
  float strokeweight;
  color baseGray;
  color overGray;
  color pressGray;
  color stroke;
  boolean over = false;
  boolean pressed = false;

  Button__(int xp, int yp, int s, int r, color b, color o, color p) {
    x = xp;
    y = yp;
    alpha=0;
    sizex=s;
    sizey=r;
    stroke= color(0);
    strokeweight=1.5;
    baseGray = b;
    overGray = o;
    pressGray = p;
    activated=false;
    extended =true;
    alpha = int(r * 0.2);
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
}

void drawMainTriangle(Button__ B) {
  fill(0);
  if (!B.activated)
    triangle(B.x + B.sizex *0.2, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.2, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.5);
  else {
    rect(B.x + B.sizex *0.2, B.y + B.sizey *0.2, B.sizex*0.25, B.sizey*0.6);
    rect(B.x + B.sizex *0.55, B.y + B.sizey *0.2, B.sizex*0.25, B.sizey*0.6);
  }
}
void draw1Triangle(Button__ B, boolean side) {
  if (side)
    triangle(B.x + B.sizex *0.2, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.2, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.5);
  else
    triangle(B.x + B.sizex *0.8, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.2, B.y + B.sizey*0.5);
}
void draw2Triangles(Button__ B, boolean side) {
  if (side) {
    triangle(B.x + B.sizex *0.2, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.2, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.6, B.y + B.sizey*0.5);
    triangle(B.x + B.sizex *0.4, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.4, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.5);
  } else {
    triangle(B.x + B.sizex *0.8, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.4, B.y + B.sizey*0.5);

    triangle(B.x + B.sizex *0.6, B.y + B.sizey *0.2,
      B.x + B.sizex * 0.6, B.y + B.sizey*0.8,
      B.x + B.sizex * 0.2, B.y + B.sizey*0.5);
  }
}
void draw1TriangleUp(Button__ B, boolean side) {
  strokeWeight(3);
  line(B.x + B.sizex *0.5, B.y + B.sizey *0.2, B.x + B.sizex *0.5, B.y + B.sizey *0.8);
  if (side)
    triangle(B.x + B.sizex *0.2, B.y + B.sizey *0.5,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.5,
      B.x + B.sizex * 0.5, B.y + B.sizey*0.2);
  else
    triangle(B.x + B.sizex *0.2, B.y + B.sizey *0.5,
      B.x + B.sizex * 0.8, B.y + B.sizey*0.5,
      B.x + B.sizex * 0.5, B.y + B.sizey*0.8);
  strokeWeight(1);
}
void drawAdjustButtom(Button__ B) {
  strokeWeight(1.5);
  line(B.x, B.y, B.x + B.sizex, B.y + B.sizey);
  line(B.x, B.y + B.sizey, B.x + B.sizex, B.y);
  fill(0);
  rect(B.x + B.sizex *0.33, B.y + B.sizey *0.33, B.sizex *0.33, B.sizey *0.33);
  strokeWeight(1);
}
void  text2InButton(Button__ B, String txt, float x) {
  text(txt, B.x + (B.sizex - textWidth(txt))/2, B.y + B.sizey * x);
}
