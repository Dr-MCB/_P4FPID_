void Interface_2() {
  fill(#FFFFFF);
  strokeWeight(2);
  rect(650, 400, 650, 370);

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  textFont(font2);
  textSize(22);
  noFill();
  stroke(0);
  strokeWeight(1);
  String[] gainsNames = {"Setpoint", "    Ke", "    Kde", "    K1", "    K2", "    K3", "    Step"};
  float[] gainsList = {SetPoint, Ke, Kde, Ky1, Ky2, Ky3, step};
  for (int i=0; i<7; i++) {
    strokeWeight(1.5);
    noFill();
    if (i == 0) {
      rect(Gain_minus_b[i].x+20, Gain_minus_b[i].y, 45, 30, 0, 10, 0, 0);
      rect(Gain_plus_b[i].x-110, Gain_minus_b[i].y, 110, 30, 10, 0, 0, 0);
    } else if (i == 6) {
      rect(Gain_minus_b[i].x+20, Gain_minus_b[i].y, 45, 30, 0, 0, 10, 0);
      rect(Gain_plus_b[i].x-110, Gain_minus_b[i].y, 110, 30, 0, 0, 0, 10);
    } else {
      rect(Gain_minus_b[i].x+20, Gain_minus_b[i].y, 45, 30);
      rect(Gain_plus_b[i].x-110, Gain_minus_b[i].y, 110, 30);
      line(Gain_plus_b[i].x-105, Gain_minus_b[i].y + 15, Gain_plus_b[i].x-57, Gain_minus_b[i].y + 15);
      fill(255);
      triangle(Gain_plus_b[i].x-95, Gain_minus_b[i].y + 3, Gain_plus_b[i].x-95, Gain_minus_b[i].y + 27,
        Gain_plus_b[i].x-70, Gain_minus_b[i].y + 15);
      fill(0);
      ellipse(Gain_plus_b[i].x-65, Gain_minus_b[i].y + 15, 5, 5);
    }
    if (i > 0 && i <6 && opt_var[1].activated && GainOpt_b[i-1].activated)
      fill(#9FFAE8);
    else if (i > 0 && i <6 && GainAdjust_b[i-1].activated)
      fill(#70B8B9, 100);
    else
      fill(255);
    rect(Gain_plus_b[i].x, Gain_plus_b[i].y, 140, 30);
    fill(0);
    textCaseVar(3, i+40, gainsList[i], 835, Gain_plus_b[i].y +22);
    if (i != 0 && i != 6)
      text(gainsNames[i], Gain_plus_b[i].x- 75, Gain_plus_b[i].y+22);
    else
      text(gainsNames[i], Gain_plus_b[i].x- 90, Gain_plus_b[i].y+22);
    if (i < 6) {
      Gain_plus_b[i].display();
      Gain_minus_b[i].display();
      strokeWeight(2);
      line(Gain_plus_b[i].x +5, Gain_plus_b[i].y +15, Gain_plus_b[i].x + 15, Gain_plus_b[i].y + 15);
      line(Gain_minus_b[i].x +5, Gain_minus_b[i].y +15, Gain_minus_b[i].x + 15, Gain_minus_b[i].y + 15);
      line(Gain_minus_b[i].x +10, Gain_minus_b[i].y +10, Gain_minus_b[i].x + 10, Gain_minus_b[i].y + 20);
    }
    if (i < 5) {
      GainAdjust_b[i].display();
      GainOpt_b[i].display();
    }
  }
  fill(200);
  rect(660, 560-min(BD_Index, 1)*30, 295, 30);
  fill(0);
  String[] controllerType = {" Fuzzy PID Controller", " Fuzzy PD + I Controller", " Opened-Loop ", " Closed-Loop "};
  text(controllerType[BD_Index], 808-textWidth(controllerType[BD_Index])/2, 580-min(BD_Index, 1)*30);
  fill(0);
  text("GA", Gain_minus_b[0].x+15 + textWidth("GA")/2, Gain_minus_b[0].y + 22);
  if (opt_start_b[0].activated)
    text("On", Gain_minus_b[0].x+15 + textWidth("On")/2, Gain_minus_b[5].y + 52);
  else
    text("Off", Gain_minus_b[0].x+15 + textWidth("Off")/2, Gain_minus_b[5].y + 52);


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  for (int i = 0; i < 3; i++) {
    dataSave_b[i].display();
    dataRecord_b[i].display();
  }
  strokeWeight(1);
  stroke(0);
  image(save, dataSave_b[0].x, dataSave_b[0].y, 30, 30);
  image(save, dataSave_b[1].x, dataSave_b[1].y, 30, 30);
  image(save, dataSave_b[1].x + 10, dataSave_b[1].y + 10, 20, 20);
  image(folder2, dataSave_b[2].x, dataSave_b[2].y + 4, 30, 26);
  image(save, dataRecord_b[1].x, dataRecord_b[1].y, 30, 30);

  fill(0);
  ellipse(dataRecord_b[0].x + 15, dataRecord_b[0].y +15, 20, 20);
  fill(255, 0, 0);
  ellipse(dataRecord_b[0].x + 15, dataRecord_b[0].y +15, 15, 15);

  image(folder, dataRecord_b[2].x, dataRecord_b[2].y, 30, 30);
  fill(0);
  textSize(19);
  text("Save ", dataSave_b[0].x + 32, dataSave_b[0].y + 22 );
  text("Save Default", dataSave_b[1].x + 32, dataSave_b[1].y + 22 );
  text("Import /Data", dataSave_b[2].x + 32, dataSave_b[2].y + 22 );
  if (dataRecord_b[0].activated)
    text("Recording ", dataRecord_b[0].x + 32, dataRecord_b[0].y + 22 );
  else
    text("Record ", dataRecord_b[0].x + 32, dataRecord_b[0].y + 22 );
  text("Save Record", dataRecord_b[1].x + 32, dataRecord_b[1].y + 22 );
  text("Improt Default", dataRecord_b[2].x + 32, dataRecord_b[2].y + 22 );

  fill(255);
  rect(dataSave_b[1].x, dataSave_b[1].y + 32, dataSave_b[1].sizex*2+15, 26, 5);

  fill(0);
  textSize(20);
  textBox(3, fileName, dataSave_b[2].x + 150, dataSave_b[1].y + 50);


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  strokeWeight(2);
  stroke(0);
  fill(#F0FAA4, 30);
  rect(965, 410, 325, 110, 7);
  rect(965, 630, 90, 30);
  fill(255);
  rect(1055, 630, 235, 30);
  rect(965, 660, 325, 90);
  fill(0); //
  tfUpload_b.display();
  tfUpload_b.ArrowUp();
  BABS.display();
  BABS.setText("B&B", 0.7);
  if (BABS.activated)
    BABModelParmetersSdisp.display();
  fill(0);
  textFont(font3);
  textSize(18);

  if (BABS.activated) {
    if (BABModelParmetersSdisp.activated) {
      textSize(21);
      text("Meff x''(t) + Perlin(t) = mgL1/L2 θ(t)",
        1125-textWidth("Meff x''(t) + Perlin(t) = mgL1/L2 θ(t)")/2, 465);
      text("θ''(t) + T θ'(t) = KVs Vin(t)", 1125-textWidth("θ''(t) + T θ'(t) = KVs/5 Vin(t)")/2, 512);
    } else {
      textSize(18);
      float fr = PerlineX.get(PerlineX.size()-1);
      float Meff = (!hollowBall.activated) ? 7/5*ballMass*0.001 : 5/3*ballMass*0.001;
      if (!noisyWinds.activated)
        fr = constB;
      String str = nf(Meff, 0, 5) + "x''(t) + " + nf(fr, 0, 5) + " = " + nf(ballMass*0.01*l1/l2, 0, 5) +" θ(t)";
      text(str, 1125-textWidth(str)/2, 465);
      str = "θ''(t) + " + nf(constT, 0, 2)+ " θ'(t)" + " = "+
        nf(constK*suplyVoltage/5, 0, 2) + " Vin(t)";
      text(str, 1125-textWidth(str)/2, 512);
    }
  } else {
    textFont(font2);
    textSize(20);
    String s="";
    int ypo=470;
    for (int j=0; j<2; j++) {
      if (name_index!=10+j) {
        s="[";
        int b;
        if (j==0)
          b=nomenator;
        else if (j==1)
          b=denomenator;
        else if (j == 2)
          b=nomenator-1 ;
        else
          b=denomenator -1;
        for (int i=0; i<=b; i++) {
          if (i<b)
            s+=String.valueOf(transfer_fct[i][j])+";";
          else
            s+=String.valueOf(transfer_fct[i][j]);
        }
        s+="]";
        text(s, 1125-textWidth(s)/2, ypo);
      } else {
        text_Disply(1125, ypo);
      }
      ypo+=30;
    }
  }
  textFont(font2);
  textSize(20);
  fill(0, 0, 255);
  if (BABS.activated) {
    text("Ball & Beam Model:", 1125 - textWidth("Ball & Beam Model:")/2, 440);
    text("Servo System Model:", 1125 - textWidth("Servo System Model:")/2, 485);
  } else {
    if (discreteSys_b.activated)
      text("System Transfer Function H(z) = ", 1125 - textWidth("System Transfer Function H(z) = ")/2, 450);
    else
      text("System Transfer Function H(s) = ", 1125 - textWidth("System Transfer Function H(s) = ")/2, 450);
    line(970, 480, 1280, 480);
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////// //////////////////////////////////////////////////////////////////


  fill(0);
  text("Serial:", 980, 651);
  int txtSize = 20;
  while (textWidth(PanelSent) > 190) {
    txtSize --;
    textSize(txtSize);
  }
  textBox(34, PanelSent, 1160, 651);
  sentToSerial_b.display();
  sentToSerial_b.setRight(1, 0);
  textSize(15);
  VscrBar.totalCount = SerialConversation.size();
  VscrBar.display();
  int startIdx = VscrBar.getOffset();
  int visibleLines = VscrBar.visibleCount;
  fill(0);
  if (SerialTimeLug >= Ts*1000 +5) {
    fill(255, 0, 0);
    text("             Control time saturation Error", 970, 680);
    text("Sampling-Time = " + Ts*1000 + "|| Calculus-Time = " + SerialTimeLug, 970, 700);
    text("CalculusTime >= Ts ", 970, 720);
    text(" Enlarge sampling time", 970, 740);
  } else
    for (int i = 0; i < min(visibleLines, VscrBar.totalCount); i++) {
      int dataIndex = startIdx + i;
      if (dataIndex < SerialConversation.size()) {
        text(SerialConversation.get(dataIndex), 970, 670+15*i);
      }
    }
  textSize(20);
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////// //////////////////////////////////////////////////////////////////


  fill(255);
  if (ComState) {
    stroke(#04831C);
    strokeWeight(3);
  } else {
    stroke(0);
    strokeWeight(1);
  }
  rect(965, 525, 325, 60, 7);
  stroke(0);
  rect(965, 590, 325, 30, 7);
  fill(0);
  String communication = "Real-Time Control:" + (ComState ? "  ON": "  OFF");
  text(communication, 1125 - textWidth(communication)/2, 545);
  text("Baud Rate: " + nf(BaudRate, 0, 0) + " bit/s | COM: " + nf(port_, 0, 0),
    1125-textWidth("Baud-Rate: " + nf(BaudRate, 0, 0) + " bit/s | COM: " + nf(port_, 0, 0))/2, 575);
  image(MaxSaturationIcon, 965, 590, 35, 30);
  maxSats.display();
  textSize(22);
  textCaseVar(2, 50 + maxSats.selectedItemIndex, MaxSaturations[maxSats.selectedItemIndex], 1205, 615);


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  mouse_shapeManagement();
}
