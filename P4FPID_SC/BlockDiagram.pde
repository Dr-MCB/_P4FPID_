void drawBlockDiagram() {
  if (dispIndex ==1) {
    if (BD_Index == 0)
      if (!discreteSys_b.activated)
        controlBlock = PIDblock_C;
      else
        controlBlock = PIDblock_D;
    else if (BD_Index == 1)
      if (!discreteSys_b.activated)
        controlBlock = PDPlusIblock_C;
      else
        controlBlock = PDPlusIblock_D;
    else if (BD_Index == 2)
      if (!discreteSys_b.activated)
        controlBlock = OpenedLoopblock_S;
      else
        controlBlock = OpenedLoopblock_Z;
    else
      if (!discreteSys_b.activated)
        controlBlock = ClosedLoopblock_S;
      else
        controlBlock = ClosedLoopblock_Z;
    fill(255);
    rect(0, 0, 1300, 430);
    rect(0, 400, 650, 345);
    rect(0, 400, 415, 345);
    fill(#F0FAA4);
    rect(0, 400, 650, 30);
    fill(0);

    String[] controllerType = {" Fuzzy PID Controller", " Fuzzy PD + I Controller", " Opened-Loop ", " Closed-Loop "};
    fill(255, 0, 0);
    text(controllerType[BD_Index], 250-textWidth(controllerType[BD_Index])/2, 422);
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    pushMatrix();
    translate(660, 200);
    if (BD_Index > 1)
      scale(1);
    else
      scale(0.95);
    image(controlBlock, -min(controlBlock.width/2, 650), -min(controlBlock.height/2, 200),
      min(controlBlock.width, 1300), min(controlBlock.height, 400));
    noStroke();
    noFill();
    rect(-min(controlBlock.width/2, 650), -min(controlBlock.height/2, 200),
      min(controlBlock.width, 1300), min(controlBlock.height, 400));
    popMatrix();
    image(P4FPIDblock, 0, 430, 410, 308);
    B_DLeft_b.display();
    B_DRight_b.display();
    discreteSys_b.display();
    if (!discreteSys_b.activated)
      discreteSys_b.setText("Continuous", 0.7);
    else
      discreteSys_b.setText("Descrete", 0.7);
    text("Time Domain", discreteSys_b.x - textWidth("Time Domain  "), 422);
    line(415, 560, 650, 560);
    textSize(20);
    text("              Fixed 1001", 425, 580);
    text("        Discretization Point", 425, 600);
    fill(255, 0, 0);
    text("Moving Step", 425, 620);
    textSize(17);
    fill(0);
    text("UoD Vector [0 1000]", 425, 640);
    text("UoD Scalar [-100 100] Image", 425, 700);

    text("IIR-LPF Smoothing Constant (Z)", 425, 452);
    if (!discreteSys_b.activated)
      text("IIR-LPF Smoothing Constant (S)", 425, 515);
    textSize(20);
    B_DRight_b.setRight(5, 0);
    B_DLeft_b.setLeft(5, 0);
    fill(#D9F033, 100);
    rect(480, 465, 150, 30, 5);
    if (!discreteSys_b.activated)
      rect(480, 525, 150, 30, 5);
    fill(#FA9D56);
    rect(490, 655, 110, 30, 5);
    fill(255);
    rect(490, 710, 110, 30, 5);
    fill(0);
    text("  A = ", 480, 487);
    textCaseVar(6, 35, filterGain, 580, 487);
    if (!discreteSys_b.activated) {
      text(" Tau= ", 480, 547);
      textCaseVar(6, 36, tau, 580, 547);
    }
    textCaseVar(3, 37, movingStep, 545, 675);
    fill(0);
    text(nf(movingStep*0.2, 0, 0), 530, 730);
  }

  dispMode.display();
  Signalsdropdown.display();
  ODedropdown.display();
  dispMode.display();
}
