void keyPressed() {
  Sleeping = false;
  sleepingTimer =0;
  if (keyCode==ENTER) {
    if (name_index!=0 && typing_counter>0) {
      String newname=String.copyValueOf(typing, 0, typing_counter);
      if (name_index==1) {
        MF[inumber][iinumber].name = newname;
        MF[inumber][iinumber].state = false;
      } else if (name_index==3) {
        fileName = newname;
        name_index=0;
      } else if (name_index==2 || (name_index == 10 || name_index == 11)) {
        settingbounds();
        newChangeHappened  = true;
      } else if (name_index== 40) {
        SetPoint=float(newname);
        inputRanges.set(inputRanges.size() - 1, SetPoint);
        BuildStepInputs();
      } else if (name_index== 41) {
        Ke=float(newname);
        if (surface_3D && surfaceGains_b.activated)
          update_3Dplot();
      } else if (name_index== 42) {
        Kde=float(newname);
        if (surface_3D && surfaceGains_b.activated)
          update_3Dplot();
      } else if (name_index== 43) {
        Ky1=float(newname);
        if (surface_3D && surfaceGains_b.activated)
          update_3Dplot();
      } else if (name_index== 44) {
        Ky2=float(newname);
      } else if (name_index== 45) {
        Ky3=float(newname);
      } else if (name_index== 46) {
        step=float(newname);
      } else if (name_index== 62 && InputMax > 1 && InputIndex != InputMax) {
        inputIntervals.set(InputIndex,
          Bound__(inputIntervals.get(InputIndex+1) - 10,
          inputIntervals.get(InputIndex-1) + 10,
          float(newname)/Ts));
        BuildStepInputs();
      } else if (name_index== 63) {
        inputRanges.set(InputIndex - 1, float(newname));
        BuildStepInputs();
      } else if (name_index >= 70 && name_index <= 72) {
        VariableSaturations[name_index - 70]=float(newname);
      } else if (name_index >= 50 && name_index <= 52) {
        MaxSaturations[name_index - 50]=float(newname);
      } else if (name_index== 14) {
        if (int(newname)>200)
          newname="200";
        individuals=int(newname);
      } else if (name_index== 15) {
        generation =int(newname);
      } else if (name_index== 16) {
        G_A.mutationProbability =float(newname);
      } else if (name_index == 9) {
        if (!serial_state) {
          ClearOffline();
          if (float(newname) > 0 ) {
            Ts=float(newname);
            filterGain = tau/ (tau + Ts);
            tau = filterGain * Ts/(1 - filterGain);
            simulationSteps = int(simulationTime/Ts);
            reBuildInputs();
            resetPerlineNoise();
          }
        }
      } else if (name_index == 18) {
        GainsMin =float(newname);
      } else if (name_index == 19) {
        GainsMax =float(newname);
      } else if (name_index == 25) {
        simulationTime = int(newname);
        simulationSteps = int(simulationTime/Ts);
        ClearOffline();
        reBuildInputs();
        resetPerlineNoise();
      } else if (name_index == 26) {
        if (!opt_var[1].activated)
          minWei = int(Bound__(maxWei, 0, int(newname)));
        else
          GASatMin = int(Bound__(GASatMax - 10, 0, int(newname)));
      } else if (name_index == 27) {
        if (!opt_var[1].activated)
          maxWei = int(Bound__(100, minWei + 1, int(newname)));
        else
          GASatMax= int(newname);
      } else if (name_index == 30)
        fitK = int(Bound__(100000, 1, int(newname)));
      else if (name_index == 31) {
        fitN = int(Bound__(10, 0, int(newname)));
      } else if (name_index == 32) {
        codename = newname;
      } else if (name_index == 33) {
        surfacename = newname;
      } else if (name_index == 34) {
        PanelSent = newname;
      } else if (name_index == 35) {
        filterGain = Bound__(0.9999, 0, float(newname));
        tau = filterGain * Ts/(1 - filterGain);
      } else if (name_index == 36 && !discreteSys_b.activated) {
        tau = Bound__(0.9999, 0, float(newname));
        filterGain = tau/ (tau + Ts);
      } else if (name_index == 37) {
        movingStep = IBound__(20, 1, int(newname));
      } else if (name_index == 80) {
        l1 = Bound__(200, 20, 10*float(newname));
        update_2Dplot();
      } else if (name_index == 81) {
        l2 = Bound__(500, 20, 10*float(newname));
        update_2Dplot();
      } else if (name_index == 82) {
        ballMass = float(newname);
        update_2Dplot();
      } else if (name_index == 83) {
        ballRaduis = float(newname);
        update_2Dplot();
      } else if (name_index == 84) {
        constB = float(newname);
        resetPerlineNoise();
        update_2Dplot();
      } else if (name_index == 85) {
        suplyVoltage = float(newname);
        update_2Dplot();
      } else if (name_index == 86) {
        constT = float(newname);
        update_2Dplot();
      } else if (name_index == 87) {
        constK = float(newname);
        update_2Dplot();
      } else if (name_index == 88) {
        constT = float(newname);
        update_2Dplot();
      } else if (name_index == 90) {
        Bmin = float(newname);
        resetPerlineNoise();
        update_2Dplot();
      } else if (name_index == 89) {
        Bmax = float(newname);
        resetPerlineNoise();
        update_2Dplot();
      } else if (name_index == 91) {
        thetaMax = float(newname);
      } else if (name_index == 92) {
        theta0 = float(newname);
      }
      typing_counter=0;
      update_2Dplot();
      name_index=0;
    }
  } else if (name_index == 0) {
    if (keyCode == TAB)
      shapes2_b[2].activated = shapes2_b[4].activated = true;
    else if (key == 'a' || key == 'A')
      shapes2_b[3].activated = true;
    else if (key == 'w' || key == 'W')
      shapes2_b[0].activated = true;
    else if (key == 'r' || key == 'R')
      shapes2_b[5].activated = !shapes2_b[5].activated;
    else if (key == 'z' || key == 'Z')
      shapes2_b[3].activated = true;
    else if (key == 'q' || key == 'Q')
      shapes2_b[1].activated = true;
    else if (key == 's')
      saveSVG = true;
    else if (key == 'o')
      ProcessIndex= (ProcessIndex + 1) % 4;
    else if (key == 'b') {
      pushFromEdge(0, 1, 3);
      for (int i = 1; i <= maxs[0]; i++) {
        MF[i][0].Shrink(i, maxs[0], fs[0], MF[i][0].type, gj);
      }
      MF[1][0].a1 = MF[1][0].a2 = -100;
      MF[9][0].a4 = MF[9][0].a3 =  100;
      gj-=10;
    } else if (key == 'g') {
      dispIndex = (dispIndex + 1) % 3;
      if (dispIndex == 2)
        face = 2;
    }

    if (Rules_Edit_b.activated && shapes2_b[5].activated && int(key-48) >=0 && int(key-48) <=9) {
      rules_Table[tablej-1][tablei-1] = int(key-48);
    }
  }
  HandlekeyCoded();
}



void keyTyped() {
  Sleeping = false;
  sleepingTimer =0;
  int maxSize = 20;
  if (name_index!=0) {
    if ((int(key)>=97 && int(key)<=122 || key==' ') && (name_index==1|| name_index==3 || (name_index>=32 && name_index<=34))) {
      typing[typing_counter]=key;
      if (name_index==32)
        maxSize = 14;
      else if (name_index==3)
        maxSize = 25;
      else if (name_index==34)
        maxSize = 15;
      if (typing_counter<maxSize) {
        typing_counter++;
      }
    } else if ((int(key)>=48 && int(key)<=57) || (int(key)>=65 && int(key)<=93)||key==';'||key==']'|| key=='/'|| key=='[' || key=='-'|| key=='.'
      && (name_index==2 || (name_index >= 10 && name_index <= 13))) {
      typing[typing_counter]=key; // setingbounds and transfer function
      typing_counter++;
    } else if (((int(key)>=48 && int(key)<=57) || (int(key)>=65 && int(key)<=93))|| key=='.' && (name_index>=4 && name_index <=100)) {
      typing[typing_counter]=key;  // control gains and GA parameters
      typing_counter++;
    }
  }
}


void HandlekeyCoded() {
  if (keyCode==BACKSPACE ) {
    if ( typing_counter>0) {
      typing_counter--;
    }
  } else if (keyCode==DELETE) {
    MF[inumber][iinumber].state=false;
    name_index=0;
    typing_counter=0;
  } else if (keyCode==RIGHT) {
    if (ruleEditing&& face==1)
      rulestext+=30;
    else if (!ruleEditing) {
      face++;
      if (face>4)
        face=1;
    }
  } else if (keyCode==LEFT) {
    if (ruleEditing&& face==1)
      rulestext-=30;
    else if (!ruleEditing) {
      face--;
      if (face<=0)
        face=3;
    }
  } else if (keyCode==UP) {
    if (ruleEditing && face==1 && ruleswheel>0) {
      ruleswheel--;
      tablej=ruleswheel%maxs[2]+1;
      tablei=ruleswheel/(maxs[2])+1;
    } else if (!ruleEditing && !surface_3D)
      Y_Translation +=50;
  } else if (keyCode==DOWN) {
    if (ruleEditing&& face==1 && tablei*tablej < maxs[1]*maxs[2]) {
      ruleswheel++;
      tablej=ruleswheel%maxs[2]+1;
      tablei=ruleswheel/(maxs[2])+1;
    } else if (!ruleEditing && !surface_3D)
      Y_Translation -=50;
  }
}
