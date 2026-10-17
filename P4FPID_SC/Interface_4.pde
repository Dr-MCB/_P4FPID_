void Interface_4() {
  fill(#FFFFFF);
  strokeWeight(2);
  rect(650, 400, 650, 370);
  animateBallAndBeam(750);
  AdaptiveC_b.display();
  //resetGains.display();
  textSize(18);
  if (AdaptiveC_b.activated)
    AdaptiveC_b.setText("Adaptive Control ON", 0.7);
  else
    AdaptiveC_b.setText("Adaptive Control OFF", 0.7);
  //resetGains.setText("Rest Gains", 0.7);
  textSize(20);

  if (BD_Index == 0)
    text("Fuzzy PID Controller", 660, 427);
  else if (BD_Index == 1)
    text("Fuzzy PD+I Controller", 660, 427);
  else if (BD_Index == 3)
    text("Closed Loop Control", 660, 427);
  else
    text("Opened Loop Control", 660, 427);
  noFill();
  rect(655, 405, 200, 30, 5);
  //text("l1 = " + l1, 660, 500);
  //text("l2 = " + l2, 850, 500);
  //text("l1/l2 = " + l1/l2, 950, 500);

  //if (AdaptiveC_b.activated && (l2Drag || l1Drag))
  //  fill(#21E5EA, 100);
  //else
  //  noFill();
  //for (int i =0; i < 4; i ++) {
  //  rect(660 + i*150, 440, 150, 30, 5);
  //}
  //fill(0);
  //String[] GainsK = {"Ke = " + nf(Ke, 0, 0), "Kde = " +nf(Kde, 0, 0),
  //  "Ky1 = " +nf(Ky1, 0, 0), "Ky2 = " +nf(Ky2, 0, 0)};
  //for (int i =0; i < 4; i ++) {
  //  text(GainsK[i], 665 + i*150, 460);
  //}

  //textSize(17);
  //text("L1/L2 = " + l1/l2, 10, 400);
  //text("Ke = " + Ke, 10, 420);
  //text("Total T = " + constT*l1*0.01*Jes, 350, 420);
  //text("Kde = " + Kde, 10, 440);
  //text("Ky1 = " + Ky1, 10, 460);
  //text("Ky2 = " + Ky2, 260, 460);
}
