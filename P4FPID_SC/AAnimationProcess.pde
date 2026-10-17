void animateProcess() {
  if (ProcessIndex == 0)
    animateBallAndBeam(0);
  else if (ProcessIndex == 1)
    animateCoupledTanks();
  else if (ProcessIndex == 2)
    drawMaglevSystem3D();
  else if (ProcessIndex == 3)
    drawRoboticArm3D();
  fill(255);
  strokeWeight(1);
  rect(-200, 0, 200, 800);
}


void animateBallAndBeam(int shiftXX) {
  try {
    debugedP = offline_sys.get(Td)*l*10;
    debugedC = UTheta;
  }
  catch (Exception e) {
  }
  if (dispIndex == 2) {
    textSize(18);
    textFont(font2, 18);
    hollowBall.display();
    solidBall.display();
    fixedWinds.display();
    noisyWinds.display();
    hollowBall.setSideText("Hollow", 0.9, 5);
    solidBall.setSideText("Solid", 0.9, 5);
    fixedWinds.setSideText("Fixed", 0.9, 5);
    noisyWinds.setSideText("Noisy", 0.9, 5);
    resetWinds.display();
    resetWinds.setText("Reset", 0.7);
    dispWinds.display();
    dispWinds.setText("disp", 0.7);
    AdaptiveC2_b.display();
    textFont(font2, 16);
    if (AdaptiveC2_b.activated)
      AdaptiveC2_b.setText("Adaptive Control ON", 0.7);
    else
      AdaptiveC2_b.setText("Adaptive Control OFF", 0.7);
    if (BD_Index == 0)
      text("Fuzzy PID Controller", 10, 407);
    else if (BD_Index == 1)
      text("Fuzzy PD+I Controller", 10, 407);
    else if (BD_Index == 3)
      text("Closed Loop Control", 10, 407);
    else
      text("Opened Loop Control", 10, 407);
    noFill();
    textFont(font2, 18);
    rect(5, 390, 155, 25, 5);
    fill(0);
    text("L1 (cm) = ", 10, 250);
    text("L2 (cm) = ", 10, 280);
    text("Ball Type : ", 10, 310);
    text("Ball mass (g) = ", 10, 340);
    text("Ball radius (cm) = ", 10, 370);



    fill(0);
    stroke(0);
    strokeWeight(2);
    line(325, 230, 325, 420);
    line(0, 420, 650, 420);

    text("V suply (volt) = ", 330, 250);
    text("Sevro Constant: T = ", 330, 280);
    text("Sevro Constant: K = ", 330, 310);
    text("Winds  Type :  ", 335, 345);
    if (noisyWinds.activated) {
      text("Wind max", 335, 370);
      text("Wind min", 335, 400);
    } else {
      text("Wind = ", 335, 370);
    }


    noFill();
    strokeWeight(1.5);
    textSize(20);
    rect(150, 235, 100, 25, 5);  // l1
    textCaseVar(1, 80, l1/10, 200, 255);
    rect(150, 265, 100, 25, 5);  // loverl1
    textCaseVar(1, 81, l2/10, 200, 285);
    rect(150, 325, 100, 25, 5);  // ball mass
    textCaseVar(1, 82, ballMass, 200, 345);
    rect(150, 355, 100, 25, 5);  // ball raduis
    textCaseVar(1, 83, ballRaduis, 200, 375);


    if (noisyWinds.activated) {
      rect(445, 355, 100, 25, 5);
      rect(445, 385, 100, 25, 5);
      textCaseVar(3, 89, Bmax, 495, 375);
      textCaseVar(3, 90, Bmin, 495, 405);
    } else {
      rect(445, 355, 100, 25, 5);
      textCaseVar(4, 84, constB, 495, 375);
    }
    //////////////////////////

    rect(480, 235, 100, 25, 5);  // suply voltage
    textCaseVar(1, 85, suplyVoltage, 530, 255);
    rect(480, 265, 100, 25, 5);  // beam mass
    textCaseVar(1, 86, constT, 530, 285);
    rect(480, 295, 100, 25, 5);  // K constant
    textCaseVar(1, 87, constK, 530, 315);
    displayWinds();
  }
  pushMatrix();
  translate(0, 70);
  scale(0.9);

  float angle = PI/theta0;
  float angleDif = PI/thetaMax;
  if (UART_b.activated)
    angle = map(onlineControl, -100, 100, angle - angleDif, angle + angleDif);
  else if (Td >0)
    angle = -debugedC + angle;

  S2.x = S1.x + l2 + l1;

  strokeWeight(4);
  ///////////////////////////////////////////////////////////////// drawing Perline Noise 
  pushMatrix();
  translate(shiftXX, 0);
  ///////////////////////////////////////////////// drawing the support
  strokeWeight(3);
  stroke(0);
  fill(200);
  arc(S1.x, S1.y, 100, 100, 0, PI);
  fill(255);
  arc(S1.x, S1.y, 80, 80, 0, PI);
  fill(200);
  rect(10, 720, 680, 10); // largest line
  rect(20, 670, 10, 50); // first smallest line
  rect(70, 550, 10, 170); // second high line
  fill(200); // semi-transparent fill
  stroke(0);
  beginShape();
  vertex(20, 670);  // bottom of left line
  vertex(70, 550);  // top of left line
  vertex(80, 550);  // top of right line
  vertex(30, 670);  // bottom of right line
  endShape(CLOSE);
  stroke(0, 200, 0);
  strokeWeight(5);
  line(S1.x - 50, S1.y, S1.x + 50, S1.y);
  line(S1.x-50, S1.y, S1.x -50, S1.y - 50);




  ///////////////////////////////////////////////// drawing the servo motor
  strokeWeight(3);
  stroke(0);
  fill(#026D9D);
  rect(S2.x - 20, S2.y - 20, 60, 80); // the servo motor support
  fill(50);
  rect(S2.x - 10, S2.y - 20, 40, 20); // the servo motor
  stroke(255);
  strokeWeight(8);
  fill(#0ABC02);
  ellipse(S2.x, S2.y, 10, 10);
  ///////////////////////////////////////////////////////////////////////////////////
  if (dispWinds.activated) {
    displayAirParticles();
  }

  ///////////////////////////////////////////////////////////////////////////////////

  PVector A = new PVector(S2.x+l1*cos(angle), S2.y+l1*sin(angle));
  PVector B = circleIntersectionLowestY(S1.x, S1.y, l2, A.x, A.y, difL); //
  PVector C = B; //rotateVectorAroundPoint(S1, B, -atan(difr / l2));
  float BetweenAngle = PVector.angleBetween(PVector.sub(C, S1), new PVector(100, 0));
  PVector Ball = new PVector();

  ballRaduis*=10;
  if (UART_b.activated) {
    Ball = new PVector(S1.x + IN*10, S1.y-15);
    if (onlineControl > 50)
      Ball = rotateVectorAroundPoint(S1, Ball, -BetweenAngle);
    else
      Ball = rotateVectorAroundPoint(S1, Ball, BetweenAngle);
  } else {
    Ball = new PVector(S1.x + debugedP +  ballRaduis, S1.y-ballRaduis);
    if (debugedC <= 0)
      Ball = rotateVectorAroundPoint(S1, Ball, -BetweenAngle);
    else
      Ball = rotateVectorAroundPoint(S1, Ball, BetweenAngle);
  }



  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////noFill();






  stroke(0);
  strokeWeight(3);


  PVector v = PVector.sub(C, S1);
  PVector v2 = PVector.add(C, PVector.mult(v, (l*1000-l2)/l2));
  strokeWeight(4);
  line(S1.x, S1.y, v2.x, v2.y);                       // Main floor line
  stroke(#FFAB03);
  v = PVector.add(C, PVector.sub(C, B));
  line(C.x, C.y, v.x, v.y);                           // Main floor line support in the middle
  line(C.x, C.y, B.x, B.y);                           // Support of the Main floor line
  stroke(100);
  line(S2.x, S2.y, A.x, A.y); // L2 Arm
  stroke(#045A81);
  line(A.x, A.y, B.x, B.y);   // L1 Arm
  fill(#0ABC02);
  ellipse(A.x, A.y, 10, 10);
  //strokeWeight(1);
  //line(S1.x, S1.y, 600, 550);
  //line(S1.x, S1.y, B.x, B.y);

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////noFill();
  //noFill();
  //stroke(0, 0, 255);
  //ellipse(S1.x, S1.y, 600, 600);
  //stroke(0);
  ///////////////////////////////////////////////////////////////////////
  //noFill();
  //stroke(255, 0, 0);
  //ellipse(S2.x, S2.y, l1*2, l1*2);
  //stroke(0);
  ///////////////////////////////////////////////////////////////////////
  //noFill();
  //stroke(0, 255, 0);
  //ellipse(A.x, A.y, difL*2, difL*2);
  //stroke(0);
  /////////////////////////////////////////////////////////////////////
  //noFill();
  //stroke(0, 255, 0);
  //ellipse(B.x, B.y, 100*2, 100*2);
  //stroke(0);
  ///////////////////////////////////////////////////////////////////
  //strokeWeight(1);
  //fill(255, 0, 0);
  //arc(S2.x, S2.y, 20, 20, PI/1.25, angle);
  //fill(#FFAB03);
  ///////////////////////////////////////////////////////////////////


  stroke(0);
  strokeWeight(2);
  if (solidBall.activated)
    fill(#FFEB03);
  else
    noFill();

  ellipse(Ball.x, Ball.y, ballRaduis*2, ballRaduis*2);
  strokeWeight(2);
  for (float i = 0; i <= 2*PI; i += PI/2)
    line(Ball.x, Ball.y, Ball.x + cos(debugedP/(ballRaduis*2)+i)*ballRaduis, Ball.y + sin(debugedP/(ballRaduis*2)+i)*ballRaduis);
  ballRaduis/=10;
  pxx.append(Ball.x);
  pyy.append(Ball.y);
  if (pxx.size()>100) {
    pxx.remove(0);
    pyy.remove(0);
  }
  stroke(0);
  strokeWeight(4);
  for (int i =0; i < pxx.size(); i +=10) {
    point(pxx.get(i), pyy.get(i));
  }
  strokeWeight(1);
  popMatrix();
  popMatrix();
}








void drawRoboticArm3D() {
  PGraphics pg = createGraphics(650, 500, P3D);

  // Animation time and joint angles
  float t = millis() / 1000.0;
  float baseAngle = radians(45 * sin(t));   // Yaw at base
  float elbowAngle = radians(45 * cos(t));  // Elbow pitch
  float wristAngle = radians(30 * sin(t * 2)); // Wrist pitch

  //float baseAngle = radians(45);   // Yaw at base
  //float elbowAngle = radians(45);  // Elbow pitch
  //float wristAngle = radians(30); // Wrist pitch

  // Mouse-controlled global rotation
  float rotX = radians((mouseY - height / 2) * 0.1);
  float rotY = radians((mouseX - width / 2) * 0.3);

  // Segment lengths
  float baseHeight = 40;
  float upperArmLength = 120;
  float forearmLength = 100;
  float wristLength = 50;

  pg.beginDraw();
  pg.background(255);
  pg.lights();
  pg.translate(pg.width / 2, pg.height / 1.5+100);
  pg.rotateX(rotX);
  pg.rotateY(rotY);

  // Draw base
  pg.pushMatrix();
  pg.fill(120);
  pg.box(60, baseHeight, 60);
  pg.translate(0, -baseHeight / 2, 0);

  // Base yaw
  pg.rotateY(baseAngle);

  // Upper arm
  pg.pushMatrix();
  pg.translate(0, -upperArmLength / 2, 0);
  pg.fill(200, 0, 0);
  pg.box(20, upperArmLength, 20);
  pg.translate(0, -upperArmLength / 2, 0);

  // Elbow pitch
  pg.rotateZ(elbowAngle);

  // Forearm
  pg.pushMatrix();
  pg.translate(0, -forearmLength / 2, 0);
  pg.fill(0, 150, 200);
  pg.box(16, forearmLength, 16);
  pg.translate(0, -forearmLength / 2, 0);

  // Wrist pitch
  pg.rotateZ(wristAngle);

  // Wrist
  pg.translate(0, -wristLength / 2, 0);
  pg.fill(0, 200, 100);
  pg.box(12, wristLength, 12);

  pg.popMatrix(); // End forearm+wrist
  pg.popMatrix(); // End upper arm
  pg.popMatrix(); // End base
  pg.endDraw();

  image(pg, 0, 200);
}

void animatePendulum() {
  fill(#D7F20C);
  rect(280, 630, 90, 30);
  rect(320, 450, 10, 210, 10);
  fill(#7E8E07);
  ellipse(290, 670, 40, 40);
  ellipse(360, 670, 40, 40);
  fill(0);
  ellipse(290, 670, 10, 10);
  ellipse(360, 670, 10, 10);
  stroke(0);
  pushMatrix();
  translate(290, 670);
  for (int i =0; i < 4; i ++) {
    rotate(PI / 2);
    line(0, 0, 0, -20);
  }
  popMatrix();
  pushMatrix();
  translate(360, 670);
  for (int i =0; i < 4; i ++) {
    rotate(PI / 2);
    line(0, 0, 0, -20);
  }
  popMatrix();
}


void animateCoupledTanks() {
  image(CoupledTanks, 30, 260, 600, 430);
  fill(#02D8F2);
  noStroke();
  float t = millis() / 1000.0;
  float levitatedY = -50 + 25 * sin(t * 2);
  rect(163, 504, 140, -100 + levitatedY);
  rect(456, 504, 148, -150 - levitatedY);
  stroke(0);
  strokeWeight(3);
  for (int i =0; i < 170; i +=5) {
    line(153, 504 - i, 163, 504 - i);
    line(446, 504 - i, 456, 504 - i);
  }
  fill(0);
  text("0%", 130, 504);
  text("100%", 140, 330);
  text("0%", 425, 504);
  text("100%", 435, 330);
}

void drawMaglevSystem3D() {
  PGraphics pg = createGraphics(650, 500, P3D);

  // Mouse-controlled rotation
  float rotX = radians((mouseY - height / 2) * 0.3);
  float rotY = radians((mouseX - width / 2) * 0.3);

  // Time for animation
  float t = millis() / 1000.0;
  float levitatedY = -100 + 30 * sin(t * 2);  // Y-position of the levitated object

  pg.beginDraw();
  pg.background(255);
  pg.lights();
  pg.translate(pg.width / 2, pg.height * 0.8, -100);
  pg.rotateX(rotX);
  pg.rotateY(rotY);

  // Rail or transparent tube
  pg.pushMatrix();
  pg.scale(1.5);
  pg.stroke(120);
  pg.noFill();
  pg.translate(0, -100, 0);
  pg.box(40, 200, 40);
  pg.popMatrix();

  // Electromagnet coil at top
  pg.pushMatrix();
  pg.translate(0, -200, 0);
  pg.fill(150, 0, 0);
  pg.noStroke();
  pg.box(60, 20, 60);
  pg.popMatrix();

  // Levitated object (sphere or platform)
  pg.pushMatrix();
  pg.translate(0, levitatedY, 0);
  pg.fill(0, 100, 250);
  pg.noStroke();
  pg.sphere(20);
  pg.popMatrix();

  // Base platform
  pg.pushMatrix();
  pg.translate(0, 10, 0);
  pg.fill(100);
  pg.box(100, 20, 100);
  pg.popMatrix();

  pg.endDraw();
  image(pg, 0, 200);
}





PVector circleIntersectionLowestY(
  float x1, float y1, float r1,
  float x2, float y2, float r2)
{
  float dx = x2 - x1;
  float dy = y2 - y1;
  float d  = sqrt(dx*dx + dy*dy);

  // --- No intersection cases ---
  if (d > r1 + r2 + 1e-6) return null;      // too far apart
  if (d < abs(r1 - r2) - 1e-6) return null; // one inside the other
  if (d < 1e-6 && abs(r1 - r2) < 1e-6) return null; // coincident circles

  float a = (r1*r1 - r2*r2 + d*d) / (2*d);
  float h2 = r1*r1 - a*a;
  if (h2 < 0) h2 = 0; // numeric guard
  float h = sqrt(h2);

  // Base point on the line between centers
  float xm = x1 + a*dx/d;
  float ym = y1 + a*dy/d;

  // Perpendicular offsets
  float rx = -dy * (h/d);
  float ry =  dx * (h/d);

  PVector p1 = new PVector(xm + rx, ym + ry);
  PVector p2 = new PVector(xm - rx, ym - ry);

  // Tangent case → only one intersection
  if (h < 1e-6) return p1;

  // Choose point with lowest y (numerically smallest y)
  return (p1.y < p2.y) ? p1 : p2;
}



PVector rotateVectorAroundPoint(PVector A, PVector B, float theta) {
  // Translate B relative to A
  float dx = B.x - A.x;
  float dy = B.y - A.y;

  // Apply rotation matrix
  float newX = dx * cos(theta) - dy * sin(theta);
  float newY = dx * sin(theta) + dy * cos(theta);

  // Translate back to A's position
  return new PVector(A.x + newX, A.y + newY);
}
