void initializeButtons() {
  fctsbtn_b= new Button[18];
  shapes_b= new Button[11];
  shapes2_b = new Button[11];
  rulesbuttons_b= new Button[5];
  Gain_plus_b= new Button[9];
  Gain_minus_b= new Button[9];
  KPplus_b = new Button[9];
  KPminus_b = new Button[9];
  Surface_b =new Button[3];
  GainOpt_b  =new Button[8];
  GainAdjust_b =new Button[6];
  range_b = new Button[3];
  defuzz_b =new Button[6];
  infer_b= new Button[2];
  aggregation_b = new Button[2];
  dataSave_b= new Button[3];
  dataRecord_b= new Button[3];
  GraphUPDown_b=new Button[2];
  opt_start_b = new Button[2];
  opt_var = new Button[4];
  erroFct_b = new Button[6];
  fitfunc_b = new Button[3];
  MFsGA_b = new Button[3];
  WeiGA_b = new Button[3];
  optSide_b = new Button[6];
  crossOverStyle_b = new Button[2];

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////

  for (int i=0; i<10; i++) {
    shapes_b[i]=new Button(1300, i*70, 65, 70, 200, #D3D8A0, #D3D8A0, 2, 7, false);
    shapes2_b[i]=new Button(1365, i*70, 80, 70, 200, #D3D8A0, #D3D8A0, 2, 7, false);
  }
  UART_b = new Button(1365, 700, 80, 70, 200, #D3D8A0, #D3D8A0, 2, 7, false);
  UARTenable_b = new Button(1300, 700, 65, 70, 200, #D3D8A0, #D3D8A0, 2, 7, false);
  int[] colors = {#FF0F0F, #F7B705, #38FF03};
  for (int i=0; i<18; i+=6) {
    int btx;
    int bty;
    if (i<6)
    {
      btx=1145;
      bty=165;
    } else if (i<12) {
      btx=1145;
      bty=365;
    } else {
      btx=495;
      bty=165;
    }
    for (int j=0; j<6; j++) {
      fctsbtn_b[i+j]= new Button(btx +j*25, bty, 20, 30, #FFFFFF, colors[i/6], colors[i/6], 2, 4, true);
    }
  }
  int Si = 20;
  int Si2 = 30;
  int[] btx = {0, 650 - Si, 650, 1300-Si, 650, 1300 - Si};
  int[] btx2 = {325, 975, 975};
  int[] bty = {0, 0, 0, 0, 200, 200};
  colors[0]=#38FF03;
  colors[1]=#FF0F0F;
  colors[2]=#F7B705;
  for (int i =0; i <6; i +=2) {
    optSide_b[i]= new Button(btx[i], bty[i], Si + 5, Si, 255, 255, colors[i/2], 1.5, 4, false);
    optSide_b[i+1]= new Button(btx[i+1] -5, bty[i+1], Si + 5, Si, 255, 255, colors[i/2], 1.5, 4, false);
    MFsGA_b[i/2] =new Button(btx[i] + 480 - Si2, bty[i] + 195 - Si2, Si2 +10, Si2, 255, 255, colors[i/2], 2, 2, false);
    WeiGA_b[i/2] =new Button(btx[i] + 445 - Si2, bty[i] + 200 - Si2, Si2, Si2-10, 200, colors[i/2], colors[i/2], 2, 2, false);
    optSide_b[i].activated=true;
    optSide_b[i + 1].activated=true;
    MFsGA_b[i/2].activated = true;
  }
  for (int i =0; i <3; i ++)
    range_b[i] = new Button(btx2[i]-10, bty[i*2], 20, 12, 200, colors[i], colors[i], 2, 2, false);


  for (int i=0; i<6; i+=2) {
    defuzz_b[i]= new Button(1145, 470+24*i/2, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 7, true);
    defuzz_b[i + 1]= new Button(1215, 470+24*i/2, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 7, true);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////

  AddInput_b = new Button(180, 230, 25, 25, 200, color(#FCDF94), #25F514, 2, 5, true);
  SubInput_b = new Button(205, 230, 25, 25, 200, color(#FCDF94), #25F514, 2, 5, true);
  UpInput_b = new Button(230, 230, 25, 25, 200, color(#FCDF94), #25F514, 2, 5, true);
  DownInput_b = new Button(255, 230, 25, 25, 200, color(#FCDF94), #25F514, 2, 5, true);
  resetInput_b = new Button(40, 230, 70, 25, 200, color(#FCDF94), #25F514, 2, 5, true);
  pushInput_b = new Button(110, 230, 70, 25, 200, color(#FCDF94), #25F514, 2, 5, true);
  
  AdaptiveC_b = new Button(900, 405, 200, 30, 200, color(#FCDF94), #25F514, 2, 7, true);
  AdaptiveC2_b = new Button(170, 390, 150, 25, 200, color(#FCDF94), #25F514, 1, 7, true);
  //AdaptiveC_b.activated = AdaptiveC2_b.activated = true;
  resetGains = new Button(1150, 405, 100, 30, 200, color(#FCDF94), #25F514, 2, 7, true);
  BABS = new Button(965, 410, 70, 20, 200, color(#FCDF94), #25F514, 2, 7, true);        // for Ball and Beam
  BABModelParmetersSdisp = new Button(1110, 410, 20, 10, 200, color(#FCDF94), #25F514, 2, 2, false);  // for Ball and Beam
  BABS.activated = true;

  tfUpload_b = new Button(1270, 410, 20, 20, 200, color(#FCDF94), #25F514, 2, 7, true);
  B_DLeft_b = new Button(0, 400, 50, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
  B_DRight_b = new Button(50, 400, 50, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
  B_DMove_b = new Button(0, 200, 40, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
  graphSave_b = new Button(40, 200, 30, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
  Process_b = new Button(0, 230, 40, 30, 200, color(255, 0, 0), #25F514, 2, 5, true);
  discreteSys_b = new Button(520, 400, 130, 30, 200, color(#FCDF94), 200, 2, 2, true);

  for (int i=0; i<9; i++) {
    if (i<2) {
      Surface_b[i] = new Button(975, 660+32*i, 160, 30, 200, color(#FCDF94), color(#FCDF94), 1.5, 7, true);
      crossOverStyle_b[i] = new Button(1245, 625 + i * 20, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 2, 5, true);
      dataSave_b[i]= new Button(660, 630+i*30, 140, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
      dataRecord_b[i]= new Button(805, 630+i*30, 150, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
      GraphUPDown_b[i]=new Button(590+i*30, 200, 30, 30, 200, color(255, 200, 0), color(255, 0, 0), 2, 5, false);
      fitfunc_b[i] = new Button(1027 + i * 120, 530, 15, 10, 200, color(255, 0, 0), color(255, 0, 0), 2, 5, false);
      opt_var[i] = new Button(660+i*63, 440, 60, 33, #05E2E8, color(#FCDF94), #05E830, 1.5, 7, true);
      infer_b[i]= new Button(1215, 615+22*i, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 7, true);
      aggregation_b[i]= new Button(1145, 615+22*i, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 7, true);
    }
    if (i < 3)
    {
      KPminus_b[i] =new Button(1070, 660 +30*i, 20, 30, 200, color(#FCDF94), #25F514, 1.5, 0, true);
      KPplus_b[i] =new Button(1215, 660+30*i, 20, 30, 200, color(#FCDF94), #25F514, 1.5, 0, true);
    }
    if (i<5) {
      GainAdjust_b[i] = new Button(660, 440+30*i, 110, 30, #FFFFFF, color(#FCDF94), color(#FCDF94), 0.5, 0, false);
      GainOpt_b[i] = new Button(925, 445+30*i, 20, 20, 200, color(#FCDF94), #05E2E8, 1.5, 7, false);
      rulesbuttons_b[i]= new Button(975, 465+32*i, 160, 30, 200, color(#FCDF94), color(#FCDF94), 1.5, 7, true);
    } else if (i<8)
      GainOpt_b[i] = new Button(1252, 665+30*(i - 5), 20, 20, 200, color(#FCDF94), #05E2E8, 1.5, 7, false);

    Gain_plus_b[i] =new Button(771, 410+30*i, 20, 30, 200, color(#FCDF94), #25F514, 1.5, 0, true);
    Gain_minus_b[i] =new Button(891, 410+30*i, 20, 30, 200, color(#FCDF94), #25F514, 1.5, 0, true);
  }
  sentToSerial_b = new Button(1260, 630, 30, 30, #0555FC, color(#FCDF94), #25F514, 1.5, 5, true);



  defuzz_b[0].activated = infer_b[0].activated = aggregation_b[0].activated = true;

  Surface_b[2] = new Button(975, 724, 115, 30, 200, color(#FCDF94), color(#FCDF94), 1.5, 7, true);
  PLC_b = new Button(1090, 724, 100, 30, 200, color(#FCDF94), color(#FCDF94), 1.5, 7, true);
  JML_b = new Button(1190, 724, 100, 30, 200, color(#FCDF94), color(#FCDF94), 1.5, 7, true);
  Matlab_b = new Button(975, 724, 115, 30, 200, color(#FCDF94), color(#FCDF94), 1.5, 7, true);

  for (int j = 0; j < 2; j ++) {
    erroFct_b[j] =new Button(955 + j * 70, 440, 15, 15, 200, color(255, 0, 0), color(255, 0, 0), 1.5, 10, false);
    erroFct_b[j + 2 ] =new Button(955 + j * 70, 465, 15, 15, 200, color(255, 0, 0), color(255, 0, 0), 1.5, 10, false);
  }
  opt_var[2] = new Button(786, 440, 87, 33, #05E2E8, color(#FCDF94), #05E830, 1.5, 7, true);
  opt_var[3] = new Button(876, 440, 60, 33, #05E2E8, color(#FCDF94), #05E830, 1.5, 7, true);
  fitfunc_b[0].activated = true;
  erroFct_b[0].activated = true;
  opt_var[0].activated=true;
  crossOverStyle_b[0].activated = true;


  dataSave_b[2] = new Button(660, 720, 140, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
  dataRecord_b[2] = new Button(805, 720, 150, 30, 200, color(#FCDF94), #25F514, 2, 5, true);
  rule_up_b = new Button(630, 200, 20, 20, 200, 200, color(0, 0, 255), 1.5, 0, false);
  rule_down_b = new Button(630, 690, 20, 20, 0, 200, color(0, 0, 255), 1.5, 0, false) ;
  rule_left_b = new Button(0, 690, 20, 20, 0, 200, color(0, 0, 255), 1.5, 0, false);
  rule_right_b = new Button(610, 690, 20, 20, 0, 200, color(0, 0, 255), 1.5, 0, false);
  Rules_anim_b = new Button(878, 420, 87, 30, 200, color(#FCDF94), color(#FCDF94), 2, 4, true);
  Rules_Edit_b = new Button(807, 420, 70, 30, 200, color(#FCDF94), color(#FCDF94), 2, 4, true);

  surfaceRot_b = new Button(0, 200, 70, 25, 200, color(#FCDF94), color(#FCDF94), 2, 4, true);
  surfaceGrid_b = new Button(70, 200, 120, 25, 200, color(#FCDF94), #25F514, 2, 4, true);
  surfaceGains_b = new Button(190, 200, 140, 25, 200, color(#FCDF94), color(#FCDF94), 2, 4, true);
  surfaceProjection_b = new Button(330, 200, 140, 25, 200, color(#FCDF94), color(#FCDF94), 2, 4, true);


  Python_b = new  Button(200, 740, 110, 25, 200, color(#FCDF94), color(#FCDF94), 1.5, 3, true);
  Cpp_b = new  Button(310, 740, 110, 25, 200, color(#FCDF94), color(#FCDF94), 1.5, 3, true);
  surfaceGradation_b = new Button(420, 740, 100, 25, 200, color(#FCDF94), color(#FCDF94), 2, 4, true);

  opt_start_b[0] = new Button(985, 560, 57, 35, #05E2E8, color(#FCDF94), #05E830, 2, 8, true);
  opt_start_b[1] = new Button(1048, 560, 57, 35, #05E2E8, color(#FCDF94), #05E830, 2, 8, true);
  GA_animation_b = new Button(985, 600, 120, 25, #05E2E8, color(#FCDF94), #05E830, 2, 5, true);
  speedUp_b = new Button(1110, 560, 30, 65, #05E2E8, color(#FCDF94), #05E830, 2, 5, true);
  speedDown_b = new Button(950, 560, 30, 65, #05E2E8, color(#FCDF94), #05E830, 2, 5, true);
  changeF_b = new Button(1105, 478, 40, 20, 200, color(#FCDF94), #25F514, 2, 5, true);
  DNA_Activator_b = new Button(1275, 715, 15, 30, color(200, 200), color(#FCDF94), #05E830, 2, 0, false);
  linkedMFs_b =new Button(720, 645, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  symmetricalMFs_b = new Button(920, 675, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  pushedMFs_b = new Button(720, 675, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  upperWidthMFs_b = new Button(840, 645, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  lowerWidthMFs_b = new Button(840, 675, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  rulesMode_b = new Button(0, 200, 160, 30, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);
  resetOperatorTable_b = new Button(160, 200, 75, 30, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);
  rulesNames_b = new Button(235, 200, 150, 30, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);
  rulesFilter_b = new Button(385, 200, 110, 30, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);

  rulesCenter_b = new Button(1140, 542, 50, 31, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);
  rulesMedium_b = new Button(1190, 542, 50, 31, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);
  rulesEdges_b = new Button(1240, 542, 50, 31, 200, color(#FCDF94), color(#FCDF94), 2, 7, true);

  rulesOpt_b = new Button(1010, 675, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  operatorsOpt_b = new Button(1125, 675, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  noRule_b = new Button(1125, 645, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  rulesWeights_b = new Button(1030, 645, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 1.5, 5, true);
  rulesOpt_b.activated =true;
  rulesNames_b.activated =true;


  Xmouse_b = new Button(615, 745, 35, 25, color(200, 250), color(#FCDF94), color(#FCDF94), 2, 5, false);
  Ymouse_b = new Button(580, 745, 35, 25, color(200, 250), color(#FCDF94), color(#FCDF94), 2, 5, false);
  Umouse_b = new Button(545, 745, 35, 25, color(200, 250), color(#FCDF94), color(#FCDF94), 2, 5, false);


  debugUP_b = new Button(505, 745, 40, 25, color(200, 250), color(#FCDF94), color(200), 2, 5, false);
  debugStart_b = new Button(465, 745, 40, 25, color(200, 250), color(#FCDF94), color(0, 200, 0), 2, 5, false);
  debugReset_b = new Button(425, 745, 40, 25, color(200, 250), color(#FCDF94), color(200), 2, 5, false);
  debugDown_b = new Button(385, 745, 40, 25, color(200, 250), color(#FCDF94), color(200), 2, 5, false);
  blockDiagram_b = new Button(280, 745, 105, 25, color(200, 250), color(#FCDF94), color(#FCDF94), 2, 5, false);
  DNA_Activator_b.activated = true;

  grid_b= new Button(560, 200, 30, 30, 200, color(#FCDF94), #25F514, 1.5, 5, true);
  elitism_b = new Button(1245, 570, 15, 15, 200, color(#FCDF94), color(255, 0, 0), 2, 5, true);

  VscrBar = new VerticalScrollbar(1270, 660, 20, 90, 50, 6);
  scrBar  = new ScrollBar(1170, 690, 100, #FC030B, 0, 100, 50);
  progBar = new ProgressBar(0, 735, 650, 10, color(#DEC7C7), 650, simulationSteps * Imax, dragged_I*Imax);

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  hollowBall = new Button(120, 297, 15, 15, 230, color(#FCDF94), #FF0329, 1.5, 8, false);
  solidBall = new Button(230, 297, 15, 15, 230, color(#FCDF94), #FF0329, 1.5, 8, false);

  fixedWinds  = new Button(505, 332, 15, 15, 230, color(#FCDF94), #FF0329, 1.5, 8, false);
  noisyWinds  = new Button(575, 332, 15, 15, 230, color(#FCDF94), #FF0329, 1.5, 8, false);
  resetWinds = new Button(595, 385, 50, 25, 200, color(#FCDF94), #25F514, 1.5, 8, false);
  dispWinds  = new Button(595, 355, 50, 25, 200, color(#FCDF94), #25F514, 1.5, 8, false);
  hollowBall.activated =noisyWinds.activated = true;
}
