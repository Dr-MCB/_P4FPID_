void mouseMoved() {
  Sleeping = false;
  sleepingTimer =0;
}

void MainInterfaceMousePressed() {
  Sleeping = false;
  sleepingTimer =0;
  if (dispIndex ==1) {
    if (discreteSys_b.press() && !debugStart_b.activated && !UART_b.activated) {
      discreteSys_b.activated = !discreteSys_b.activated;
      update_2Dplot();
    } else if (B_DLeft_b.press()) {
      BD_Index = abs((BD_Index - 1)) % 4;
    } else if (B_DRight_b.press()) {
      BD_Index = abs((BD_Index + 1)) % 4;
    }
  } else if (dispIndex ==2) {
    if (fixedWinds.press()) {
      fixedWinds.activated = !fixedWinds.activated;
      noisyWinds.activated = !fixedWinds.activated;
      resetPerlineNoise();
      update_2Dplot();
    } else if (noisyWinds.press()) {
      noisyWinds.activated = !noisyWinds.activated;
      fixedWinds.activated = !noisyWinds.activated;
      resetPerlineNoise();
      update_2Dplot();
    } else if (solidBall.press()) {
      solidBall.activated = !solidBall.activated;
      hollowBall.activated = !solidBall.activated;
      update_2Dplot();
    } else if (hollowBall.press()) {
      hollowBall.activated = !hollowBall.activated;
      solidBall.activated = !hollowBall.activated;
      update_2Dplot();
    } else if (dispWinds.press()) {
      dispWinds.activated = !dispWinds.activated;
    } else if (resetWinds.press()) {
      resetPerlineNoise();
    } else if (AdaptiveC2_b.press()) {
      AdaptiveC2_b.activated = !AdaptiveC2_b.activated;
      AdaptiveC_b.activated = AdaptiveC2_b.activated;
      update_2Dplot();
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  if (grid_b.press()) {
    grid_b.activated=!grid_b.activated;
  } else if (GraphUPDown_b[0].press())
    Y_Translation-=50;
  else if (GraphUPDown_b[1].press() ) {
    Y_Translation+=50;
  } else if (UART_b.press() && UARTenable_b.activated) {
    ClearOnline();
    Clearrecord();
    Rules_anim_b.activated = UART_b.activated = !UART_b.activated;
    myPort.clear();
    yout3 = yout2 = yout1 = 0;
    RTPreviousDer = 0;
    ClearOnline();
    Clearrecord();
    debugStart_b.activated = false;
    timeTick = 0;
    online_dE.append(0);
    online_E.append(0);
    if (keyPressed && key == 'R') {
      dataRecord_b[0].activated = true;
    }
  } else if (UARTenable_b.press() && ComState && !UART_b.activated) {
    ClearOnline();
    Clearrecord();
    RTPreviousDer = 0;
    SerialTimeLug = 0;
    UARTenable_b.activated = !UARTenable_b.activated;
    if (!UARTenable_b.activated) {
      dataRecord_b[0].activated = UART_b.activated = false;
    } else {
      SerialConversation.clear();
      VscrBar.reset();
    }
    if (UARTenable_b.strokeweight == 5) {
      boolean errorAcured = false;
      char[] StartPacket = {'(', 's', 't', 'a', 'r', 't', ')'};
      char[] StopPacket  = {'(', 's', 't', 'o', 'p', ')'};
      if (UARTenable_b.activated)
        for (int i =0; i < 7; i ++) {
          try {
            myPort.write(StartPacket[i]);
          }
          catch (Exception e) {
            UARTenable_b.activated = UART_b.activated = false;
            errorAcured = true;
            break;
          }
        } else {
        for (int i =0; i < 6; i ++) {
          try {
            myPort.write(StopPacket[i]);
          }
          catch (Exception e) {
            UARTenable_b.activated = UART_b.activated = false;
            errorAcured = true;
            break;
          }
        }
      }
      if (errorAcured) {
        UARTenable_b.stroke = color(0);
        UARTenable_b.strokeweight = 2;
        UARTenable_b.x -= 2.5;
        UARTenable_b.sizex += 5;
        UARTenable_b.y -= 2.5;
        UARTenable_b.sizey += 5;
      }
    }
  }
  if (B_DMove_b.press()) {
    BD_Index = (BD_Index + 1) % 4;
    update_2Dplot();
  } else if (graphSave_b.press()) {
    saveGraph();
  } else if (Process_b.press())
    Process_b.activated = !Process_b.activated;

  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////


  if (!surface_3D) {
    if (debugStart_b.press() && BD_Index <= 1 && !UART_b.activated) {
      Rules_anim_b.activated = debugStart_b.activated = !debugStart_b.activated;
      yout3 = yout2 = yout1 = 0;
      //PerlineX.clear();
      refA1 = -40;//MF[(maxs[0] + 1)/2][0].a1;
      refA4 =  40;//MF[(maxs[0] + 1)/2][0].a4;
      refWidth = abs(refA4 -refA1)/2;
      MF[(maxs[0]+1)/2][0].a2 = MF[(maxs[0]+1)/2][0].a3 =0;
      if (debugStart_b.activated && resetDebug) {
        LaunchDebugThread();
        PerlineX.clear();
        PerlineX.append(map(noise(Td*Ts), 0, 1, Bmin, Bmax));
      }
      debugReset_b.activated = resetDebug = false;
      if (debugStart_b.activated && Td < 2)
        stopDebug();
    } else if (debugReset_b.press()&& !UART_b.activated) {
      debugReset_b.activated = debugStart_b.activated = false;
      resetDebug = true;
      resetPerlineNoise();
      ClearOffline();
      resetUniverse();
      resetRug_kutta();
      update_2Dplot();
      simTik = 0;
    } else if (debugUP_b.press()) {
      debugSpeed = IBound__(50, 5, debugSpeed - 5);
    } else if (debugDown_b.press()) {
      debugSpeed = IBound__(50, 5, debugSpeed + 5);
    } else if (blockDiagram_b.press()) {
      Umouse_b.activated = false;
      blockDiagram_b.activated = !blockDiagram_b.activated;
    } else if (Xmouse_b.press()) {
      Xmouse_b.activated = !Xmouse_b.activated ;
      Ymouse_b.activated = false;
      if (keyPressed && (key == 'x' || key == 'X'))
        adjustImax();
    } else if (Ymouse_b.press()) {
      Ymouse_b.activated = !Ymouse_b.activated ;
      Xmouse_b.activated = false;
      if (keyPressed && (key == 'y' || key == 'Y'))
        adjustVmax(offline_sys.max());
    } else if (Umouse_b.press() && (dispIndex ==0) && !debugStart_b.activated) {
      Umouse_b.activated = !Umouse_b.activated ;
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////


  if (UpInput_b.press()) {  ///////////////////////////////////////////////
    InputIndex = IBound__(InputMax, 1, InputIndex + 1);
  } else if (DownInput_b.press()) {
    InputIndex = IBound__(InputMax, 1, InputIndex - 1);
  } else if (AddInput_b.press()) {
    InputMax = IBound__(100, 1, InputMax + 1);
    resetAllInputs();
  } else if (SubInput_b.press()) {
    InputMax = IBound__(100, 1, InputMax - 1);
    resetAllInputs();
  } else if (pushInput_b.press()) {
    pushAllInputs();
  } else if (resetInput_b.press()) {
    reBuildInputs();
  }

  if (Umouse_b.activated) {
    for (int i =0; i < inputIntervals.size()-1 && rmouseY > 250 && rmouseY < 280; i ++) {
      if (rmouseX >= 40 + inputIntervals.get(i)*600/simulationSteps
        && rmouseX < 40 + inputIntervals.get(i+1)*600/simulationSteps
        ) {
        InputIndex = i+1;
      }
    }
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////


  for (int i =0; i <3; i ++) {
    if (range_b[i].press()) {
      range_b[i].activated = !range_b[i].activated;
      if ((keyPressed && keyCode == TAB) || shapes2_b[2].activated || shapes2_b[4].activated ) {
        range_b[0].activated = range_b[1].activated = range_b[2].activated = range_b[i].activated;
        break;
      }
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////


  for (int j=0; j<10; j++) {
    if (shapes_b[j].press()) {
      if (j<3) {
        MFtype=j+1;
      } else if (j==3) {
        symmetry=!symmetry;
      } else if (j >= 5 && j <= 8) {
        int start = selectedRec -1;
        int end = selectedRec;
        if ((keyPressed && keyCode ==  TAB) || shapes2_b[2].activated || shapes2_b[4].activated) {
          start = 0;
          end = 3;
        }
        for (int ii=start; ii<end && j==5; ii++) {
          Randomize_fcts(ii);
        }
        for (int ii=start; ii<end && j==6; ii++) {
          optimize_fcts(ii);
        }
        for (int ii=start; ii<end && j==7; ii++) {
          PushOUT_fcts(ii);
        }
        for (int ii=start; ii < end && j==8; ii++) {
          if (!PushALL) {
            PushMFsTrapo(ii);
          }
          if (ii == end-1)
            PushALL = !PushALL;
        }
        update_2Dplot();
      } else if (j==4 ) {
        NormalityEnabled=!NormalityEnabled;
      } else if (j==9 ) {
        LinkedMF=!LinkedMF;
      }

      break;
    } else if (shapes2_b[j].press()) {
      if  ( j < 6) {
        shapes2_b[j].activated = !shapes2_b[j].activated;
      } else if ( j < 8) {
        int start = selectedRec -1;
        int end = selectedRec;
        if ((keyPressed && keyCode ==  TAB) || shapes2_b[2].activated || shapes2_b[4].activated) {
          start = 0;
          end = 3;
        }
        for (int ii=start; ii<end && j==6; ii++) {
          separate_fcts(ii);
          update_2Dplot();
        }
        for (int ii=start; ii<end && j==7; ii++) {
          PushIN_fcts(ii);
          update_2Dplot();
        }
      } else if (j==8) {
        face++;
        for (int i =0; i < 5; i ++)
          GainAdjust_b[i].activated = false;
        int maxFace = (dispIndex == 2)? 3:4;
        if (face>maxFace)
          face=1;
      } else if (j==9) {
        face--;
        for (int i =0; i < 5; i ++)
          GainAdjust_b[i].activated = false;
        if (face==0)
          if (dispIndex == 2)
            face = 3;
          else
            face=4;
      }
      if (j<5)
        for (int i =0; i < 5; i++)
          if ( j != i)
            shapes2_b[i].activated = false;
    }
  }


  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////


  for (int j=0; j<18; j++) {
    if (fctsbtn_b[j].press() && MFtype!=0) {
      int ii=j/6;
      int i = j%6;
      if (ii+1>2)
        ii=0;
      else
        ii++;
      switch(i) {
      case 3:
        {
          if (fs[ii]>0.1)
            fs[ii]-=0.1;
          break;
        }
      case 2:
        {
          if (fs[ii]<2.9)
            fs[ii]+=0.1;
          break;
        }
      case 5:
        {
          if (maxs[ii]>3)
            maxs[ii]-=2;
          high[ii]=0;
          break;
        }
      case 4:
        {
          if (maxs[ii]<11)
            maxs[ii]+=2;
          high[ii]=0;
          break;
        }
      case 1:
        {
          if ( 100-5*(high[ii]+1)*(maxs[ii]-1)/2 > 0) {
            high[ii]++;
            if ((keyPressed && keyCode == TAB) || shapes2_b[2].activated || shapes2_b[4].activated) {
              for (int k =0; k <3; k++) {
                high[k] =high[ii];
                tandence_generator(k);
              }
            } else
              tandence_generator(ii);
          }
          break;
        }
      case 0:
        {
          if ( 100+5*(high[ii]-1)*(maxs[ii]-1)/2>0) {
            high[ii]--;
            if ((keyPressed && keyCode == TAB) || shapes2_b[2].activated || shapes2_b[4].activated) {
              for (int k =0; k <3; k++) {
                high[k] =high[ii];
                tandence_generator(k);
              }
            } else
              tandence_generator(ii);
          }
          break;
        }
      }
      tablei=tablej=1;
      if (i>1)
        setting_up_membershipfunctions(ii);
      update_2Dplot();
      break;
    }
  }
}

void adjustImax() {
  dragged_I = 0;
  int timeMax = offline_sys.size();
  if ((timeMax+1)*Imax > 600) {
    while ((timeMax+1)*Imax > 600 && Imax > 0.5)
      Imax -= 0.5;
  } else if ((timeMax+1)*Imax < 600) {
    while ((timeMax+1)*Imax < 600 && Imax < 100)
      Imax += 0.5;
  }
}

void adjustVmax(float sysMax) {
  Y_Translation = -30;
  if (sysMax <= 1)
    Vmax = 1;
  else if (sysMax <= 10)
    Vmax = 10;
  else if (sysMax <= 50)
    Vmax = 50;
  else if (sysMax <= 100)
    Vmax = 100;
  else if (sysMax <= 150)
    Vmax = 150;
  else if (sysMax <= 200)
    Vmax = 200;
  else if ( sysMax <= 500)
    Vmax = 500;
  else
    Vmax = 1000;
}

void MainInterfaceMouseReleased() {
  if (mousePressCatched==false) {
    mousePressCatched=true;
    MF[maxs[iinumber]+1-inumber][iinumber].state=false;
    for (int i =1; i <=4; i++)
      MF[draggedMF_index][draggedMV_I].setParameter(int(MF[draggedMF_index][draggedMV_I].getParameter(i)), i);
    if (surface_3D)
      update_3Dplot();
  }
  UART_b.release();
  fixedWinds.release();
  noisyWinds.release();
  solidBall.release();
  hollowBall.release();
  resetWinds.release();
  dispWinds.release();
  AdaptiveC2_b.release();
  //if (blockDiagram_b.activated)
  //  discreteSys_b.release();
  for (int i=0; i<18; i++) {
    if (i<10) {
      shapes_b[i].release();
      shapes2_b[i].release();
    }
    if (i<3) {
      MFsGA_b[i].release();
      WeiGA_b[i].release();
      range_b[i].release();
    }
    if (i<2)
      GraphUPDown_b[i].release();
    if (i < 6)
      optSide_b[i].release();
    fctsbtn_b[i].release();
  }
  UART_b.release();
  UARTenable_b.release();
  for (int i=0; i<5 && face==1; i++) {
    rulesbuttons_b[i].release();
  }
  grid_b.release();
  Xmouse_b.release();
  blockDiagram_b.release();
  Ymouse_b.release();
  Umouse_b.release();
  debugStart_b.release();
  B_DMove_b.release();
  graphSave_b.release();
  Process_b.release();
  debugReset_b.release();
  debugUP_b.release();
  debugDown_b.release();
  Python_b.release();
  Cpp_b.release();
  B_DLeft_b.release();
  B_DRight_b.release();

  if (Umouse_b.activated) {
    AddInput_b.release();
    SubInput_b.release();
    UpInput_b.release();
    DownInput_b.release();
    resetInput_b.release();
    pushInput_b.release();
  }
}
