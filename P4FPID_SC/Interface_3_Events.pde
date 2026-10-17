void Interface3MousePressed() {
  if (GA_Progression == 0) {
    for (int i =0; i < 4; i ++)
      if (opt_var[i].press()) {
        for (int j =0; j < 8; j ++) {
          GainOpt_b[j].activated = false;
        }
      }
    if (opt_var[0].press()) {
      opt_var[0].activated=true;
      opt_var[1].activated
        = opt_var[2].activated = opt_var[3].activated =false;
    } else if (opt_var[1].press()) {
      opt_var[1].activated = true;
      opt_var[0].activated = opt_var[2].activated = opt_var[3].activated = false;
      for (int i =0; i < 8; i ++)
        GainOpt_b[i].activated = true;
    } else if (opt_var[2].press()) {
      opt_var[2].activated=true;
      opt_var[0].activated = opt_var[1].activated = opt_var[3].activated = false;
    } else if (opt_var[3].press()) {
      opt_var[3].activated=true;
      opt_var[0].activated = opt_var[1].activated = opt_var[2].activated = false;
    } else if (GA_animation_b.press()) {
      GA_animation_b.activated=!GA_animation_b.activated;
    } else if (pushedMFs_b.press()) {
      pushedMFs_b.activated=!pushedMFs_b.activated;
      upperWidthMFs_b.activated = lowerWidthMFs_b.activated = false;
    } else if (linkedMFs_b.press()) {
      linkedMFs_b.activated=!linkedMFs_b.activated;
      upperWidthMFs_b.activated = lowerWidthMFs_b.activated = false;
    } else if (DNA_Activator_b.press()) {
      DNA_Activator_b.activated = !DNA_Activator_b.activated;
    } else if (symmetricalMFs_b.press()) {
      boolean sym=true;
      for (int ii=0; ii<3; ii++) {
        for (int i=(maxs[ii]+1)/2; i<=maxs[ii]; i++) {
          if (MF[i][ii].type!=MF[maxs[ii]-i+1][ii].type)
            sym=false;
        }
      }
      if (sym) {
        symmetricalMFs_b.activated=!symmetricalMFs_b.activated;
        for (int i = 0; i < 6; i ++) {
          optSide_b[i].activated = true;
        }
      }
    } else if (changeF_b.press()) {
      fitType = !fitType;
    } else if (fitfunc_b[0].press()) {
      fitfunc_b[0].activated = !fitfunc_b[0].activated;
      if (fitfunc_b[1].activated )
        fitfunc_b[1].activated = false;
    } else if (fitfunc_b[1].press()) {
      fitfunc_b[1].activated = !fitfunc_b[1].activated;
      if (fitfunc_b[0].activated )
        fitfunc_b[0].activated = false;
    } else if (elitism_b.press()) {
      elitism_b.activated = !elitism_b.activated;
    } else if (upperWidthMFs_b.press()) {
      lowerWidthMFs_b.activated = pushedMFs_b.activated =
        linkedMFs_b.activated = pushedMFs_b.activated = false;
      upperWidthMFs_b.activated  = !upperWidthMFs_b.activated ;
    } else if (lowerWidthMFs_b.press()) {
      upperWidthMFs_b.activated = pushedMFs_b.activated =
        linkedMFs_b.activated = pushedMFs_b.activated =false;
      lowerWidthMFs_b.activated  = !upperWidthMFs_b.activated ;
    } else if (noRule_b.press()) {
      noRule_b.activated  = !noRule_b.activated ;
      if (noRule_b.activated)
        noRuleIndex =0;
      else
        noRuleIndex =1;
    } else if (rulesWeights_b.press()) {
      rulesWeights_b.activated  = !rulesWeights_b.activated ;
    } else if (operatorsOpt_b.press()) {
      operatorsOpt_b.activated  = !operatorsOpt_b.activated ;
    } else if (rulesOpt_b.press()) {
      rulesOpt_b.activated  = !rulesOpt_b.activated;
    }
    for (int i = 0; i < 4; i ++) {
      if (erroFct_b[i].press()) {
        erroFct_b[i].activated = true;
        for (int j = 0; j < 4; j ++)
          if (j!=i)
            erroFct_b[j].activated = false;
        break;
      }
    }
    if (!opt_var[1].activated || !opt_var[3].activated) {
      for (int j=0; j<3; j++) {
        if (WeiGA_b[j].press()) {
          weightsShape[j]= (weightsShape[j] +1 ) % 3;
          for (int i =0; i < 3 && keyPressed && keyCode == TAB; i++)
            weightsShape[i]= weightsShape[j];
        }
        if (MFsGA_b[j].press()) {
          MFsGA_b[j].activated = !MFsGA_b[j].activated ;
          for (int i =0; i < 3 && keyPressed && keyCode == TAB; i++)
            MFsGA_b[i].activated = MFsGA_b[j].activated;
        }
      }

      if (!symmetricalMFs_b.activated)
        for (int j=0; j<6; j++)
          if (optSide_b[j].press() && MFsGA_b[j/2].activated) {
            int I = (j % 2 == 0) ? 1 : -1;
            if (!(optSide_b[j].activated && !optSide_b[j + I].activated))
              optSide_b[j].activated = ! optSide_b[j].activated;
          }
    }
  } // progression == 0
  if (!debugStart_b.activated && !UART_b.activated) {
    if (opt_start_b[0].press()) { ////////
      opt_start_b[0].activated=!opt_start_b[0].activated;
      if (GA_Progression == 0 )
        setUpCorrespondingVariable();
      if (GA_animation_b.activated) {
        if (GA_Progression == 0 ) {
          bestFit = 0 ;
          currentFit = 0;
          GAFailed = GASucced = false;
        }
        Already_Started = opt_start_b[0].activated;
      } else {
        //BackgroundOptimization();
        LaunchGAOp = true;
        LaunchAnimatedOptimizationThread();
      }
    } else if (opt_start_b[1].press()) {
      if (Already_Started)
        Already_Started = false;
      update_2Dplot();
      G_A.Reset();
      opt_start_b[0].activated=false;
      initCounter=0;
      genCounter=0;
      GA_Progression=0;
    } else if (speedUp_b.press()) {
      GA_Speed = int(max(4, GA_Speed - 1));
    } else if (speedDown_b.press()) {
      GA_Speed = int(min(30, GA_Speed + 1));
    } else if (crossOverStyle_b[0].press()) {
      crossOverStyle_b[0].activated= !crossOverStyle_b[0].activated;
      crossOverStyle_b[1].activated= !crossOverStyle_b[0].activated;
      G_A.randomCross = crossOverStyle_b[0].activated;
    } else if (crossOverStyle_b[1].press()) {
      crossOverStyle_b[1].activated= !crossOverStyle_b[1].activated;
      crossOverStyle_b[0].activated= !crossOverStyle_b[1].activated;
      G_A.randomCross = crossOverStyle_b[0].activated;
    }
  }
}

void Interface3MouseReleased() {
  elitism_b.release();
  for (int i=0; i<2; i++) {
    opt_start_b[i].release();
    crossOverStyle_b[i].release();
  }
  for (int i = 0; i < 4; i ++) {
    erroFct_b[i].release();
    opt_var[i].release();
  }
  opt_var[2].release();
  GA_animation_b.release();
  linkedMFs_b.release();
  symmetricalMFs_b.release();
  DNA_Activator_b.release();
  speedDown_b.release();
  speedUp_b.release();
  changeF_b.release();
  fitfunc_b[0].release();
  fitfunc_b[1].release();
  pushedMFs_b.release();
  upperWidthMFs_b.release();
  lowerWidthMFs_b.release();
  operatorsOpt_b.release();
  rulesOpt_b.release();
  noRule_b.release();
  rulesWeights_b.release();
}
