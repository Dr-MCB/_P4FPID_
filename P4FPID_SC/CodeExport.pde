void exportCode() {
  Thread CodeExportThread = new Thread(new Runnable() {
    public void run() {
      String name = "";
      if (Cpp_b.activated)
      name = "C, C++ Surface/" + surfacename + " ; " +  int(200/surfaceResolution[GrCounter])+ "X" + int(200/surfaceResolution[GrCounter]) + ".txt";
      else if (Python_b.activated)
      name = "Python Surface/" + surfacename + " ; " +  int(200/surfaceResolution[GrCounter])+ "X" + int(200/surfaceResolution[GrCounter])+ ".txt";
      writer = createWriter(name);
      if (Cpp_b.activated) {
        PrintHowToUseCpp();
        for (int i = 0; i < 200; i++) {
          if (i % surfaceResolution[GrCounter] == 0) {
            writer.print("  {");
            for (int j = 0; j < 200; j++) {
              if (j % surfaceResolution[GrCounter] == 0) {
                writer.print(int(Surface[i][j]));
                if (j < 200 - surfaceResolution[GrCounter]) writer.print(", ");
              }
            }
            writer.println("}," + (i < 199 ? "" : ""));
          }
        }
        writer.println("};");
      } else if (Python_b.activated) {
        PrintHowToUsePy();
        for (int i = 0; i < 200; i++) {
          if (i % surfaceResolution[GrCounter] == 0) {
            writer.print("  [");
            for (int j = 0; j < 200; j++) {
              if (j % surfaceResolution[GrCounter] == 0) {
                writer.print(int(Surface[i][j]));
                if (j < 200 - surfaceResolution[GrCounter]) writer.print(", ");
              }
            }
            writer.println("]," + (i < 199 ? "" : ""));
          }
        }
        writer.println("];");
      }
      writer.close();

      Cpp_b.activated = Python_b.activated = false;
    }
  }
  );
  CodeExportThread.start();
}


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555


void writeTriangularSet(int I, int II) {
  output.println("      <FuzzyTerm name=\"" + MF[I][II].name + "\">");
  output.println("        <TriangularShape Param1=\"" + MF[I][II].a1 + "\" Param2=\"" + MF[I][II].a2 + "\" Param3=\"" + MF[I][II].a4 + "\"/>");
  output.println("      </FuzzyTerm>");
}
void writeTrapezoidalSet(int I, int II) {
  output.println("      <FuzzyTerm name=\"" + MF[I][II].name + "\">");
  output.println("        <trapezoidShape Param1=\"" + MF[I][II].a1 + "\" Param2=\"" + MF[I][II].a2 + "\" Param3=\"" + MF[I][II].a3 + "\" Param4=\"" + MF[I][II].a4 + "\"/>");
  output.println("      </FuzzyTerm>");
}

void writeFuzzyVariable(String type, String name, float min, float max) {
  output.println("    <FuzzyVariable name=\"" + name  + "\" domainLeft=\""
    + min + "\" domainRight=\"" + max + "\"  " + "\" type=\"" + type +  "defaultValue= \" 0.0 \" >");
}


void exportFJML() {
  Thread FJMLExportThread = new Thread(new Runnable() {
    public void run() {

      String fileName = "IEEE 1855 FML/" + codename + ".txt";
      String fileName2 = "IEEE 1855 FML/" + codename+ "Normalization Gains" + ".txt";
      output = createWriter(fileName);
      outputGains = createWriter(fileName2 );
      outputGains.println("K-Error = " + Range[1]/MaxSaturations[0]);
      outputGains.println("K-Error Derivative = " + Range[2]/MaxSaturations[1] );
      outputGains.println("K-Fuzzy Output = " + MaxSaturations[2]/Range[0] );

      output.println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
      output.println("<fuzzySystem xmlns=\"http://www.ieee1855.org\" name=\"" + codename + "\">");

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


      String[] varTypes = {"output", "input", "input"};
      String[] varNames= {"System_output", "Error", "D_Error"};

      output.println("  <KnowledgeBase name=\""  + codename +   "\">");
      for (int ii = 0; ii < 3; ii ++) {
        writeFuzzyVariable(varTypes[ii], varNames[ii], -Range[ii], Range[ii]);
        for (int j = 1; j <= maxs[ii]; j ++) {
          if (MF[j][ii].type !=3)
          writeTriangularSet(j, ii);
          else
            writeTrapezoidalSet(j, ii);
        }
        output.println("    </FuzzyVariable>");
      }
      output.println("  </KnowledgeBase>");


      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      String aggrMethod = "";
      String impliMethod = "";
      String defMethod = "";
      if (aggregation_method == 1)
      aggrMethod = "MAX";
      else
        aggrMethod = "SUM";
      if (implication_method == 1)
      impliMethod = "MIN";
      else
        impliMethod = "PROD";
      if (Def_method == 2)
      defMethod = "MOM";
      else if (Def_method == 3)
      defMethod = "LOM";
      else if (Def_method == 4)
      defMethod = "SOM";
      else
        defMethod = "COG";

      output.println("  <RuleBase name=\" " + codename + " \" activationMethod=\"" + impliMethod + "\" andMethod=\"MIN\" orMethod=\"MAX\" accumulationMethod=\""+ aggrMethod + "\" defuzzifier=\" " + defMethod + " \" type=\"mamdani\">");

      for (int i =1; i <= maxs[1]; i ++) {
        for (int j =1; j <= maxs[2]; j ++) {

          output.println(
            "    <Rule name=\"\"rule" + nf(j+ (i-1) * maxs[1])  + "\""              +
            " andMethod=" +  ((rules_Operators[j-1][i-1])? "\"MAX\"" : "\"MIN\"")   +
            "\" connector=\"" + ((rules_Operators[j-1][i-1])? "\"or\"" : "\"and\"") +
            "\" weight=\""+ nf(rules_Weights[j-1][i-1], 0, 1)                       +
            "\">");

          output.println("      <Antecedent>");
          output.println("        <Clause>");
          output.println("          <Variable>Error</Variable>");
          output.println("          <Term>" + MF[i][1].name + "</Term>");
          output.println("        </Clause>");
          output.println("        <Clause>");
          output.println("          <Variable>D_Error</Variable>");
          output.println("          <Term>" + MF[j][2].name + "</Term>");
          output.println("        </Clause>");
          output.println("      </Antecedent>");
          output.println("      <Consequent>");
          output.println("        <Clause>");
          output.println("          <Variable>System_output</Variable>");
          output.println("          <Term>" + MF[rules_Table[j-1][i-1]][0].name + "</Term>");
          output.println("        </Clause>");
          output.println("      </Consequent>");
          output.println("    </Rule>");
        }
      }



      output.println("  </RuleBase>");

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      output.println("</fuzzySystem>");
      outputGains.flush();
      outputGains.close();
      output.flush();
      output.close();
      JML_b.activated = false;
    }
  }
  );
  FJMLExportThread.start();
}


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555

void exportPLC() {
  Thread PLCExportThread = new Thread(new Runnable() {
    public void run() {
      String fileName = "IEC 61131/" + codename + ".txt";
      String fileName2 = "IEC 61131/" + codename+ "Normalization Gains" + ".txt";
      output = createWriter(fileName);
      outputGains = createWriter(fileName2 );
      outputGains.println("K-Error = " + Range[1]/MaxSaturations[0]);
      outputGains.println("K-Error Derivative = " + Range[2]/MaxSaturations[1] );
      outputGains.println("K-Fuzzy Output = " + MaxSaturations[2]/Range[0] );

      output.println("FUNCTION_BLOCK FuzzyController\n");

      output.println("VAR_INPUT");
      output.println("    Error : REAL;");
      output.println("    D_Error : REAL;");
      output.println("END_VAR\n");

      output.println("VAR_OUTPUT");
      output.println("    System_output : REAL;");
      output.println("END_VAR\n");


      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      String[] tx = {"DEFUZZIFY System_output", "FUZZIFY Error", "FUZZIFY D_Error"};
      String[] tx2 = {"END_DEFUZZIFY\n", "END_FUZZIFY\n", "END_FUZZIFY\n"};
      String[] tx3 = {"COG;", "MOM;", "LOM;", "SOM;"};

      for (int j = 1; j <= 3; j++) {
        int ii = j % 3;
        output.println(tx[ii]);
        for (int i =1; i <= maxs[ii]; i ++) {
          if (MF[i][ii].type !=3)
          output.println("    TERM " + MF[i][ii].name + " := (" + String.valueOf(MF[i][ii].a1)+ " , 0) " +
            " (" + String.valueOf(MF[i][ii].a2)+ ", 1) " + " (" + String.valueOf(MF[i][ii].a4)+ ", 0);");
          else
            output.println("    TERM " + MF[i][ii].name + " := (" + String.valueOf(MF[i][ii].a1)+ " , 0 ) " +
              " (" + String.valueOf(MF[i][ii].a2)+ ", 1) " +  " (" + String.valueOf(MF[i][ii].a3)+ ", 1) " + " (" + String.valueOf(MF[i][ii].a4)+ ", 0);");
        }
        if (j == 3) {
          output.println("METHOD : " + tx3[IBound__(3, 0, Def_method-1)]);
        }
        output.println(tx2[ii]);
      }

      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

      output.println("RULEBLOCK");
      for (int i =1; i <= maxs[1]; i ++) {
        for (int j =1; j <= maxs[2]; j ++) {
          String operator = " AND ";
          if (rules_Operators[j-1][i-1])
          operator = " OR ";
          output.println("RULE "+ String.valueOf(j+(i-1)*maxs[1]) + " (" + nf(rules_Weights[j-1][i-1], 0, 0) + ") " +  ": IF Error IS "+ MF[i][1].name + operator +
            " D_Error IS " + MF[j][2].name + " THEN System_output IS " + MF[rules_Table[j-1][i-1]][2].name);
        }
      }
      output.println("END_RULEBLOCK");
      outputGains.flush();
      outputGains.close();
      output.flush();
      output.close();
      PLC_b.activated = false;
    }
  }
  );
  PLCExportThread.start();
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55555


void exportFis() {
  Thread FisExportThread = new Thread(new Runnable() {
    public void run() {
      String fileName = "Matlab file/" + codename + ".fis";
      String fileName2 = "Matlab file/" + codename+ "Normalization Gains" + ".txt";
      output = createWriter(fileName);
      outputGains = createWriter(fileName2);
      outputGains.println("K-Error = " + Range[1]/MaxSaturations[0]);
      outputGains.println("K-Error Derivative = " + Range[2]/MaxSaturations[1] );
      outputGains.println("K-Fuzzy Output = " + MaxSaturations[2]/Range[0] );
      String aggrMethod = "";
      String impliMethod = "";
      String defMethod = "";
      if (aggregation_method == 1)
      aggrMethod = "'max'";
      else
        aggrMethod = "'sum'";
      if (implication_method == 1)
      impliMethod = "'min'";
      else
        impliMethod = "'prod'";
      if (Def_method == 2)
      defMethod = "'mom'";
      else if (Def_method == 3)
      defMethod = "'lom'";
      else if (Def_method == 4)
      defMethod = "'som'";
      else
        defMethod = "'centroid'";



      output.println("[System]");
      output.println("Name='" + codename + "'");
      output.println("Type='mamdani'");
      output.println("Version=2.0");
      output.println("NumInputs=2");
      output.println("NumOutputs=1");
      output.println("NumRules=" + String.valueOf(maxs[1]*maxs[2]));
      output.println("AndMethod='min'");
      output.println("OrMethod='max'");
      output.println("ImpMethod=" + impliMethod);
      output.println("AggMethod=" + aggrMethod);
      output.println("DefuzzMethod=" + defMethod);
      output.println("");

      // Write input variables
      output.println("[Input1]");
      output.println("Name='Error'");
      output.println("Range=[" + -Range[1] + " " +  Range[1] + "]");
      output.println("NumMFs=" + String.valueOf(maxs[1]));
      for (int i =1; i <= maxs[1]; i ++) {
        if (MF[i][1].type !=3)
        output.println("MF"+ String.valueOf(i)+ "='" + MF[i][1].name + "':'trimf'" +
          ",[" + String.valueOf(MF[i][1].a1)+ " " + String.valueOf(MF[i][1].a2)+ " " + String.valueOf(MF[i][1].a4)+ "]");
        else
          output.println("MF"+ String.valueOf(i)+ "='" + MF[i][1].name + "':'trapmf'" +
            ",[" + String.valueOf(MF[i][1].a1)+ " " + String.valueOf(MF[i][1].a2)+ " " + String.valueOf(MF[i][1].a3)+ " " + String.valueOf(MF[i][1].a4)+ "]");
      }
      output.println("");

      //////////////////////////////////////////////////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////////////////////////////////////////////////

      output.println("[Input2]");
      output.println("Name='Error Derivative'");
      output.println("Range=[" + -Range[2] + " " +  Range[2] + "]");
      output.println("NumMFs=" + String.valueOf(maxs[2]));
      for (int i =1; i <= maxs[1]; i ++) {
        if (MF[i][1].type !=3)
        output.println("MF"+ String.valueOf(i)+ "='" + MF[i][2].name + "':'trimf'" +
          ",[" + String.valueOf(MF[i][2].a1)+ " " + String.valueOf(MF[i][2].a2)+ " " + String.valueOf(MF[i][2].a4)+ "]");
        else
          output.println("MF"+ String.valueOf(i)+ "='" + MF[i][2].name + "':'trapmf'" +
            ",[" + String.valueOf(MF[i][2].a1)+ " " + String.valueOf(MF[i][2].a2)+ " " + String.valueOf(MF[i][2].a3)+ " " + String.valueOf(MF[i][2].a4)+  "]");
      }
      output.println("");


      // Write output variables
      output.println("[Output1]");
      output.println("Name='System Output'"); // Replace with actual name
      output.println("Range=[" + -Range[0] + " " +  Range[0] + "]");
      output.println("NumMFs=" + String.valueOf(maxs[0]));
      for (int i =1; i <= maxs[0]; i ++) {
        if (MF[i][1].type !=3)
        output.println("MF"+ String.valueOf(i)+ "='" + MF[i][0].name + "':'trimf'" +
          ",[" + String.valueOf(MF[i][0].a1)+ " " + String.valueOf(MF[i][0].a2)+ " " + String.valueOf(MF[i][0].a4)+  "]");
        else
          output.println("MF"+ String.valueOf(i)+ "='" + MF[i][0].name + "':'trapmf'" +
            ",[" + String.valueOf(MF[i][0].a1)+ " " + String.valueOf(MF[i][0].a2)+ " " + String.valueOf(MF[i][0].a3)+ " " + String.valueOf(MF[i][0].a4)+ "]");
      }
      output.println("");

      //// Write rules
      output.println("[Rules]");
      for (int i =1; i <= maxs[1]; i ++)
      for (int j =1; j <= maxs[2]; j ++) {
        if (rules_Table[j-1][i-1] !=0) {
          String operator = "1";
          if (rules_Operators[j-1][i-1])
          operator = "2";
          output.println(String.valueOf(i) + " " + String.valueOf(j) + ", "+
            String.valueOf(rules_Table[j-1][i-1]) + " ("+ nf(rules_Weights[j-1][i-1], 0, 0)+") : " + operator);  // Rule 1
        }
      }
      outputGains.flush();
      outputGains.close();
      output.flush();
      output.close();
      Matlab_b.activated = false;
    }
  }
  );
  FisExportThread.start();
}



void PrintHowToUseCpp() {
  writer.println("//------------------------------ HOW TO USE !! ------------------------------");
  writer.println();
  writer.println("");
  writer.println("");
  writer.println("// #include\"" + surfacename + ".h\"");
  writer.println("// float error =  X;   // the error value. 'X' is the mapped value of the error according to the maximum saturation and the universe of discourt Range");
  writer.println("// float D_error  = dX;   // the error derivative value. 'dX' is the mapped value of the error derivative according to the maximum saturation and the universe of discourt Range");
  writer.println("// float ctr_output;     // the variable where we put the output of the fuzzy PD controller");
  writer.println("// Now, how to calculate the control output");
  writer.println("// Simply, we take the integer value of the mapped error and its derivative");
  writer.println("");
  writer.println("// ctr_output = FPD_controller[int(D_error)][int(error)];");
  writer.println("");
  writer.println("// re-map out the crt_output according to the universe of discourt Range and the maximum saturation of your process accordingly");
  writer.println("");
  writer.println("");
  writer.println("const float FPD_controller[" + int(200/surfaceResolution[GrCounter]) + "][" + int(200/surfaceResolution[GrCounter]) + " ] = {");
}

void PrintHowToUsePy() {
  writer.println("#------------------------------ HOW TO USE !! ------------------------------");
  writer.println();
  writer.println("");
  writer.println("");
  writer.println("# from " + surfacename + " import FPD_controller");
  writer.println("# error =  X;   // the error value. 'X' is the mapped value of the error according to the maximum saturation and the universe of discourt Range");
  writer.println("# D_error  = dX;   // the error derivative value. 'dX' is the mapped value of the error derivative according to the maximum saturation and the universe of discourt Range");
  writer.println("# ctr_output;     // the variable where we put the output of the fuzzy PD controller");
  writer.println("# Now, how to calculate the control output");
  writer.println("# Simply, we take the integer value of the mapped error and its derivative");
  writer.println("");
  writer.println("# ctr_output = FPD_controller[int(D_error)][int(error)];");
  writer.println("");
  writer.println("# re-map out the crt_output according to the universe of discourt Range and the maximum saturation of your process accordingly");
  writer.println("");
  writer.println("");
  writer.println("FPD_controller = [");
}
