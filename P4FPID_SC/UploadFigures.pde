void uploadFigures() {
  v= createGraphics(650, 570, P3D);
  r= createGraphics(140, 180, P3D);
  g= createGraphics(650, 550, P2D);
  font1= loadFont("Fonts/ArialMT-48.vlw");
  font2= loadFont("Fonts/TimesNewRomanPSMT-48.vlw");
  font3 = createFont("TimesNewRomanPSMT", 32);
  folder = loadImage("Icons/folder.PNG");
  folder2 = loadImage("Icons/folder2.PNG");
  save = loadImage("Icons/save.PNG"); 
  usb = loadImage("Icons/usb.png");
  CoupledTanks = loadImage("Icons/CoupledTack.PNG");


  OpenedLoopblock_S = loadImage("Icons/Opened-Loop S.PNG");
  ClosedLoopblock_S = loadImage("Icons/Closed-Loop S.PNG");
  OpenedLoopblock_Z = loadImage("Icons/Opened-Loop Z.PNG");
  ClosedLoopblock_Z = loadImage("Icons/Closed-Loop Z.PNG");
  PIDblock_C = loadImage("Icons/PID continuous.PNG");
  PDPlusIblock_C = loadImage("Icons/PD+I continuous.PNG");
  PIDblock_D = loadImage("Icons/PID discrete.PNG");
  PDPlusIblock_D = loadImage("Icons/PD+I discrete.PNG");
  P4FPIDblock = loadImage("Icons/P4FPID.PNG");
  //CoupledTanks = loadImage("Icons/CoupledTack.PNG");

  JML_Icon = loadImage("Icons/JML.png");
  PLC_Icon = loadImage("Icons/PLC.png");
  MATALB_Icon = loadImage("Icons/Matlab.png");
  Python_Icon = loadImage("Icons/Python.png");
  Cpp_Icon = loadImage("Icons/C++.png");
  MaxSaturationIcon = loadImage("Icons/MaxSaturation.PNG");
}
