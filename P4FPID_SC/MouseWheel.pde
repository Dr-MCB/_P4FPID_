void mouseWheel(MouseEvent event) {
  rotWheel += event.getCount();
  if (shapes_b[5].over || shapes_b[6].over || shapes_b[7].over || shapes2_b[6].over
    || shapes2_b[7].over || shapes_b[8].over)
    selectedRec = (selectedRec + abs(event.getCount())) % 3 + 1;
  if ((rmouseX<=1300 && rmouseY<=200)|| (rmouseX<=1300 && rmouseY<=400 && rmouseX>=650)) {
    if (!MF[inumber][iinumber].state) {
      if (wheel+event.getCount()>0)
        wheel+=event.getCount();
      MFtype =wheel%3+1;
      shapes_b[0].activated= shapes_b[1].activated= shapes_b[2].activated=false;
      shapes_b[MFtype-1].activated=true;
    } else if (MF[inumber][iinumber].state) {
      mouseWheelActions(inumber, iinumber, event.getCount(), symmetry);
      mouseWheelingTimer = 0;
      update_2Dplot();
      if (surface_3D)
        update_3Dplot();
    }
  } else if (rmouseX <= 650 && rmouseY >= 200) {
    if (!rulesbuttons_b[0].activated  & surface_3D && !keyPressed)
      zoom_3D+=event.getCount()*5;
    else if (!rulesbuttons_b[0].activated ) {
      if (((keyPressed && key == 'x' && !InLoop) || Xmouse_b.activated)) {
        float wheelStep = 0.01;
        if (Imax>= 10)
          wheelStep = 5;
        else if (Imax >=5)
          wheelStep = 2;
        else if (Imax >=1)
          wheelStep = 1;
        else
          wheelStep = 0.1;
        Imax = Bound__(50, 0.1, Imax - wheelStep * event.getCount());
      } else if ((keyPressed && key == 'y') || Ymouse_b.activated) {
        int zoomStep = 200;
        if (Vmax < 10)
          zoomStep = 1;
        else if (Vmax < 50)
          zoomStep = 5;
        else if (Vmax < 100)
          zoomStep = 10;
        else if (Vmax < 150)
          zoomStep = 25;
        else if (Vmax < 200)
          zoomStep = 50;
        else if (Vmax < 500)
          zoomStep = 100;
        Vmax = int(Bound__(1000, 1, Vmax + event.getCount()*zoomStep));
      }
    }
    if (face==2) {
      if (GainAdjust_b[0].activated) {
        Ke += step * event.getCount();
        update_2Dplot();
      } else if (GainAdjust_b[1].activated) {
        Kde += step * event.getCount();
        update_2Dplot();
      } else if (GainAdjust_b[2].activated) {
        Ky1 += step * event.getCount();
        update_2Dplot();
      } else if (GainAdjust_b[3].activated) {
        Ky2 += step * event.getCount();
        update_2Dplot();
      }
    }
  } else if (rmouseX >= 650 && rmouseY >= 200 && rmouseX <= 1300 && face==1  && Rules_Edit_b.activated) {
    if (shapes2_b[5].activated) {
      if (rulesMode == 0)
        rules_Table[tablej-1][tablei-1]= IBound__(maxs[0], 0, rules_Table[tablej-1][tablei-1]+event.getCount());
      else if (rulesMode == 1) {
        rules_Weights[tablej-1][tablei-1]= Bound__(1, 0, rules_Weights[tablej-1][tablei-1]-event.getCount()*0.1);
      } else {
        if (event.getCount() > 0)
          rules_Operators[tablej-1][tablei-1]= true;
        else
          rules_Operators[tablej-1][tablei-1]= false;
      }
      update_2Dplot();
      if (surface_3D)
        update_3Dplot();
    } else if (ruleswheel+event.getCount() < maxs[1]*maxs[2] && ruleswheel+event.getCount() >=0 && !surface_3D) {
      ruleswheel+=event.getCount();
      tablej = ruleswheel%maxs[2]+1;
      tablei = ruleswheel/(maxs[2])+1;
    }
  }
  if (face == 4 || dispIndex == 2)
    Airspeed = max(Airspeed - event.getCount(), 1);
}

void mouseWheelActions(int A, int B, int x, boolean Sym) {
  int a = A;
  int b = B;
  int c = maxs[b] - a + 1;
  int start2 = a;
  int start1 = b;
  int end1 = b+1;
  int end2 = a;
  boolean NoOpposition = false;
  boolean global  = shapes2_b[2].activated ? true : false;
  boolean partial = (global || shapes2_b[1].activated) ? true : false;
  boolean globalWidth =  shapes2_b[4].activated ? true : false;
  boolean partialWidth = (globalWidth || shapes2_b[3].activated) ? true : false;
  boolean particularWidth = shapes2_b[0].activated? true : false;
  boolean AllowSym = !(global | globalWidth | partial | partialWidth);
  if (global || globalWidth) {
    start1 = 0;
    start2 = 1;
    end1 = 3;
    NoOpposition = true;
  } else if (partial || partialWidth) {
    start2 = 1;
  }
  for (b = start1; b < end1; b ++) {
    c = maxs[b] - a + 1;
    if ((global || partial || globalWidth || partialWidth)) {
      end2 = maxs[b];
      mouseWheeling = true;
    }
    for (a =start2; a <= end2; a ++) {
      if (partialWidth || particularWidth) {
        if (MF[a][b].type==3) {
          if (a != maxs[b])
            MF[a][b].a3=Bound__(min(MF[a+1][b].a2, MF[a][b].a4), MF[a][b].a2, MF[a][b].a3 - x);
          if (a != 1)
            MF[a][b].a2=Bound__(MF[a][b].a3, max(MF[a-1][b].a3, MF[a][b].a1), MF[a][b].a2 + x);
          if (AllowSym && MF[c][b].type == MF[a][b].type && !NoOpposition) {
            if (c != maxs[b])
              MF[c][b].a3=Bound__(min(MF[c+1][b].a2, MF[c][b].a4), MF[c][b].a2, MF[c][b].a3 - x);
            if (c != 1)
              MF[c][b].a2=Bound__(MF[c][b].a3, max(MF[c-1][b].a3, MF[c][b].a1), MF[c][b].a2 + x);
          }
        } else if (MF[a][b].type==2) {
          MF[a][b].Gauss = Bound__(20, 1, MF[a][b].Gauss + x * 0.2);
          if (AllowSym  &&  MF[c][b].type == MF[a][b].type && !NoOpposition) {
            MF[c][b].Gauss = MF[a][b].Gauss;
          }
        }
      } else {
        if (a != 1)
          MF[a][b].a1 =Bound__(min(MF[a-1][b].a4, MF[a][b].a2), MF[a-1][b].a1, MF[a][b].a1 + x );
        if (a!=maxs[b])
          MF[a][b].a4 =Bound__(MF[a+1][b].a4, max(MF[a][b].a2, MF[a+1][b].a1), MF[a][b].a4 - x );

        if (AllowSym  &&  MF[c][b].type == MF[a][b].type && !NoOpposition) {
          if (c != 1)
            MF[c][b].a1 =Bound__(min(MF[c-1][b].a4, MF[c][b].a2), MF[c-1][b].a1, MF[c][b].a1 + x );
          if (c!=maxs[b])
            MF[c][b].a4 =Bound__(MF[c+1][b].a4, max(MF[c][b].a2, MF[c+1][b].a1), MF[c][b].a4 - x );
        }
      }
    }
  }
}
