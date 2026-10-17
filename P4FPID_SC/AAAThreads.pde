void LaunchGraphUpdateThread() {
  Thread GraphThread = new Thread(new Runnable() {
    public void run() {
      while (true) {
        if (!UART_b.activated && resetDebug && !debugStart_b.activated && Launch2D_Update && !Launch3D_Update && !opt_start_b[0].activated && !(face == 1 && surface_3D)) {
          executionTime = millis();
          Perceive();
          resetUniverse();
          executionTime = millis() - executionTime;
          //println("Execution Time = " + executionTime);
        }
        Launch2D_Update = false;
        delay(10);
      }
    }
  }
  );
  GraphThread.start();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////











void LaunchSurfaceThread() {
  Thread surfaceThread = new Thread(new Runnable() {
    public void run() {
      while (Surface_b[0].activated) {
        if (Launch3D_Update && !Launch2D_Update  && !debugStart_b.activated && !opt_start_b[0].activated ) { //
          min3D =  max3D = 0;
          for (int i=0; i<200; i++) {
            for (int j=0; j<200; j++) {
              if (surfaceGains_b.activated) {
                inference(Bound__(Range[1], -Range[1], Ke*(int(j-100))), Bound__(Range[2], -Range[2], Kde*(int(i-100))));
                Surface[i][j]= Bound__(Range[0], -Range[0], Ky1*Defuzzification());
              } else {
                inference(i-100, j-100);
                Surface[i][j]=Defuzzification();
              }
              if (min3D > Surface[i][j])
              min3D = Surface[i][j];
              if (max3D < Surface[i][j])
              max3D = Surface[i][j];
              resetUniverse();
              Launch3D_Update = false;
            }
          }
        }
        delay(10);
      }
      delay(10);
    }
  }
  );
  surfaceThread.start();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void LaunchDebugThread() {
  Thread DebugThread = new Thread(new Runnable() {
    public void run() {
      delay(10);
      while (!resetDebug) {
        if (!Launch2D_Update && !Launch3D_Update && !opt_start_b[0].activated  && debugStart_b.activated) {
          Td ++;
          Sleeping = false;
          sleepingTimer =0;
          if (discreteSys_b.activated)
          FuzzyPIDAnimationDiscrete();
          else
            FuzzyPIDAnimationContinuous();
          if (newChangeHappened) {
            loadTransferFunction();
            newChangeHappened = false;
          }
          if (Rules_anim_b.activated) {
            ein = offline_er.get(Td);
            dein = offline_der.get(Td);
            yout1 = offline_y1.get(Td);
          }
          if (Td >= simulationSteps-1) {
            removeZeroOffline();
            Td --;
          }
          //PerlineX.append(map(noise(simTik*Ts), 0, 1, Bmin, Bmax));
        }
        delay(debugSpeed);
      }
    }
  }
  );
  DebugThread.start();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void LaunchAnimatedOptimizationThread() {
  Thread OptimizationThread = new Thread(new Runnable() {
    public void run() {
      while (LaunchGAOp)
      if (opt_start_b[0].activated && !Launch2D_Update &&
        !Launch3D_Update && !debugStart_b.activated && !GA_animation_b.activated) {
        BackgroundOptimization();
        LaunchGAOp = false;
      }
      delay(10);
    }
  }
  );
  OptimizationThread.start();
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
