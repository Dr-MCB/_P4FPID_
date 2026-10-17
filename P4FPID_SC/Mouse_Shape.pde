void mouse_shapeManagement() {
  curcounter++;
  if (curcounter%5==0 && Cursor==" |") {
    Cursor="_";
  } else if (curcounter%5==0 && Cursor=="_") {
    Cursor=" |";
  }

  if (curcounter == 100)
    curcounter = 0;


  //if (MouseCursor())
  //  cursor(TEXT);
  //else
  //  cursor(ARROW);


  if (MFtype!=0 && ((rmouseX>=20  && rmouseX<=640  && rmouseY<=145 && rmouseY>=10)
    ||(rmouseX>=670 && rmouseX<=1290 && rmouseY<=145 && rmouseY>=10)
    ||(rmouseX>=670 && rmouseX<=1290 && rmouseY<=345 && rmouseY>=210)))
    mousebrand();
  // shapes inside the mouse cursor
  stroke(0);
  strokeWeight(4);
  line(0, 0, 1300, 0);
  for (int i =0; i < 2; i ++)
    Range[i] = Bound__(99, 0, Range[i]);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



void mousebrand() {
  strokeWeight(3);
  stroke(255, 0, 0);
  if (MFtype==1)
    triangle(rmouseX-5, rmouseY+20, rmouseX+5, rmouseY+20, rmouseX, rmouseY+10);
  else if (MFtype==3)
    quad(rmouseX-10, rmouseY+20, rmouseX+10, rmouseY+20, rmouseX+5, rmouseY+10, rmouseX-5, rmouseY+10);
  else if (MFtype==2) {
    for (float i=-10; i<=10; i+=1) {
      line(rmouseX+i, rmouseY+20-10*Gaussian(i+rmouseX, rmouseX, -10/GAUSS), rmouseX+i, rmouseY+20);
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



boolean MouseCursor() {
  boolean mousecursor=false;
  int ii=-1;
  int ax=975;
  float ay=40;
  float[] a=new float[5];
  if (MF[inumber][iinumber].state==true) {
    if (iinumber==1) {
      ii=1;
    } else if (iinumber==2) {
      ii=2;
      ay=240;
    } else if (iinumber==0) {
      ii=0;
      ax=325;
    }
    float y=ay+100-rmouseY;
    a[2]=ax+MF[inumber][iinumber].a2*3;
    a[4]=ax+MF[inumber][iinumber].a3*3;
    if (MF[inumber][iinumber].type<3 && ii!=-1) {
      corner_Left=a[2]-textWidth(MF[inumber][iinumber].name)/2;
      corner_Right=a[2]+textWidth(MF[inumber][iinumber].name)/2;
    } else if (MF[inumber][iinumber].type==3 && ii!=-1) {
      corner_Left=(a[4]+a[2])/2-textWidth(MF[inumber][iinumber].name)/2;
      corner_Right=(a[4]+a[2])/2+textWidth(MF[inumber][iinumber].name)/2;
    }
    if (
      ( rmouseX >= corner_Left && rmouseX <= corner_Right && y>=MF[inumber][iinumber].normality+10 && y<=MF[inumber][iinumber].normality+20)
      || ( rmouseX >= ax-280 && rmouseX <= ax+135 && rmouseY>=ay+130 && rmouseY<=ay+150)
      ) {
      return true;
    }
  } else if (face==2) {
    if (   (rmouseX>=Gain_plus_b[0].x + 20 && rmouseX<= Gain_minus_b[0].x && rmouseY >= Gain_plus_b[0].y && rmouseY<= Gain_plus_b[6].y + 30)
      ||   (rmouseX>= dataSave_b[1].x && rmouseX<= dataSave_b[1].x + 250 && rmouseY >= dataSave_b[1].y + 30 && rmouseY<= dataSave_b[1].y + 60)
      ||   (rmouseX>=1070  && rmouseX<=1200 && rmouseY >=460 && rmouseY<=500)
      ||   (rmouseX>=1130  && rmouseX<=1290 && rmouseY >=590 && rmouseY<=620)
      ||   (rmouseX>=1070 && rmouseX<=1260 && rmouseY >=630 && rmouseY<=660)
      )
      return true;
  } else if (face == 3) {
    if   (rmouseX>=870  && rmouseX<= 950 && rmouseY >=510 && rmouseY<=590
      || (rmouseX>=1015 && rmouseX<=1135 && rmouseY >=710 && rmouseY<=745)
      || (rmouseX>=805  && rmouseX<=905  && rmouseY >=710 && rmouseY<=745)
      )
      return true;
  }
  if ((rmouseX>=290  && rmouseX<=390 && rmouseY >=200 && rmouseY<=230 && !Rules_Edit_b.activated && !surface_3D)
    || (rmouseX>=480 && rmouseX<=540 && rmouseY >=200 && rmouseY<=230 && !Rules_Edit_b.activated && !surface_3D)
    || (dispIndex ==1 && rmouseX>=480 && rmouseX<=630 && rmouseY >=465 && rmouseY<=495)
    || (dispIndex ==1 && rmouseX>=480 && rmouseX<=630 && rmouseY >=525 && rmouseY<=555 && !discreteSys_b.activated)
    )
    return true;
  return mousecursor;
}
