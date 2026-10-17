void Interface1MousePressed() {
  if (surfaceRot_b.press() && surface_3D) {
    surfaceRot_b.activated = !surfaceRot_b.activated;
  } else if (surfaceGrid_b.press()) {
    surfaceGrid_b.activated = !surfaceGrid_b.activated;
  } else if (surfaceGains_b.press()) {
    surfaceGains_b.activated = !surfaceGains_b.activated;
  } else if (surfaceProjection_b.press()) {
    surfaceProjection_b.activated = !surfaceProjection_b.activated;
    if (surfaceProjection_b.activated) {
      rot_X = rot_Y = surfaceRrotateCounter = 0;
    } else {
      rot_X=329.67;
      rot_Y=322.24;
    }
  } else if (surfaceGradation_b.press()) {
    GrCounter ++;
    if (GrCounter == 7)
      GrCounter = 0;
  }
  if (rmouseX>=660+(310/(maxs[1]+1)) && rmouseX<=970  && rmouseY<=750 && rmouseY>=450+(310/(maxs[2]+1)) && Rules_Edit_b.activated ) {
    tablei=int((rmouseX-660)/(310/(maxs[1]+1)));
    tablej=int((rmouseY-450)/(310/(maxs[2]+1)));
    ruleswheel=(tablei-1)*maxs[2]+tablej;
    if (keyPressed && keyCode == TAB)
      rules_Table[tablej-1][tablei-1]=0;
  }
  if (Rules_Edit_b.activated) {
    if (rulesMode_b.press()) {
      tableMode = !tableMode ;
      for (int ii=0; ii<3; ii++) {
        for (int i=1; i<=maxs[ii]; i++)
          MF[i][ii].autonaming();
      }
    } else if (rulesNames_b.press()) {
      rulesNames_b.activated = !rulesNames_b.activated;
    } else if (rulesFilter_b.press()) {
      rulesFilter_b.activated = !rulesFilter_b.activated ;
    } else if (resetOperatorTable_b.press()) {
      resetOperators = !resetOperators;
      for (int i=0; i<=12; i++) {
        for (int j=0; j<=12; j++)
          rules_Operators[i][j]=resetOperators;
      }
      update_2Dplot();
    } else if (rulesbuttons_b[0].press()) {
      ruleEditing=!ruleEditing;
      rulesbuttons_b[0].activated=!rulesbuttons_b[0].activated;
      surface_3D =false;
      Surface_b[0].activated=false;
    } else if (rulesbuttons_b[1].press()) {
      setup_Rules(maxs[0]);
      update_2Dplot();
    } else if (rulesbuttons_b[2].press()) {
      for (int i=0; i<=12 && rulesMode == 0; i++) {
        for (int j=0; j<=12; j++)
          rules_Table[i][j]=0;
      }
      for (int i=0; i<=12 && rulesMode == 1; i++) {
        for (int j=0; j<=12; j++) {
          rules_Weights[i][j]=1;
        }
      }
      if (rulesMode <2) {
        rulesTrend.clear();
        weightsTrend.clear();
        for (int j=0; j < maxs[0]; j++) {
          rulesTrend.append(rules_Table[maxs[0]-1][j]);
          weightsTrend.append(1);
        }
      }
      for (int i=0; i<=12 && rulesMode == 2; i++) {
        for (int j=0; j<=12; j++) {
          rules_Operators[i][j]=!rules_Operators[i][j];
        }
      }
      update_2Dplot();
    } else if (rulesbuttons_b[3].press()) {
      rulesMode ++;
      rulesMode= rulesMode% 3;
    } else if (rulesbuttons_b[4].press()) {
      rulesbuttons_b[4].activated = !rulesbuttons_b[4].activated;
    } else if (rulesCenter_b.press()) {
      if (rulesMode == 0)
        PushRulesToCenter(maxs[0]);
      else
        PushWeigtsToCenter(maxs[0]);
      rules_Table[(maxs[0]+1)/2-1][(maxs[0]+1)/2-1] = (maxs[0]+1)/2;
      update_2Dplot();
    } else if (rulesMedium_b.press()) {
      if (rulesMode == 0)
        PushRulesToMeduim(maxs[0]);
      else
        PushWeigtsToMeduim(maxs[0]);
        rules_Table[(maxs[0]+1)/2-1][(maxs[0]+1)/2-1] = (maxs[0]+1)/2;
      update_2Dplot();
    } else if (rulesEdges_b.press()) {
      if (rulesMode == 0)
        PushRulesToEdges(maxs[0]);
      else
        PushWeigtsToEdges(maxs[0]);
        rules_Table[(maxs[0]+1)/2-1][(maxs[0]+1)/2-1] = (maxs[0]+1)/2;
      update_2Dplot();
    }
  }

  if (Surface_b[0].press()) {
    ruleEditing=false;
    rulesbuttons_b[0].activated=false;
    surface_3D=!surface_3D;
    Surface_b[0].activated=!Surface_b[0].activated;
    if (Surface_b[0].activated)
      LaunchSurfaceThread();
    if (!Surface_b[0].activated) {
      Surface_b[1].activated=false;
    }
  } else if (Surface_b[1].press() && Surface_b[0].activated) {
    update_3Dplot();
    Reset_Rules_Activation();
  } else if (Rules_anim_b.press()) {
    Rules_anim_b.activated= !Rules_anim_b.activated;
    Ke=Kde=Ky1=1;
    update_Rules_animation();
  } else if ( Rules_Edit_b.press()) {
    Rules_Edit_b.activated = !Rules_Edit_b.activated;
    rulesbuttons_b[0].activated = ruleEditing = false;
  }

  for (int i =0; i < 6; i ++) {
    if (defuzz_b[i].press()) {
      defuzz_b[i].activated = ! defuzz_b[i].activated;
      Def_method =i + 1;
      update_2Dplot();
      if (surface_3D)
        update_3Dplot();
      break;
    }
  }

  if (infer_b[0].press()) {
    infer_b[0].activated = true;
    infer_b[1].activated = false;
    implication_method = 1;
    update_2Dplot();
    if (surface_3D)
      update_3Dplot();
  } else if (infer_b[1].press()) {
    infer_b[1].activated = true;
    infer_b[0].activated = false;
    implication_method = 2;
    update_2Dplot();
    if (surface_3D)
      update_3Dplot();
  } else if (aggregation_b[0].press()) {
    aggregation_b[0].activated = true;
    aggregation_b[1].activated = false;
    aggregation_method = 1;
    update_2Dplot();
    if (surface_3D)
      update_3Dplot();
  } else if (aggregation_b[1].press()) {
    aggregation_b[1].activated = true;
    aggregation_b[0].activated = false;
    aggregation_method = 2;
    update_2Dplot();
    if (surface_3D)
      update_3Dplot();
  }

  if (PLC_b.press()) {
    PLC_b.activated = true;
    exportPLC();
  } else if (JML_b.press()) {
    JML_b.activated = true;
    exportFJML();
  } else if (Matlab_b.press()) {
    Matlab_b.activated = true;
    exportFis();
  } else if (Python_b.press() && surface_3D) {
    Python_b.activated = true;
    update_3Dplot();
    exportCode();
  } else if (Cpp_b.press() && surface_3D) {
    Cpp_b.activated = true;
    update_3Dplot();
    exportCode();
  }



  if (rule_down_b.press() && tablei*tablej<maxs[1]*maxs[2]) {
    ruleswheel++;
    tablej=ruleswheel%maxs[2]+1;
    tablei=ruleswheel/(maxs[2])+1;
  } else if (rule_up_b.press() && ruleswheel>0) {
    ruleswheel--;
    tablej=ruleswheel%maxs[2]+1;
    tablei=ruleswheel/(maxs[2])+1;
  } else if (rule_right_b.press()) {
    rulestext+=10;
  } else if (rule_left_b.press()) {
    rulestext-=10;
  } else if (rmouseX<=630  && rmouseY<=690 && rmouseY>=232 && ruleEditing) {
    int cn=0;
    for (int i=0; i<=20; i++) {
      if (rmouseY>=237+i*28 && rmouseY<=265+i*28) {
        if (RulesView_begin==0)
          cn=i+1;
        else
          cn=i;
        break;
      }
    }
    for (int i=1; i<=maxs[1]; i++) {
      for (int j=1; j<=maxs[2]; j++) {
        if ((i-1)*maxs[2]+j==RulesView_begin+cn) {
          tablei=i;
          tablej=j;
          ruleswheel=(tablei-1)*maxs[2]+tablej;
          break;
        }
      }
    }
  }
}

void Interface1MouseReleased() {
  rulesCenter_b.release();
  rulesEdges_b.release();
  rulesMedium_b.release();
  rulesNames_b.release();
  rulesMode_b.release();
  resetOperatorTable_b.release();
  rulesFilter_b.release();
  rule_up_b.release();
  rule_down_b.release();
  rule_right_b.release();
  rule_left_b.release();
  surfaceRot_b.release();
  surfaceGrid_b.release();
  surfaceGains_b.release();
  surfaceProjection_b.release();
  surfaceGradation_b.release();
  for (int i=0; i<6; i++) {
    defuzz_b[i].release();
    if (defuzz_b[i].activated && Def_method != i+1)
      defuzz_b[i].activated = false;
    if (i<2) {
      infer_b[i].release();
      aggregation_b[i].release();
    }
    if (i < 5)
      rulesbuttons_b[i].release();
    if (i<3) {
      if (i == 2)
        Surface_b[i].release();
      else
        Surface_b[i].release();
    }
  }
  rule_up_b.release();
  rule_down_b.release();
  rule_right_b.release();
  rule_left_b.release();
  Rules_anim_b.release();
  Rules_Edit_b.release();
  hold3D = false;
  PLC_b.release();
  JML_b.release();
  Matlab_b.release();
}
