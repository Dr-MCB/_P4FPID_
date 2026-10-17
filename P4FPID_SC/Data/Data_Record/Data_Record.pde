boolean dataUploaded, Failed;
int V2max = 100;
int I2max = 1;
int Y2g;
int Speed = 1;
int direction = 1;
int dragged2_I = 0;
int playCounter = 1;
int timerPlay = 0;
float scl_x;
float scl_w;
int fullRange, recordTime, range;
FloatList  restored_sys = new FloatList();
FloatList  restored_ctr = new FloatList();
FloatList  restored_er = new FloatList();
FloatList  restored_der = new FloatList();
FloatList  restored_SetPoint = new FloatList();
FloatList  restored_Y1 = new FloatList();
FloatList  restored_Y2 = new FloatList();
FloatList  restored_Y3 = new FloatList();
StringList  restored_Time = new StringList();
String import_Path="";
Button__ sys2_b, er2_b, der2_b, ctr2_b, Y1_b, Y2_b, Y3_b, grid2_b,
  speedUp_b, speedDown_b, play_b, forward_b, backward_b, levelUp_b, levelDown_b, adjust_b, importFrom;
ProgressBar bar;




void setup() {
  size(1250, 700);
  surface.setResizable(true);
  windowRatio(1250, 700);
  initializeButtons();
  I2max = 10;
  playCounter = 0;
  bar = new ProgressBar(50, 650, 1150, 30, 200, 1150, recordTime * I2max, playCounter * I2max);
}

public void draw() {
  background(255);
  stroke(0);
  fill(0);
  strokeWeight(3);
  line(50, 50, 50, 650);
  strokeWeight(2);
  stroke(0, 200);
  line(50, 50, 1200, 50);
  line(50, 650, 1200, 650);
  line(1200, 50, 1200, 650);
  triangle(50, 50, 40, 60, 60, 60);
  triangle(50, 650, 40, 640, 60, 640);



  ///////////////////////////////////////////////////////////////
  pushMatrix();
  translate(0, Y2g);
  ///////////////////////////////////////////////////////////////


  stroke(0);
  strokeWeight(3);
  line(50, 500, 1200, 500);
  triangle(1200, 500, 1185, 490, 1185, 510);
  ///////////////////////////////////////////////////////////////
  strokeWeight(0.7);
  stroke(#21CDFA);
  if (grid2_b.activated) {
    for (int i=0; i<=450 + abs(Y2g); i+=2)
      if (i*V2max/500 % 10 ==0 && abs((i-2))*V2max/500 % 10 !=0) {
        line(50, 500-i, 1200, 500-i);
        line(50, 500+i, 1200, 500+i);
      }
  }


  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  stroke(0);
  textSize( 15);
  strokeWeight(1);
  for (int i=2; i<500 + abs(Y2g); i+=2) {
    fill(0);
    if (i*V2max/500 % 5 ==0 && (i-2)*V2max/500 % 5 !=0 ) {
      line(45, 500-i, 55, 500-i);
      line(45, 500+i, 55, 500+i);
    }
    if (abs(i)*V2max/500 % 10 ==0 && abs(i-2)*V2max/500 % 10 !=0 ) {
      text(i*V2max/500, 20, 500-i);
      text(-i*V2max/500, 20, 500+i);
    }
  }



  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  if (play_b.activated) {
    timerPlay ++;
    if (timerPlay > Speed) {
      if (forward_b.activated)
        playCounter = int(min(recordTime - 1, playCounter +1));
      else
        playCounter = int(max(1, playCounter -1));
      timerPlay = 0;
    }
    bar.UpdatePrgB(playCounter * I2max, recordTime * I2max);
  }


  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  color[] graphColor = {color(0, 0, 255), 0, #FF0F0F, #FCA900, #06B925, #FA0AF7, #6D00FF, #8E031F};
  ArrayList<FloatList> Points = new ArrayList<FloatList>();
  boolean[] status = {true, sys2_b.activated, er2_b.activated, der2_b.activated, ctr2_b.activated, Y1_b.activated,
    Y2_b.activated, Y3_b.activated};
  strokeWeight(3);
  Points.add(restored_SetPoint);
  Points.add(restored_sys);
  Points.add(restored_er);
  Points.add(restored_der);
  Points.add(restored_ctr);
  Points.add(restored_Y1);
  Points.add(restored_Y2);
  Points.add(restored_Y3);

  int I_index = 0;
  boolean entered = false;
  int finished = 1;

  for (int i= 1; i <= recordTime && dataUploaded; i++) {  //
    I_index = min(i + playCounter, recordTime);
    if (i + playCounter < recordTime) {
      finished ++;
      entered = true;
      for (int j = 0; j< 8; j++) {
        if (status[j]) {
          if (j == 3 || j == 2)
            strokeWeight(2.5);
          else
            strokeWeight(1.5);
          stroke(graphColor[j]);
          line( 50+i*I2max, 500 - (Points.get(j).get(I_index)*500/V2max),
            50+(i-1)*I2max, 500 - (Points.get(j).get(I_index-1)*500/V2max));
        }
      }
      if ( int(round(100*float(restored_Time.get(I_index)))) % 5 == 0) {
        pushMatrix();
        translate(50+i*I2max, 517);
        rotate(PI/2);
        text(restored_Time.get(I_index), 0, 0);
        popMatrix();
        strokeWeight(3);
        stroke(0);
        line(50+i*I2max, 510, 50+i*I2max, 490);
        if (grid2_b.activated) {
          strokeWeight(0.7);
          stroke(#21CDFA);
          line(50+i*I2max, -abs(Y2g), 50+i*I2max, 700 + abs(Y2g));
        }
      }
      strokeWeight(1);
      stroke(0);
      line(50+i*I2max, 505, 50+i*I2max, 495);
    }
  }

  popMatrix();
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  if (!entered && play_b.activated) {
    play_b.activated = false;
    playCounter --;
  } else if (finished == recordTime -2 && play_b.activated) {
    play_b.activated = false;
    playCounter ++;
  }


  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  noStroke();
  fill(255);
  rect(0, 0, 1250, 50);
  rect(0, 652, 1250, 100);
  rect(1200, 0, 700, 700);
  if (dataUploaded)
    bar.Display();
  fill(0);
  sys2_b.display();
  er2_b.display();
  der2_b.display();
  Y1_b.display();
  Y2_b.display();
  Y3_b.display();
  ctr2_b.display();
  grid2_b.display();
  speedUp_b.display();
  speedDown_b.display();
  play_b.display();
  forward_b.display();
  backward_b.display();
  adjust_b.display();
  fill(0);
  draw1Triangle(forward_b, true);
  draw1Triangle(backward_b, false);
  draw2Triangles(speedUp_b, true);
  draw2Triangles(speedDown_b, false);
  drawMainTriangle(play_b);
  for (int i = 0; i < grid2_b.sizex; i +=10)
    line(grid2_b.x + i, grid2_b.y, grid2_b.x + i, grid2_b.y + grid2_b.sizey);
  for (int i = 0; i < grid2_b.sizey; i +=10)
    line(grid2_b.x, grid2_b.y + i, grid2_b.x + grid2_b.sizex, grid2_b.y + i);
  textSize(22);
  fill(0);
  text2InButton(sys2_b, "System", 0.7);

  if (er2_b.activated)fill(graphColor[2]);
  else fill(0);
  text2InButton(er2_b, "Error (E)", 0.7);

  if (der2_b.activated)fill(graphColor[3]);
  else fill(0);
  text2InButton(der2_b, " D(E)/dt", 0.7);

  if (ctr2_b.activated)fill(graphColor[4]);
  else fill(0);
  text2InButton(ctr2_b, "Control", 0.7);

  if (Y1_b.activated)fill(graphColor[5]);
  else fill(0);
  text2InButton(Y1_b, "Y1", 0.7);

  if (Y2_b.activated)fill(graphColor[6]);
  else fill(0);
  text2InButton(Y2_b, "Y2", 0.7);

  if (Y3_b.activated)fill(graphColor[7]);
  else fill(0);
  text2InButton(Y3_b, "Y3", 0.7);

  draw1TriangleUp(adjust_b, true);

  importFrom.display();
  fill(0);
  textSize(22);
  text2InButton(importFrom, "Import From", 0.7);
  //text("Upload Data", 1043, 30);
  noFill();
  for (int i =0; i< 5; i++)
    ellipse(adjust_b.x + adjust_b.sizex/2, adjust_b.y + 11 + 5 *i, 25, 10);
  if (Failed) {
    textSize(40);
    text("Data Upload has Failed !", 550, 350);
    rect(540, 300, textWidth("Data Upload has Failed !") + 20, 60);
  }

}
