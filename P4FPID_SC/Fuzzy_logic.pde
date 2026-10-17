void inference(float x1, float x2) {
  float u1=0;
  float u2=0;
  float Ux =0 ;
  for (int i=1; i<=maxs[1]; i++) {
    if (x1>=MF[i][1].a1 && x1<= MF[i][1].a4) {
      u1=MF[i][1].getu(x1);
      for (int j=1; j<=maxs[2]; j++) {
        if (x2>=MF[j][2].a1 && x2<= MF[j][2].a4) {
          u2=MF[j][2].getu(x2);
          if (!rules_Operators[j-1][i-1])
            Ux = min(u1, u2);
          else
            Ux = max(u1, u2);
          if (rules_Table[j-1][i-1]!=0) {
            MF[rules_Table[j-1][i-1]][0].setfct(Ux, rules_Weights[j-1][i-1]);
          }
        }
      }
    }
  }
}

float Defuzzification() {
  float sum_=0;
  float count_=0;
  int maximum = int(max(UoD))-4;

  if (Def_method == 1) {
    for (int k=0; k<1000; k+=movingStep) {
      sum_+=UoD[k]*((k-500)/5);
      count_+=UoD[k];
    }
    count_ = (count_ == 0) ? 1 : count_;
    return Bound__(Range[0], -Range[0], sum_/count_);
  } else if (Def_method == 2) {
    for (int k=0; k<1000; k+=movingStep) {
      if (UoD[k] >= maximum) {
        sum_+=UoD[k]*((k-500)/5);
        count_+=UoD[k];
      }
    }
    count_ = (count_ == 0) ? 1 : count_;
    return Bound__(Range[0], -Range[0], sum_/count_);
  } else if (Def_method == 3) {
    for (int k=1000; k>=0; k-=movingStep) {
      if (UoD[k] >= maximum) {
        sum_=((k-500)/5);
        break;
      }
    }
    return Bound__(Range[0], -Range[0], sum_);
  } else if (Def_method == 4) {
    for (int k=0; k < 1000; k+=movingStep) {
      if (UoD[k] >= maximum) {
        sum_=((k-500)/5);
        break;
      }
    }
    return Bound__(Range[0], -Range[0], sum_);
  } else if (Def_method == 5) {
    int sum2 = 0;
    for (int k=1000; k >=0; k-=movingStep) {
      if (UoD[k] >= maximum) {
        sum_=((k-500)/5);
        break;
      }
    }
    for (int k=0; k < 1000; k+=movingStep) {
      if (UoD[k] >= maximum) {
        sum2=((k-500)/5);
        break;
      }
    }
    if (abs(sum_) == abs(sum2)) //
      return 0;
    else if (abs(sum_) > abs(sum2))
      return Bound__(Range[0], -Range[0], sum_);
    else
      return Bound__(Range[0], -Range[0], sum2);
  } else {
    for (int k=0; k < 500; k+=movingStep) {
      if (UoD[500-k] >= maximum) {
        sum_=(-k/5);
        break;
      }
      if (UoD[500+k] >= maximum) {
        sum_=((k)/5);
        break;
      }
    }
    return Bound__(Range[0], -Range[0], sum_);
  }
}

void resetUniverse() {
  if (Rules_anim_b.activated)
    arrayCopy(UoD, mp);
  arrayCopy(EmptyUoD, UoD);
}

void update_2Dplot() {
  Launch2D_Update = true;
}


void update_3Dplot() {
  Launch3D_Update = true;
}
