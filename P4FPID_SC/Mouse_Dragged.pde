void mouseDragged() {
  if (mousePressCatched==true && !rulesAnimDragDEr && !rulesAnimDragEr
    && !rangeDrag[0] && !rangeDrag[1]&& !rangeDrag[2]) {
    for (int i =0; i < 3; i ++)
      if (MVB[i].InsideBoxe(rmouseX, rmouseY)) {
        draggedMV_I=MVB[i].index;
        draggedMV_Y=MVB[i].centery;
        draggedMV_X=MVB[i].centerx;
      }
    if (draggedMV_I!=-1) {
      for (int i=1; i<=maxs[draggedMV_I]; i++) {
        draggedMF_Parameter = CheckDragging(draggedMV_I, i, (rmouseX-draggedMV_X)/3, -1*rmouseY+draggedMV_Y, 5);
        if (draggedMF_Parameter > 0 && VerifyMFAssignment(draggedMV_I, i, draggedMF_Parameter, (rmouseX-draggedMV_X)/3, -rmouseY+draggedMV_Y)) {
          draggedMF_index=i;
          mousePressCatched=false;
          break;
        }
      }
    }
  } else if (draggedMF_index != 0 && !rulesAnimDragDEr && !rulesAnimDragEr
    && !rangeDrag[0] && !rangeDrag[1] && !rangeDrag[2]) {
    float sign = (mouseX-pmouseX) * 0.2;
    if (mouseButton == RIGHT) {
      rightMouse = true;
      for (int k = 1; k <=4; k ++) {
        VerifyMFAssignment(draggedMV_I, draggedMF_index, k, MF[draggedMF_index][draggedMV_I].getParameter(k)+sign, -rmouseY+draggedMV_Y);
        if (LinkedMF)
          ConstrainedLikage(draggedMV_I, draggedMF_index, k);
        if (symmetry && MF[draggedMF_index][draggedMV_I].type == MF[maxs[draggedMV_I] - draggedMF_index + 1][draggedMV_I].type) {
          VerifyMFAssignment(draggedMV_I, maxs[draggedMV_I] - draggedMF_index + 1, 5 - k, -MF[draggedMF_index][draggedMV_I].getParameter(k)-sign, -rmouseY+draggedMV_Y);
          if (LinkedMF)
            ConstrainedLikage(draggedMV_I, maxs[draggedMV_I] - draggedMF_index + 1, 5 - k);
        }
      }
    } else if (mouseButton == LEFT) {
      rightMouse =false;
      VerifyMFAssignment(draggedMV_I, draggedMF_index, draggedMF_Parameter, (rmouseX-draggedMV_X)/3, -rmouseY+draggedMV_Y);

      if (PushALL)
        pushAll(draggedMV_I, draggedMF_index, draggedMF_Parameter);
      if (LinkedMF) {
        ConstrainedLikage(draggedMV_I, draggedMF_index, draggedMF_Parameter);
        if (PushALL)
          ConstrainedLikage(draggedMV_I, maxs[draggedMV_I] - draggedMF_index + 1, 5-draggedMF_Parameter);
      }

      if (symmetry && MF[draggedMF_index][draggedMV_I].type == MF[maxs[draggedMV_I] - draggedMF_index + 1][draggedMV_I].type) {
        VerifyMFAssignment(draggedMV_I, maxs[draggedMV_I] - draggedMF_index + 1, 5 - draggedMF_Parameter, -(rmouseX-draggedMV_X)/3, -rmouseY+draggedMV_Y);
        if (LinkedMF)
          ConstrainedLikage(draggedMV_I, maxs[draggedMV_I] - draggedMF_index + 1, 5 - draggedMF_Parameter);
      }
    }

    if (LinkedMF)
      optimize_fcts(draggedMV_I);
    update_2Dplot();
    MF[inumber][iinumber].state=false;
    MF[draggedMF_index][draggedMV_I].state=true;
    inumber=draggedMF_index;
    iinumber=draggedMV_I;
  }

  float per = progBar.DragProgB();
  if ( !InputDragged && !rulesAnimDragDEr && !rulesAnimDragEr
    && !rangeDrag[0] && !rangeDrag[1]&& !rangeDrag[2])
    dragged_I = int(per*simulationSteps)- int(per*simulationSteps)%10;


  if (Rules_anim_b.activated) {
    if (!rulesAnimDragDEr && rmouseX<=990+dein*Kde*3 && rmouseX>=960+dein*Kde*3 && rmouseY<=370 && rmouseY>=355) {
      rulesAnimDragDEr = true;
    } else if (!rulesAnimDragEr && rmouseX<=990+ein*Ke*3 && rmouseX>=960+ein*Ke*3 && rmouseY<=170 && rmouseY>=155) {
      rulesAnimDragEr = true;
    }
    if (rulesAnimDragDEr) {
      dein= Bound__(Range[2], -Range[2], (rmouseX-975)/3);
      update_Rules_animation();
    } else if (rulesAnimDragEr) {
      ein= Bound__(Range[1], -Range[1], (rmouseX-975)/3);
      update_Rules_animation();
    }
  }

  for (int i =0; i < 3; i ++) {
    if (range_b[i].activated) {
      float  X = MVB[i].centerx;
      float  X1 = X+ 3*Range[i];
      float  X2 = X- 3*Range[i];
      float  Y = MVB[i].b;
      if (! rangeDrag[i] && rmouseX<=X1+15 && rmouseX>=X1-15 && rmouseY<=Y+10 && rmouseY>=Y-10) {
        rangeDrag[i] = true;
      } else if (!rangeDrag[i] && rmouseX<=X2+15 && rmouseX>=X2-15 && rmouseY<=Y+10 && rmouseY>=Y-10) {
        rangeDrag[i] = true;
      }

      if (rangeDrag[i]) {
        Range[i] = Bound__(99, abs(min(MF[1][i].a4, MF[maxs[i]][i].a1)), abs((rmouseX-X)/3));
        if ((keyPressed && keyCode == TAB) || shapes2_b[2].activated || shapes2_b[4].activated ) {
          Range[0] =Range[1]= Range[2]= Range[i];
          range_b[0].activated = range_b[1].activated = range_b[2].activated = range_b[i].activated;
        }
        update_2Dplot();
      }
    }
  }

  if (Umouse_b.activated)
    DragInputTimeIntervals();
  if (VscrBar.totalCount >= 20)
    VscrBar.drag(rmouseY);

  if (!rulesBarDrag && rmouseX>=630 && rmouseX<=650 &&   rmouseY<=690 &&   rmouseY>=220 && Rules_Edit_b.activated && face==1) {
    rulesBarDrag = true;
  }
  if (rulesBarDrag) {
    ruleswheel=(IBound__(470, 0, rmouseY-220))*(maxs[1]*maxs[2])/470;
    tablej=ruleswheel%maxs[2]+1;
    tablei=ruleswheel/(maxs[2])+1;
  }
  if (face == 3 && !crossOverStyle_b[0].activated)
    G_A.crossOverPoint = scrBar.Drag()/100;


  if (mousePressed && rmouseX<650 && rmouseY > 230 && rmouseY < 730  && Surface_b[0].activated) {
    hold3D = true;
    rot_X=map(rmouseX, 40, 650, -90, 90)*0.1;
    rot_Y=map(rmouseY, 200, 770, -90, 90)*0.1;
  }

  if (dispIndex == 2 || face == 4) {
    if (face!= 4) {
      if (rmouseX <= S2.x*ScalProcess +10 && rmouseX >= S2.x*ScalProcess -10 &&
        rmouseY <= S2.y +5 && rmouseY >= S2.y -5 && !l1Drag && !l2Drag) {
        l1Drag = true;
      } else if (rmouseX <= (S2.x-l1)*ScalProcess +10 && rmouseX >= (S2.x-l1)*ScalProcess -10 &&
        rmouseY <= S2.y +5 && rmouseY >= S2.y -5 && !l2Drag && !l1Drag) {
        l2Drag = true;
      }
      if (l1Drag) {
        l1 = Bound__(min(560-l1, l2, 150), 40, abs(int(rmouseX - l2)));
      } else if (l2Drag) {
        l2 = Bound__(560-l1, l1, abs(int(rmouseX - S1.x)));
      }
    } else {
      if (rmouseX <= (S2.x*ScalProcess+650) +10 && rmouseX >= (S2.x*ScalProcess+650) -10 &&
        rmouseY <= S2.y +5 && rmouseY >= S2.y -5 && !l1Drag && !l2Drag) {
        l1Drag = true;
      } else if (rmouseX <= (S2.x-l1)*ScalProcess +10 +650 && rmouseX >= (S2.x-l1)*ScalProcess -10 +650 &&
        rmouseY <= S2.y +5 && rmouseY >= S2.y -5 && !l2Drag && !l1Drag) {
        l2Drag = true;
      }
      if (l1Drag) {
        l1 = Bound__(min(560-l1, l2, 150), 40, abs(int(rmouseX - l2 - 650)));
      } else if (l2Drag) {
        l2 = Bound__(560-l1, l1, abs(int(rmouseX - S1.x - 650)));
      }
    }
    if (l1Drag || l2Drag) {
      if (AdaptiveC_b.activated) {
        //pushFromEdge(0, 1, 3);
        //for (int i = 1; i <= maxs[0]; i++) {
        //  MF[i][0].Shrink(i, maxs[0], fs[0], MF[i][0].type, min(abs(100-1.5*l1/6), 100));
        //}
        //MF[1][0].a1 = MF[1][0].a2 = -100;
        //MF[maxs[0]][0].a4 = MF[maxs[0]][0].a3 =  100;
        //optimize_fcts(0);
        //Range[0] = abs((MF[1][0].a3 + MF[1][0].a2)/2);
        //Range[1] = abs(100 - 2*l1/10);
        //MF[(maxs[1] + 1)/2-1][2].a2 = MF[(maxs[1] + 1)/2-1][2].a3 = min(-35-35*(l1/l2-0.5), -35);
        //MF[(maxs[1] + 1)/2+1][2].a2 = MF[(maxs[1] + 1)/2+1][2].a3 = max(35+35*(l1/l2-0.5), 35);
        //pushFromEdge(0, 1, 3);

        ///////////////////////////////////////
        rulesTrend.clear();
        weightsTrend.clear();
        rulesStep = pow(l1/l2-0.01, 2);
        for (int j=0; j < maxs[0]; j++) {
          rulesTrend.append(rules_Table[maxs[0]-1][j]);
          weightsTrend.append(1);
        }

        //////////////////////////////////////
        //Kde = Bound__(1.5, 1, l1/300 + pow(l1/l2, 2));
        Ky1 = l1/10; //pow(l1/l2,2)
        //Ke = max(1-abs(l1/l2), 0.1); //*(Ky1+Ky2)/Kde
        //Ky2 = 0;
      }
      update_2Dplot();
    }
  }
}
int sign(float X) {
  if (X>=0)
    return 1;
  else
    return -1;
}
