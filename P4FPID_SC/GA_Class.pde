class GeneticAlgorithm {
  ArrayList<ArrayList<FloatList>> environment;
  int populations;
  int Amplifier;
  int EquiliberumFactor;
  float mutationProbability;
  float crossOverPoint;
  boolean randomCross;
  boolean Inprogess;
  IntList individualSize;
  IntList gessBox;
  FloatList fitVector;
  FloatList Min;
  FloatList Max;

  GeneticAlgorithm() {
    environment = new ArrayList<ArrayList<FloatList>>();
    fitVector = new FloatList();
    Min = new FloatList();
    Max = new FloatList();
    gessBox = new IntList();
    individualSize = new IntList();
    individuals = 10;
    generation = 5;
    mutationProbability = 0.1;
    crossOverPoint = 0.5;
    Amplifier = individuals * 5;
    EquiliberumFactor = 5;
  }

  void SetUp(int populations_number, IntList individual_size, FloatList mins, FloatList maxs) {
    populations = populations_number;
    individualSize = individual_size;
    Min = mins;
    Max = maxs;
    for (int i = 0; i < populations; i++) {
      ArrayList<FloatList> list2D = new ArrayList<FloatList>();
      for (int j = 0; j < individuals; j++) {
        FloatList list1D = new FloatList();
        for (int l = 0; l < individualSize.get(i); l++) {
          list1D.append(0);
        }
        list2D.add(list1D);
      }
      environment.add(list2D);
    }
  }


  void Reset() {
    boolean alreadyEmpty = false;
    for (int i = 0; i < populations; i++) {
      for (int j = 0; j < individuals; j++) {
        try {
          environment.get(i).get(j).clear();
        }
        catch (Exception e) {
          alreadyEmpty = true;
        }
      }
      if (!alreadyEmpty)
        environment.get(i).clear();
    }
    environment.clear();
    Min.clear();
    Max.clear();
    individualSize.clear();
    gessBox.clear();
    fitVector.clear();
  }

  void Initiate(int p) {
    for (int i = 0; i < populations; i++) {
      for (int l = 0; l < individualSize.get(i); l++) {
        environment.get(i).get(p).set(l, random(Min.get(i), Max.get(i)));
      }
    }
  }

  void CalculateFitness(int p) {
    ReOrderMFs();
    Perceive();
    resetUniverse();
    float error =0;
    if (erroFct_b[1].activated)
      error = IAE();
    else if (erroFct_b[0].activated)
      error = MSE();
    else if (erroFct_b[2].activated)
      error = TIAE();
    else
      error =  RMSE();

    if (fitType)
      error = fitK * simulationSteps * MaxSaturations[2] - error;
    else
      error = 1 + fitK / (1 + error);

    if (error < 0)
      GANegativeError = true;
    if (fitfunc_b[0].activated)
      error = exp(error);
    else if (fitfunc_b[1].activated)
      error = pow(error, fitN);
    currentFit = int(error*100)/100;
    fitVector.set(p, currentFit);
  }


  void NaturalSelection() {
    float accumulation = 0 ;
    gessBox.clear();
    for (int i = 0; i < individuals; i++)
      accumulation += fitVector.get(i);
    for (int k=0; k<individuals; k++) {
      for (int l=0; l<=fitVector.get(k)*Amplifier/accumulation; l++) {
        gessBox.append(k);
      }
    }
    mixGuessBox();
  }

  void CrossOver(int p, boolean ElitIndiviual) {
    int pic1 = gessBox.get(int(random(gessBox.size())));
    int pic2 = gessBox.get(int(random(gessBox.size())));
    if (p ==0 && ElitIndiviual) {
      pic1 = bestElt;
      pic2 = bestElt;
    }
    for (int i = 0; i < populations; i++) {
      int Portion = 1;
      if (randomCross)
        Portion = int (random(individualSize.get(i)));
      else
        Portion = int (individualSize.get(i) * crossOverPoint);
      FloatList Father = new FloatList();
      FloatList Mother = new FloatList();
      Father.clear();
      Mother.clear();
      for (int j =0; j < G_A.environment.get(i).get(p).size(); j ++) {
        Father.append(G_A.environment.get(i).get(pic1).get(j));
        Mother.append(G_A.environment.get(i).get(pic2).get(j));
      }
      for (int l = 0; l < Portion; l++) {
        environment.get(i).get(p).set(l, Father.get(l));
      }
      for (int l = Portion; l < individualSize.get(i); l++) {
        environment.get(i).get(p).set(l, Mother.get(l));
      }
    }
  }

  void Mutation(int p, boolean ElitIndiviual) {
    if (p != 0 && !ElitIndiviual) {
      for (int i = 0; i < populations; i++) {
        if (random(100) < mutationProbability) {
          int ConcernedGene = int(random(individualSize.get(i)));
          environment.get(i).get(p).set(ConcernedGene, random(Min.get(i), Max.get(i)));
        }
      }
    }
  }

  int BestElement() {
    int maxIndex = 0;
    for (int i = 0; i < individuals; i++) {
      if (fitVector.get(i) >= fitVector.get(maxIndex)) {
        maxIndex = i;
      }
    }
    return maxIndex;
  }

  void mixGuessBox() {
    for (int i=0; i<gessBox.size() * EquiliberumFactor; i++) {
      int k=int(random(gessBox.size()));
      int l=int(random(gessBox.size()));
      int Sweap=gessBox.get(k);
      gessBox.set(k, gessBox.get(l));
      gessBox.set(l, Sweap);
    }
  }
}
