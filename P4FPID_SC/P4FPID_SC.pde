import processing.serial.*; // the only used libarary

boolean saveSVG = false;
PrintWriter writer;
PrintWriter output, outputGains;
PImage  folder, folder2, save, usb, JML_Icon, PLC_Icon, MATALB_Icon, Python_Icon, Cpp_Icon, MaxSaturationIcon,
  controlBlock, PIDblock_C, PDPlusIblock_C, PIDblock_D, PDPlusIblock_D, OpenedLoopblock_S, ClosedLoopblock_S, OpenedLoopblock_Z, ClosedLoopblock_Z, P4FPIDblock, CoupledTanks;
PFont font1, font2, font3;
PGraphics v, r, g;
String Cursor=" |"; 
String fileName="Untitled", codename = "Untitled", surfacename = "Untitled";
String saving_Path;
String import_Path;
String SerialReivedSent;
String PanelSent = "turn on led 13";
StringList SerialConversation = new StringList();
char[] typing=new char[50];
float ein, dein, yout1, yout2, yout3, ein1, Ke=1, Kde=1, Ky1=1, Ky2 = 1, Ky3 = 1, corner_Left, corner_Right, surfaceRrotateCounter = 0, delta = 0.02f, step=1, rulestext,
  Max_sat=100, zoom_3D=35, SetPoint=50, Ts=0.02, MoMR, MoML, currentFit, RTPy1, rot_X=329.67, rot_Y=322.24, GA_Progression, U, UTheta, GAUSS = sqrt(log(30000)), timeTick=1,
  simulationTime = 20, simulationSteps = int(simulationTime/Ts), recTime, IN, Trs = 0.02, bestFit, averageFit = 1, RZ=45, GainsMax = 2, GainsMin = 0.5
  , min3D, max3D, GASatMin=150, GASatMax=200, debugY1, debugY2, debugY3;


FloatList offline_E   = new FloatList();
FloatList offline_dE  = new FloatList();
FloatList offline_sys = new FloatList();
FloatList offline_er  = new FloatList();
FloatList offline_der = new FloatList();
FloatList offline_y1  = new FloatList();
FloatList offline_y2  = new FloatList();
FloatList offline_y3  = new FloatList();
FloatList offline_theta  = new FloatList();
FloatList offline_dtheta  = new FloatList();
FloatList offline_ddtheta  = new FloatList();
FloatList offline_ctr = new FloatList();
FloatList offline_SetPoint = new FloatList();


FloatList online_E   = new FloatList();
FloatList online_dE  = new FloatList();
FloatList online_sys = new FloatList();
FloatList online_ctr = new FloatList();
FloatList online_er  = new FloatList();
FloatList online_der = new FloatList();
FloatList online_y1  = new FloatList();
FloatList online_y2  = new FloatList();
FloatList online_y3  = new FloatList();
FloatList online_SetPoint = new FloatList();

FloatList  recorded_sys = new FloatList();
FloatList  recorded_ctr = new FloatList();
FloatList  recorded_er  = new FloatList();
FloatList  recorded_der = new FloatList();
FloatList  recorded_y1  = new FloatList();
FloatList  recorded_y2  = new FloatList();
FloatList  recorded_y3  = new FloatList();
FloatList  recorded_SetPoint = new FloatList();

FloatList inputIntervals = new FloatList();
FloatList inputRanges = new FloatList();
int InputMax = 1, InputIndex = 1;
FloatList Input = new FloatList();

float[] fs = new float[3];
float[] Gain_max_GA= new float[3];
float[] UoD = new float[1001];
float[] EmptyUoD = new float[1001];
float[] mp = new float[1001];
float[] Deno_ = new float[20];
float[] NewDeno_ = new float[20];
float[] Nome_ = new float[20];
float[] Range = {100, 100, 100};
float[] VariableSaturations = {100, 100, 100};
float[] MaxSaturations = {100, 100, 100};
float[][] Surface=new float[200][200];
double[][] Rang_kutta_= new double[20][7];
double[][] A_Rang_kutta_= new double[20][7];
double[][] B_Rang_kutta_= new double[20][7];
float[][] transfer_fct= new float[40][4];
float[][][] Systems= new float[20][4][10];
float[][][] RK = new float[10][6][7];
float[][][] refrenceMFs = new float[23][3][5];
boolean[] rangeDrag = new boolean[3];
boolean mousePressCatched=true, usbPlugged, buildingSetpoints, waitDefaultFile, hold3D, ControllerOn = true, ruleEditing, symmetry, surface_3D, NormalityEnabled, Integral = true, openedLoop = false, Already_Started, serial_state, still_sending, InputDragged, sysDragged, fuzzy = true, InLoop, resetDebug = true, windowOpened, fitType, uartFailed, mouseWheeling, tableMode,
  resetOperators, GAFailed, GASucced, ComState, GANegativeError, rulesAnimDragDEr, rulesAnimDragEr, rulesBarDrag, newChangeHappened, alreadyKeyPressed, PushALL, LinkedMF,
  rightMouse, Launch3D_Update, Launch2D_Update, LaunchGAOp, LaunchRecord, LaunchInputs, doneSending = true;

boolean Sleeping, l1Drag, l2Drag;
int sleepingTimer, gj = 100;

float Imax = 0.5, draggedMV_X=975, draggedMV_Y=140, rulesStep = 0.05, onlineControl, debugedP, debugedC, tau = 0.5, filterGain = tau/ (tau + Ts), PreviousDer, onlinePreviousDer, RTPreviousDer;
int  Vmax=150, endy, executionTime, dragged_I, endt, sta, MFtype, face, name_index, output_number, inumber, iinumber,
  j_point, draggedMF_index, draggedMF_Parameter, tablei=1, tablej=1, initCounter, popCounter, genCounter, RulesView_begin, ruleswheel=1, selected, wheel, wheel2, draggedMV_I=-1,
  ODE=6, typing_counter, rulesMode, BaudRate, implication_method=1, aggregation_method=1, Def_method=1, curcounter, Z=45, nomenator, denomenator,
  minWei = 20, maxWei = 100, port_, Y_Translation = -30, noRuleIndex = 1, UlineY = 255, GrCounter = 4, recordTime, GA_Speed = 5, GA_Counter, fitK = 1000, fitN = 2, FrameCounter, FrameCounter2
  , selectedRec = 1, mouseWheelingTimer, SerialTimeLug, individuals, BD_Index = 3, generation, bestElt, rotWheel, debugSpeed = 25, debugtimer
  , Td, sysIndex = 1, sysMax =1, dispIndex = 2, ProcessIndex=0, movingStep = 1;

int[] vd = new int[200];
int[] maxs = new int[3];
int[] bs = new int[3];
int[] high = new int[3];
int[] weightsShape = new int[3];
int[] surfaceResolution = {1, 2, 4, 5, 10, 20, 25};
byte[] serial_sequence = new byte[4];
int[][] rules_Table =new int[13][13];
float[][] rules_Weights =new float[13][13];
boolean[][] rules_Operators = new boolean[13][13];
IntList MFsIndivSize= new IntList();
IntList MFsPop= new IntList();
IntList rulesTrend = new IntList();
FloatList weightsTrend = new FloatList();
FloatList pxx = new FloatList();
FloatList pyy = new FloatList();
color[] graphColor = {color(0, 0, 255), 0, #FF0F0F, #FCA900, #06B925, #FA0AF7, #6D00FF, #6D00FF,
  #C104C1, #027E95, #F5560C};
Serial myPort;
ScrollBar scrBar;
VerticalScrollbar VscrBar;
ProgressBar progBar;
DropdownChecklist Signalsdropdown;
DropdownSimple ODedropdown, maxSats, dispMode;
mbmfct[][] MF = new mbmfct[23][3];
GeneticAlgorithm G_A = new GeneticAlgorithm();
MVBox[] MVB = new MVBox[3];

Button[] fctsbtn_b, shapes_b, shapes2_b, rulesbuttons_b, Surface_b, defuzz_b, infer_b, aggregation_b, Gain_plus_b, Gain_minus_b, dataSave_b,
  KPplus_b, KPminus_b, GraphUPDown_b, geneticA_b, opt_var, opt_start_b, dataRecord_b, erroFct_b, fitfunc_b, MFsGA_b, WeiGA_b, optSide_b,
  GainOpt_b, GainAdjust_b, crossOverStyle_b, range_b;

Button rule_up_b, rule_down_b, rule_right_b, rule_left_b, Rules_anim_b, Rules_Edit_b, AdaptiveC_b, AdaptiveC2_b, resetGains,
  GA_animation_b, weights_b, linkedMFs_b, symmetricalMFs_b, UART_b, UARTenable_b,
  grid_b, DNA_Activator_b, speedUp_b, speedDown_b, changeF_b, surfaceRot_b
  , pushedMFs_b, surfaceGrid_b, surfaceGains_b, PLC_b, JML_b, Matlab_b, Python_b, Cpp_b, upperWidthMFs_b, lowerWidthMFs_b, operatorsOpt_b, rulesOpt_b,
  noRule_b, rulesWeights_b, rulesMode_b, rulesFilter_b, rulesNames_b, resetOperatorTable_b, elitism_b, surfaceProjection_b, surfaceGradation_b
  , rulesCenter_b, rulesEdges_b, rulesMedium_b, Amouse_b, Xmouse_b, Ymouse_b, Umouse_b, debugStart_b, debugReset_b, debugUP_b, debugDown_b,
  blockDiagram_b, discreteSys_b, resetInput_b, AddInput_b, SubInput_b, pushInput_b, hollowBall, solidBall, fixedWinds, noisyWinds, resetWinds
  , dispWinds, UpInput_b, DownInput_b, B_DLeft_b, B_DRight_b, B_DMove_b, graphSave_b, Process_b, sentToSerial_b, BABS, BABModelParmetersSdisp, tfUpload_b;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
PVector S1 = new PVector(70, 550);
float l1 = 40;
float l2 = 300;
float l  = 0.6;
float ScalProcess = 0.9;
float B           = 0.1;       // viscous friction
float Kt          = 1;
PVector S2 = new PVector(S1.x + l2 + l1, 660);
float difr = 0;
float difL = S2.y - S1.y - difr;
float suplyVoltage = 5, constK = 30, constT = 10, constB = 0.03, Bmin = 0, Bmax = 0.03,
  beamMass = 50, ballMass = 2.7, ballRaduis = 2.5, thetaMax = 8, theta0 = 1;
FloatList PerlineX = new FloatList();
int simTik = 0;
ArrayList<Particle> particles;
float speed = 1;
int minX = 0;
int maxX = 650;
int minY = 500;
int maxY = 750;
float Airspeed = 3;
float refA1, refA4, refWidth;
float ErSum;
int ErTimeSum;
int ErWindow = 150;
int ErMaxWindow = 10;
float FCenter= 0;
boolean cycle;

void setup() {
  size(1445, 770, P2D);
  surface.setResizable(true);
  windowRatio(1445, 770);
  initializeButtons();
  initializeRKMatrix();
  initiateSerialCom();
  uploadFigures();
  initializeDropdownLists();
  setUpFisDisplay();
  importDefualtFile();



  update_2Dplot();
  LaunchGraphUpdateThread();
  InitializeAirParticles();
  face = 2;
}


void draw() {
  background(#FFFFFF);
  MainInterface();
  if ( face==1 ) {
    Interface_1();
  } else if ( face==2 ) {
    Interface_2();
  } else if ( face==3 ) {
    Interface_3();
  } else if ( face==4 ) {
    Interface_4();
  }
  //fill(0);
  //textFont(font2, 18);
  //text("Execution Time = " + executionTime, 500, 250);
  //println("Execution Time = ", executionTime);
}
