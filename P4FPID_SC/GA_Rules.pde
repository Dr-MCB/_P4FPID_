void setUpRules() {
  FloatList minimumsList = new FloatList();
  FloatList maximumsList = new FloatList();
  IntList ruleList = new IntList();
  int end = maxs[2];
  int rulesParameters = 0;
  if (operatorsOpt_b.activated)
    rulesParameters++;
  if (rulesOpt_b.activated)
    rulesParameters++;
  if (rulesWeights_b.activated)
    rulesParameters++;
  end *=rulesParameters;
  for (int i =0; i < end; i ++) {
    minimumsList.append(noRuleIndex);
    maximumsList.append(100);
    ruleList.append(maxs[1]);
  }
  G_A.SetUp(end, ruleList, minimumsList, maximumsList);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void assignToRules(int p) {
  for (int i =0; i < maxs[2]; i ++) {
    for (int j =0; j < maxs[1]; j ++) {
      if (rulesOpt_b.activated && !operatorsOpt_b.activated && !rulesWeights_b.activated) {
        assigntoTAble(p, i, j, 0);
      } else if (operatorsOpt_b.activated && !rulesOpt_b.activated && !rulesWeights_b.activated) {
        assigntoConnectors(p, i, j, 0);
      } else if (rulesWeights_b.activated && !operatorsOpt_b.activated && !rulesOpt_b.activated) {
        assigntorulesWeigths(p, i, j, 0);
      } else if (!rulesWeights_b.activated && operatorsOpt_b.activated && rulesOpt_b.activated) {
        assigntoTAble(p, i, j, 0);
        assigntoConnectors(p, i, j, 1);
      } else if (rulesWeights_b.activated && operatorsOpt_b.activated && !rulesOpt_b.activated) {
        assigntorulesWeigths(p, i, j, 0);
        assigntoConnectors(p, i, j, 1);
      } else if (rulesWeights_b.activated && !operatorsOpt_b.activated && rulesOpt_b.activated) {
        assigntorulesWeigths(p, i, j, 0);
        assigntoTAble(p, i, j, 1);
      } else if (rulesWeights_b.activated && operatorsOpt_b.activated && rulesOpt_b.activated) {
        assigntorulesWeigths(p, i, j, 0);
        assigntoTAble(p, i, j, 1);
        assigntoConnectors(p, i, j, 2);
      }
    }
  }

  if (symmetricalMFs_b.activated) {
    for (int i = 0; i < maxs[2]; i++) {
      for (int j = 0; j < maxs[1]; j++) {
        if (i + j < maxs[0] - 1) {
          if (operatorsOpt_b.activated)
            rules_Operators[i][j] = rules_Operators[maxs[0] - 1 - j][maxs[0] - 1 - i];
          if (rulesOpt_b.activated){
            rules_Table[i][j] = maxs[0] - rules_Table[maxs[0] - 1 - j][maxs[0] - 1 - i] + 1;
          }if (rulesWeights_b.activated)
            rules_Weights[i][j] = rules_Weights[maxs[0] - 1 - j][maxs[0] - 1 - i];
        }
      }
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void assigntoTAble(int P, int I, int J, int k) {
  rules_Table[I][J] = int(map(int(G_A.environment.get(I+ k * maxs[2]).get(P).get(J)), noRuleIndex, 100, noRuleIndex, maxs[0] + 1));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void assigntoConnectors(int P, int I, int J, int k) {
  if (G_A.environment.get(I+k*maxs[2]).get(P).get(J) > 50)
    rules_Operators[I][J] = true;
  else
    rules_Operators[I][J] = false;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void assigntorulesWeigths(int P, int I, int J, int k) {
  rules_Weights[I][J] = int(G_A.environment.get(I+k*maxs[2]).get(P).get(J))*0.01;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
