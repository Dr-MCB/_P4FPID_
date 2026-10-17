void OpenedLoopBlockContinuous() {
  for (int j=1; j<=simulationSteps; j++) {
    //float hgh = random(0.5, 1);
    offline_SetPoint.set(j-1, Input.get(j-1));
    U = Input.get(j-1);
    U = Bound__(MaxSaturations[2], -MaxSaturations[2], U);
    offline_ctr.set(j, U);
    offline_sys.set(j, (float) RungKutta());

    offline_theta.set(j, UTheta);

    if (j>1)
      offline_dtheta.set(j, (offline_theta.get(j) - offline_theta.get(j-1))/Ts); //A_Rang_kutta_
    else
      offline_dtheta.set(j, 0);

    if (j>2)
      offline_ddtheta.set(j, 0.25*(offline_dtheta.get(j) - offline_dtheta.get(j-1))/Ts);
    else
      offline_ddtheta.set(j, 0);
  }
}


void ClosedLoopBlockContinuous() {
  for (int j=1; j<=simulationSteps; j++) {
    offline_SetPoint.set(j-1, Input.get(j-1));
    U = Input.get(j-1) - offline_sys.get(j-1);
    offline_er.set(j, U);
    U = Bound__(MaxSaturations[2], -MaxSaturations[2], U);
    offline_ctr.set(j, U);
    offline_sys.set(j, (float) RungKutta());

    offline_theta.set(j, UTheta*offline_sys.get(j));

    if (j>1)
      offline_dtheta.set(j, (offline_theta.get(j) - offline_theta.get(j-1))/Ts);
    else
      offline_dtheta.set(j, 0);

    if (j>2)
      offline_ddtheta.set(j, l1/l2*(offline_dtheta.get(j) - offline_dtheta.get(j-1))/Ts);
    else
      offline_ddtheta.set(j, 0);
  }
}


void FuzzyPIDBlockContinuous() {
  float y1 = 0;
  float y2 = 0;
  float y3 = 0;
  float PreviousDerivative = 0;
  ErSum = ErTimeSum= 0;
  for (int j= 1; j<=simulationSteps; j++) {
    offline_E.set(j, Input.get(j-1)-offline_sys.get(j-1));
    offline_dE.set(j, (offline_E.get(j)-offline_E.get(j-1))/Ts);
    offline_er.set(j, Bound__(Range[1], -Range[1], Ke*offline_E.get(j)*Range[1]/MaxSaturations[0]));
    PreviousDerivative = (1 - filterGain)  * offline_dE.get(j) + filterGain * PreviousDerivative;
    offline_der.set(j, Bound__(Range[2], -Range[2], Kde*(PreviousDerivative)*Range[2]/MaxSaturations[1]));

    inference(offline_er.get(j), offline_der.get(j));
    offline_SetPoint.set(j-1, Input.get(j-1));

    y1 = Defuzzification()/100;
    y2 = y2 + y1*Ts;
    y3 = y3 + offline_E.get(j)*Ts;

    offline_y1.set(j, Bound__(MaxSaturations[2], -MaxSaturations[2], y1*Ky1));
    offline_y2.set(j, Bound__(MaxSaturations[2], -MaxSaturations[2], y2*Ky2));
    offline_y3.set(j, Bound__(MaxSaturations[2], -MaxSaturations[2], y3*Ky3));

    if (BD_Index == 0)
      U = Bound__(MaxSaturations[2], -MaxSaturations[2], offline_y1.get(j) + offline_y2.get(j));
    else
      U = Bound__(MaxSaturations[2], -MaxSaturations[2], offline_y1.get(j) + offline_y3.get(j));

    offline_ctr.set(j, U);
    offline_sys.set(j, (float) RungKutta());
    resetUniverse();

    offline_theta.set(j, UTheta);
    if (j>1)
      offline_dtheta.set(j, (offline_theta.get(j) - offline_theta.get(j-1))/Ts);
    else
      offline_dtheta.set(j, 0);

    float converter = 1;
    if (j>2)
      offline_ddtheta.set(j, converter*(offline_dtheta.get(j) - offline_dtheta.get(j-1))/Ts);
    else
      offline_ddtheta.set(j, 0);
  }
}


void FuzzyPIDAnimationContinuous() {
  Sleeping = false;
  sleepingTimer =0;
  if (noisyWinds.activated)
    PerlineX.append(map(noise(simTik*Ts), 0, 1, Bmin, Bmax));
  else
    PerlineX.append(constB);
  offline_E.set(Td, Input.get(Td-1)-offline_sys.get(Td-1));
  offline_dE.set(Td, (offline_E.get(Td)-offline_E.get(Td-1))/Ts);

  offline_er.set(Td, Bound__(Range[1], -Range[1], Ke*offline_E.get(Td)*Range[1]/MaxSaturations[0]));
  PreviousDer = (1 - filterGain)  * offline_dE.get(Td) + filterGain * PreviousDer;
  offline_der.set(Td, Bound__(Range[2], -Range[2], Kde*(PreviousDer)*Range[2]/MaxSaturations[1]));
  inference(offline_er.get(Td), offline_der.get(Td));
  offline_SetPoint.set(Td-1, Input.get(Td-1));

  debugY1 = Defuzzification()*MaxSaturations[2]/Range[0];
  debugY2 = debugY2 + debugY1*Ts;
  debugY3 = debugY3 + offline_E.get(Td)*Ts;

  offline_y1.set(Td, Bound__(MaxSaturations[2], -MaxSaturations[2], Ky1*debugY1));
  offline_y2.set(Td, Bound__(MaxSaturations[2], 0, debugY2*Ky2));
  offline_y3.set(Td, Bound__(MaxSaturations[2], 0, debugY3*Ky3));

  if (BD_Index == 0)
    U = Bound__(MaxSaturations[2], -MaxSaturations[2], offline_y1.get(Td) + offline_y2.get(Td));
  else
    U = Bound__(MaxSaturations[2], -MaxSaturations[2], offline_y1.get(Td) + offline_y3.get(Td));

  offline_ctr.set(Td, U*500);
  offline_sys.set(Td, (float) RungKutta());
  resetUniverse();

  offline_theta.set(Td, UTheta);
  if (Td>1)
    offline_dtheta.set(Td, (offline_theta.get(Td) - offline_theta.get(Td-1))/Ts);
  else
    offline_dtheta.set(Td, 0);

  float converter = 1;
  if (Td>2)
    offline_ddtheta.set(Td, converter*(offline_dtheta.get(Td) - offline_dtheta.get(Td-1))/Ts);
  else
    offline_ddtheta.set(Td, 0);
}


void OpenedLoopBlockContinuousAnimation() {
  for (int j=1; j<=simulationSteps; j++) {
    offline_SetPoint.set(j-1, Input.get(j-1));
    U = Input.get(j-1);
    U = Bound__(MaxSaturations[2], -MaxSaturations[2], U);
    offline_ctr.set(j, U);
    offline_sys.set(j, (float) RungKutta());
  }
}


void ClosedLoopBlockContinuousAnimation() {
  for (int j=1; j<=simulationSteps; j++) {
    offline_SetPoint.set(j-1, Input.get(j-1));
    U = Input.get(j-1) - offline_sys.get(j-1);
    offline_er.set(j, U);
    U = Bound__(MaxSaturations[2], -MaxSaturations[2], U);
    offline_ctr.set(j, U);
    offline_sys.set(j, (float) RungKutta());
  }
}
