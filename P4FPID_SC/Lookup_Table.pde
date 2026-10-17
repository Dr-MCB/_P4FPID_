void draw_3DSurface() {
  Sleeping = false;
  sleepingTimer =0;
  float factor=map(zoom_3D, 1, 100, 0.5, 3);
  v.scale(factor, factor, factor);
  v.beginDraw();
  v.background(#F0FFFE);
  v.translate(v.width/2, v.height/2);
  v.rotateY(rot_X);
  v.rotateX(rot_Y);
  v.rotateZ(0.19f * surfaceRrotateCounter);
  v.stroke(0);
  for (int j=0; j<199; j++) {
    for (int i=0; i<199; i++) {
      if (abs(i-100) <= Range[2] && abs(j-100) <= Range[1]) {
        float zp = Surface[i+1][j+1];
        float zp2 = Surface[i][j];
        if (surfaceProjection_b.activated) {
          zp =0;
          zp2=0;
        }
        color shade1= lerpColor(#05FF07, #FFF305, map(Surface[i+1][j+1], 0, abs(max3D) -20, 0, 1));
        color shade2= lerpColor(#05FF07, #03FFF0, map(-Surface[i+1][j+1], 0, abs(min3D) - 20, 0, 1));
        if ( Surface[i][j]>0)
          v.stroke(shade1);
        else
          v.stroke(shade2);
        v.strokeWeight(3);
        v.line((i-100)*factor, (j-100)*factor, zp2*factor, (i-99)*factor, (j-99)*factor, zp*factor);
        if (surfaceResolution[GrCounter] > 1) {
          if (i%surfaceResolution[GrCounter]==0) {
            v.strokeWeight(3);
            v.stroke(0);
            v.line((i-100)*factor, (j-100)*factor, zp2*factor, (i-99)*factor, (j-99)*factor, zp*factor);
          }
          if (j%surfaceResolution[GrCounter]==0) {
            v.strokeWeight(3);
            v.stroke(0);
            v.line((i-100)*factor, (j-100)*factor, zp2*factor, (i-99)*factor, (j-99)*factor, zp*factor);
          }
        }
      }
    }
  }
  float ax=factor*100;
  v.noFill();
  if (!surfaceGrid_b.activated && !surfaceProjection_b.activated) {
    for (float i=-ax; i<=ax; i+=20) {
      if (ax%i==0) {
        v.strokeWeight(5);
        v.stroke(0);
      } else {
        v.strokeWeight(2);
        v.stroke(150, 170);
      }
      v. line(i, ax, -ax, i, -ax, -ax);
      v.line(ax, i, -ax, -ax, i, -ax);
      v.line(i, ax, ax, i, ax, -ax);
      v.line(ax, i, ax, ax, i, -ax);
      v.line(ax, ax, i, -ax, ax, i);
      v.line(ax, -ax, i, ax, ax, i);
    }
  }

  if (Rules_anim_b.activated && surfaceProjection_b.activated) {
    v.pushMatrix();
    v.translate(ein*factor, dein*factor, 0);
    v.stroke(#FF03E2);
    v.sphere(10*zoom_3D/100);
    v.popMatrix();
  }

  v.strokeWeight(3);
  v.stroke(255, 0, 0);
  if (!surfaceProjection_b.activated) {
    v.line(0, 0, -ax, 0, 0, ax);
    v.line(-ax, 0, 0, ax, 0, 0);
    v.line(0, -ax, 0, 0, ax, 0);
  } else {
    v.strokeWeight(1.5);
  }
  v.strokeWeight(3);
  v.line(-ax, -ax, 0, ax, -ax, 0);
  v.line(-ax, ax, 0, ax, ax, 0);
  v.line(-ax, -ax, 0, -ax, ax, 0);
  v.line(ax, -ax, 0, ax, ax, 0);
  v.fill(0);
  v.textSize(20*factor);
  v.pushMatrix();
  v.translate(0, ax, 0);
  if (!surfaceProjection_b.activated) {
    v.rotateX(PI/2);
    v.rotateZ(PI);
  }
  v.text("Y:A", 0, 35, 0);
  v.popMatrix();

  v.pushMatrix();
  v.translate(0, -ax, 0);
  if (!surfaceProjection_b.activated) {
    v.rotateX(PI/2);
    v.rotateZ(PI);
  }
  v.text("Y:-A", 0, -10, 0);
  v.popMatrix();

  v.pushMatrix();
  v.translate(ax, 0, 0);
  if (!surfaceProjection_b.activated) {
    v.rotateX(PI/2);
    v.rotateZ(PI);
  }
  v.text("X:A", 10, 0, 0);
  v.popMatrix();

  v.pushMatrix();
  v.translate(-ax, 0, 0);
  if (!surfaceProjection_b.activated) {
    v.rotateX(PI/2);
    v.rotateZ(PI);
  }
  v.text("X:-A", -50, 0, 0);
  v.popMatrix();

  v.rotateZ(-0.19f * surfaceRrotateCounter);
  if (!surfaceProjection_b.activated) {
    v.pushMatrix();
    v.translate(0, 0, ax);
    v.rotateX(PI/2);
    v.rotateZ(PI);
    v.text("Z:1", 0, 0, 0);
    v.popMatrix();

    v.pushMatrix();
    v.translate(0, 0, -ax);
    v.rotateX(PI/2);
    v.rotateZ(PI);
    v.text("Z:-1", 0, 0, 0);
    v.popMatrix();
  }


  if (surfaceRot_b.activated && !hold3D)
    if (face ==3)
      surfaceRrotateCounter += 30*0.02f;
    else
      surfaceRrotateCounter += 50*0.02f;
  v.endDraw();
  image(v, 0, 200);
}




void DNA() {
  color[] COL={#F70707, #034CFF, #FF2903, #07D304, #05E3FA};
  r.beginDraw();
  r.scale(0.60);
  r.background(#FFFFFF);
  r.pushMatrix();
  r.translate(r.width/2, 300, -700);
  r.rotateX(PI/2);
  r.rotateY(PI/8);
  r.rotateZ(radians(RZ));
  r.stroke(#06CE1B);
  r.strokeWeight(7);
  r.line(0, 0, -450, 0, 0, 800);
  r.fill(255);
  for (float i=0; i<= 4.5; i+=0.2) {
    r.pushMatrix();
    r.translate(0, 0, i*250-400);
    r.rotateZ(i*3*PI/4.5);
    r.stroke(COL[int(i*5)%5]);
    r. strokeWeight(8);
    r.line(180, 0, 0, 0, 0, 0);
    r.pushMatrix();
    r.translate(180, 0, 0);
    r.stroke(COL[int(i*5)%5]);
    r.strokeWeight(2);
    r.sphere(40);
    r.popMatrix();
    r.popMatrix();
    r.pushMatrix();
    r.translate(0, 0, i*250-350);
    r.rotateZ(i*3*PI/4.5);
    r. strokeWeight(8);
    r.stroke(COL[int(i*3)%5]);
    r.line(-180, 0, 0, 0, 0, 0);
    r.pushMatrix();
    r.translate(-180, 0, 0);
    r. strokeWeight(2);
    r.stroke(COL[int(i*5)%5]);
    r.sphere(40);
    r.popMatrix();
    r.popMatrix();
  }
  r.popMatrix();
  if (!opt_start_b[0].activated)
    RZ+=1;
  else
    RZ+=2*(36-GA_Speed);
  if (RZ == 360)
    RZ = 0;
  r.endDraw();
}
