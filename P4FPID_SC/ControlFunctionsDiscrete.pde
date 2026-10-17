void OpenedLoopBlockDiscrete() {
  int begin = max(denomenator, nomenator);
  for (int j= 1+begin; j<=simulationSteps; j++) {
    offline_SetPoint.set(j-begin-1, Input.get(j-begin-1));
    U = Input.get(j-1);
    offline_ctr.set(j, U);
    offline_sys.set(j, (float) BuildDescreteSystemOutput(j));
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////


void ClosedLoopBlockDiscrete() {
  int begin = max(denomenator, nomenator);
  for (int j= begin + 1; j<=simulationSteps; j++) {
    offline_SetPoint.set(j-begin-1, Input.get(j-begin-1));
    offline_er.set(j, Input.get(j-1) - offline_sys.get(j-begin));
    U = Bound__(MaxSaturations[2], 0, offline_er.get(j));
    offline_ctr.set(j, U);
    offline_sys.set(j, (float) BuildDescreteSystemOutput(j));
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////


void FuzzyPIDBlockDiscrete() {
  float y1 = 0;
  float Py1 = 0;
  float y2 = 0;
  float y3 = 0;
  float PreviousDerivative = 0;
  int begin = max(denomenator, nomenator);
  for (int j= 1+begin; j <= simulationSteps; j++) {
    offline_E.set(j, Input.get(j-1)-offline_sys.get(j-begin));
    offline_dE.set(j, offline_E.get(j)-offline_E.get(j-1));

    offline_er.set(j, Bound__(Range[1], -Range[1], Ke*offline_E.get(j)*Range[1]/MaxSaturations[0]));
    PreviousDerivative = (1 - filterGain) * offline_dE.get(j) - filterGain * PreviousDerivative;

    offline_der.set(j, Bound__(Range[2], -Range[2], Kde*(PreviousDerivative)*Range[2]/MaxSaturations[1]));
    inference(offline_er.get(j), offline_der.get(j));
    offline_SetPoint.set(j-begin-1, Input.get(j-begin-1));

    y1 = Defuzzification()*MaxSaturations[2]/Range[0];
    y2 = Py1 + y1;
    y3 = offline_E.get(j-1)  + offline_E.get(j);

    offline_y1.set(j, Bound__(MaxSaturations[2], -MaxSaturations[2], Ky1*y1));
    offline_y2.set(j, Bound__(MaxSaturations[2], 0, y2*Ky2));
    offline_y3.set(j, Bound__(MaxSaturations[2], 0, y3*Ky3));

    if (BD_Index == 0)
      U = Bound__(MaxSaturations[2], 0, offline_y1.get(j) + offline_y2.get(j));
    else
      U = Bound__(MaxSaturations[2], 0, offline_y1.get(j) + offline_y3.get(j));


    offline_ctr.set(j, U);
    offline_sys.set(j, (float) BuildDescreteSystemOutput(j));
    resetUniverse();
    Py1 = y1;
  }
}


void FuzzyPIDAnimationDiscrete() {
  Sleeping = false;
  sleepingTimer =0;
  float y1 = 0;
  float y2 = 0;
  float y3 = 0;
  int begin = max(denomenator, nomenator);
  offline_E.set(Td, Input.get(Td-1)-offline_sys.get(Td-begin));
  offline_dE.set(Td, offline_E.get(Td)-offline_E.get(Td-1));

  offline_er.set(Td, Bound__(Range[1], -Range[1], Ke*offline_E.get(Td)*Range[1]/MaxSaturations[0]));
  PreviousDer = (1 - filterGain) * offline_dE.get(Td) - filterGain * PreviousDer;
  offline_der.set(Td, Bound__(Range[2], -Range[2], Kde*(PreviousDer)*Range[2]/MaxSaturations[1]));
  inference(offline_er.get(Td), offline_der.get(Td));
  offline_SetPoint.set(Td, Input.get(Td));

  y1 = Defuzzification()*MaxSaturations[2]/Range[0];
  y2 = debugY1 + y1;
  y3 = offline_E.get(Td-1) + offline_E.get(Td);


  offline_y1.set(Td, Bound__(MaxSaturations[2], -MaxSaturations[2], Ky1*y1));
  offline_y2.set(Td, Bound__(MaxSaturations[2], 0, y2*Ky2));
  offline_y3.set(Td, Bound__(MaxSaturations[2], 0, y3*Ky3));

  if (BD_Index == 0)
    U = Bound__(MaxSaturations[2], 0, offline_y1.get(Td) + offline_y2.get(Td));
  else
    U = Bound__(MaxSaturations[2], 0, offline_y1.get(Td) + offline_y3.get(Td));


  offline_ctr.set(Td, U);
  offline_sys.set(Td, (float) BuildDescreteSystemOutput(Td));
  resetUniverse();
  debugY1 = y1;
}
