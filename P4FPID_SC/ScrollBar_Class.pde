class ProgressBar {
  float x;
  float y;
  float w;
  float h;
  float B_x;
  float B_w;
  float range;
  float col;
  float B_col;
  float stro;
  float alpha;
  float currentValue;
  boolean stateOn;
  boolean ProgDragged;
  ProgressBar(float X, float Y, float W, float H, color COl, float Ran, float MAXv, float CURv) {
    x = X;
    y = Y;
    w = W;
    h = H;
    col = color(COl);
    B_col =  color(COl, 100);
    stro = 0;
    alpha = h * 0.2;
    range = Ran;
    currentValue = CURv;
    UpdatePrgB(CURv, MAXv);
  }

  void UpdatePrgB(float currentValue, float maximumValue) {
    if (maximumValue >= range ) {
      stateOn = true;
      B_w = w * range/maximumValue;
      B_x = map(currentValue/maximumValue, 0, 1, B_w/2, w-B_w/2);
    } else
      stateOn = false;
  }

  float DragProgB() {
    if (rmouseX >= x + B_x - B_w/2 && rmouseX <= x + B_x + B_w/2
      && rmouseY >= y && rmouseY <= y + h && !ProgDragged)
      ProgDragged = true;
    if (ProgDragged)
      B_x = Bound__(w - B_w/2, B_w/2, rmouseX - x);

    return (B_x - B_w/2)/(w - B_w);
  }

  void Display() {
    if (stateOn) {
      fill(255);
      stroke(stro);
      rect(x, y, w, h, alpha);
      fill(#AF5151);
      rect(x + B_x - B_w/2, y, B_w, h, alpha);
    }
  }
}


class ScrollBar {
  float x;
  float y;
  float w;
  color col;
  float stro;
  float stroW;
  float textS;
  float currentValue;
  float minValue;
  float maxValue;
  float px;
  boolean Pdragged;
  ScrollBar(float X, float Y, float W, color COl, float MINv, float MAXv, float CURv) {
    x = X;
    y = Y;
    w = W;
    col = COl;
    stro = 0;
    currentValue = CURv;
    minValue =MINv;
    maxValue = MAXv;
    stroW = 3;
    textS = 15;
    px = map(currentValue, minValue, maxValue, 0, w);
  }
  void display() {
    strokeWeight(stroW);
    stroke(0);
    line(x, y, x + w, y);
    strokeWeight(1);
    for (float i = x; i <= x + w; i +=w/10)
      line( i, y + 5, i, y -5);
    if (Pdragged)
      fill(col);
    else
      fill(col, 200);
    triangle(x + px, y, x + px - 10, y - 15, x + px + 10, y -15);
    fill(0);
    textSize(textS);
    text(nf(minValue, 0, 0), x - textWidth(nf(minValue, 0, 0))/2, y + textS +2);
    text(nf(maxValue, 0, 0), x + w - textWidth(nf(maxValue, 0, 0))/2, y + textS +2 );
  }
  float Drag() {
    if (!Pdragged && rmouseX >= x + px - 10 && rmouseX <=  x + px +10 && rmouseY >= y - 10  && rmouseY <= y + 10 )
      Pdragged = true;
    if (Pdragged)
      px  =  Bound__(w, 0, rmouseX - x );
    currentValue = map(px, 0, w, minValue, maxValue);
    return currentValue;
  }
}

class VerticalScrollbar {
  float x, y, w, h;
  float barY, barH;
  int totalCount, visibleCount;
  boolean dragging = false;
  float dragOffset;

  VerticalScrollbar(float x, float y, float w, float h, int totalCount, int visibleCount) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.totalCount = max(totalCount, 1);
    this.visibleCount = max(visibleCount, 1);

    float ratio = (float)visibleCount / this.totalCount;
    barH = constrain(ratio * h, 20, h);
    barY = y;
  }

  void reset() {
    barH = constrain(0, 20, h);
    barY = y;
  }

  void display() {
    // Track
    noStroke();
    fill(230);
    rect(x, y, w, h, 5);

    // Scrollbar handle
    fill(100);
    rect(x, barY, w, barH, 5);
  }

  void press(float mx, float my) {
    if (mx > x && mx < x + w && my > barY && my < barY + barH) {
      dragging = true;
      dragOffset = my - barY;
    }
  }

  void drag(float my) {
    if (dragging) {
      float scrollable = h - barH;
      barY = constrain(my - dragOffset, y, y + scrollable);
    }
  }

  void release() {
    dragging = false;
  }

  int getOffset() {
    float scrollable = h - barH;
    float norm = (barY - y) / scrollable;
    return floor(norm * (totalCount - visibleCount));
  }
}
