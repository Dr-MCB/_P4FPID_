void drawGraph() {
  if ((!ruleEditing & !surface_3D) || face!=1) {
    if (surface_3D) {
      fill(#F1FA90, 30);
      rect(0, 200, 650, 570);
    }
    stroke(0);
    strokeWeight(2);
    int centerY = 720;
    int centerX = 40;
    line(centerX, 220, centerX, 770);
    float xLine = Imax / Ts;
    strokeWeight(1);
    stroke(#21CDFA);
    if (grid_b.activated) {
      for (int i=0; i<=600; i+=2)
        if ((i+dragged_I) % xLine ==0)
          line(centerX+i, 200, centerX+i, 750);
    }
    pushMatrix();
    translate(0, Y_Translation);
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    float zoomStep = 200;
    if (Vmax <= 1)
      zoomStep = 0.1;
    else if (Vmax <= 10)
      zoomStep = 1;
    else if (Vmax <= 50)
      zoomStep = 5;
    else if (Vmax <= 100)
      zoomStep = 10;
    else if (Vmax <= 150)
      zoomStep = 25;
    else if (Vmax <= 200)
      zoomStep = 50;
    else if (Vmax <= 500)
      zoomStep = 100;
    zoomStep /=2;
    zoomStep = 400 * zoomStep / float(Vmax);

    fill(0);
    textFont(font2, 15);
    

    float Gmax = 1000;
    for (float i=0; i<=Gmax; i+=zoomStep) {
      if (grid_b.activated) {
        stroke(#21CDFA);
        line(centerX, centerY-i, 650, centerY-i);
        line(centerX, centerY+i, 650, centerY+i);
      }
      stroke(0);
      text(nf(i*Vmax/400, 0, 0), 10, centerY-i);
      line(centerX-6, centerY-i, centerX+6, centerY-i);
      text(nf(-i*Vmax/400, 0, 0), 10, centerY+i);
      stroke(0);
      line(centerX-6, centerY+i, centerX+6, centerY+i);
    }


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    fill(0);
    stroke(0);
    strokeWeight(3);
    line(40, 720, 645, 720);
    triangle(630, 710, 630, 730, 645, 720);
    textFont(font2, 15);

    for (int i=0; i<=simulationSteps*Imax &&  (i-dragged_I*Imax) < 650 &&!UART_b.activated && resetDebug; i+=10) {
      if ((i+dragged_I*Imax) % xLine == 0) {
        text(nf(Ts*(i+dragged_I*Imax)/Imax, 1, 0), 30+i, 735);
        strokeWeight(3);
      } else {
        strokeWeight(1);
      }
      line(40+i, 725, 40+i, 715);
    }

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if (surface_3D)
      strokeWeight(2.5);
    else
      strokeWeight(1.5);
    stroke(0);
    
    int endTime = offline_sys.size()-2;
    for (int i= 0; i  <= endTime && centerY- MaxSaturations[2]*400/Vmax < 600; i++)
      if ((i)*Imax % 20 == 0)
        line(centerX+(i + 1)*Imax, centerY- MaxSaturations[2]*400/Vmax, 55+(i)*Imax, centerY- MaxSaturations[2]*400/Vmax);
    if (!UART_b.activated) {
      ArrayList<FloatList> Points = new ArrayList<FloatList>();
      Points.add(offline_SetPoint);
      Points.add(offline_sys);
      Points.add(offline_er); 
      Points.add(offline_der);
      Points.add(offline_ctr);
      Points.add(offline_y1);
      Points.add(offline_y2);
      Points.add(offline_y3);
      Points.add(offline_theta);
      Points.add(offline_dtheta);
      Points.add(offline_ddtheta);
      pushMatrix();
      translate(40, 720);
      strokeWeight(2);
      progBar.UpdatePrgB(dragged_I * Imax, endTime * Imax);
      try {
        for (int i= dragged_I + 1; i  <= endTime && (i - dragged_I + 1)*Imax < 650; i++) {
          for (int j = 0; j< 10; j++) {
            if (Signalsdropdown.selected[j]) {
              if (j == 0)
                strokeWeight(3);
              else
                strokeWeight(2);
              stroke(graphColor[j]);
              if (!discreteSys_b.activated)
                line( (i - dragged_I + 1)*Imax, -(Points.get(j).get(i)*400/Vmax),
                  (i - dragged_I)*Imax, - (Points.get(j).get(i-1)*400/Vmax));
              else {
                line( (i - dragged_I + 1)*Imax, -(Points.get(j).get(i)*400/Vmax),
                  (i - dragged_I+1)*Imax, - (Points.get(j).get(i-1)*400/Vmax));
                line( (i - dragged_I + 1)*Imax, -(Points.get(j).get(i-1)*400/Vmax),
                  (i - dragged_I)*Imax, - (Points.get(j).get(i-1)*400/Vmax));
              }
            }
          }
          strokeWeight(2);
          stroke(graphColor[10]);
          fill(0);
          if (Signalsdropdown.selected[10] && Points.get(0).get(i)-Points.get(0).get(i+1) == 0) {
            line( (i - dragged_I)*Imax, -(Points.get(10).get(i)*400/Vmax),
              (i - dragged_I)*Imax, 0);
            if (abs(Points.get(10).get(i)) >= 9.8)
              ellipse((i - dragged_I)*Imax, -Points.get(10).get(i)*400/Vmax, 10, 10);
          }
        }
      }
      catch (Exception e) {
      }
      popMatrix();
    } else {
      realtimeDraw();
    }
    popMatrix();
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }
}

void DrawGraphSettings() {
  fill(255);
  noStroke();
  rect(650, -1000, 6000, 3000);
  rect(0, -1000, 6000, 1000);
  rect(0, 770, 6000, 1000);
  if ((!ruleEditing & !surface_3D) || face!=1) {
    noStroke();
    stroke(0);
    textFont(font2, 20);
    int ha = 222;
    float px = 70;
    fill(255, 0, 0);
    rect(0, 200, px+10, 30);
    strokeWeight(2);
    fill(255);
    rect(px, 200, 400, 30, 7);
    fill(0);
    if (UART_b.activated) {
      //text("  Input: "+ nf(IN, 0, 2), px, ha);
      //px+= textWidth("  Input: "+ nf(100, 0, 2));
      text("  Real-time control: ", px, ha);
      px+= textWidth("  Real-time control: ");
      if (dataRecord_b[0].activated || recorded_sys.size() > 0) {
        fill(#BDFABE);
        rect(px, 200, textWidth("      Rec : " + nf(recTime, 0, 2) + "  sec") +100, 30, 2);
        fill(0);
        text("      Rec : ", px, ha);
        fill(255, 0, 0);
        stroke(0);
        strokeWeight(4);
        ellipse(px + 20, 215, 15, 15);
        px+= textWidth("      Rec : ");
        fill(255, 0, 0);
        text(nf(recTime, 0, 2), px, ha);
        px+= textWidth(nf(recTime, 0, 2));
      }
    } else {
      if (!resetDebug) {
        text("   Animation: ", px, ha);
        px += textWidth("   Animation: ");
        fill(255, 0, 0);
        if (debugStart_b.activated) {
          text(" Start", px, ha);
          px += textWidth("Start");
        } else {
          text(" Pause", px, ha);
          px += textWidth(" Pause");
        }
        fill(0);
        rect(px + 10, 200, 3, 30);
        text("    Speed : ", px, ha);
        px += textWidth("    Speed : ");
        px+=10;
        noFill();
        rect(px, 205, 100, 20);
        fill(50);
        rect(px, 205, 110-debugSpeed*2, 20);
      } else {
        text("  OFFLINE | ", px, ha);
        px += textWidth("  OFFLINE | ");
        text("Simulation Time : ", px, ha);
        px += textWidth("Simulation Time : ");
        px+=40;
        textCaseVar(0, 25, simulationTime, px, ha);
        px+=20;
        text("sec", px, ha);
      }
    }

    strokeWeight(2);
    fill(255);
    rect(425, 200, 170, 30);
    fill(0);
    text("Step T =  ", 430, ha);
    textCaseVar(3, 9, Ts, 520, ha);
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    stroke(0);
    strokeWeight(1);
    GraphUPDown_b[0].display();
    GraphUPDown_b[1].display();
    GraphUPDown_b[0].ArrowUp();
    GraphUPDown_b[1].ArrowDown();
    grid_b.display();
    for (int i=0; i<=30; i+=5) {
      line(560+i, 200, 560+i, 230);
      line(560, 200+i, 590, 200+i);
    }
    noStroke();
    fill(255);
    rect(0, 0, 650, 200);
    B_DMove_b.display();
    graphSave_b.display();
    graphSave_b.ArrowDown();
    noFill();
    for (int i =5; i < 30; i +=5)
      ellipse(55, 200 + i, 30, 5);
    stroke(0);

    //Process_b.display();
    if (!discreteSys_b.activated)
      B_DMove_b.setText((4-BD_Index) + "-C", 0.7);
    else
      B_DMove_b.setText((4-BD_Index) + "-D", 0.7);
    // Process_b.setText("A-P", 0.7);
    Signalsdropdown.display();
    ODedropdown.display();
    dispMode.display();
    Xmouse_b.display();
    Umouse_b.display();
    Ymouse_b.display();
    //blockDiagram_b.display();
    Ymouse_b.setText("Y", 0.7);
    Xmouse_b.setText("X", 0.7);
    Umouse_b.setText("U", 0.7);
    //blockDiagram_b.setText("View B-D", 0.7);
    debugStart_b.display();
    debugReset_b.display();
    debugUP_b.display();
    debugDown_b.display();
    debugStart_b.Play(true);
    debugReset_b.StopPlay(true);
    debugUP_b.speedUp(true);
    debugDown_b.speedDown(true);
    progBar.Display();
    if (Umouse_b.activated && (dispIndex ==0)) {
      UlineY = 255;
      AddInput_b.display();
      SubInput_b.display();
      resetInput_b.display();
      pushInput_b.display();
      resetInput_b.setText("Reset", 0.8);
      pushInput_b.setText("Push", 0.8);
      AddInput_b.setplus(3);
      SubInput_b.setminus(3);
      DrawUline();
    }
  }
}
