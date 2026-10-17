void Perceive() {
  ClearOffline();
  appendOffline();
  loadTransferFunction();
  if (!discreteSys_b.activated) {
    if (BD_Index <= 1)
      FuzzyPIDBlockContinuous();
    else if (BD_Index == 2)
      OpenedLoopBlockContinuous();
    else if (BD_Index == 3)
      ClosedLoopBlockContinuous();
    removeZeroOffline();
    resetRug_kutta();
  } else {
    if (BD_Index <= 1)
      FuzzyPIDBlockDiscrete();
    else if (BD_Index == 2)
      OpenedLoopBlockDiscrete();
    else if (BD_Index == 3)
      ClosedLoopBlockDiscrete();
    removeParmetricZeros();
  }
  simTik = 0;
}

void appendOffline() {
  int times = (!discreteSys_b.activated) ? 1 : max(denomenator, nomenator);
  for (int i =0; i<= times; i ++) {
    offline_SetPoint.append(SetPoint);
    offline_sys.append(0);
    if (!discreteSys_b.activated)
      offline_E.append(Input.get(0));
    else
      offline_E.append(0);
    offline_dE.append(0);
    offline_er.append(0);
    offline_der.append(0);
    offline_ctr.append(0);
    offline_y1.append(0);
    offline_y2.append(0);
    offline_y3.append(0);
    offline_theta.append(0);
    offline_dtheta.append(0);
    offline_ddtheta.append(0);
  }
  Td = times - 1;
  PreviousDer = 0;
}

void removeZeroOffline() {
  offline_SetPoint.remove(0);
  offline_sys.remove(0);
  offline_er.remove(0);
  offline_der.remove(0);
  offline_E.remove(0);
  offline_dE.remove(0);
  offline_ctr.remove(0);
  offline_y1.remove(0);
  offline_y2.remove(0);
  offline_y3.remove(0);
  offline_theta.remove(0);
  offline_dtheta.remove(0);
  offline_ddtheta.remove(0);
}


void removeParmetricZeros() {
  for (int i =1; i <= max(denomenator, nomenator); i ++) {
    offline_er.remove(0);
    offline_der.remove(0);
    offline_E.remove(0);
    offline_dE.remove(0);
  }
  offline_SetPoint.remove(0);
  offline_sys.remove(0);
  offline_er.remove(0);
  offline_der.remove(0);
  offline_E.remove(0);
  offline_dE.remove(0);
  offline_ctr.remove(0);
  offline_y1.remove(0);
  offline_y2.remove(0);
  offline_y3.remove(0);
  offline_theta.remove(0);
  offline_dtheta.remove(0);
  offline_ddtheta.remove(0);
}

void removeZeroONline() {
  online_SetPoint.remove(0);
  online_sys.remove(0);
  online_E.remove(0);
  online_dE.remove(0);
  online_er.remove(0);
  online_der.remove(0);
  online_ctr.remove(0);
  online_y1.remove(0);
  online_y2.remove(0);
  online_y3.remove(0);
}
void ClearOnline() {
  online_SetPoint.clear();
  online_sys.clear();
  online_er.clear();
  online_der.clear();
  online_E.clear();
  online_dE.clear();
  online_ctr.clear();
  online_y1.clear();
  online_y2.clear();
  online_y3.clear();
  RTPy1 = debugY1 = debugY2 = debugY3 = 0;
  yout1 = yout2 = yout3  = 0;
}

void Clearrecord() {
  recorded_SetPoint.clear();
  recorded_sys.clear();
  recorded_er.clear();
  recorded_der.clear();
  recorded_ctr.clear();
  recorded_y1.clear();
  recorded_y2.clear();
  recorded_y3.clear();
}

void ClearOffline() {
  offline_SetPoint.clear();
  offline_sys.clear();
  offline_E.clear();
  offline_dE.clear();
  offline_er.clear();
  offline_der.clear();
  offline_ctr.clear();
  offline_y1.clear();
  offline_y2.clear();
  offline_y3.clear();
  offline_theta.clear();
  offline_dtheta.clear();
  offline_ddtheta.clear();
  Td = 0;
  PreviousDer = 0;
  RTPy1 = debugY1 = debugY2 = debugY3 = 0;
  resetRug_kutta();
}

void stopDebug() {
  ClearOffline();
  appendOffline();
  newChangeHappened = true;
  resetDebug = false;
}
