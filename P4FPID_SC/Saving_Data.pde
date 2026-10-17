void savedata(int saving_option) {
  String[] MV_name = {"Error", "Error Derivative", "Output"};
  Table data2 = new Table();
  data2.addColumn("maxoutputMFs", Table.INT);
  data2.addColumn("maxerrorMFs", Table.INT);
  data2.addColumn("maxderrorMFs", Table.INT);
  data2.addColumn("Ranges", Table.FLOAT);
  data2.addColumn("FixedSatrurations", Table.FLOAT);
  //data2.addColumn("VariableSatrurations", Table.FLOAT);
  data2.addColumn("Inference", Table.INT);
  data2.addColumn("Aggregation", Table.INT);
  data2.addColumn("Def_methode", Table.INT);
  data2.addColumn("Nomerator", Table.INT);
  data2.addColumn("Denomerator", Table.INT);
  data2.addColumn("Ke", Table.FLOAT);
  data2.addColumn("Kde", Table.FLOAT);
  data2.addColumn("KY1", Table.FLOAT);
  data2.addColumn("KY2", Table.FLOAT);
  data2.addColumn("KY3", Table.FLOAT);
  data2.addColumn("Transfer_fct", Table.FLOAT);

  data2.addColumn("Discretisation Type", Table.INT);
  data2.addColumn("Moving_step", Table.INT);
  data2.addColumn("Smoothing Canstant Z", Table.FLOAT);
  data2.addColumn("Smoothing Canstant S", Table.FLOAT);

  data2.addColumn("X extension", Table.FLOAT);
  data2.addColumn("Y extension", Table.INT);
  data2.addColumn("X shift", Table.INT);
  data2.addColumn("Y shift", Table.INT);
  data2.addColumn("Interface", Table.INT);
  data2.addColumn("Selected graphs", Table.INT);
  data2.addColumn("Grid state", Table.INT);
  data2.addColumn("Simulation time", Table.FLOAT);
  data2.addColumn("Simulation Ts", Table.FLOAT);

  data2.addColumn("Block Diagram", Table.INT);
  data2.addColumn("Rules", Table.INT);
  data2.addColumn("Rules  weights", Table.FLOAT);
  data2.addColumn("Rules  connectors", Table.INT);
  data2.addColumn("SetPoint", Table.FLOAT);
  data2.addColumn("Gains step", Table.FLOAT);
  data2.addColumn("SetPoints Values", Table.FLOAT);
  data2.addColumn("SetPoints Times", Table.FLOAT);
  data2.addColumn("File name", Table.STRING);

  TableRow row = data2.addRow();
  row.setInt("maxoutputMFs", maxs[0]);
  row.setInt("maxerrorMFs", maxs[1]);
  row.setInt("maxderrorMFs", maxs[2]);
  row.setInt("Inference", implication_method);
  row.setInt("Aggregation", aggregation_method);
  row.setInt("Def_methode", Def_method);
  row.setInt("Nomerator", nomenator);
  row.setInt("Denomerator", denomenator);
  row.setFloat("SetPoint", SetPoint);

  row.setFloat("Smoothing Canstant Z", filterGain);
  row.setFloat("Smoothing Canstant S", tau);
  row.setInt("Moving_step", movingStep);
  row.setInt("Discretisation Type", (discreteSys_b.activated ? 1:0));

  row.setFloat("X extension", Imax);
  row.setInt("Y extension", Vmax);
  row.setInt("X shift", dragged_I);
  row.setInt("Y shift", Y_Translation);

  row.setInt("Interface", face);
  row.setInt("Grid state", grid_b.activated ? 1:0);
  row.setFloat("Simulation time", simulationTime);
  row.setFloat("Simulation Ts", Ts);
  row.setFloat("Gains step", step);

  row.setInt("Block Diagram", BD_Index);
  row.setFloat("Ke", Ke);
  row.setFloat("Kde", Kde);
  row.setFloat("KY1", Ky1);
  row.setFloat("KY2", Ky2);
  row.setFloat("KY3", Ky3);
  row.setString("File name", fileName);
  for (int j=0; j<maxs[2]; j++) {
    for (int i=0; i<maxs[1]; i++) {
      row = data2.getRow(i+j*maxs[2]+1);
      row.setInt("Rules", rules_Table[j][i]);
      row.setFloat("Rules  weights", rules_Weights[j][i]);
      row.setInt("Rules  connectors", (rules_Operators[j][i] ? 1:0));
    }
  }
  row = data2.getRow(0);
  row.setFloat("SetPoints Times", inputIntervals.size());
  row.setFloat("SetPoints Values", inputRanges.size());
  for (int j=1; j<=inputIntervals.size(); j++) {
    row = data2.getRow(j);
    row.setFloat("SetPoints Times", inputIntervals.get(j-1));
  }
  for (int j=1; j<=inputRanges.size(); j++) {
    row = data2.getRow(j);
    row.setFloat("SetPoints Values", inputRanges.get(j-1));
  }

  for (int j=0; j<11; j++) {
    row = data2.getRow(j);
    if (Signalsdropdown.selected[j])
      row.setInt("Selected graphs", 1);
    else
      row.setInt("Selected graphs", -1);
  }

  for (int i=0; i< 3; i++) {
    row = data2.getRow(i);
    row.setFloat("Ranges", Range[i]);
    //row.setFloat("VariableSatrurations", VariableSaturations[i]);
    row.setFloat("FixedSatrurations", MaxSaturations[i]);
  }

  for (int j=0; j<4; j++) {
    for (int i=0; i<10; i++) {
      row = data2.getRow(i+j*10);
      row.setFloat("Transfer_fct", transfer_fct[i][j]);
    }
  }

  if (saving_option ==0) {
    saveTable(data2, "Data/System Data.csv");
    saveTable(data2, "Data/" + fileName +  " [ " + year() + ";" + month() + ";" + day() + ";" +
      hour()+ ";" + minute()+ ";" + second()+ " ]" + "/System Data.csv");
  } else
    saveTable(data2, "Data/Default File/System Data.csv");
  Table[] data = new Table[3];
  for (int i=0; i<3; i++) {
    data[i]=new Table();
    data[i].addColumn(MV_name[i], Table.FLOAT);
    data[i].addColumn("type", Table.INT);
    data[i].addColumn("parameters", Table.INT);
    data[i].addColumn("name", Table.STRING);
    data[i].addColumn("namesize", Table.INT);
    data[i].addColumn("weight", Table.FLOAT);
    data[i].addColumn("width", Table.FLOAT);
  }
  for (int ii=0; ii<3; ii++) {
    for (int i=1; i<=maxs[ii]; i++) {
      row=data[ii].addRow();
      row.setInt("type", MF[i][ii].type);
      row.setInt("namesize", MF[i][ii].name_Size);
      row.setInt("parameters", MF[i][ii].parameters);
      row.setString("name", MF[i][ii].name);
      row.setFloat("weight", MF[i][ii].normality);
      row.setFloat("width", MF[i][ii].Gauss);
      for (int j=1; j<=4; j++) {
        row = data[ii].addRow();
        row.setFloat(MV_name[ii], MF[i][ii].getParameter(j));
      }
    }
    if (saving_option==1)
      saveTable(data[ii], "Data/Default File/"+ MV_name[ii] +".csv");
    else {
      saveTable(data[ii], "Data/"+ MV_name[ii] +".csv");
      saveTable(data[ii], "Data/"+ fileName +" [ " + year() + ";" + month() + ";" + day() + ";" +
        hour()+ ";" + minute()+ ";" + second()+ " ]" + "/ " + MV_name[ii] + ".csv");
    }
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void datarestore() {
  try {
    String[] MF_name = {"Error", "Error Derivative", "Output"};
    for (int i=0; i<=12; i++) {
      for (int j=0; j<=12; j++)
        rules_Table[i][j]=0;
    }
    Table table=loadTable(import_Path + "/System Data.csv", "header");
    TableRow row=table.getRow(0);
    maxs[0]=row.getInt("maxoutputMFs");
    maxs[1]=row.getInt("maxerrorMFs");
    maxs[2]=row.getInt("maxderrorMFs");
    implication_method=row.getInt("Inference");
    aggregation_method=row.getInt("Aggregation");
    filterGain = row.getFloat("Smoothing Canstant Z");
    tau = row.getFloat("Smoothing Canstant S");
    movingStep = row.getInt("Moving_step");
    sta = row.getInt("Discretisation Type");
    face = row.getInt("Interface");
    Imax  = row.getFloat("X extension");
    Vmax = row.getInt("Y extension");
    dragged_I = row.getInt("X shift");
    Y_Translation = row.getInt("Y shift");
    simulationTime  = row.getFloat("Simulation time");
    Ts  = row.getFloat("Simulation Ts");
    SetPoint=row.getFloat("SetPoint");
    step = row.getFloat("Gains step");
    simulationSteps = int(simulationTime/Ts);
    row = table.getRow(0);
    Input.clear();
    int I = int(row.getFloat("SetPoints Times"));
    for (int i =0; i <= simulationSteps; i ++)
      Input.append(SetPoint);
    InputMax = I;
    InputIndex =1;
    inputIntervals.clear();
    inputRanges.clear();

    for (int j=1; j<=I; j++) {
      row = table.getRow(j);
      inputIntervals.append(row.getFloat("SetPoints Times"));
    }
    for (int j=1; j<I; j++) {
      row = table.getRow(j);
      inputRanges.append(row.getFloat("SetPoints Values"));
    }
    InputMax--;
    BuildStepInputs();
    row = table.getRow(0);
    discreteSys_b.activated = (sta == 1 ? true : false);
    aggregation_b[0].activated = aggregation_b[1].activated =
      infer_b[0].activated = infer_b[1].activated = false;
    infer_b[implication_method-1].activated = true;
    aggregation_b[aggregation_method-1].activated = true;
    Def_method=row.getInt("Def_methode");
    for (int i=0; i< 3; i++) {
      row = table.getRow(i);
      Range[i] = row.getFloat("Ranges");
      //VariableSaturations[i] = row.getFloat("VariableSatrurations");
      MaxSaturations[i] = row.getFloat("FixedSatrurations");
    }
    for (int j=0; j<11; j++) {
      row = table.getRow(j);
      Signalsdropdown.selected[j] = row.getInt("Selected graphs") == 1 ? true:false;
    }
    for (int i =0; i < 6; i ++)
      defuzz_b[i].activated = false;
    defuzz_b[Def_method-1].activated = true;
    row = table.getRow(0);
    grid_b.activated = row.getInt("Grid state") == 1 ? true:false;
    nomenator=row.getInt("Nomerator");
    denomenator=row.getInt("Denomerator");
    BD_Index=row.getInt("Block Diagram");
    Ke =row.getFloat("Ke");
    Kde=row.getFloat("Kde");
    Ky1=row.getFloat("KY1");
    Ky2=row.getFloat("KY2");
    Ky3=row.getFloat("KY3");
    fileName=row.getString("File name");
    row=table.getRow(1);
    MFtype=3;
    tablei=tablej=1;
    for (int i=0; i<=2; i++) {
      setting_up_membershipfunctions(i);
    }
    for (int j=0; j<=maxs[2]-1; j++) {
      for (int i=0; i<=maxs[1]-1; i++) {
        row = table.getRow(i+j*maxs[2]+1);
        rules_Table[j][i]=row.getInt("Rules");
        rules_Operators[j][i]=(row.getInt("Rules  connectors") == 0) ? false: true;
        rules_Weights[j][i]=row.getFloat("Rules  weights");
      }
    }
    for (int j=0; j<4; j++) {
      for (int i=0; i<10; i++) {
        row = table.getRow(i+j*10);
        transfer_fct[i][j]=row.getFloat("Transfer_fct");
      }
    }

    Table data=new Table();
    int rowcount;
    for (int ii=0; ii<3; ii++) {
      rowcount=-1;
      data=loadTable(import_Path + "/"+ MF_name[ii] +".csv", "header");
      for (int i=1; i<=maxs[ii]; i++) {
        rowcount++;
        row=data.getRow(rowcount);
        MF[i][ii].type=row.getInt("type");
        MF[i][ii].parameters=row.getInt("parameters");
        MF[i][ii].name_Size=row.getInt("namesize");
        MF[i][ii].name=row.getString("name");
        MF[i][ii].normality=row.getFloat("weight");
        MF[i][ii].Gauss=row.getFloat("width");
        for (int j=1; j<=4; j++) {
          rowcount++;
          row=data.getRow(rowcount);
          MF[i][ii].setParameter(row.getFloat(MF_name[ii]), j);
        }
      }
    }
    dataRecord_b[2].stroke = color(0);
    dataRecord_b[2].strokeweight = 2;
    ReOrderMFs();
    waitDefaultFile = true;
  }
  catch (Exception e) {
    dataRecord_b[2].stroke = color(255, 0, 0);
    dataRecord_b[2].strokeweight = 3;
  }
}
//////////////////////////////
void saveGraph() {
  Table graphTable = new Table();
  TableRow row = graphTable.addRow();
  graphTable.addColumn("T (millis)", Table.FLOAT);
  graphTable.addColumn("Setpoints", Table.FLOAT);
  graphTable.addColumn("E", Table.FLOAT);
  graphTable.addColumn("dE", Table.FLOAT);
  graphTable.addColumn("error", Table.FLOAT);
  graphTable.addColumn("error derivative", Table.FLOAT);
  graphTable.addColumn("Y1", Table.FLOAT);
  graphTable.addColumn("Y2", Table.FLOAT);
  graphTable.addColumn("Y3", Table.FLOAT);
  graphTable.addColumn("Control signal", Table.FLOAT);
  graphTable.addColumn("System output", Table.FLOAT);
  graphTable.addColumn("theta", Table.FLOAT);
  graphTable.addColumn("Dtheta", Table.FLOAT);
  graphTable.addColumn("DDtheta", Table.FLOAT);
  int Time = int(Ts * 1000);
  for (int i =0; i < offline_sys.size(); i ++) {
    row = graphTable.getRow(i);
    row.setFloat("T (millis)", Time*i);
    row.setFloat("Setpoints", Input.get(i));
    row.setFloat("E", offline_E.get(i));
    row.setFloat("dE", offline_dE.get(i));
    row.setFloat("error", offline_er.get(i));
    row.setFloat("error derivative", offline_der.get(i));
    row.setFloat("Y1", offline_y1.get(i));
    row.setFloat("Y2", offline_y2.get(i));
    row.setFloat("Y3", offline_y3.get(i));
    row.setFloat("Control signal", offline_ctr.get(i));
    row.setFloat("System output", offline_sys.get(i));
    row.setFloat("theta", offline_theta.get(i));
    row.setFloat("Dtheta", offline_dtheta.get(i));
    row.setFloat("DDtheta", offline_ddtheta.get(i));
  }
  String syGraph = "[";
  for (int i = 0; i <= nomenator; i ++) {
    syGraph += String.valueOf(Nome_[i]);
    if (i<nomenator)
      syGraph +=";";
  }
  syGraph +="];[";
  for (int i = 0; i <= denomenator; i ++) {
    syGraph += String.valueOf(Deno_[i]);
    if (i<denomenator)
      syGraph +=";";
  }
  syGraph +="]";
  saveTable(graphTable, "Data/Graphs/" + syGraph + ".csv");
  try {
    saveTable(graphTable, "C:/Users/dell/Desktop/MATLAB Benchmark Experiment/" + syGraph + ".csv");
  }
  catch(Exception e) {
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void saveRecordedData() {
  Table recordings = new Table();
  recordings.addColumn("Time (sec)", Table.STRING);
  recordings.addColumn("SetPoint", Table.FLOAT);
  recordings.addColumn("System Output", Table.FLOAT);
  recordings.addColumn("Control signal", Table.FLOAT);
  recordings.addColumn("Error signal", Table.FLOAT);
  recordings.addColumn("Error derivative", Table.FLOAT);
  recordings.addColumn("Y1", Table.FLOAT);
  recordings.addColumn("Y2", Table.FLOAT);
  recordings.addColumn("Y3", Table.FLOAT);
  recordings.addColumn("Sampling time", Table.STRING);
  TableRow row = recordings.getRow(0);
  row.setString("Sampling time", nf(Ts, 0, 2));
  float startingTime = recTime - recorded_sys.size()*Ts;
  for (int i=0; i< recorded_sys.size(); i++) {
    row = recordings.getRow(i);
    row.setString("Time (sec)", nf( startingTime + i * Ts, 0, 2));
    row.setFloat("SetPoint", recorded_SetPoint.get(i));
    row.setFloat("System Output", recorded_sys.get(i));
    row.setFloat("Control signal", recorded_ctr.get(i));
    row.setFloat("Error signal", recorded_er.get(i));
    row.setFloat("Error derivative", recorded_der.get(i));
    row.setFloat("Y1", recorded_y1.get(i));
    row.setFloat("Y2", recorded_y2.get(i));
    row.setFloat("Y3", recorded_y3.get(i));
  }
  saveTable(recordings, "Data/Data_Record/" + fileName + " [ " + year() + ";" + month() + ";" + day() + ";" +  hour()+ ";" + minute()+ ";" + second()+ " ]/Data Rec.csv");
  saveTable(recordings, "Data/Data_Record/Data Rec.csv");
  Clearrecord();
  LaunchRecord = false;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void uploadTransferFunction() {
  try {
    String[] lines = loadStrings("Transfer Function.txt");
    if (lines == null || lines.length < 2) {
      return;
    }
    if (isValidTFLine(lines[0])  && isValidTFLine(lines[1])
      && parseTFLine(lines[0]).length < parseTFLine(lines[1]).length) {
      nomenator = parseTFLine(lines[0]).length - 1;
      Nome_ = parseTFLine(lines[0]);
      for (int i = 0; i <= nomenator; i ++)
        transfer_fct[i][0] = Nome_[nomenator- i];
      denomenator = parseTFLine(lines[1]).length - 1;
      Deno_ = parseTFLine(lines[1]);
      for (int i = 0; i <= denomenator; i ++)
        transfer_fct[i][1] = Deno_[denomenator-i];
    } else
      return;
  }
  catch(Exception  e) {
  }
}



float[] parseTFLine(String line) {
  line = line.trim().replace("[", "").replace("]", "");
  String[] parts = split(line, ';');
  float[] values = new float[parts.length];
  for (int i = 0; i < parts.length; i++) {
    values[parts.length -1 - i] = float(trim(parts[i]));
  }
  return values;
}

boolean isValidTFLine(String line) {
  line = line.trim();
  return line.startsWith("[") && line.endsWith("]");
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
