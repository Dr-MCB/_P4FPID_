void Interface2MousePressed() {
  int s =0;
  VscrBar.press(rmouseX, rmouseY);
  for (int i=0; i<5; i++) {
    if (GainOpt_b[i].activated)
      s++;
  }
  for (int i=0; i<5 && GA_Progression == 0; i++) {
    if (opt_var[1].activated) {
      if (GainOpt_b[i].press())
        if (!(GainOpt_b[i].activated && s == 2))
          GainOpt_b[i].activated = ! GainOpt_b[i].activated;
    } else {
      if (GainAdjust_b[i].press()) {
        GainAdjust_b[i].activated = ! GainAdjust_b[i].activated ;
        for (int j =0; j < 5; j ++)
          if (i!=j)
            GainAdjust_b[j].activated = false;
      }
    }
  }


  for (int i=0; i<6 && GA_Progression == 0; i++) {
    int right = 0, left = 0;
    if (Gain_plus_b[i].press()) {
      right = -1;
    } else if (Gain_minus_b[i].press()) {
      left = 1;
    }
    if (left != 0 || right != 0) {
      if (i == 0) {
        SetPoint+= right*step + left*step;
        reBuildInputs();
        update_2Dplot();
      } else if (i == 1) {
        Ke+=right*step + left*step;
        update_2Dplot();
        if (surfaceGains_b.activated) {
          update_3Dplot();
        }
      } else if (i == 2) {
        Kde+=right*step + left*step;
        update_2Dplot();
        if (surfaceGains_b.activated) {
          update_3Dplot();
        }
      } else if (i == 3) {
        Ky1+=right*step + left*step;
        update_2Dplot();
        if (surfaceGains_b.activated) {
          update_3Dplot();
        }
      } else if (i == 4) {
        Ky2+=right*step + left*step;
        update_2Dplot();
      } else if (i == 5) {
        Ky3+=right*step + left*step;
        update_2Dplot();
      }
    }
  }
  if (dataSave_b[0].press()) {
    savedata(0);
  } else if (dataSave_b[1].press()) {
    savedata(1);
  } else if (dataSave_b[2].press()) {
    import_Path = "Data";
    datarestore();
    update_2Dplot();
  } else if (dataRecord_b[0].press() && UART_b.activated) {
    if (dataRecord_b[0].activated) {
      Clearrecord();
      recTime = 0;
    }
    dataRecord_b[0].activated = !dataRecord_b[0].activated;
  } else if (dataRecord_b[1].press() && UART_b.activated) {
    saveRecordedData();
    Clearrecord();
    recTime = 0;
  } else if (dataRecord_b[2].press()) {
    import_Path = "Data/Default File";
    datarestore();
    update_2Dplot();
  } else if (sentToSerial_b.press() && UARTenable_b.activated) {
    SerialConversation.append("Sent: (<" + PanelSent + ">)");
    myPort.write("(<" + PanelSent + ">)");
  } else if (tfUpload_b.press()) {
    uploadTransferFunction();
    update_2Dplot();
  } else if (BABS.press()) {
    BABS.activated = !BABS.activated;
    update_2Dplot();
  } else if (BABModelParmetersSdisp.press()) {
    BABModelParmetersSdisp.activated = !BABModelParmetersSdisp.activated;
  }
}

void Interface2MouseReleased() {
  for (int i=0; i<9; i++) {
    if (i <8)
      GainOpt_b[i].release();
    Gain_plus_b[i].release();
    Gain_minus_b[i].release();
    if (i<3) {
      dataSave_b[i].release();
      dataRecord_b[i].release();
      KPplus_b[i].release();
      KPminus_b[i].release();
    }
    if (i < 5)
      GainAdjust_b[i].release();
  }
  sentToSerial_b.release();
  VscrBar.release();
  tfUpload_b.release();
  BABS.release();
  BABModelParmetersSdisp.release();
}
