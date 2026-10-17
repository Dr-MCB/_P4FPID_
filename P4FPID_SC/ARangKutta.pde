void loadTransferFunction() {
  for (int i=0; i<=denomenator; i++) {
    Deno_[i] = transfer_fct[denomenator - i][1];
  }
  for (int i=0; i<=nomenator; i++)
    Nome_[i] = transfer_fct[nomenator - i][0];
}


double RungKutta() {
  double s = 0;
  int order = int(ODE/2) + 1;
  simTik ++;
  if (ODE ==8)
    order = 6;
  if (!BABS.activated) {
    // calculating the Kj for each state Xi step by step all at once
    for (int j = 1; j <= order; j++) {
      for (int i = 1; i <= denomenator; i++) {
        if (i!=denomenator) {
          Rang_kutta_[i][j] = Rang_kutta_[i+1][0] + RK_Sum(i+1, j);
        } else {
          Rang_kutta_[i][j] = lastLineFunction(j-1);
        }
      }
    }
    // calculating the y for each state depending of the calculated Kjs
    for (int i=1; i<=denomenator; i++) {
      for (int j = 1; j <= order; j++)
        Rang_kutta_[i][0] += Ts * RK[ODE][0][j]*Rang_kutta_[i][j]/RK[ODE + 1][0][j];
    }

    for (int i=0; i<=nomenator; i++)
      s += Rang_kutta_[i+1][0] * Nome_[i];

    return s;
  } else {
    ////%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ////%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    Deno_[0] = Nome_[0] = constK*suplyVoltage/5;
    Deno_[1] = constT;
    Deno_[2] = 1;
    nomenator = 0;
    denomenator = 2;
  
    for (int j = 1; j <= order; j++) {
      for (int i = 1; i <= denomenator; i++) {
        if (i!=denomenator) {
          A_Rang_kutta_[i][j]= A_Rang_kutta_[i+1][0] + RK_SumA(i+1, j);
        } else {
          A_Rang_kutta_[i][j] = lastLineFunctionA(j-1);
        }
      }
    }

    for (int i=1; i<=denomenator; i++) {
      for (int j = 1; j <= order; j++)
        A_Rang_kutta_[i][0] += Ts * RK[ODE][0][j]*A_Rang_kutta_[i][j]/RK[ODE + 1][0][j];
    }

    s=0;
    for (int i=0; i<=nomenator; i++)
      s += A_Rang_kutta_[i+1][0] * Nome_[i];

    UTheta = (float) s;


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Nome_[0] = ballMass*0.001*9.8*l1/l2;
    Deno_[0] = 0;
    Deno_[1] = 0;
    if (solidBall.activated)
      Deno_[2] = ballMass*0.001*1.4;
    else
      Deno_[2] = ballMass*0.001*1.67;

    nomenator = 0;
    denomenator = 2;

    for (int j = 1; j <= order; j++) {
      for (int i = 1; i <= denomenator; i++) {
        if (i!=denomenator) {
          B_Rang_kutta_[i][j]= B_Rang_kutta_[i+1][0] + RK_SumB(i+1, j);
        } else {
          B_Rang_kutta_[i][j] = lastLineFunctionB(j-1);
        }
      }
    }

    for (int i=1; i<=denomenator; i++) {
      for (int j = 1; j <= order; j++)
        B_Rang_kutta_[i][0] += Ts * RK[ODE][0][j]*B_Rang_kutta_[i][j]/RK[ODE + 1][0][j];
    }
    s=0;
    for (int i=0; i<=nomenator; i++)
      s += B_Rang_kutta_[i+1][0] * Nome_[i];

    return s*100/l;
  }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

double lastLineFunctionA(int indexj) {
  double k=0;
  for (int i=1; i<=denomenator; i++) {
    k+= -Deno_[i-1] * (A_Rang_kutta_[i][0] + RK_SumA(i, indexj));
  }
  k+=U;
  k /= Deno_[denomenator];
  return k;
}


double RK_SumA(int I, int J) {
  double s = 0;
  for (int k = 1; k < J; k ++) {
    s += Ts * RK[ODE][k][J] * A_Rang_kutta_[I][J-k] / RK[ODE + 1][k][J];
  }
  return s;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////


double lastLineFunctionB(int indexj) {
  double k=0;
  for (int i=1; i<=denomenator; i++) {
    k+= -Deno_[i-1] * (B_Rang_kutta_[i][0] + RK_SumB(i, indexj));
  }
  k+=UTheta;
  if (debugStart_b.activated)
    k+= PerlineX.get(PerlineX.size()-1);
  else
    k+= PerlineX.get(simTik);
  k /= Deno_[denomenator];
  return k;
}

double RK_SumB(int I, int J) {
  double s = 0;
  for (int k = 1; k < J; k ++) {
    s += Ts * RK[ODE][k][J] * B_Rang_kutta_[I][J-k] / RK[ODE + 1][k][J];
  }
  return s;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



double lastLineFunction(int indexj) {
  double k=0;
  for (int i=1; i<=denomenator; i++) {
    k+= -Deno_[i-1] * (Rang_kutta_[i][0] + RK_Sum(i, indexj));
  }
  k+=U;
  k /= Deno_[denomenator];
  return k;
}

double RK_Sum(int I, int J) {
  double s = 0;
  for (int k = 1; k < J; k ++) {
    s += Ts * RK[ODE][k][J] * Rang_kutta_[I][J-k] / RK[ODE + 1][k][J];
  }
  return s;
}


void resetRug_kutta() {
  for (int i=0; i<= 6; i++)
    for (int j=0; j<=denomenator; j++)
      Rang_kutta_[j][i]=A_Rang_kutta_[j][i]=B_Rang_kutta_[j][i]=0;
}



void initializeRKMatrix() {
  float[][][]Ks = {
    {{0, 1, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////
    {{0, 1, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    {{0, 0, 1, 0, 0, 0, 0},
      {0, 0, 1, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////
    {{0, 1, 1, 0, 0, 0, 0},
      {0, 0, 2, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    {{0, 1, 4, 1, 0, 0, 0},
      {0, 0, 1, 2, 0, 0, 0},
      {0, 0, 0, -1, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////
    {{0, 6, 6, 6, 0, 0, 0},
      {0, 0, 2, 1, 0, 0, 0},
      {0, 0, 1, 1, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    {{0, 1, 2, 2, 1, 0, 0},
      {0, 0, 1, 1, 1, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////
    {{0, 6, 6, 6, 6, 0, 0},
      {0, 0, 2, 2, 1, 0, 0},
      {0, 0, 1, 1, 1, 0, 0},
      {0, 0, 1, 1, 1, 0, 0},
      {0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0}},
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    {{0, 16, 0, 6656, 28561, -9, 2},
      {0, 0, 1, 9, 7296, -845, -11},
      {0, 0, 0, 3, -7200, 3680, 1859},
      {0, 0, 0, 0, 1932, -8, -3544},
      {0, 0, 0, 0, 0, 439, 2},
    {0, 0, 0, 0, 0, 0, -8}},
    ////////////////////////////////////////////////////
    {{0, 135, 1, 12825, 56430, 50, 55},
      {0, 0, 4, 32, 2197, 4104, 40},
      {0, 0, 1, 32, 2197, 513, 4104},
      {0, 0, 1, 1, 2197, 1, 2565},
      {0, 0, 1, 1, 1, 216, 1},
    {0, 0, 1, 1, 1, 1, 27}}
  };

  for (int i = 0; i < 10; i ++)
    for (int j =0; j < 6; j ++)
      for (int l =0; l < 7; l ++)
        RK[i][j][l] = Ks[i][j][l];
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
double BuildDescreteSystemOutput(int T) {
  double y = 0;
  if (T>=denomenator) {
    for (int k=1; k <= denomenator; k++) {
      y -= Deno_[denomenator - k] * offline_sys.get(T-k);
    }
    for (int k=0; k <= nomenator; k++) {
      y += Nome_[nomenator - k] * offline_ctr.get(T-k);
    }
  }
  return y/Deno_[denomenator];
}

double X(int stateIndex, int Algoindex) {
  return Rang_kutta_[stateIndex][0] + RK_SumA(stateIndex, Algoindex);
}

double A_X(int stateIndex, int Algoindex) {
  return A_Rang_kutta_[stateIndex][0] + RK_SumA(stateIndex, Algoindex);
}

double B_X(int stateIndex, int Algoindex) {
  return B_Rang_kutta_[stateIndex][0] + RK_SumA(stateIndex, Algoindex);
}

//float J         = 0.1;      // inertia (kg.m^2)
//// torque constant
//float tau_max   = 1;         // max motor torque (N.m)
//float omega_max = 7;       // rad/s
//float alpha_max = 150;       // rad/s^2

//for (int j = 1; j <= order; j++) {
//  A_Rang_kutta_[1][j] = DBound__(A_X(2, j), omega_max);
//  double saturatedAcc = DBound__(Kt*(U - A_X(1, j)), tau_max);
//  A_Rang_kutta_[2][j] = DBound__((saturatedAcc - B*A_X(2, j))/J, alpha_max);
//}

//for (int j = 1; j <= order; j++) {
//  A_Rang_kutta_[1][0] += Ts * RK[ODE][0][j]*A_Rang_kutta_[1][j]/RK[ODE + 1][0][j];
//  A_Rang_kutta_[2][0] += Ts * RK[ODE][0][j]*A_Rang_kutta_[2][j]/RK[ODE + 1][0][j];
//}
