void mouseClicked() {
  int ii=-1;
  float ax=0;
  float ay=0;
  for (int i =0; i < 3; i ++)
    if (MVB[i].InsideBoxe(rmouseX, rmouseY)) {
      ii=MVB[i].index;
      ax=MVB[i].centerx;
      ay=MVB[i].b + 40;
    }
  float yy = ay+100-rmouseY;
  if (ii!=-1) {
    float[] a = new float[5];
    float constraint1=0, constraint2=0;
    for (int i=1; i<=maxs[ii]; i++) {
      for (int j=1; j<=4; j++)
        a[j]=MF[i][ii].getParameter(j);
      float x=(rmouseX-ax)/3;
      float y=(ay+100-rmouseY);
      if (MF[i][ii].type!=2) {
        constraint1=MF[i][ii].normality*(x-a[1])/(a[2]-a[1]);
        if (MF[i][ii].type==1) {
          constraint2=MF[i][ii].normality*(x-a[4])/(a[2]-a[4]);
          a[3]=a[2];
        } else {
          constraint2=MF[i][ii].normality*(x-a[4])/(a[3]-a[4]);
        }
      } else {
        a[3]=a[2];
        constraint2=Gaussian(x, a[2], (a[4]-a[2])/MF[i][ii].Gauss)*MF[i][ii].normality;
        constraint1=Gaussian(x, a[2], (a[2]-a[1])/MF[i][ii].Gauss)*MF[i][ii].normality;
      }
      if (y > 0 && y < 105 &&
        ((y>=constraint1-8 && y<=constraint1+8) ||
        (y>=constraint2-8 && y<=constraint2+8)
        || (x>a[2] && x<a[3] &&  y<=MF[i][ii].normality + 5 && y>=MF[i][ii].normality - 5))) {
        bs[ii]=i;
        if (MFtype!=0 && MFtype!= MF[i][ii].type) {
          MF[i][ii].settype(MFtype, ii);
          int start = 0;
          int end = 0;
          if (shapes2_b[4].activated ||  shapes2_b[2].activated) {
            start = 0;
            end = 3;
          } else if (shapes2_b[1].activated ||  shapes2_b[3].activated) {
            start = ii;
            end = ii + 1;
          }
          for (int l =start; l < end; l++)
            for (int t = 1; t <= maxs[l]; t++)
              MF[t][l].settype(MFtype, l);
          if (symmetry)
            MF[maxs[ii]-i+1][ii].settype(MFtype, ii);
        }
        if (name_index==0) {
          MF[inumber][iinumber].state=false;
          MF[i][ii].state=true;
          inumber=i;
          iinumber=ii;
        }
        if (Rules_Edit_b.activated) {
          if (ii==1)
            tablei=i;
          else if (ii==2)
            tablej=i;
          else if (ii==0) {
            if (mouseButton == RIGHT )
              rules_Table[tablej-1][tablei-1]=0;
            else
              rules_Table[tablej-1][tablei-1]=i;
            //if (Rules_anim_b.activated)
            //  update_Rules_animation();
            update_2Dplot();
          }
        }
        break;
      } else if (name_index>=0 && name_index <=2 && MF[inumber][iinumber].state) {
        if (yy>=MF[inumber][iinumber].normality+10 && yy<=MF[inumber][iinumber].normality+20 && rmouseX >= corner_Left && rmouseX<=corner_Right ) {
          name_index=1;
        } else if (rmouseX >= ax-325 && rmouseX <= ax+155 && rmouseY>=ay+130 && rmouseY<=ay+150 ) {
          name_index=2;
        } else {
          MF[i][ii].state=false;
          name_index=0;
        }
      }
    }
  } else {
    MF[inumber][iinumber].state=false;
    name_index=0;
  }
  if (!surface_3D) {
    Signalsdropdown.handleClick(rmouseX, rmouseY);
    if (ODedropdown.handleClick(rmouseX, rmouseY)) {
      ODE = 2 * ODedropdown.selectedItemIndex;
      update_2Dplot();
    } else if (dispMode.handleClick(rmouseX, rmouseY)) {
      Umouse_b.activated = false;
      dispIndex = dispMode.selectedItemIndex;
    }
  }
  if (rmouseX>=480 && rmouseX<=560 && rmouseY >=200 && rmouseY<=230 && !debugStart_b.activated
    && !UART_b.activated && resetDebug)
    name_index=9;
  if (rmouseX>=290 && rmouseX<=390 && rmouseY >=200 && rmouseY<=230 && !debugStart_b.activated
    && !UART_b.activated && resetDebug)
    name_index=25;
  if (Umouse_b.activated) {
    if (rmouseX>=410 && rmouseX<=540 && rmouseY >=230 && rmouseY<=255) {
      name_index = 62;
    } else if (rmouseX>=540 && rmouseX<=670 && rmouseY >=230 && rmouseY<=255) {
      name_index = 63;
    }
  }
  if (dispIndex ==1) {
    if (rmouseX>=480 && rmouseX<=630 && rmouseY >=465 && rmouseY<=495)
      name_index=35;
    else if (rmouseX>=480 && rmouseX<=630 && rmouseY >=525 && rmouseY<=555 && !discreteSys_b.activated)
      name_index=36;
    else if (rmouseX>=480 && rmouseX<=630 && rmouseY >=660 && rmouseY<=690)
      name_index=37;
  } else if (dispIndex == 2) {
    if (rmouseX >= 150 &&  rmouseX <=  250 && rmouseY >=235 && rmouseY <=260)
      name_index = 80;
    else if (rmouseX >= 150 &&  rmouseX <= 250 && rmouseY >=265 && rmouseY <= 290)
      name_index = 81;
    else if (rmouseX >= 150 && rmouseX <= 250 && rmouseY >=325 && rmouseY <= 350)
      name_index = 82;
    else if (rmouseX >= 150 && rmouseX <= 250 && rmouseY >=355 && rmouseY <= 375)
      name_index = 83;
    else if (rmouseX >= 445 &&  rmouseX <= 545 && rmouseY >=355 && rmouseY <= 380 && fixedWinds.activated)
      name_index = 84;
    else if (rmouseX >= 445 &&  rmouseX <= 545 && rmouseY >=355 && rmouseY <= 380 && !fixedWinds.activated)
      name_index = 89;
    else if (rmouseX >= 445 &&  rmouseX <= 545 && rmouseY >=385 && rmouseY <= 410 && !fixedWinds.activated)
      name_index = 90;
    ///////////////////////////
    else if (rmouseX >= 480 && rmouseX <= 580 && rmouseY >=235 && rmouseY <=260)
      name_index = 85;
    else if (rmouseX >= 480 && rmouseX <= 580 && rmouseY >=265 && rmouseY <= 290)
      name_index = 86;
    else if (rmouseX >= 480 && rmouseX <= 580 && rmouseY >=295 && rmouseY <= 320)
      name_index = 87;
    //else if (rmouseX >= 380 && rmouseX <= 480 && rmouseY >=325 && rmouseY <= 350)
    //  name_index = 88;
    //else if (rmouseX >= 430 && rmouseX <= 530 && rmouseY >=380 && rmouseY <= 415) //430, 385
    //  name_index = 91;
    //else if (rmouseX >= 430 && rmouseX <= 530 && rmouseY >=415 && rmouseY <= 445)
    //  name_index = 92;
  }

  if (face == 1) { /////////////////////////////////////////////////////////////////////////////////////
    float table_X=(310)/(maxs[1]+1);
    float table_Y=(310)/(maxs[2]+1);
    if (rmouseX >= 670 && rmouseX <= table_X + 670 &&
      rmouseY >= 450 && rmouseY <=table_Y +450 && Rules_Edit_b.activated) {
      rules_Operators[tablej-1][tablei-1] = !rules_Operators[tablej-1][tablei-1];
      update_2Dplot();
    }
    if (rmouseX>= 1140 && rmouseX<= 1290 && rmouseY >= 690 && rmouseY<= 710) {
      name_index=32;
    } else if (rmouseX<=200  && rmouseY >=740 && rmouseY<=765 && surface_3D)
      name_index= 33;
  } else if (face==2) { /////////////////////////////////////////////////////////////////////////////////////
    maxSats.handleClick(rmouseX, rmouseY);
    if (rmouseX>= dataSave_b[1].x && rmouseX<= dataSave_b[1].x + 300 && rmouseY >= dataSave_b[1].y +30 && rmouseY<= dataSave_b[1].y + 60)
      name_index=3;
    else if (rmouseX>=1070 && rmouseX<=1260 && rmouseY >=630 && rmouseY<=660)
      name_index= 34;
    else if (rmouseX>=Gain_plus_b[0].x + 20 && rmouseX<= Gain_minus_b[0].x && rmouseY >= Gain_plus_b[0].y && rmouseY<= Gain_plus_b[6].y + 30)
      name_index= (rmouseY-Gain_plus_b[0].y)/30+40;
    else if (rmouseX>=1070 && rmouseX<=1200 && rmouseY >=460 && rmouseY<=500)
      name_index= int(rmouseY/480)+10;
    else if (rmouseX>=1135 && rmouseX<=1290 && rmouseY >=590 && rmouseY<=620)
      name_index= 50 + maxSats.selectedItemIndex;
  } else if (face == 3 && !UART_b.activated) {
    /////////////////////////////////////////////////////////////////////////////////////
    if (rmouseX>=870 && rmouseX<= 950 && rmouseY >=490 && rmouseY<=565)
      name_index= (rmouseY-490)/25+14;
    else if (rmouseX>=1015  && rmouseX<=1075  && rmouseY >=710 && rmouseY<=745)
      name_index= 18;
    else if (rmouseX>=1075  && rmouseX<= 1135 && rmouseY >=710 && rmouseY<=745)
      name_index= 19;
    else if (rmouseX>=805   && rmouseX<=855   && rmouseY >=710 && rmouseY<=745)
      name_index= 26;
    else if (rmouseX>=855   && rmouseX<=905   && rmouseY >=710 && rmouseY<=745)
      name_index= 27;
    else if (rmouseX>=970   && rmouseX<=1090  && rmouseY >=500 && rmouseY<=520)
      name_index= 30;
    else if (rmouseX>=1190  && rmouseX<=1250  && rmouseY >=500 && rmouseY<=520)
      name_index= 31;
  }
}
