void fetchConcernedMFs() {
  MFsPop.clear();
  for (int i =0; i< 3; i++) {
    if (MFsGA_b[i].activated) {
      if (!symmetricalMFs_b.activated) {
        if (optSide_b[2*i].activated)
          MFsPop.append(-(i+1));
        if (optSide_b[2*i+1].activated)
          MFsPop.append(i+1);
      } else
        MFsPop.append(i+1);
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void setUpMFs() {
  fetchConcernedMFs();
  FloatList minimumsList = new FloatList();
  FloatList maximumsList = new FloatList();
  MFsIndivSize.clear();
  for (int i=0; i<MFsPop.size(); i++) {
    int sum = 0;
    int start = 0;
    int end = 0;
    int I = abs(MFsPop.get(i)) - 1 ;
    if (MFsPop.get(i) < 0 || symmetricalMFs_b.activated) {
      start = 1;
      end  = (maxs[I]+1)/2-1;
      if (pushedMFs_b.activated)
        minimumsList.append(-Range[I]);
      else
        minimumsList.append(-100);
      maximumsList.append(0);
    } else {
      start = (maxs[I]+1)/2+1;
      end = maxs[I];
      minimumsList.append(0);
      if (pushedMFs_b.activated)
        maximumsList.append(Range[I]);
      else
        maximumsList.append(100);
    }
    for (int j=start; j<=end; j++)
      sum+= MF[j][I].parameters;
    if (MF[(maxs[I]+1)/2][I].type == 3)
      sum++;
    MFsIndivSize.append(sum);
  }
  G_A.SetUp(MFsIndivSize.size(), MFsIndivSize, minimumsList, maximumsList);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void setUpMFsWidths() {
  fetchConcernedMFs();
  MakeRefrence();
  FloatList minimumsList = new FloatList();
  FloatList maximumsList = new FloatList();
  MFsIndivSize.clear();
  for (int i=0; i<MFsPop.size(); i++) {
    minimumsList.append(0);
    maximumsList.append(100);
    MFsIndivSize.append((maxs[abs(MFsPop.get(i))-1]+1)/2);
  }
  G_A.SetUp(MFsIndivSize.size(), MFsIndivSize, minimumsList, maximumsList);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void assignToMFsWidths(int p) {
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
    } else {
      start = (maxs[I]+1)/2;
      end = maxs[I];
    }
    ReSetToRefrence(I, start, end);
    for (int j = start; j <= end; j ++) {
      GAmouseWheelActions(j, I, int(abs(vec.get(j-start))), symmetricalMFs_b.activated);
    }
    vec.clear();
  }
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void GAmouseWheelActions(int A, int B, float x, boolean Sym) {
  int a = A;
  int b = B;
  int c = maxs[b] - a + 1;
  float sup = 0;
  float inf = 0;
  if (upperWidthMFs_b.activated) {
    if (MF[a][b].type==3) {
      sup = (MF[a][b].a2 + MF[a][b].a3)/2;
      if (a != 1)
        MF[a][b].a2  = int(sup - x * abs(sup - max(MF[a][b].a1, MF[a-1][b].a3))*0.01);
      else
        MF[a][b].a2 = int(sup - x * abs(sup +100)*0.01);

      if (a!=maxs[b])
        MF[a][b].a3 = int(sup + x * abs(sup - min(MF[a][b].a4, MF[a+1][b].a2))*0.01);
      else
        MF[a][b].a3 = int(sup + x * abs(sup - 100)*0.01);

      if (Sym && MF[c][b].type == MF[a][b].type) {
        a = c;
        sup = (MF[a][b].a2 + MF[a][b].a3)/2;
        if (a != 1)
          MF[a][b].a2  = int(sup - x * abs(sup - max(MF[a][b].a1, MF[a-1][b].a3))*0.01);
        else
          MF[a][b].a2 = int(sup - x * abs(sup +100)*0.01);

        if (a!=maxs[b])
          MF[a][b].a3 = int(sup + x * abs(sup - min(MF[a][b].a4, MF[a+1][b].a2))*0.01);
        else
          MF[a][b].a3 = int(sup + x * abs(sup - 100)*0.01);
      }
    } else if (MF[a][b].type==2) {
      MF[a][b].Gauss = Bound__(12, 1, int(map(x, 0, 100, 1, 12)));
      if (Sym  &&  MF[c][b].type == MF[a][b].type) {
        MF[c][b].Gauss = MF[a][b].Gauss;
      }
    }
  } else if (lowerWidthMFs_b.activated) {
    sup = min(MF[a-1][b].a4, MF[a][b].a2);
    inf = MF[a-1][b].a3;
    if (a != 1)
      MF[a][b].a1 =IBound__(sup, inf, inf + x * (sup - inf) * 0.01);
    sup = MF[a+1][b].a2;
    inf = max(MF[a][b].a3, MF[a+1][b].a1);
    if (a!=maxs[b])
      MF[a][b].a4 =IBound__(sup, inf, sup - x * (sup - inf) * 0.01);

    if (Sym  &&  MF[c][b].type == MF[a][b].type) {
      sup = min(MF[c-1][b].a4, MF[c][b].a2);
      inf = MF[c-1][b].a3;
      if (c != 1)
        MF[c][b].a1 =IBound__(sup, inf, inf + x * (sup - inf) * 0.01);
      sup = MF[c+1][b].a2;
      inf = max(MF[c][b].a3, MF[c+1][b].a1);
      if (c!=maxs[b])
        MF[c][b].a4 =IBound__(sup, inf, sup - x * (sup - inf) * 0.01);
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void assignToMFs(int p) {
  FloatList vec = new FloatList();
  int start = 0;
  int end = 0;
  int begin = 0;
  for (int i = 0; i < MFsPop.size(); i ++) {
    int I = abs(MFsPop.get(i)) - 1 ;
    for (int j =0; j < G_A.environment.get(i).get(p).size(); j ++)
      vec .append(G_A.environment.get(i).get(p).get(j));
    vec.sort();
    if (MFsPop.get(i) < 0 || symmetricalMFs_b.activated) {
      start = 1;
      end  = (maxs[I]+1)/2;
      vec.insert(0, -100);
      if (pushedMFs_b.activated)
        vec.set(1, -Range[I]);
      begin = 1;
    } else {
      start = (maxs[I]+1)/2;
      end = maxs[I];
      vec.append(100);
      if (pushedMFs_b.activated)
        vec.set(vec.size()-2, Range[I]);
      begin = 3;
    }
    for (int j = start; j <= end; j ++) {
      for (int k = begin; k <= MF[j][I].parameters; k ++) {
        if (vec.size()!=0) {
          int e = MF[j][I].parameters;
          int l = k/e;
          if (j == end && k == e && end == maxs[I])
            l = 0;
          MF[j][I].setVal(int(vec.get(l)), k);
          if (symmetricalMFs_b.activated)
            MF[maxs[I]-j + start][I].setVal(int(-vec.get(l)), e-k+1);
          vec.remove(l);
        }
      }
      begin = 1;
    }
    if (linkedMFs_b.activated)
      optimize_fcts(I);
    if (pushedMFs_b.activated)
      PushOUT_fcts(I);
    vec.clear();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void MakeRefrence() {
  for (int ii =0; ii < 3; ii ++) {
    for (int i =1; i <= maxs[ii]; i ++) {
      refrenceMFs[i][ii][0] = MF[i][ii].a1;
      refrenceMFs[i][ii][1] = MF[i][ii].a2;
      refrenceMFs[i][ii][2] = MF[i][ii].a3;
      refrenceMFs[i][ii][3] = MF[i][ii].a4;
      refrenceMFs[i][ii][4] = MF[i][ii].Gauss;
    }
  }
}

void ReSetToRefrence(int II, int starting, int ending) {
  for (int j =starting; j <= ending; j ++) {
    MF[j][II].a1 =    refrenceMFs[j][II][0];
    MF[j][II].a2 =    refrenceMFs[j][II][1];
    MF[j][II].a3 =   refrenceMFs[j][II][2];
    MF[j][II].a4 =    refrenceMFs[j][II][3];
    MF[j][II].Gauss = refrenceMFs[j][II][4];
  }
}
