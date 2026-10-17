void Interface_1() {
  textFont(font2, 25);
  fill(#FFFFFF);
  strokeWeight(2);
  rect(650, 400, 650, 370);
  DrawRuleTable();
  String[] titles1 = {"View rules", "Set default rules", "Reset all rules", "Change Mode", " Rules line"};
  String[] titles2 = {"View surface", "Update Surface", "Export file"};
  String[] titles3 = {"COG", "MOM", "LOM", "SOM", "ALOM", "ASOM"};
  String[] titles4 = {"Max", "Sum"};
  String[] titles5 = {"Min", "Dot"};
  if (rulesMode == 1)
    titles1[2] = "Reset all weights";
  else if (rulesMode == 2)
    titles1[2] = "Sweap connections";
  textSize(20);
  for (int i=0; i<6; i++) {
    defuzz_b[i].display();
    textSize(17);
    if (defuzz_b[i].over)
      textSize(18);
    defuzz_b[i].setSideText(titles3[i], 0.9, 2);
    if (i<5) {
      rulesbuttons_b[i].display();
      textSize(21);
      rulesbuttons_b[i].setText(titles1[i], 0.7);
    }
    textSize(20);
    if (i<2) {
      Surface_b[i].display();
      Surface_b[i].setText(titles2[i], 0.7);
    }
    if (i<2) {
      infer_b[i].display();
      aggregation_b[i].display();
      if (infer_b[i].over)
        textSize(22);
      infer_b[i].setSideText(titles5[i], 0.9, 5);
      textSize(20);
      if (aggregation_b[i].over)
        textSize(22);
      aggregation_b[i].setSideText(titles4[i], 0.9, 5);
    }
  }

  //fill(#0BE3CF,50+4*abs(FrameCounter-50));
  fill(#0BE3CF);
  rect(1140, 435, 150, 30, 7);
  rect(1140, 575, 150, 30, 7);
  rect(1140, 660, 150, 30, 7);
  rect(975, 435, 160, 30, 7);
  rect(975, 630, 160, 30, 7);
  rect(660, 420, 150, 30, 7);
  if (surface_3D)
    rect(450, 200, 200, 25, 7);
  noFill();
  strokeWeight(2);
  rect(1140, 465, 150, 75, 7);
  rect(1140, 605, 150, 55, 7);
  fill(255);
  rect(1140, 692, 150, 30, 7);
  PLC_b.display();
  JML_b.display();
  Matlab_b.display();
  Rules_anim_b.display();
  Rules_Edit_b.display();
  rulesCenter_b.display();
  rulesEdges_b.display();
  rulesMedium_b.display();
  noFill();
  rulesEdges_b.speedUp(false);
  fill(200);
  ellipse(rulesCenter_b.x + rulesCenter_b.sizex/2, rulesCenter_b.y + rulesCenter_b.sizey/2, 20, 20);
  triangle(rulesMedium_b.x + 25, rulesMedium_b.y + 5, rulesMedium_b.x + 10, rulesMedium_b.y + 15,
    rulesMedium_b.x + 25, rulesMedium_b.y + 25);
  triangle(rulesMedium_b.x + 25, rulesMedium_b.y + 5, rulesMedium_b.x + 40, rulesMedium_b.y + 15,
    rulesMedium_b.x + 25, rulesMedium_b.y + 25);
  textSize(22);
  Rules_anim_b.setText("Animate", 0.7);
  Rules_Edit_b.setText("Edit", 0.7);
  textBox(32, codename, 1215, 712);



  fill(0);
  textSize(23);
  text("Defuzification", 1155, 457);
  text("Inference", 1167, 597);
  text("Export file", 1155, 682);
  text("Rules", 1030, 457);
  text("Surface", 1030, 653);
  if (rulesMode == 0)
    text("Rules table:", 670, 442);
  else if (rulesMode == 1)
    text("Rules weights:", 670, 442);
  else
    text(" Connections:", 670, 442);
  if (surface_3D) {
    fill(255);
    rect(0, 740, 200, 25, 5);
    rect(520, 740, 130, 25, 5);
    fill(0);
    textSize(22);
    text("3D Surface", 500, 220); // gradationCounter
    text(int(200/surfaceResolution[GrCounter])+ "X" + int(200/surfaceResolution[GrCounter]), 550, 760);
    surfaceRot_b.display();
    surfaceGrid_b.display();
    surfaceGains_b.display();
    surfaceProjection_b.display();
    surfaceGradation_b.display();
    Cpp_b.display();
    Python_b.display();
    image(Python_Icon, Python_b.x, Python_b.y, 35, 25);
    image(Cpp_Icon, Cpp_b.x, Cpp_b.y, 35, 25);
    textSize(20);
    surfaceGains_b.setText("Link to Gains", 0.7);
    surfaceProjection_b.setText("2D Projection", 0.7);
    surfaceGradation_b.setText("Gradation", 0.7);
    surfaceRot_b.setText("Rotate", 0.7);
    text("Python", Python_b.x + 40, Python_b.y + 18);
    text("C/C++", Cpp_b.x + 40, Cpp_b.y + 18);
    if (surfaceGrid_b.activated)
      surfaceGrid_b.setText("Grid OFF", 0.7);
    else
      surfaceGrid_b.setText("Grid ON", 0.7);
    textBox(33, surfacename, 100, 757);
  }
  fill(0);
  image(PLC_Icon, PLC_b.x, PLC_b.y, 30, 30);
  image(JML_Icon, JML_b.x, JML_b.y, 30, 30);
  image(MATALB_Icon, Matlab_b.x, Matlab_b.y, 35, 30);
  textSize(20);
  text("  PLC", PLC_b.x + 32, PLC_b.y + 22);
  text(" JFML", JML_b.x + 32, JML_b.y + 22);
  text("Matlab", Matlab_b.x + 40, Matlab_b.y + 22);
  mouse_shapeManagement();
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void DrawRuleTable() {
  fill(0);
  text("Fuzzy Inference System (FIS)", 1130-textWidth("Fuzzy Inference System (FIS)")/2, 425);
  pushMatrix();
  translate(-10, 50);
  float table_X=(310)/(maxs[1]+1);
  float table_Y=(310)/(maxs[2]+1);
  strokeWeight(2);
  textSize(250/(maxs[1]+maxs[2]));
  if (rmouseX >= 670 && rmouseX <= table_X + 670 &&
    rmouseY >= 450 && rmouseY <=table_Y +450) {
    fill(#7EFFE8);
    rect(670, 400, table_X, table_Y);
  }
  if (Rules_Edit_b.activated) {
    fill(#38FF03);
    rect(tablei*table_X+670, tablej*table_Y+400, table_X, table_Y, 150/(maxs[1]+maxs[2]));
    fill(#FF0F0F);
    rect(tablei*table_X+670, 400, table_X, table_Y);
    fill(#F7B705);
    rect(670, tablej*table_Y+400, table_X, table_Y);
    fill(0);
    if (rulesMode != 2) {
      if (!rules_Operators[tablej-1][tablei-1])
        text("and", 675 + table_X*0.05, 400 + table_Y*0.6);
      else
        text("or", 675 + table_X*0.15, 400 + table_Y*0.6);
    } else {
      text(rules_Table[tablej-1][tablei-1], 675 + table_X*0.15, 400 + table_Y*0.6);
    }
  }
  fill(0);
  stroke(0);
  textSize(250/(maxs[1]+maxs[2]));
  for (int i=0; i<=maxs[1]; i++) {
    line(i*table_X+670, 400, i*table_X+670, (maxs[2]+1)*table_Y+400);
    if (i>0) {
      if (!rulesNames_b.activated || MF[i][1].name_Size > 3)
        text(i, i*table_X+table_X*0.3+670, 405+table_Y*0.5);
      else
        text(MF[i][1].name, i*table_X+table_X*0.1+670, 405+table_Y*0.5);
    }
  }
  line((maxs[1]+1)*table_X+670, 400, (maxs[1]+1)*table_X+670, (maxs[2]+1)*table_Y+400);
  for (int i=0; i<=maxs[2]; i++) {
    line(670, i*table_Y+400, (maxs[1]+1)*table_X+670, i*table_Y+400);
    if (i>0) {
      if (!rulesNames_b.activated || MF[i][2].name_Size >3)
        text(i, table_X*0.3+670, 405+i*table_Y+table_Y*0.5);
      else
        text(MF[i][2].name, table_X*0.1+670, 405+i*table_Y+table_Y*0.5);
    }
  }
  line(670, (maxs[2]+1)*table_Y+400, (maxs[1]+1)*table_X+670, (maxs[2]+1)*table_Y+400);

  for (int i=1; i<=maxs[1]; i++) {
    for (int j=1; j<=maxs[2]; j++) {
      fill(255);
      if (rulesMode == 0) {
        fill(100+15*rules_Table[j-1][i-1], 250-15*rules_Table[j-1][i-1]);
      } else if (rulesMode == 1) {
        fill(150+100*rules_Weights[j-1][i-1], 250 - 100*rules_Weights[j-1][i-1]);
      } else if (rulesMode == 2) {
        if (!rules_Operators[j-1][i-1])
          fill(255);
        else
          fill(150, 100);
      } 
      rect(i*table_X + 670, j*table_Y +400, table_X, table_Y);
      fill(0);
      if (rulesMode == 2) {
        if (!rules_Operators[j-1][i-1])
          text("and", (i+0.1)*table_X+670, (j+0.5)*table_Y+405);
        else
          text("or", (i+0.1)*table_X+670, (j+0.5)*table_Y+405);
      } else if (rulesMode == 0) {
        if (rules_Table[j-1][i-1]==0)
          text("/", (i+0.4)*table_X+670, (j+0.5)*table_Y+405);
        else {
          if (!rulesNames_b.activated || MF[i][0].name_Size > 3)
            text(rules_Table[j-1][i-1], (i+0.3)*table_X+670, (j+0.5)*table_Y+405);
          else
            text(MF[rules_Table[j-1][i-1]][0].name, (i+0.1)*table_X+670, (j+0.5)*table_Y+405);
        }
      } else if (rulesMode == 1) {
        text(nf(rules_Weights[j-1][i-1], 0, 0), (i+0.1)*table_X+670, (j+0.5)*table_Y+405);
      }
    }
  }
  popMatrix();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void DrawRulesLine() {
  float A2 =975+(MF[tablei][1].a2+MF[tablei][1].a3)/2*3;
  float A3 =140-MF[tablei][1].normality;
  float B2 =975+(MF[tablej][2].a2+MF[tablej][2].a3)/2*3;
  float B3 =340-MF[tablej][2].normality;
  float C2 =340+(MF[rules_Table[tablej-1][tablei-1]][0].a2+MF[rules_Table[tablej-1][tablei-1]][0].a3)/2*3;
  float C3 =140-MF[rules_Table[tablej-1][tablei-1]][0].normality/2;
  float alpha = 0, beta = 0, x200 = A2;
  alpha = (A3-B3)/(A2-B2);
  beta = A3 - A2*alpha;
  if (A2-B2 != 0)
    x200 = (180-beta)/alpha;
  strokeWeight(3);
  stroke(0);
  line(A2, A3, B2, B3);
  fill(255);
  rect(x200-30, 160, 60, 30);
  //ellipse(x200, 180, 40, 40);
  fill(0);
  strokeWeight(3);
  if (rules_Operators[tablej-1][tablei-1]) {
    text("OR", x200 -15, 180);
  } else {
    text("AND", x200 -25, 180);
  }
  if (shapes2_b[5].activated && rules_Table[tablej-1][tablei-1] != 0) {
    strokeWeight(3);
    line(x200-30, 160, C2, C3);
  }
}
