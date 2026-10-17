void initializeButtons() {
  int sx = 2;
  sys2_b =  new Button__(sx, 6, 170, 30, color(200, 100), color(#FCDF94), color(200));
  sx += sys2_b.sizex + 2;
  er2_b =  new Button__(sx, 6, 100, 30, color(200, 100), color(#FCDF94), color(200));
  sx += er2_b.sizex + 2;
  der2_b =   new Button__(sx, 6, 100, 30, color(200, 100), color(#FCDF94), color(200));
  sx += der2_b.sizex + 2;
  ctr2_b =  new Button__(sx, 6, 100, 30, color(200, 100), color(#FCDF94), color(200));
  sx += ctr2_b.sizex + 2;
  Y1_b =  new Button__(sx, 6, 60, 30, color(200, 100), color(#FCDF94), color(200));
  sx +=60;
  Y2_b =  new Button__(sx, 6, 60, 30, color(200, 100), color(#FCDF94), color(200));
  sx +=60;
  Y3_b =  new Button__(sx, 6, 60, 30, color(200, 100), color(#FCDF94), color(200));
  sx +=60;

  backward_b = new Button__(sx, 6, 60, 30, 200, color(#FCDF94), color(0, 255, 0));
  sx += backward_b.sizex + 2;
  speedDown_b = new Button__(sx, 6, 60, 30, 200, color(#FCDF94), color(0, 255, 0));
  sx += speedDown_b.sizex + 2;
  play_b = new Button__(sx, 1, 80, 40, 200, color(#FCDF94), color(0, 255, 0));
  sx += play_b.sizex + 2;
  speedUp_b = new Button__(sx, 6, 60, 30, 200, color(#FCDF94), color(0, 255, 0));
  sx += speedUp_b.sizex + 2;
  forward_b = new Button__(sx, 6, 60, 30, 200, color(#FCDF94), color(0, 255, 0));
  sx += forward_b.sizex + 2;
  grid2_b = new Button__(sx, 6, 50, 30, 200, color(#FCDF94), color(0, 255, 0));
  importFrom = new Button__(1043, 6, 130, 30, 200, color(#FCDF94), color(0, 255, 0));
  sx += grid2_b.sizex + 135;
  adjust_b = new Button__(sx, 3, 30, 46, 200, color(#FCDF94), color(0, 255, 0));
  sx += adjust_b.sizex + 2;
  play_b.alpha = 15;
  sys2_b.activated = true;
  forward_b.activated = true;
}
