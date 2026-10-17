void drawMFsShapes() {
  FrameCounter++;
  if (mouseWheeling)
    mouseWheelingTimer ++;
  if (mouseWheelingTimer > 10)
    mouseWheeling = false;
  if (FrameCounter % 5 == 0)
    FrameCounter2  =  (FrameCounter2 + 1) % 30;
  if (FrameCounter2 == 30)
    FrameCounter2 = 0;
  if (FrameCounter == 100)
    FrameCounter = 0;
  stroke(0);
  strokeWeight(2);
  line(25, 140, 625, 140);
  line(325, 40, 325, 140);
  line(650, 0, 650, 750);
  line(650, 200, 1300, 200);
  line(1300, 0, 1300, 400);
  line(675, 140, 1275, 140);
  line(975, 40, 975, 140);
  line(675, 340, 1275, 340);
  line(975, 240, 975, 340);
  line(0, 200, 650, 200);
  line(0, 0, 0, 770);


  stroke(0);
  for (int l=0; l<=600; l+=10) {
    fill(0);
    line(25+l, 135, 25+l, 143);
    line(675+l, 135, 675+l, 143);
    line(675+l, 335, 675+l, 343);
  }
  stroke(0);
  strokeWeight(1.2);
  int ax=0;
  float ay=0;
  int by=0;
  int[] colors;
  float[] a = new float[5];
  boolean overButton =  (shapes_b[5].over || shapes_b[6].over || shapes_b[7].over || shapes2_b[6].over
    || shapes2_b[7].over || shapes_b[8].over) ? true: false;
  for (int k =0; k < 18; k ++)
    if ((fctsbtn_b[k].over || (shapes2_b[1].activated|shapes2_b[2].activated|shapes2_b[3].activated|shapes2_b[4].activated))
      && MFtype > 0) {
      if (fctsbtn_b[k].over)
        overButton = true;
      for (int i =0; i < 3; i ++)
        if (MVB[i].InsideBoxe(rmouseX, rmouseY)) {
          selectedRec=MVB[i].index + 1;
        }
      break;
    }
  colors= new int[3];
  colors[0]=#38FF03;
  colors[1]=#FF0F0F;
  colors[2]=#F7B705;
  for (int ii=0; ii<3; ii++) {
    if (ii==2) {
      ax=975;
      by=340;
      if (longesCondition(ii, overButton)) { //
        fill(colors[ii], 50);
        noStroke();
        rect(650, 200, 650, 200);
      }
    } else if (ii==0) {
      ax=325;
      by=140;
      if (longesCondition(ii, overButton)) { //
        fill(colors[ii], 50);
        noStroke();
        rect(0, 0, 650, 200);
      }
    } else if (ii==1) {
      ax=975;
      by=140;
      if (longesCondition(ii, overButton)) { //
        fill(colors[ii], 50);
        noStroke();
        rect(650, 0, 650, 200);
      }
    }
    for (int i=1; i<=maxs[ii]; i++) {
      for (int c=1; c<=4; c++) {
        a[c]=ax+MF[i][ii].getParameter(c)*3;
      }
      ay=by-MF[i][ii].normality;
      stroke(0);
      if (MF[i][ii].state) {
        strokeWeight(4);
        stroke(255, 0, 0);
        line(ax-300, by, a[1], by);
        line(ax+300, by, a[4], by);
      } else
        strokeWeight(2);
      if (MF[i][ii].type==2) {
        float z=a[1];
        line(z, by, z, by-Gaussian(z+1, a[2], (a[2]-z)/MF[i][ii].Gauss)*MF[i][ii].normality);
        for (z=a[1]; z<a[2]; z+=1) {
          line(z, by-Gaussian(z, a[2], (a[2]-a[1])/MF[i][ii].Gauss)*MF[i][ii].normality, z+1, by-Gaussian(z+1, a[2], (a[2]-a[1])/MF[i][ii].Gauss)*MF[i][ii].normality);
        }
        z=a[4];
        line(z, by, z, by-Gaussian(z+1, a[2], (a[4]-a[2])/MF[i][ii].Gauss)*MF[i][ii].normality);
        for (z=a[2]; z<a[4]; z+=1) {
          line(z, by-Gaussian(z, a[2], (a[4]-a[2])/MF[i][ii].Gauss)*MF[i][ii].normality, z+1, by-Gaussian(z+1, a[2], (a[4]-a[2])/MF[i][ii].Gauss)*MF[i][ii].normality);
        }
      } else if (MF[i][ii].type==1) {
        line(a[1], by, a[2], ay);
        line(a[2], ay, a[4], by);
      } else if (MF[i][ii].type==3) {
        line(a[1], by, a[2], ay);
        line(a[3], ay, a[4], by);
        line(a[2], ay, a[3], ay);
      }
      strokeWeight(2);
      if (Rules_Edit_b.activated) {
        fill(colors[ii], 100);
        if ((i==rules_Table[tablej-1][tablei-1] && ii==0) || (i==tablei && ii==1) || (i==tablej && ii==2)) {
          float rulZ = 1;
          rulZ =rules_Weights[tablej-1][tablei-1];
          ay=by-MF[i][ii].normality*rulZ;
          if (MF[i][ii].type==1) {
            triangle(a[1], by, a[2], ay, a[4], by);
            ay=by-MF[i][ii].normality;
          } else if (MF[i][ii].type==3) {
            quad(a[1], by, a[2], ay, a[3], ay, a[4], by);
            ay=by-MF[i][ii].normality;
          } else if (MF[i][ii].type==2) {
            stroke(colors[ii]);
            for (float z=a[1]; z<a[2]; z+=1) {
              line(z, by-Gaussian(z, a[2], (a[1]-a[2])/MF[i][ii].Gauss)*MF[i][ii].normality*rulZ, z, by);
            }
            for (float z=a[2]; z<a[4]; z+=1) {
              line(z, by-Gaussian(z, a[2], (a[4]-a[2])/MF[i][ii].Gauss)*MF[i][ii].normality*rulZ, z, by);
            }
            ay=by-MF[i][ii].normality;
          }
        }
        textSize(30);
        fill(0);
        text(MF[i][ii].n, (a[2]+a[3])/2-10, ay+25);
        textFont(font1, 18);
        fill(colors[ii]);
      } else {
        fill(colors[ii]);
        stroke(colors[ii]);
      }    
      stroke(0);
      int recS = 8;
      int shiftRec = recS/2;
      if (MF[i][ii].type!=0) {
        rect(a[1]-shiftRec, by-shiftRec, recS, recS);
        rect(a[2]-shiftRec, ay-shiftRec, recS, recS);
        rect(a[4]-shiftRec, by-shiftRec, recS, recS);
        if (MF[i][ii].type==3)
          rect(a[3]-shiftRec, ay-shiftRec, recS, recS);
      }

      if (MF[i][ii].state)
        noFill();
      textFont(font2, 20);
      if (MF[i][ii].type!=0) {
        String current_name=" ";
        float current_size=0;
        if (MF[i][ii].state && name_index==1) {
          current_name=String.copyValueOf(typing, 0, typing_counter);
          current_size=textWidth(current_name);
          current_name+=Cursor;
          if (MF[i][ii].type==3)
            rect((a[3]-a[2])/2+a[2]- current_size/2-5, ay-30, current_size+15, 25);
          else
            rect(a[2]-current_size/2-5, ay-30, current_size+15, 25);
        } else {
          current_name=MF[i][ii].name;
          current_size=textWidth(current_name);
        }
        fill(0);
        if (MF[i][ii].type==3) {
          text(current_name, (a[3]-a[2])/2+a[2]-current_size/2, ay-10);
        } else
          text(current_name, a[2]-current_size/2, ay-10);
      }
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


boolean longesCondition(int I, boolean ovbt) {
  if (
    ((selectedRec == I + 1 || shapes2_b[2].activated || shapes2_b[4].activated) && ovbt)
    || ((iinumber == I || shapes2_b[2].activated || shapes2_b[4].activated) && mouseWheeling)
    || (MFtype > 0 && ((keyPressed && ((key == 'a' && selectedRec == I + 1) || keyCode == TAB))
    || (((shapes2_b[1].activated || shapes2_b[3].activated) && selectedRec == I + 1) || shapes2_b[2].activated || shapes2_b[4].activated)  )  )
    )
    return true;
  return false;
}
