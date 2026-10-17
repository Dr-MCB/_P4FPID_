void serialEvent(Serial myPort) {
  Sleeping = false;
  sleepingTimer =0;
  String INput = myPort.readString();
  myPort.clear();
  char[]  INlist = INput.toCharArray();
  if (INlist[0] == '(' && INlist[INlist.length-1] == ')') {
    if (UARTenable_b.activated)
      SerialReivedSent = "Recieved: " + String.valueOf(INlist);
    IN = float(new String(INlist, 1, INlist.length-2));
    if (doneSending && UART_b.activated)
      realTimeControl();
    else {
      SerialConversation.append(SerialReivedSent + "| T:" + hour() + ":" + minute() + ":" + second() + ":" + millis()%100);
      SerialReivedSent = "";
      if (SerialConversation.size() > 30)
        SerialConversation.remove(0);
    }
  }
  timeTick += Ts;
}


void realTimeControl() {
  doneSending = false;
  int last_index = online_sys.size()-1;
  float St = (!discreteSys_b.activated) ? Ts : 1;
  SerialTimeLug = millis();
  online_E.append(SetPoint-IN);
  online_dE.append((online_E.get(online_E.size()-1)-online_E.get(online_E.size()-2))/St);
  if (BD_Index <=1) {
    if (!discreteSys_b.activated)
      RTPreviousDer = (1 - filterGain) * online_dE.get(online_dE.size()-1) + filterGain * RTPreviousDer;
    else
      RTPreviousDer = (1 - filterGain) * online_dE.get(online_dE.size()-1) - filterGain * RTPreviousDer;
    ein = Bound__(Range[1]-1, -Range[1]+1, Ke * (SetPoint-IN) *Range[1]/MaxSaturations[0]);
    dein = Bound__(Range[2]-1, -Range[2]+1, Kde * RTPreviousDer *Range[2]/MaxSaturations[1]);
    Reset_Rules_Activation();
    inference(ein, dein);
    if (!discreteSys_b.activated) {
      debugY1 = Defuzzification()*MaxSaturations[2]/Range[0];
      debugY2 = debugY2 + debugY1*Ts;
      debugY3 = debugY3 + (SetPoint-IN)*Ts;
    } else {
      debugY1 = Defuzzification()*MaxSaturations[2]/Range[0];
      debugY2 = RTPy1 + debugY1;
      debugY3 = online_E.get(online_E.size()-2) + online_E.get(online_E.size()-1);
    }
    yout1 = Bound__(MaxSaturations[2], -MaxSaturations[2], Ky1*debugY1);
    yout2 = Bound__(MaxSaturations[2], 0, debugY2*Ky2);
    yout3 = Bound__(MaxSaturations[2], 0, debugY3*Ky3);
    if (BD_Index == 0)
      onlineControl = Bound__(MaxSaturations[2], 0, yout1 + yout2);
    else
      onlineControl = Bound__(MaxSaturations[2], 0, yout1 + yout3);
    RTPy1 = debugY1;
  } else if (BD_Index == 3) {
    onlineControl = Bound__(MaxSaturations[2], 0, SetPoint - IN);
  } else {
    onlineControl = SetPoint;
  }
  try {
    String message = "(" + nf(onlineControl, 0, 2) + ")";
    myPort.write(message);
    SerialReivedSent = SerialReivedSent + " | Sent : (" + nf(onlineControl, 0, 2) + ")";
  }
  catch (Exception e) {
    //UART_b.activated = false;
  }

  // SerialReivedSent = "Recieved: " + SerialReivedSent;
  SerialConversation.append(SerialReivedSent + "| T:" + hour() + ":" + minute() + ":" + second() + ":" + millis()%100);
  SerialReivedSent = "";
  if (SerialConversation.size() > 30)
    SerialConversation.remove(0);


  if (Rules_anim_b.activated && (dispIndex ==0))
    arrayCopy(UoD, mp);
  resetUniverse();


  online_sys.append(IN);
  online_SetPoint.append(SetPoint);
  online_er.append(ein);
  online_der.append(dein);
  online_ctr.append(onlineControl);
  online_y1.append(yout1);
  online_y2.append(yout2);
  online_y3.append(yout3);

  if (dataRecord_b[0].activated && !LaunchRecord) {
    recorded_sys.append(IN);
    recorded_ctr.append(onlineControl);
    recorded_er.append(ein);
    recorded_der.append(dein);
    recorded_SetPoint.append(SetPoint);
    recorded_y1.append(yout1);
    recorded_y2.append(yout2);
    recorded_y3.append(yout3);
    recTime += Ts;
    if (recorded_sys.size() > 10000) {
      saveRecordedData();
    }
  }
  last_index *= Imax;
  InLoop = true;
  while (last_index > 450) {
    removeZeroONline();
    last_index = int((online_sys.size()-1) * Imax);
  }
  InLoop = false;
  doneSending = true;
  SerialTimeLug = millis()-SerialTimeLug;
  //if (SerialTimeLug >= Ts*1000 + 5) {
  //  UARTenable_b.activated = UART_b.activated = false;
  //}
}



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void realtimeDraw() {
  strokeWeight(2);
  stroke(255, 0, 0);
  int last = online_sys.size()-1;
  ArrayList<FloatList> Points = new ArrayList<FloatList>();
  Points.add(online_SetPoint);
  Points.add(online_sys);
  Points.add(online_er);
  Points.add(online_der);
  Points.add(online_ctr);
  Points.add(online_y1);
  Points.add(online_y2);
  Points.add(online_y3);
  try {
    InLoop = true;
    for (int i=1; i<last; i++) {
      int I_index = min(i, online_sys.size()-1);
      for (int j = 0; j< 8 && 40+i*Imax <650 && I_index < Points.get(j).size(); j++)
        if (Signalsdropdown.selected[j]) {
          stroke(graphColor[j]);
          if (discreteSys_b.activated) {
            line( 40+i*Imax, 720-(Points.get(j).get(I_index-1)*400/Vmax),
              40+(i-1)*Imax, 720 - (Points.get(j).get(I_index-1)*400/Vmax));
            line( 40+i*Imax, 720-(Points.get(j).get(I_index-1)*400/Vmax),
              40+(i)*Imax, 720 - (Points.get(j).get(I_index)*400/Vmax));
          } else
            line( 40+i*Imax, 720-(Points.get(j).get(I_index)*400/Vmax),
              40+(i-1)*Imax, 720 - (Points.get(j).get(I_index-1)*400/Vmax));
        }
    }
    InLoop = false;
  }
  catch (Exception e) {
  }
  //for (int i =0; i < 8; i++)
  //  Points.get(i).clear();
  Points.clear();
}



void initiateSerialCom() {
  try {
    Table table=loadTable("Data/Serial/COM.csv", "header");
    TableRow row=table.getRow(0);
    if (row.getInt("COM state") == 1) {

      BaudRate = row.getInt("COM baudrate");
      port_ = row.getInt("COM number");
      ComState = true;
      if (row.getInt("COM auto-detect") == 1) {
        String portName = "";
        try {
          //  println(Serial.list());
          portName = Serial.list()[0];
          myPort = new Serial(this, portName, BaudRate);
          UARTenable_b.stroke = color(0, 255, 0);
          UARTenable_b.strokeweight = 5;
          UARTenable_b.x += 2.5;
          UARTenable_b.sizex -= 5;
          UARTenable_b.y += 2.5;
          UARTenable_b.sizey -= 5;
        }
        catch (Exception e) {
          ComState = false;
        }
      } else {
        port_ = row.getInt("COM number");
        println("com name is :    COM"+String.valueOf(port_));
        myPort = new Serial(this, "COM"+String.valueOf(port_), BaudRate);
      }
      myPort.bufferUntil(')');
    }
  }
  catch (Exception e) {
    uartFailed = true;
    println(" the UART is Failed");
  }
}
