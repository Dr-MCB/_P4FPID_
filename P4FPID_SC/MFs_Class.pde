class mbmfct {
  int n;
  int V;
  int mx;
  int type;
  int name_Size;
  float a1;
  float a2;
  float a3;
  float a4;
  float a12;
  float a23;
  float normality;
  float activation;
  float Gauss;
  boolean state;
  String name;
  int parameters;
  mbmfct() {
    name_Size=2;
    normality=100;
    mx=7;
  }
  void inifct(int i, int x, float z, int typemf) {
    n=i;
    mx=x;
    type=typemf;
    a1=-100+(i-1)*100*(((2+z)/mx)-z/(mx-1));
    a4=a1+100*(2+z)/mx;
    if (type!=3) {
      a2=(a1+a4)/2;
      a3=a2;
      parameters = 3;
    } else {
      a2=(a4-a1)/3+a1;
      a3=a4-(a4-a1)/3;
      parameters = 4;
    }
    RoundParameters();
    normality=100;
    Gauss = sqrt(log(3000));
    autonaming();
  }
  void RoundParameters() {
    a1 = refineParameter(a1);
    a2 = refineParameter(a2);
    a3 = refineParameter(a3);
    a4 = refineParameter(a4);
  }
  int refineParameter(float A) {
    if (A >0)
      return int(A);
    else
      return -int(abs(A));
  }
  void Shrink(int i, int x, float z, int typemf, float newRange) {
    n=i;
    mx=x;
    type=typemf;
    a1=-newRange+(i-1)*newRange*(((2+z)/mx)-z/(mx-1));
    a4=a1+newRange*(2+z)/mx;
    if (type!=3) {
      a2=(a1+a4)/2;
      a3=a2;
      parameters = 3;
    } else {
      a2=(a4-a1)/3+a1;
      a3=a4-(a4-a1)/3;
      parameters = 4;
    }
    RoundParameters();
  }



  void autonaming() {
    String tx1[]={"N", "ZE", "P"};
    String tx2[]={"NB", "N", "ZE", "P", "PB"};
    String tx3[]={"NB", "NM", "NS", "ZE", "PS", "PM", "PB"};
    String tx4[]={"NB", "NMB", "NMS", "NS", "ZE", "PS", "PMS", "PMB", "PB"};
    String tx5[]={"NVB", "NMB", "NMS", "NVS", "ZS", "ZE", "ZB", "PVS", "PMS", "PMB", "PVB"};
    name_Size=2;
    if (mx==3) {
      name=tx1[n-1];
    } else if (mx==5) {
      name=tx2[n-1];
    } else if (mx==7) {
      name=tx3[n-1];
    } else if (mx==9) {
      name=tx4[n-1];
      name_Size=3;
    } else if (mx==11) {
      name=tx5[n-1];
      name_Size=3;
    } else
      name=String.valueOf(n);
  }

  void settype(int newType, int F) {
    if (newType==3) {
      a2=(a4-a1)/3+a1;
      a3=a4-(a4-a1)/3;
      parameters =4;
    } else if (type==3 && newType!=3) {
      a2=(a4-a1)/2+a1;
      a3=a2;
      parameters =3;
    }
    if (n!=1)
      a2 = max(a2, MF[n-1][F].a3);
    else
      a2 = max(a2, a1);
    if (n != maxs[F])
      a3 = min(a3, MF[n+1][F].a2);
    else
      a3 = min(a3, a4);
    type=newType;
    RoundParameters();
  }

  float getParameter(int k) {
    switch (k) {
    case 1:
      return a1;
    case 2:
      return a2;
    case 3:
      return a3;
    case 4:
      return a4;
    }
    return 0;
  }

  void setParameter(float val, int k) {
    if (k == 1)
      a1 = val;
    else if (k == 4)
      a4 = val;
    else if (k == 2)
      a2= val;
    else
      a3 = val;
  }


  void setVal(float val, int k) {
    if (type < 3) {
      switch (k) {
      case 1:
        a1=val;
        break;
      case 2:
        a2=a3=val;
        break;
      case 3:
        a4=val;
        break;
      case 4:
        Gauss = map(abs(val), 0, 100, 1, 15);
        break;
      }
    } else {
      switch (k) {
      case 1:
        a1=val;
        break;
      case 2:
        a2=val;
        break;
      case 3:
        a3=val;
        break;
      case 4:
        a4=val;
        break;
      }
    }
  }
  void setfct(float u, float w) {
    float yy=0;
    if (Rules_anim_b.activated)
      activation = u*100;
    if (implication_method == 1) {
      if (type!=2) {
        a12=int(u*(a2-a1)+a1);
        a23=int(u*(a3-a4)+a4);
      } else if (type==2) {
        u= int(u*normality*w);
        a12=int(max(sqrt(2*log(int(normality*w)/u))*(a1-a2)/Gauss+a2, a1));
        a23=int(min(sqrt(2*log(int(normality*w)/u))*(a4-a2)/Gauss+a2, a4));
      }
    } else {
      a12=int(a2);
      a23=int(a3);
    }
    a12 = refineParameter(a12);
    a23 = refineParameter(a23);
    int A1  = int(a1*5+500);
    int A12 = int(a12*5+500);
    int A23 = int(a23*5+500);
    int A4  = int(a4*5+500);
    A1  = A1  -  A1%movingStep  + movingStep;
    A12 = A12 -  A12%movingStep + movingStep;
    A23 = A23 -  A23%movingStep + movingStep;
    A4  = A4  -  A4%movingStep;
    if (type!=2)
      u= u*normality*w;
    ///////////////////////////////////////////////////////////////////////////////
    for (int i=A1; i<A12; i+=movingStep) {
      float X = (i-500)/5;
      if (type!= 2)
        yy=((u)/(a12-a1))*(X-a1);
      else if (type==2) {
        if (implication_method ==1)
          yy=abs(Gaussian(X, a2, (a2-a1)/Gauss)*normality*w);
        else
          yy=Gaussian(X, a2, (a2-a1)/Gauss)*u;
      }
      if (aggregation_method == 1)
        UoD[i]= max(yy, UoD[i]);
      else
        UoD[i]= min(normality, yy + UoD[i]);
    }
    ///////////////////////////////////////////////////////////////////////////////
    for (int i=A12; i<A23; i+=movingStep) {
      if (aggregation_method == 1)
        UoD[i]= max(u, UoD[i]);
      else
        UoD[i]= min(normality, u + UoD[i]);
    }
    ////////////////////////////////////////////////////////////////////////////////
    for (int i=A23; i<A4; i+=movingStep) {
      float X = (i-500)/5;
      if (type!= 2 )
        yy=((-u)/(a4-a23))*(X-a4);
      else if (type==2) {
        if (implication_method  == 1)
          yy=abs(Gaussian(X, a2, (a4-a2)/Gauss)*normality*w);
        else
          yy=Gaussian(X, a2, (a4-a2)/Gauss)*u;
      }
      if (aggregation_method == 1)
        UoD[i]= max(yy, UoD[i]);
      else
        UoD[i]= min(normality, yy + UoD[i]);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////

  float getu(float x) {
    float returned_U=0;
    if (x>=a2 && x<=a3 && type==3) {
      returned_U=1;
    } else if (x<=a2) {
      if (type!=2)
        returned_U=((x-a1)/(a2-a1));
      else
        returned_U=Gaussian(x, a2, (a2-a1)/Gauss);
    } else if (x>a2) {
      if (type==1)
        returned_U=((x-a4)/(a2-a4));
      else if (type==2)
        returned_U=Gaussian(x, a2, (a4-a2)/Gauss);
      else if (type==3)
        returned_U=((x-a4)/(a3-a4));
    }
    if (Rules_anim_b.activated)
      activation = returned_U*100;
    return returned_U*normality/100;
  }
}
void importDefualtFile() {
  import_Path = "Data/Default File";
  datarestore();
  import_Path = "Data/";
  for (int i=0; i<=2; i++)
    bs[i]=(maxs[i]+1) /2;
  simulationSteps = int(simulationTime/Ts);
  resetPerlineNoise();
  MFtype=0;
}

void setUpFisDisplay() {
  MVB[0] = new MVBox(0, 0, 0, 650, 200, 325, 140);
  MVB[1] = new MVBox(1, 650, 0, 1300, 200, 975, 140);
  MVB[2] = new MVBox(2, 650, 200, 1300, 400, 975, 340);
  for (int i=0; i<=2; i++) {
    maxs[i]=13;
    bs[i]=7;
    fs[i]=0.6;
  }
  MFtype=2;
  for (int i=0; i<=14; i++) {
    MF[i][0]=new mbmfct();
    MF[i][1]=new mbmfct();
    MF[i][2]=new mbmfct();
  }
  MFtype=1;
  for (int i=0; i<=2; i++)
    setting_up_membershipfunctions(i);
  for (int i=0; i<=2; i++) {
    maxs[i]=3;
    bs[i]=2;
    fs[i]=0.6;
  }
  for (int i=0; i<=2; i++) {
    MFtype = 1;
    setting_up_membershipfunctions(i);
  }
  //setup_Rules(maxs[0]);
  Gain_max_GA[0] = Gain_max_GA[1] = Gain_max_GA[2] = 10;
  MFtype=0;
}
