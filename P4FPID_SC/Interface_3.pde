void Interface_3() {
  fill(#FFFFFF);
  strokeWeight(2);
  rect(650, 400, 650, 370);

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////
  if (!DNA_Activator_b.activated) {
    DNA();
    image(r, 1150, speedUp_b.y, 140, 180);
  }
  //fill(255);
  //noStroke();
  //rect(1150, 715, 140, 700);
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(1150, 560, 140, 185, 10);
  if (DNA_Activator_b.activated)
  rect(1150, 715, 140, 30, 0, 0, 10, 10);
  DNA_Activator_b.display();
  fill(0);
  textSize(25);
  float s = 100 * GA_Progression/((generation)*(individuals));
  text(nf(s, 0, 0) + "%", 1220 - textWidth(nf(s, 0, 0) + "%")/2, 740);
  textSize(20);
  if (DNA_Activator_b.activated) {
    text("Elitism", 1160, 585);
    text("CrossOver", 1220 - textWidth("CrossOver")/2, 615);
    text("Random", 1160, 640);
    text("Fixed", 1160, 660);
    scrBar.display();
    crossOverStyle_b[0].display();
    crossOverStyle_b[1].display();
    elitism_b.display();
    line(1150, 595, 1290, 595);
  }

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////
  for (int i=0; i<4; i++)
    opt_var[i].display();
  fill(0);
  textFont(font2);
  textSize(22);
  text("Optimization Variables", 670, 430);
  textSize(20);
  opt_var[0].setText("MFs", 0.7);
  opt_var[1].setText("Gains", 0.7);
  opt_var[2].setText("Normality", 0.7);
  opt_var[3].setText("Rules", 0.7);
  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////


  String[] methods  = {"MSE", "IAE", "ITAE", "RMSE"};
  text("Error E(X)", 960, 430);
  text("Fitness Function F(X)", 1105, 430);
  textSize(18);
  for (int i = 0; i < 4; i ++) {
    erroFct_b[i].display();
    fill(0);
    text(methods[i], erroFct_b[i].x + 20, erroFct_b[i].y + 25);
    if (i < 2)
      fitfunc_b[i].display();
  }
  textSize(21);

  text("g(K) = ", 1170 - textWidth("g(K) = "), 465);
  if (!fitType) {
    text("K", 1205, 455);
    line(1180, 460, 1240, 460);
    text(" + 1", 1245, 465);
    text("E(X) + 1", 1210 - textWidth("E(X) + 1")/2, 485);
  } else {
    text(" K*S - E(X)", 1165, 465);
  }
  text("K = ", 960, 520);
  text("n = ", 1150, 520);
  textCaseVar(0, 30, fitK, 1050, 520);
  textCaseVar(0, 31, fitN, 1220, 520);

  text("F(X) = ", 960, 540);
  text("exp(g(K))", fitfunc_b[0].x + 25, 540);
  text("pow(g(K), n)", fitfunc_b[1].x + 25, 540);



  noFill();
  stroke(0);
  strokeWeight(2);
  rect(950, 410, 340, 140, 10);
  strokeWeight(1);
  line(950, 501, 1290, 501);
  line(1098, 410, 1098, 501);
  changeF_b.display();
  fill(0);
  changeF_b.ArrowDown();

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////

  textSize(20);
  strokeWeight(1);
  float[] dspgenetic={individuals, generation, G_A.mutationProbability, bestFit, currentFit};
  String[] parameteres = {"Individuals number:", "Generation number:", "Muation probability:"
    , "Max(F(X)):", "F(X)_i"};
  if (opt_start_b[0].activated || GA_Progression > 0) {
    if (initCounter < individuals) {
      dspgenetic[0] = initCounter;
      parameteres[0] = "Initializing .....";
      dspgenetic[1] = genCounter;
    } else {
      dspgenetic[0] = popCounter;
      dspgenetic[1] = genCounter + 1;
      parameteres[0] = "Individual number:";
    }
    parameteres[1] = "Current generation:";
  }
  for (int i=0; i<5; i++) {
    if (i < 2) {
      noFill();
      rect(840, 492+i*25, 90, 25);
      fill(0);
      textCaseVar(0, i+14, dspgenetic[i], 885, 512+i*25);
    } else if (i == 2) {
      noFill();
      rect(840, 492+i*25, 90, 25);
      fill(0);
      textCaseVar(0, i+14, dspgenetic[i], 875, 512+i*25);
      text(" %", 900, 510 + i*25);
    } else if (i >= 3) {
      if (i == 3 && (GASucced || GAFailed)) {
        if (GAFailed)
          fill(255, 0, 0, 100);
        else if (GASucced)
          fill(0, 255, 0, 100);
      } else
        noFill();
      if (GANegativeError) {
        stroke(255, 0, 0);
        strokeWeight(3);
      }
      rect(760, 492+i*25, 170, 25);
      strokeWeight(1);
      fill(0);
      textSize(setTextWidth(20, 140, String.valueOf(dspgenetic[i])));
      text(nf(dspgenetic[i], 0, 0), 845 - textWidth(nf(dspgenetic[i], 0, 0))/2, 512 + i*25);
    }
    text(parameteres[i], 660, 510 + i*25);
  }
  noFill();
  stroke(0);
  strokeWeight(2);
  rect(655, 410, 285, 215, 10);

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////


  textFont(font2, 20);
  strokeWeight(1);
  stroke(0);
  text("Gains [           ;           ]", 960, 735);
  textCaseVar(0, 18, GainsMin, 1045, 735);
  textCaseVar(0, 19, GainsMax, 1105, 735);



  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////

  linkedMFs_b.display();
  symmetricalMFs_b.display();
  pushedMFs_b.display();
  upperWidthMFs_b.display();
  lowerWidthMFs_b.display();
  fill(0);
  textSize(19);
  text("Linked", 660, 660);
  text("Pushed", 660, 690);
  text("UpperWidth", 740, 660);
  text("LowerWidth", 740, 690);
  text("Symm-", 865, 660);
  text("etrical", 865, 690);

  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////

  textSize(20);
//  if (!opt_var[1].activated) {
    text("Normality          [        ;         ] ", 670, 735);
    textCaseVar(0, 27, maxWei, 880, 737);
    textCaseVar(0, 26, minWei, 825, 737);
 // }
  //else {
  //  text("Saturations        [          ;          ] ", 670, 735);
  //  textCaseVar(0, 27, GASatMax, 880, 737);
  //  textCaseVar(0, 26, GASatMin, 825, 737);
  //}
  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////

  operatorsOpt_b.display();
  noRule_b.display();
  rulesOpt_b.display();
  rulesWeights_b.display();
  fill(0);
  text("Weights       Add (/)", 955, 660);
  text("Rules", 955, 690);
  text("Operators", 1035, 690);


  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////



  stroke(0);
  strokeWeight(2);
  opt_start_b[0].display();
  opt_start_b[1].display();
  GA_animation_b.display();
  speedUp_b.display();
  speedDown_b.display();
  opt_start_b[0].Play(true);
  ;
  opt_start_b[1].StopPlay(true);
  speedUp_b.speedUp(true);
  speedDown_b.speedDown(true);
  GA_animation_b.setText("Animation", 0.7);
  /////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////

  OptimizationRects();
  mouse_shapeManagement();
}





















void OptimizationRects() {
  stroke(0);
  strokeWeight(3);
  noFill();
  if (opt_var[1].activated) {
    strokeWeight(3);
    stroke(#FF0808);
    //rect(660, 710, 485, 35, 10);
     rect(950, 710, 195, 35, 10);
  } else {
    strokeWeight(2);
    stroke(0);
    rect(950, 710, 195, 35, 10);
  }

  if (opt_var[0].activated) {
    strokeWeight(3);
    stroke(#FF0808);
    rect(655, 635, 285, 70, 10);
  } else if (opt_var[2].activated || opt_var[3].activated ) {
    strokeWeight(2);
    stroke(0);
    rect(655, 635, 205, 70, 10);
  } else {
    strokeWeight(2);
    stroke(0);
    rect(655, 635, 285, 70, 10);
  }
  if (opt_var[2].activated) {
    strokeWeight(3);
    stroke(#FF0808);
    rect(655, 710, 285, 35, 10, 0, 10, 10);
    rect(860, 635, 80, 75, 10, 10, 0, 0);
    strokeWeight(4);
    stroke(255);
    fill(255);
    rect(863.5, 710, 73, 2);
    noFill();
  } else  { //if (!opt_var[1].activated)
    strokeWeight(2);
    stroke(0);
    rect(660, 710, 280, 35, 10);
  }

  if (opt_var[3].activated) {
    strokeWeight(3);
    stroke(#FF0808);
    rect(860, 635, 285, 70, 10);
  } else {
    strokeWeight(2);
    stroke(0);
    rect(950, 635, 195, 70, 10);
  }
}


void WeightsOrientation(Button B, int I) {
  stroke(0);
  strokeWeight(3);
  fill(0);
  if (I == 1) {
    triangle(B.x, B.y, B.x, B.y +B.sizey, B.x + B.sizex/2, B.y );
    triangle(B.x + B.sizex/2, B.y, B.x+ B.sizex, B.y +B.sizey, B.x + B.sizex, B.y );
  } else if (I ==2) {
    triangle(B.x + B.sizex/2, B.y +B.sizey, B.x + B.sizex, B.y +B.sizey, B.x + B.sizex, B.y );
    triangle(B.x, B.y, B.x, B.y +B.sizey, B.x + B.sizex/2, B.y +B.sizey);
  }
}
