///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class MVBox {
  float a;
  float b;
  float c;
  float d;
  float centerx;
  float centery;
  int index;
  MVBox(int index_, float a_, float b_, float c_, float d_, float centerx_, float centery_) {
    index = index_;
    a = a_;
    b = b_;
    c = c_;
    d = d_;
    centerx = centerx_;
    centery = centery_;
  }
  boolean InsideBoxe(float X, float Y) {
    if (X > a && X < c && Y > b && Y < d)
      return true;
    return false;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void ShowMVRanges(int I) {
  color[] Cols = {#38FF03, #FF311A, color(255, 200, 0)};
  float X1 = MVB[I].centerx+3*Range[I];
  float X2 = MVB[I].centerx-3*Range[I];
  float Y = MVB[I].b;
  strokeWeight(2);
  stroke(0);
  //if (range_b[I].activated) {
  //  fill(200, 200);
  //   fill(Cols[I]);
  //  rect(X1-5, Y, 10, 10);
  //  rect(X2-5, Y, 10, 10);
  //}
  //line(X1, Y, X1, Y + 140);
  //line(X2, Y, X2, Y + 140);
  // range_b[I].display();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




void drawMFsConfig() {
  textFont(font2, 22);
  fill(0);
  strokeWeight(1);
  for (int j=0; j<3; j++) {
    int px=700, py=190;
    if (j==0)
      px = 50;
    if (j>1)
      py = 390;
    if (range_b[j].activated) {
      text("Range = " + nf(Range[j], 0, 2) + " %", px-35, py);
    } else {
      if ((name_index!=2 || j!=iinumber)) {
        if (j==iinumber && MF[bs[j]][j].state) {
          noFill();
          rect(px-40, py-22, 400, 30);
        }
        if (MF[bs[j]][j].type == 1)
          text(" [ "+nf(MF[bs[j]][j].a1, 0, 1)+" ; "
            + nf(MF[bs[j]][j].a2, 2, 2)
            + " ; " + nf(MF[bs[j]][j].a4, 0, 1)
            + " ; " + nf(MF[bs[j]][j].normality, 0, 1) + " ] ", px-35, py);

        else if (MF[bs[j]][j].type == 2)
          text(" [ "+nf(MF[bs[j]][j].a1, 0, 1)+" ; "
            + nf(MF[bs[j]][j].a2, 2, 2)
            + " ; " + nf(MF[bs[j]][j].a4, 0, 1)
            + " ; " + nf(MF[bs[j]][j].Gauss, 0, 1)
            + " ; " + nf(MF[bs[j]][j].normality, 0, 1) + " ] ", px-35, py);
        else
          text("["+nf(MF[bs[j]][j].a1, 0, 1)
            +" ; "+nf(MF[bs[j]][j].a2, 0, 1) + " ; "
            +nf(MF[bs[j]][j].a3, 0, 1) + " ; "
            +nf(MF[bs[j]][j].a4, 0, 1)
            +" ; "+nf(MF[bs[j]][j].normality, 0, 1)+ " ] ", px-35, py);
      } else if (name_index==2 && j==iinumber) {
        text(String.copyValueOf(typing, 0, typing_counter)+Cursor, px+135-textWidth(String.copyValueOf(typing, 0, typing_counter))/2, py);
        noFill();
        rect(px-35, py-22, 410, 30);
      }
    }
  }
  if (Rules_Edit_b.activated && rulesbuttons_b[4].activated)
    DrawRulesLine();
  for (int i =0; i < 3; i ++)
    ShowMVRanges(i);
}
