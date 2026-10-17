void Launch_GA_optimization() {
  if (opt_start_b[0].activated && GA_animation_b.activated) {
    GA_Counter ++;
    Sleeping = false;
    sleepingTimer =0;
    if (GA_Counter >= GA_Speed) {
      GA_Counter = 0;
      GA_Progression ++;
      if (initCounter <individuals ) {
        G_A.Initiate(initCounter);
        assignToCorrespondingVariable(initCounter);  
        G_A.CalculateFitness(initCounter);
        initCounter++;
      } else if (initCounter==individuals) {
        G_A.NaturalSelection();
        bestElt = G_A.BestElement();
        bestFit = G_A.fitVector.max();
        initCounter++;
      } else {
        G_A.CrossOver(popCounter, elitism_b.activated);
        G_A.Mutation(popCounter, elitism_b.activated);
        assignToCorrespondingVariable(popCounter);
        G_A.CalculateFitness(popCounter);
        popCounter++;
      }
      if (popCounter==individuals) {
        bestElt = G_A.BestElement();
        popCounter=0;
        G_A.NaturalSelection();
        GAFailed = GASucced = false;
        if (bestFit > G_A.fitVector.max())
          GAFailed = true;
        else if (bestFit < G_A.fitVector.max())
          GASucced = true;
        bestFit = G_A.fitVector.max();
        genCounter++;
      }
      if (genCounter == generation-1) {
        stopGA();
      }
    }
  }
}


void BackgroundOptimization() {
  for (int i =0; i < individuals; i ++) {
    G_A.Initiate(i);
    assignToCorrespondingVariable(i);
    G_A.CalculateFitness(i);
  }
  for (int j =0; j < generation; j ++) {
    G_A.NaturalSelection();
    bestElt = G_A.BestElement();
    bestFit = G_A.fitVector.max();
    for (int i =0; i < individuals; i ++) {
      G_A.CrossOver(i, elitism_b.activated);
      G_A.Mutation(i, elitism_b.activated);
      assignToCorrespondingVariable(i);
      G_A.CalculateFitness(i);
    }
  }
  stopGA();
}
void assignToCorrespondingVariable(int I) {
  if (opt_var[0].activated) {
    if (upperWidthMFs_b.activated || lowerWidthMFs_b.activated)
      assignToMFsWidths(I);
    else
      assignToMFs(I);
  } else if (opt_var[1].activated) {
    assignToGains(I);
  } else if (opt_var[2].activated) {
    assignToMFsNormality(I);
  } else if (opt_var[3].activated) {
    assignToRules(I);
  }
}

void setUpCorrespondingVariable() {
  if (opt_var[0].activated) {
    if (upperWidthMFs_b.activated || lowerWidthMFs_b.activated)
      setUpMFsWidths();
    else
      setUpMFs();
  } else if (opt_var[1].activated) {
    setUpGains();
  } else if (opt_var[2].activated) {
    setUpMFsNormality();
  } else if (opt_var[3].activated) {
    setUpRules();
  }
}

void stopGA() {
  initCounter=0;
  popCounter =0;
  genCounter=0;
  GA_Progression=0;
  GA_Counter= 0;
  assignToCorrespondingVariable(G_A.BestElement());
  ReOrderMFs();
  update_2Dplot();
  G_A.Reset();
  opt_start_b[0].activated = GANegativeError = false;
}



void ReOrderMFs() {
  for (int ll=0; ll<3; ll++)
    for (int jj=0; jj<= maxs[ll]; jj++) {
      if (MF[jj][ll].type <3)
        MF[jj][ll].a3 = MF[jj][ll].a2;
    }
}

float MSE() {
  float dif=0;
  for (int i=0; i<offline_E.size(); i++) {
    dif+=pow(offline_E.get(i), 2);
  }
  return dif/offline_E.size();
}

float RMSE() {
  return sqrt(MSE());
}

float IAE() {
  float dif=0;
  for (int i=0; i<offline_E.size(); i++) {
    dif+=abs(offline_E.get(i));
  }
  return dif*Ts;
}

float TIAE() {
  float dif=0;
  for (int i=0; i<offline_E.size(); i++) {
    dif+=i*abs(offline_E.get(i));
  }
  return dif*Ts;
}
