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
  ProgressBar(float X, float Y, float W, float H, color COl, float Ran, float MAXv, float CURv) {
    x = X;
    y = Y;
    w = W;
    h = H;
    col = color(COl, 100);
    B_col =  color(COl);
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
      && rmouseY >= y && rmouseY <= y + h) {
      B_x = Bound__(w - B_w/2, B_w/2, rmouseX - x);
    }
    return (B_x - B_w/2)/(w - B_w);
  }

  void Display() {
    if (stateOn) {
      fill(col);
      stroke(stro);
      rect(x, y, w, h, alpha);
      fill(B_col);
      rect(x + B_x - B_w/2, y, B_w, h, alpha);
    }
  }
}
