void drawMVsCtrButtons() {
  drawMFsCtrButtons1();
  drawMFsCtrButtons2();
  drawMFsCtrButtons3();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void drawMFsCtrButtons1() {
  for (int i=0; i<18; i++) {
    fctsbtn_b[i].display();
    int MF_b = i % 6 ;
    strokeWeight(3);
    if (MF_b == 4)
      fctsbtn_b[i].setplus(4);
    else if (MF_b == 5)
      fctsbtn_b[i].setminus(4);
    strokeWeight(1);
    if (MF_b == 2)
      fctsbtn_b[i].setLeft(0.5, 0);
    else if (MF_b == 3)
      fctsbtn_b[i].setRight(0.5, 0);
    else if (MF_b == 0)
      fctsbtn_b[i].setUp(0.5, 0);
    else if (MF_b == 1)
      fctsbtn_b[i].setDown(0.5, 0);
    if (face == 3 && !opt_var[1].activated) {
      if (i < 6) {
        MFsGA_b[i/2].display();
        if (opt_var[2].activated) {
          WeiGA_b[i/2].display();
          WeightsOrientation(WeiGA_b[i/2], weightsShape[i/2]);
        }
        MFsGA_b[i/2].setText("GA", 0.75);
        if (MFsGA_b[i/2].activated) {
          if (!opt_var[1].activated) {
            optSide_b[i].display();
            if ( i % 2 ==  0)
              optSide_b[i].setText("L", 0.9);
            else
              optSide_b[i].setText("R", 0.9);
          }
        }
      }
    }
  }
  fill(0);
  textFont(font2, 20);
  text("Output (Y)", 10, 165);
  text("Error (E)", 660, 165);
  text("Error derivative (dE)", 660, 365);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void drawMFsCtrButtons2() {
  textFont(font2, 30);
  for (int i=0; i<10; i++) {
    if (i== MFtype-1 ||(i==3 && symmetry) || (i==4 && NormalityEnabled) || (i == 8 && PushALL)
      || (i == 9 && LinkedMF))
      shapes_b[i].activated=true;
    else
      shapes_b[i].activated=false;
    shapes_b[i].display();
    shapes2_b[i].display();
  }
  UART_b.display();
  UARTenable_b.display();
  pushMatrix();
  translate(-5, 0);
  strokeWeight(2);
  stroke(0);

  line(1310, 130, 1310, 130-50*Gaussian(1, 25, 25/GAUSS));
  for (float i=0; i<=50; i+=1) {
    line(i+1310, 130-50*Gaussian(i, 25, 25/GAUSS), i+1311, 130-50*Gaussian(i+1, 25, 25/GAUSS));
  }
  line(1360, 130, 1360, 130-50*Gaussian(51, 25, 25/GAUSS));

  noFill();
  triangle(1315, 50, 1355, 50, 1335, 10);
  quad(1310, 200, 1320, 155, 1350, 155, 1360, 200);
  int rest = FrameCounter2 % 2;
  if (shapes_b[3].over && rest == 1) {
    triangle(1315, 245, 1330, 225, 1330, 265);
    triangle(1355, 245, 1340, 225, 1340, 265);
  } else {
    triangle(1310, 245, 1325, 225, 1325, 265);
    triangle(1360, 245, 1345, 225, 1345, 265);
  }
  line(1335, 220, 1335, 270);
  line(1310, 270, 1358, 270);
  if (shapes_b[4].over && rest == 1) {
    triangle(1310, 340, 1330, 300, 1350, 340);
    triangle(1330, 340, 1345, 305, 1365, 340);
  } else {
    triangle(1310, 340, 1330, 290, 1350, 340);
    triangle(1330, 340, 1345, 310, 1365, 340);
  }
  rest = FrameCounter2 % 3;
  if (shapes_b[5].over) {
    if (rest ==0 ) {
      for (float i=0; i<=50; i+=1)
        line(i+1310, 410-50*Gaussian(i, 25, 25/GAUSS), i+1311, 410-50*Gaussian(i+1, 25, 25/GAUSS));
    } else if (rest == 1) {
      quad(1310, 410, 1320, 360, 1350, 360, 1360, 410);
    } else if (rest == 2) {
      triangle(1310, 410, 1360, 410, 1335, 360);
    }
  } else {
    for (float i=0; i<=50; i+=1)
      line(i+1310, 410-50*Gaussian(i, 25, 25/GAUSS), i+1311, 410-50*Gaussian(i+1, 25, 25/GAUSS));
    quad(1310, 410, 1320, 360, 1350, 360, 1360, 410);
    triangle(1310, 410, 1360, 410, 1335, 360);
  }
  rest = FrameCounter2 % 2;
  pushMatrix();
  translate(0, 140);
  for (int i=0; i<3; i++)
    triangle(1315+i*10, 330, 1325+i*10, 290, 1335+i*10, 330);
  triangle(1310, 360, 1310, 400, 1335, 400);
  triangle(1340, 400, 1365, 360, 1365, 400);
  int d = 0;
  if (shapes_b[8].over && rest == 0)
    d= 10;
  float xsp = shapes_b[6].x;
  float ysp = shapes_b[6].y;
  fill(0);
  ellipse(xsp + 35 + d, ysp + 15, 5, 5);
  line(xsp + 10, ysp + 15, xsp + 35 + d, ysp + 15);
  line(xsp + 35 +d, ysp + 15, xsp + 55 + d, ysp + 60);
  line(xsp + 55 +d, ysp + 60, xsp + 10, ysp + 60);
  line(xsp + 10, ysp + 60, xsp + 10, ysp + 15);
  xsp = shapes_b[7].x;
  ysp = shapes_b[7].y;
  d =0;
  if (shapes_b[9].over && rest == 0) {
    d= 10;
  }
  line(xsp + 15, ysp + 60, xsp + 15, ysp + 15);
  line(xsp + 15, ysp + 15, xsp + 35 + d, ysp + 60);
  line(xsp + 35 + d, ysp + 60, xsp + 60, ysp + 15);
  line(xsp + 60, ysp + 15, xsp + 60, ysp + 60);
  line(xsp + 60, ysp + 60, xsp + 35 + d, ysp + 15);
  line(xsp + 35 + d, ysp + 15, xsp + 15, ysp + 60);


  image(usb, 1305, 565, 55, 55);
  popMatrix();
  popMatrix();
  textSize(20);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void drawMFsCtrButtons3() {
  int rest = FrameCounter2 % 2;
  fill(255);
  strokeWeight(2);
  int centerx = 1405;
  int centery = 630;
  int trw = 10;
  ellipse(centerx, 630, 50, 50);
  fill(200);
  pushMatrix();
  translate(centerx, centery);
  rotate(radians(10*rotWheel));
  fill(0);
  for (int i =0; i < 4; i ++) {
    pushMatrix();
    rotate(i*PI/2);
    triangle(-trw, 0, trw, 0, 0, 30);
    triangle(-trw, 34, trw, 34, 0, 0);
    popMatrix();
  }
  fill(200);
  if (shapes2_b[8].activated || shapes2_b[9].activated)
    fill(shapes2_b[5].pressGray);
  ellipse(0, 0, 20, 20);
  popMatrix();
  noFill();
  strokeWeight(2);
  arc(centerx, centery-25, 70, 60, PI, 3*PI/2);
  arc(centerx, centery + 25, 70, 60, 0, PI/2);
  triangle(shapes2_b[8].x + 40, shapes2_b[8].y + 5, shapes2_b[8].x + 40, shapes2_b[8].y + 25, shapes2_b[8].x + 60, shapes2_b[8].y + 15);
  triangle(shapes2_b[9].x + 40, shapes2_b[9].y + 45, shapes2_b[9].x + 40, shapes2_b[9].y + 65, shapes2_b[9].x + 20, shapes2_b[9].y + 55);
  fill(0);
  text("Rule", shapes2_b[5].x + shapes2_b[5].sizex/2 - textWidth("Rule")/2, 365);
  if ((shapes2_b[5].over || shapes2_b[5].activated)  && rest == 1)
    text("   Then", shapes2_b[5].x + shapes2_b[5].sizex/2 - textWidth("   Then")/2, 405);
  else
    text("...Then", shapes2_b[5].x + shapes2_b[5].sizex/2 - textWidth("...Then")/2, 405);
  noFill();
  rect(shapes2_b[5].x + 10, shapes2_b[5].y + 20, 60, 40);
  line(shapes2_b[5].x + 10, shapes2_b[5].y + 30, shapes2_b[5].x + 70, shapes2_b[5].y + 30);
  for (int i =0; i < 6; i ++) {
    line(shapes2_b[5].x + 10 + i * 10, shapes2_b[5].y + 20, shapes2_b[5].x + 10 + i * 10, shapes2_b[5].y + 30);
  }
  for (int i=0; i<3; i++)
    triangle(1375+i*20, 470, 1385+i*20, 430, 1395+i*20, 470);
  triangle(1405, 500, 1405, 540, 1430, 540);
  triangle(1400, 500, 1400, 540, 1375, 540);
  text("UART", UART_b.x + UART_b.sizex/2 - textWidth("UART")/2, UART_b.y + 20);
  if (UART_b.activated) {
    text("ON", UART_b.x + UART_b.sizex/2 - textWidth("ON")/2, UART_b.y +  45);
  } else {
    text("OFF", UART_b.x + UART_b.sizex/2 - textWidth("OFF")/2, UART_b.y + 45);
  }

  int w = 0;
  if ((shapes2_b[0].over || shapes2_b[0].activated)  && rest == 1) {
    w = 7 ;
  }
  quad(shapes2_b[0].x + 20, shapes2_b[0].y + 50,
    shapes2_b[0].x + 35 - w, shapes2_b[0].y + 10,
    shapes2_b[0].x + 45 + w, shapes2_b[0].y + 10,
    shapes2_b[0].x + 60, shapes2_b[0].y + 50);
  w = 0;
  if ((shapes2_b[1].over || shapes2_b[1].activated)  && rest == 1) {
    w = 3 ;
  }
  int y = shapes2_b[1].y + 20;
  int x = shapes2_b[1].x + 10;
  int dx = (shapes2_b[1].sizex -10) / 4;
  int dy = 30;
  int d = 10;
  for (int i =0; i < 3; i ++) {
    triangle(x + i*dx - w, y + dy, x+i*dx + d, y, x+i*dx + 2*d + w, y + dy);
  }
  w=0;
  y = shapes2_b[2].y + 5;
  dy = 17;
  d = 10;
  if ((shapes2_b[2].over || shapes2_b[2].activated)  && rest == 1) {
    w = 3 ;
  }
  for (int j = 0; j < 3; j ++) {
    for (int i =0; i < 3; i ++) {
      triangle(x + i*dx - w, y + dy, x+i*dx + d, y, x+i*dx + 2*d + w, y + dy);
    }
    y+= dy + 3;
  }
  w=0;
  y = shapes2_b[3].y + 20;
  x-=5;
  d = 25;
  dx = d-2;
  dy = 30;
  if ((shapes2_b[3].over || shapes2_b[3].activated)  && rest == 1) {
    w = 2 ;
  }
  for (int i =0; i < 3; i ++) {
    quad(x + i*dx, y + dy,
      x + i*dx +   d/4 - w, y,
      x + i*dx + 3*d/4 + w, y,
      x + i*dx + d, y + dy);
  }
  w=0;
  y = shapes2_b[4].y + 5;
  dy = 17;
  d = 25;
  if ((shapes2_b[4].over || shapes2_b[4].activated)  && rest == 1) {
    w = 1 ;
  }
  for (int j = 0; j < 3; j ++) {
    for (int i =0; i < 3; i ++) {
      quad(x + i*dx, y + dy,
        x + i*dx +   d/4 - w, y,
        x + i*dx + 3*d/4 + w, y,
        x + i*dx + d, y + dy);
    }
    y+= dy + 3;
  }
}
