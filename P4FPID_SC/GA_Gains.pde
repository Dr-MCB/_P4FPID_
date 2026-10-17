void setUpGains() {
  FloatList minimumsList = new FloatList();
  FloatList maximumsList = new FloatList();
  IntList gain = new IntList();
  minimumsList.append(GainsMin);
  maximumsList.append(GainsMax);
  int s =0;
  for (int i =0; i < 5; i ++)
    if (GainOpt_b[i].activated)
      s++;
  gain.append(s);
  G_A.SetUp(1, gain, minimumsList, maximumsList);
}

void assignToGains(int p) {
  int s = 0;
  if (GainOpt_b[0].activated) {
    Ke = G_A.environment.get(0).get(p).get(s);
    s++;
  }
  if (GainOpt_b[1].activated) {
    Kde = G_A.environment.get(0).get(p).get(s);
    s++;
  }
  if (GainOpt_b[2].activated) {
    Ky1 = G_A.environment.get(0).get(p).get(s);
    s++;
  }
  if (GainOpt_b[3].activated) {
    Ky2 = G_A.environment.get(0).get(p).get(s);
    s++;
  }
  if (GainOpt_b[4].activated) {
    Ky3 = G_A.environment.get(0).get(p).get(s);
    s++;
  }
  //if (GainOpt_b[5].activated) {
  //  VariableSaturations[0] = map(G_A.environment.get(0).get(p).get(s), GainsMin, GainsMax, GASatMin, GASatMax) ;
  //  s++;
  //}
  //if (GainOpt_b[6].activated) {
  //  VariableSaturations[1] = map(G_A.environment.get(0).get(p).get(s), GainsMin, GainsMax, GASatMin, GASatMax);
  //  s++;
  //}
  //if (GainOpt_b[7].activated) {
  //  VariableSaturations[2] = map(G_A.environment.get(0).get(p).get(s), GainsMin, GainsMax, GASatMin, GASatMax);
  //  s++;
  //}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////
