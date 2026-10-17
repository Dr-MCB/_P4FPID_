void setting_up_membershipfunctions(int u) {
  Range[u] = 99;
  if (shapes2_b[2].activated || shapes2_b[4].activated) {
    for (int i=0; i<=2; i++) {
      maxs[i]= maxs[u];
      bs[i] = bs[u];
      fs[i] = fs[u];
      Range[i] = 99;
    }
    for (int ii=0; ii<=2; ii++) {
      for (int i=1; i<=maxs[ii] && MFtype != 0; i++)
        MF[i][ii].inifct(i, maxs[ii], fs[ii], MFtype);
      if (ii==0)
        setup_Rules(maxs[0]);
    }
  } else {
    for (int i=1; i<=maxs[u] && MFtype != 0; i++)
      MF[i][u].inifct(i, maxs[u], fs[u], MFtype);
    if (u==0)
      setup_Rules(maxs[0]);
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



int CheckDragging(int MFV, int MFI, float X, float Y, int dist) {
  if (MF[MFI][MFV].a1 >= X - dist && MF[MFI][MFV].a1 <= X + dist &&
    Y >= -dist && Y <= dist)
    return 1;
  else if (MF[MFI][MFV].a2 >= X - dist && MF[MFI][MFV].a2 <= X + dist
    && Y >= MF[MFI][MFV].normality -dist/2 && Y <= MF[MFI][MFV].normality +dist/2)
    return 2;
  else if (MF[MFI][MFV].a3 >= X - dist && MF[MFI][MFV].a3 <= X + dist
    && Y >= MF[MFI][MFV].normality -dist/2 && Y <= MF[MFI][MFV].normality +dist/2)
    return 3;
  if (MF[MFI][MFV].a4 >= X - dist && MF[MFI][MFV].a4 <= X + dist &&
    Y >= -dist/2 && Y <= dist/2)
    return 4;
  return -1;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


boolean VerifyMFAssignment(int MFV, int MFI, int MFP, float X, float Y) {

  if (NormalityEnabled && (MFP == 2 || MFP == 3) && Y > 0) {
    MF[MFI][MFV].normality = min(Y, 100);
  }
  if (MFP == 3 && symmetry && MF[MFI][MFV].type != 3)
    MFP = 2;
  float oldValue = MF[MFI][MFV].getParameter(MFP);
  int MFIR = min(MFI + 1, maxs[MFV]);
  int MFIL = max(MFI - 1, 1);
  float Z1 = MF[MFIR][MFV].a2, Z2 = MF[MFIL][MFV].a3;
  MF[MFI][MFV].setParameter(X, MFP);
  if (MFI == maxs[MFV] )
    Z1 = 100;
  if (MFI == 1)
    Z2= -100;
  if (MF[MFI][MFV].type == 3) {
    if ( MF[MFI][MFV].a1 >= max(-100, MF[MFIL][MFV].a1)
      && MF[MFI][MFV].a1 <= min(MF[MFI][MFV].a2, MF[MFIL][MFV].a4)
      && MF[MFI][MFV].a4 <= min(100, MF[MFIR][MFV].a4)
      && MF[MFI][MFV].a4 >= max(MF[MFIR][MFV].a1, MF[MFI][MFV].a4)
      && MF[MFI][MFV].a2 <= MF[MFI][MFV].a3 - 5
      && MF[MFI][MFV].a2 >= max(MF[MFI][MFV].a1, Z2)
      && MF[MFI][MFV].a3 <= min(MF[MFI][MFV].a4, Z1)
      ) {
      return  true;
    }
  } else if (MF[MFI][MFV].type < 3) {
    if ( MF[MFI][MFV].a1 >= max(-100, MF[MFIL][MFV].a1)
      && MF[MFI][MFV].a1 <= min(MF[MFI][MFV].a2, MF[MFIL][MFV].a4)
      && MF[MFI][MFV].a4 <= min(100, MF[MFIR][MFV].a4)
      && MF[MFI][MFV].a4 >= max(MF[MFIR][MFV].a1, MF[MFI][MFV].a4)
      && MF[MFI][MFV].a2 <= min(MF[MFI][MFV].a4, Z1)
      && MF[MFI][MFV].a2 >= max(MF[MFI][MFV].a1, Z2)
      ) {
      MF[MFI][MFV].a3 = MF[MFI][MFV].a2;
      return  true;
    }
  }
  MF[MFI][MFV].setParameter(oldValue, MFP);

  return false;
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




void pushFromEdge(int MFV, int MFI, int MFP) {
  if (MF[MFI][MFV].type == 3 && (((MFP == 3 || MFP == 2)&& MFI == 1)||(MFP == 2 && MFI == maxs[MFV]))) {
    int step = 1, end = maxs[MFV], I = MFI, P = MFP;
    if (MFI == maxs[MFV]) {
      step = -1;
      end = 1;
    }
    float R_Range = abs(MF[I][MFV].getParameter(P)*1.2);
    float old = MF[I][MFV].getParameter(P);

    if (step > 0) {
      for (int i = I; i <= end; i+=step) {
        MF[i][MFV].Shrink(i, maxs[MFV], fs[MFV], MF[i][MFV].type, R_Range);
      }
    } else {
      for (int i = I; i >= end; i+=step) {
        MF[i][MFV].Shrink(i, maxs[MFV], fs[MFV], MF[i][MFV].type, R_Range);
      }
    }
    MF[I][MFV].setParameter(old, P);
    MF[I][MFV].setParameter(MF[I + step][MFV].getParameter(P - step), P + step);
    MF[I][MFV].setParameter(-step * 100, P - 2*step);
    MF[I][MFV].setParameter(-step * 100, P -  step);

    for (int j = 1; j <=4; j ++)
      MF[maxs[MFV]-I+1][MFV].setParameter(-MF[I][MFV].getParameter(5-j), j);

    if (range_b[MFV].activated && (MFI == 1 || MFI == maxs[MFV]))
      Range[MFV] = abs((MF[1][MFV].a3 + MF[1][MFV].a2)/2);
  }
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void pushAll(int A, int B, int C) {
  pushFromEdge(A, B, C);
  pushFromCenter(A, B, C);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void pushFromCenter (int MFV, int MFI, int MFP) {
  int center = (maxs[MFV] + 1) /2;
  if ((MFI == center && (MFP == 1 || MFP == 4))) {
    int P = MFP, start = 1, step = 1;
    if (MFP == 4) {
      start = maxs[MFV];
      step = -1;
    }
    float R_Range = 100;
    if (range_b[MFV].activated)
      R_Range = Range[MFV];
    R_Range = R_Range - abs(MF[center][MFV].getParameter(P));
    float old = MF[MFI][MFV].getParameter(P);
    if (step > 0) {
      for (int i = start; i < center; i+=step) {
        MF[i][MFV].Shrink(i, maxs[MFV], fs[MFV], MF[i][MFV].type, R_Range);
        for (int j = 1; j <=4; j ++) {
          MF[i][MFV].setParameter(MF[i][MFV].getParameter(j) + old, j);
        }
        for (int j = 1; j <=4; j ++) {
          MF[maxs[MFV]-i+1][MFV].setParameter(-MF[i][MFV].getParameter(5-j), j);
        }
      }
    } else {
      for (int i = start; i > center; i+=step) {
        MF[i][MFV].Shrink(i, maxs[MFV], fs[MFV], MF[i][MFV].type, R_Range);
        for (int j = 1; j <=4; j ++) {
          MF[i][MFV].setParameter(MF[i][MFV].getParameter(j) + old, j);
        }
        for (int j = 1; j <=4; j ++) {
          MF[maxs[MFV]-i+1][MFV].setParameter(-MF[i][MFV].getParameter(j), 5-j);
        }
      }
    }
    MF[center][MFV].setParameter(-old, 5-P);
    MF[center-step][MFV].setParameter(MF[center][MFV].getParameter(P)*0.5, 5-P);
    MF[center+step][MFV].setParameter(MF[center][MFV].getParameter(5-P)*0.5, P);
    PushMFsTrapo(MFV);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void pushFromCenterBaB (int MFV, int MFI, int MFP, float RR) {
  int center = (maxs[MFV] + 1) /2;
  int P = MFP, start = 1, step = 1;
  if (MFP == 4) {
    start = maxs[MFV];
    step = -1;
  }
  float R_Range = 100;
  if (range_b[MFV].activated)
    R_Range = Range[MFV];
  R_Range = Range[MFV] - RR;
  float old = RR;
  if (step > 0) {
    for (int i = start; i < center; i+=step) {
      MF[i][MFV].Shrink(i, maxs[MFV], fs[MFV], MF[i][MFV].type, R_Range);
      for (int j = 1; j <=4; j ++) {
        MF[i][MFV].setParameter(MF[i][MFV].getParameter(j) + old, j);
      }
      for (int j = 1; j <=4; j ++) {
        MF[maxs[MFV]-i+1][MFV].setParameter(-MF[i][MFV].getParameter(5-j), j);
      }
    }
  } else {
    for (int i = start; i > center; i+=step) {
      MF[i][MFV].Shrink(i, maxs[MFV], fs[MFV], MF[i][MFV].type, R_Range);
      for (int j = 1; j <=4; j ++) {
        MF[i][MFV].setParameter(MF[i][MFV].getParameter(j) + old, j);
      }
      for (int j = 1; j <=4; j ++) {
        MF[maxs[MFV]-i+1][MFV].setParameter(-MF[i][MFV].getParameter(j), 5-j);
      }
    }
  }
  MF[center][MFV].setParameter(old, P);
  MF[center][MFV].setParameter(-old, 5-P);
  MF[center-step][MFV].setParameter(MF[center][MFV].getParameter(P)*0.5, 5-P);
  MF[center+step][MFV].setParameter(MF[center][MFV].getParameter(5-P)*0.5, P);
  PushMFsTrapo(MFV);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushMFsTrapo(int k) {
  MF[1][k].settype(3, k);
  MF[maxs[k]][k].settype(3, k);
  MF[1][k].a2  = MF[1][k].a1 = -100;
  MF[1][k].a3 = -Range[k] + 5;
  MF[maxs[k]][k].a2 = Range[k]-5;
  MF[maxs[k]][k].a4 = MF[maxs[k]][k].a3 = 100;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void  ConstrainedLikage(int MFV, int MFI, int MFP) {
  float dist = 0;
  if ((MFI < maxs[MFV] && !symmetry) || (symmetry && !rightMouse && (MFI != (maxs[MFV]+ 1)/2))) {
    if (MFP == 4) {
      dist = abs(MF[MFI+1][MFV].a3 - MF[MFI+1][MFV].a2);
      VerifyMFAssignment(MFV, MFI + 1, 2, MF[MFI][MFV].a4 - dist/2, MF[MFI+1][MFV].normality);
      VerifyMFAssignment(MFV, MFI + 1, 3, MF[MFI][MFV].a4 + dist/2, MF[MFI+1][MFV].normality);
    }
    if (MFP == 1) {
      dist = abs(MF[MFI-1][MFV].a3 - MF[MFI-1][MFV].a2);
      VerifyMFAssignment(MFV, MFI - 1, 2, MF[MFI][MFV].a1 - dist/2, MF[MFI-1][MFV].normality);
      VerifyMFAssignment(MFV, MFI - 1, 3, MF[MFI][MFV].a1 + dist/2, MF[MFI-1][MFV].normality);
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void optimize_fcts(int k) {
  for (int i=2; i<=maxs[k]-1; i++) {
    if (MF[i+1][k].type==3)
      MF[i][k].a4= (MF[i+1][k].a2+MF[i+1][k].a3)/2;
    else
      MF[i][k].a4=MF[i+1][k].a2;
    if (MF[i-1][k].type==3)
      MF[i][k].a1=(MF[i-1][k].a2+MF[i-1][k].a3)/2;
    else
      MF[i][k].a1=MF[i-1][k].a2;
    if (MF[i][k].type==3)
      MF[i+1][k].a1=MF[i-1][k].a4=(MF[i][k].a2+MF[i][k].a3)/2;
    else
      MF[i+1][k].a1=MF[i-1][k].a4=MF[i][k].a2;
    MF[i-1][k].RoundParameters();
    MF[i][k].RoundParameters();
    MF[i+1][k].RoundParameters();
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void separate_fcts(int k) {
  for (int i=1; i<=maxs[k]-1; i++) {
    MF[i][k].a4   = MF[i+1][k].a1 = int((MF[i][k].a4 +MF[i+1][k].a1)/2);
    MF[i][k].a4 = max(MF[i][k].a4, MF[i][k].a3);
    MF[i+1][k].a1 = min(MF[i+1][k].a1, MF[i+1][k].a2);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void tandence_generator(int u) {
  if (high[u]>0) {
    for (int i=(maxs[u]+1)/2; i<=maxs[u]; i++) {
      MF[i][u].normality= 100-5*high[u]*(i-(maxs[u]+1)/2);
    }
    for (int i=(maxs[u]+1)/2-1; i>=1; i--) {
      MF[i][u].normality= 100+5*high[u]*(i-(maxs[u]+1)/2);
    }
  } else if (high[u]<0) {
    for (int i=(maxs[u]+1)/2; i>=1; i--) {
      MF[i][u].normality= 100+5*high[u]*(i-1);
    }
    for (int i=(maxs[u]+1)/2+1; i<=maxs[u]; i++) {
      MF[i][u].normality= 100+5*high[u]*(maxs[u]-i);
    }
  } else {
    for (int i=1; i<=maxs[u]; i++) {
      MF[i][u].normality= 100;
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void Randomize_fcts(int k) {
  int begin = 1;
  if (symmetry)
    begin = (maxs[k]+1)/2;
  for (int i=begin; i<=maxs[k]; i++) {
    int a  = int(random(3)) + 1;
    MF[i][k].settype(a, k);
    if (symmetry)
      MF[maxs[k]-i+1][k].settype(a, k);
  }
  ReOrderMFs();
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushOUT_fcts(int k) {
  if (MF[maxs[k]][k].type==3) {
    MF[1][k].a2=MF[1][k].a1;
    MF[1][k].a3= -Range[k];
    MF[maxs[k]][k].a3=MF[maxs[k]][k].a4;
    MF[maxs[k]][k].a2 = Range[k];
  } else {
    MF[1][k].a2=MF[1][k].a3= -Range[k];
    MF[maxs[k]][k].a3=MF[maxs[k]][k].a2=Range[k];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void PushIN_fcts(int k) {
  int mi = 1;
  int ma = maxs[k];
  Range[k] = max(abs((MF[mi][k].a3 + MF[mi][k].a2)/2), abs((MF[ma][k].a3 + MF[ma][k].a2)/2));
}
