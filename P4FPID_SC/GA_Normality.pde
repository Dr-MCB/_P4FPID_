  void setUpMFsNormality() {
  fetchConcernedMFs();
  FloatList minimumsList = new FloatList();
  FloatList maximumsList = new FloatList();
  MFsIndivSize.clear();
  for (int i=0; i<MFsPop.size(); i++) {
    minimumsList.append(minWei);
    maximumsList.append(maxWei);
    MFsIndivSize.append((maxs[abs(MFsPop.get(i))-1]+1)/2);
  }
  G_A.SetUp(MFsIndivSize.size(), MFsIndivSize, minimumsList, maximumsList);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void assignToMFsNormality(int p) {
  FloatList vec = new FloatList();
  int start = 0;
  int end = 0;
  for (int i = 0; i < MFsPop.size(); i ++) {
    int I = abs(MFsPop.get(i)) - 1 ;
    for (int j =0; j < G_A.environment.get(i).get(p).size(); j ++)
      vec .append(G_A.environment.get(i).get(p).get(j));
    if (MFsPop.get(i) < 0 || symmetricalMFs_b.activated) {
      start = 1;
      end  = (maxs[I]+1)/2;
      if (weightsShape[I] == 1)
        vec.sort();
      else if (weightsShape[I] == 2)
        vec.sortReverse();
    } else {
      start = (maxs[I]+1)/2;
      end = maxs[I];
      if (weightsShape[I] == 1)
        vec.sortReverse();
      else if (weightsShape[I] == 2)
        vec.sort();
    }
    for (int j = start; j <= end; j ++) {
      MF[j][I].normality = int(vec.get(j-start));
      if (symmetricalMFs_b.activated)
        MF[maxs[I]-j+1][I].normality = MF[j][I].normality;
    }
    vec.clear();
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
