void DrawUline() {
  fill(255);
  rect(380, 230, 130, 25);
  rect(510, 230, 130, 25);

  fill(200, 200);
  rect(230, 230, 150, 25);

  fill(0);
  textSize(21);
  text("Step Inputs : ", 260, 247);

  textSize(20);
  textCaseVar(0, 62, inputIntervals.get(InputIndex) * Ts, 440, 250);
  textCaseVar(0, 63, inputRanges.get(InputIndex-1), 575, 250);

  float yT = UlineY;
  float dT = 30;
  stroke(0);
  fill(255, 200);
  rect(40, yT, 600, dT, 3);
  for (int i =0; i < 100; i ++) {
    line(40 + i*6, yT, 40 + i*6, yT+ 5);
    line(40 +i*6, yT + dT -5, 40 + i*6, yT + dT );
  }

  float xT = 40 + inputIntervals.get(InputIndex-1)*600/simulationSteps;
  fill(#98F6FF, 100);
  rect(xT, yT, 40 + inputIntervals.get(InputIndex)*600/simulationSteps - xT, dT);
  for (int i =0; i < inputIntervals.size(); i ++) {
    xT = 40 + inputIntervals.get(i)*600/simulationSteps;
    int k = (i < inputIntervals.size() -1) ? i+1:inputIntervals.size() -1;
    float xTp = (40 + inputIntervals.get(k)*600/simulationSteps - xT) /2;
    fill(0, 0, 200);
    triangle(xT - 5, yT, xT + 5, yT, xT, yT +10);
    triangle(xT - 5, yT+ dT, xT + 5, yT + dT, xT, yT + dT -10);
    stroke(0, 0, 200);
    line(xT, yT, xT, yT+dT);
    if (i < InputMax ) {
      if (textWidth(nf(inputRanges.get(i), 0, 0)) < 50) {
        fill(0);
        text(nf(inputRanges.get(i), 0, 0), xT + xTp - textWidth(nf(inputRanges.get(i), 0, 0))/2, yT + dT*0.7);
      }
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void DragInputTimeIntervals() {
  for (int i =1; i <= InputMax && !InputDragged; i ++) {
    if (rmouseX >= 40+inputIntervals.get(i)*600/simulationSteps - 5
      && rmouseX <= 40+inputIntervals.get(i)*600/simulationSteps + 5
      && rmouseY >= UlineY && rmouseY <= UlineY + 30) {
      InputDragged = true;
      InputIndex = i;
      break;
    }
  }
  if (InputDragged && InputIndex != InputMax) {
    float X = (rmouseX-40)*simulationSteps/600;
    if (X > inputIntervals.get(InputIndex-1) + 5  && X < inputIntervals.get(InputIndex+1) - 5)
      inputIntervals.set(InputIndex, X);
    BuildStepInputs();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void resetAllInputs() {
  InputIndex = 1;
  inputIntervals.clear();
  inputRanges.clear();
  inputRanges.append(SetPoint);
  for (int i =0; i < InputMax - 1; i ++)
    inputRanges.append(SetPoint);
  inputIntervals.append(0);
  int timeInterval = int(simulationSteps/InputMax);
  for (int i =1; i <= InputMax; i ++) {
    inputIntervals.append(timeInterval * i);
  }
  inputIntervals.set(inputIntervals.size() -1, simulationSteps);
  BuildStepInputs();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void pushAllInputs() {
  for (int i =1; i < InputMax; i ++) {
    inputIntervals.set(i, simulationSteps);
  }
  for (int i = InputMax -1; i > 0; i --) {
    inputIntervals.set(i, max(inputIntervals.get(i + 1)-5, 1));
  }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void BuildStepInputs() {
  if (!Launch2D_Update) {
    int T = 0;
    FloatList In = new FloatList();
    for (int j=0; j<=simulationSteps+denomenator+1; j++) {
      if (j >= inputIntervals.get(T) && j < inputIntervals.get(T+1)) {
        In.append(inputRanges.get(T));
      } else if (T < InputMax - 1) {
        T ++;
        In.append(inputRanges.get(T));
      } else
        In.append(inputRanges.get(T));
    }
    Input = In.copy();
    if (waitDefaultFile) // wait until the defautl file is uploaded
      update_2Dplot();
  }
}



/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void reBuildInputs() {
  InputMax = 1;
  InputIndex =1;
  inputIntervals.clear();
  inputRanges.clear();
  Input.clear();
  for (int i =0; i <= simulationSteps; i ++)
    Input.append(SetPoint);
  inputIntervals.append(0);
  inputIntervals.append(simulationSteps);
  inputRanges.append(SetPoint);
}
