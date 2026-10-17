void setup_Rules(int t) { 
  for (int i=0; i<=12; i++) {
    for (int j=0; j<=12; j++) {
      rules_Table[i][j]=0;
      rules_Weights[i][j]=1;
      rules_Operators[i][j]= false;
    }
  }
  for (int j=0; j < t; j++) {
    for (int i=t-1; i-j >= 0; i--) {
      if ( j < (t+1)/2)
        rules_Table[t-i-1][i-j] = (t+1)/2 - j;
      else
        rules_Table[t-i-1][i-j] = 1;
    }
    for (int i=0; i+j < t; i++) {
      if ( (t+1)/2 < t-j )
        rules_Table[t-i-1][i+j] = (t+1)/2 + j;
      else
        rules_Table[t-i-1][i+j] = t;
    }
  }
  rulesTrend.clear();
  weightsTrend.clear();
  for (int j=0; j < t; j++) {
    rulesTrend.append(rules_Table[t-1][j]);
    weightsTrend.append(1);
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void PushRulesToCenter(int t) {
  int center = (t+1)/2;
  int leng = rulesTrend.size();
  for (int i = 0; i < leng; i++) {
    if (rulesTrend.get(i) != center) {
      rulesTrend.append(max(center, rulesTrend.min()-1));
      rulesTrend.sort();
      rulesTrend.remove(leng);
      break;
    }
  }
  SetUprulesTrend(t);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushRulesToEdges(int t) {
  int lenght = rulesTrend.size();
  for (int i = lenght -1; i >=0; i--) {
    if (rulesTrend.get(i) != t) {
      rulesTrend.append(min(rulesTrend.max()+1, t));
      rulesTrend.remove(0);
      break;
    }
  }
  SetUprulesTrend(t);
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushRulesToMeduim(int t) {
  setup_Rules(t);
  if (t>3) {
    int center = (t+1)/2;
    int lenght = rulesTrend.size();
    for (int i = 1; i < lenght-center; i++) {
      rulesTrend.append(rulesTrend.get(i));
    }
    rulesTrend.sort();
    for (int i = 1; i < lenght-center; i++) {
      rulesTrend.remove(rulesTrend.size()-1);
    }
  }
  SetUprulesTrend(t);
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void SetUprulesTrend(int Mx) {
  for (int i = 0; i < Mx; i++) {
    rules_Table[Mx-1][i] = rulesTrend.get(i);
    for (int j = i; j < Mx; j++) {
      rules_Table[Mx-1-j+i][j] = rules_Table[Mx-1][i];
    }
  }
  for (int i = 0; i < Mx-1; i++) {
    for (int j = 0; j < Mx-i; j++) {
      rules_Table[i][j] = Mx - rules_Table[Mx-i-1][Mx-j-1] + 1;
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void PushWeigtsToCenter(int t) {
  int leng = weightsTrend.size();
  for (int i = 0; i < leng; i++) {
    weightsTrend.set(i, max(weightsTrend.get(i)-0.05*i, 0.2));
  }
  SetUpweightsTrend(t);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushWeigtsToEdges(int t) {
  int leng = weightsTrend.size();
  for (int i = leng -1; i >= 0; i--) {
    weightsTrend.set(i, max(weightsTrend.get(i)-0.05*(leng-1-i), rulesStep));
  }
  SetUpweightsTrend(t);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushWeigtsToMeduim(int t) {
  int leng = weightsTrend.size();
  int center = (leng-1)/2;
  for (int i = center; i < leng; i++) {
    weightsTrend.set(i, max(weightsTrend.get(i)-0.05*(i-center), 0.2));
    weightsTrend.set(leng-i-1, max(weightsTrend.get(leng-i-1)-0.05*(i-center), rulesStep));
  }
  SetUpweightsTrend(t);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void SetUpweightsTrend(int Mx) {
  for (int i = 0; i < Mx; i++) {
    rules_Weights[Mx-1][i] = weightsTrend.get(i);
    for (int j = i; j < Mx; j++) {
      rules_Weights[Mx-1-j+i][j] = rules_Weights[Mx-1][i];
    }
  }
  for (int i = 0; i < Mx-1; i++) {
    for (int j = 0; j < Mx-i; j++) {
      rules_Weights[i][j] = rules_Weights[Mx-i-1][Mx-j-1];
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void show_Rules() {
  String[][] rulesName = new String[170][3];
  String[] ruleOperator = new String[170];
  String[][] ruleActivation = new String[170][3];
  String[][] MFsWeight = new String[170][3];
  String[] RuleWeight = new String[170];
  textFont(font2, 20);
  rulesMode_b.display();
  rulesNames_b.display();
  resetOperatorTable_b.display();
  rulesFilter_b.display();
  fill(0);
  rulesMode_b.setText("Set default names", 0.7);
  rulesFilter_b.setText("Filter rules", 0.7);
  if (!resetOperators)
    resetOperatorTable_b.setText("All 'and'", 0.7);
  else
    resetOperatorTable_b.setText("All 'or'", 0.7);
  rulesNames_b.setText("Rules names", 0.7);
  fill(#0BE3CF, 200);
  rect(495, 200, 155, 30, 7);
  fill(0);
  text(" RULES LIST", 500, 221);

  RulesView_begin=((tablei-1)*maxs[2]+tablej)-((tablei-1)*maxs[2]+tablej)%17+1;
  float E_maxLenght = 0, dE_maxLenght = 0;
  for (int i=1; i<=maxs[1]; i++) {
    for (int j=1; j<=maxs[2]; j++) {
      rulesName[j+(i-1)*maxs[2]][0]=MF[i][1].name;
      rulesName[j+(i-1)*maxs[2]][1]=MF[j][2].name;
      if (rules_Table[j-1][i-1] != 0)
        rulesName[j+(i-1)*maxs[2]][2]= MF[rules_Table[j-1][i-1]][0].name;
      else
        rulesName[j+(i-1)*maxs[2]][2]= "Do Nothing";

      if (textWidth(MF[i][1].name) > E_maxLenght)
        E_maxLenght = textWidth(MF[i][1].name);
      if (textWidth(MF[i][2].name) > dE_maxLenght)
        dE_maxLenght = textWidth(MF[i][2].name);

      if (MF[i][1].normality != 100)
        MFsWeight[j+(i-1)*maxs[2]][1]= "[" + nf(MF[i][1].normality/100, 0, 1) + "]";
      else
        MFsWeight[j+(i-1)*maxs[2]][1]= "";
      if (MF[j][2].normality != 100)
        MFsWeight[j+(i-1)*maxs[2]][2]= "[" + nf(MF[j][2].normality/100, 0, 1) + "]";
      else
        MFsWeight[j+(i-1)*maxs[2]][2]= "";
      if (MF[rules_Table[j-1][i-1]][0].normality != 100)
        MFsWeight[j+(i-1)*maxs[2]][0]= "[" + nf(MF[rules_Table[j-1][i-1]][0].normality/100, 0, 1) + "]";
      else
        MFsWeight[j+(i-1)*maxs[2]][0]= "";

      if (rules_Weights[j-1][i-1]!= 1)
        RuleWeight[j+(i-1)*maxs[2]]= "[" + nf(rules_Weights[j-1][i-1], 0, 1) + "] ;";
      else
        RuleWeight[j+(i-1)*maxs[2]]= "";

      if (MF[i][1].activation != 0 && MF[j][2].activation != 0) {
        ruleActivation[j+(i-1)*maxs[2]][0]= " (" + nf(MF[i][1].activation, 0, 1) + " %)";
        ruleActivation[j+(i-1)*maxs[2]][1]= " (" + nf(MF[j][2].activation, 0, 1) + " %)";
        if (rules_Table[j-1][i-1] != 0)
          ruleActivation[j+(i-1)*maxs[2]][2]= " (" + nf(MF[rules_Table[j-1][i-1]][0].activation, 0, 1) + " %)";
        else
          ruleActivation[j+(i-1)*maxs[2]][2]= "";
      } else {
        ruleActivation[j+(i-1)*maxs[2]][0]="";
        ruleActivation[j+(i-1)*maxs[2]][1]="";
        ruleActivation[j+(i-1)*maxs[2]][2]="";
      }


      if (!rules_Operators[j-1][i-1])
        ruleOperator[j+(i-1)*maxs[2]] = " AND ";
      else
        ruleOperator[j+(i-1)*maxs[2]] = " OR    ";
    }
  }


  pushMatrix();
  translate(-rulestext, 0);
  int hk=0;
  if (RulesView_begin==0)
    hk=1;
  else
    hk=RulesView_begin;
  strokeWeight(3);
  stroke(255, 0, 0);
  int poFilter = hk;
  for (int i=hk; i<=maxs[1]*maxs[2]; i++) {
    float px = 5;
    if ((rulesFilter_b.activated && ruleActivation[i][0].length() > 1) || !rulesFilter_b.activated) {

      int po=260+(poFilter-hk)*28;
      poFilter ++;
      if ((tablei-1)*maxs[2]+tablej ==i) {
        noFill();
        rect(0, po-23, 630 + rulestext, 28);
      }
      fill(0);

      text(RuleWeight[i], px, po);
      px +=  textWidth(RuleWeight[i]);
      text("IF E" + MFsWeight[i][1] + " is ", px, po);
      px +=  textWidth("IF E" + MFsWeight[i][1] + " is ");


      fill(255, 0, 0);
      text(rulesName[i][0], px, po);
      px +=  E_maxLenght;

      fill(0);
      text(ruleActivation[i][0], px, po);
      px +=  textWidth(ruleActivation[i][0]);

      fill(#F203FF);
      text(ruleOperator[i], px, po);
      px +=  textWidth(ruleOperator[i]);

      fill(0);
      text("dE" + MFsWeight[i][2] + " is    ", px, po);
      px +=  textWidth("dE" + MFsWeight[i][2] + " is    ");

      fill(0, 0, 255);
      text(rulesName[i][1], px, po);
      px +=  dE_maxLenght;

      fill(0);
      text(ruleActivation[i][1], px, po);
      px +=  textWidth(ruleActivation[i][1]);


      fill(0);
      text(" THAN Y " + MFsWeight[i][0] + " is  ", px, po);
      px +=  textWidth(" THAN Y" + MFsWeight[i][0] + " is  ");


      fill(#03A704);
      text(rulesName[i][2], px, po);
      px +=  textWidth(rulesName[i][2]);

      fill(0);
      text(ruleActivation[i][2], px, po);
      px +=  textWidth(ruleActivation[i][2]);
    }
  }
  popMatrix();



  fill(#D1F1FA);
  stroke(0);
  strokeWeight(1);
  rect(630, 200, 20, 510);
  rule_up_b.display();
  rule_down_b.display();
  fill(0, 0, 255);
  triangle(630, 220, 640, 200, 650, 220);
  triangle(630, 690, 640, 710, 650, 690);
  fill(0, 0, 255);
  float xc=7990/(maxs[1]*maxs[2]);
  if (maxs[1]*maxs[2]<=17)
    xc=470;
  rect(630, 220+(ruleswheel*(470-xc)/(maxs[1]*maxs[2])), 20, xc);
  rule_right_b.display();
  rule_left_b.display();
  fill(#D1F1FA);
  rect(20, 690, 590, 20);
  fill(#FFFFFF);
  rect(20, 710, 610, 40);
  fill(0, 0, 255);
  triangle(20, 690, 0, 700, 20, 710);
  triangle(610, 690, 630, 700, 610, 710);
  strokeWeight(1);
  fill(255);
  noStroke();
  rect(0, 750, 650, 500);
  stroke(0);
  line(0, 770, 650, 770);
  noStroke();
  fill(255);
  rect(-400, 0, 400, 770);
  rect(650, 0, 1000, 770);
}
