void Animate_Rules() {
  //float K_e =3;
  //float K_de =3;
  //float K_y1 =3;
  //float K_y2 =3;
  //float K_y3 =3;
  //if (UART_b.activated) {
  //  K_e *= Ke;
  //  K_de *= Kde;
  //  K_y1 *= Ky1;
  //  K_y2 *= Ky2;
  //  K_y3 *= Ky3;
  //}
  float E   = Bound__(300, -300, 3 *ein);
  float DE  = Bound__(300, -300, 3 *dein);
  float YO1 = Bound__(300, -300, 3 *yout1);
  float YO2 = Bound__(300, -300, 3 *yout2);
  float YO3 = Bound__(300, -300, 3 *yout3);

  if (debugStart_b.activated) {
    YO1 = Bound__(300, -300, 3 *debugY1);
    YO2 = Bound__(300, -300, 3 *debugY2);
    YO3 = Bound__(300, -300, 3 *debugY3);
  }

  for (int i=0; i<1000; i+=movingStep) {
    stroke(#D10FAE,100);
    strokeWeight(max(movingStep/5, 1)); //min(movingStep, 5)
    line(i*0.6+25, 140-mp[i], i*0.6+25, 140);
    strokeWeight(2);
    stroke(0);
    line(i*0.6+25, 140-mp[i], (i+movingStep)*0.6+25, 140-mp[int(min(i+movingStep, 999))]);
  }

  strokeWeight(2);
  fill(#FF311A);
  stroke(0);
  line(975+E, 150, 975+E, 5);
  triangle(975+E, 150, 970+E, 165, 980+E, 165);



  strokeWeight(2);
  fill(255, 200, 0);
  stroke(0);
  line(975+DE, 350, 975+DE, 205);
  triangle(975+DE, 350, 970+DE, 365, 980+DE, 365);


  fill(#38FF03);
  stroke(0);
  line(325+YO1, 150, 325+YO1, 5);
  triangle(325+YO1, 150, 320+YO1, 165, 330+YO1, 165);



  fill(0);
  if (UART_b.activated || debugStart_b.activated) {
    if (BD_Index == 0) {
      line(325+YO2, 150, 325+YO2, 5);
      triangle(325+YO2, 150, 320+YO2, 165, 330+YO2, 165);
    } else if (BD_Index == 1) {
      line(975+YO3, 150, 975+YO3, 5);
      triangle(975+YO3, 150, 970+YO3, 165, 980+YO3, 165);
    }
  }

  textFont(font1, 20);
  fill(0);
  text(nf(ein, 0, 2), 950, 168);
  text(nf(dein, 0, 2), 950, 368);
  text(nf(yout1, 0, 2), 300, 168);
  textFont(font2, 20);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void update_Rules_animation() {
  Reset_Rules_Activation();
  inference(ein, dein);
  if (!debugStart_b.activated && !UART_b.activated) {
    arrayCopy(UoD, mp);
    yout1=Defuzzification();
  }
  resetUniverse();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void Reset_Rules_Activation() {
  for (int i=0; i<=14; i++) {
    MF[i][0].activation = 0;
    MF[i][1].activation = 0;
    MF[i][2].activation = 0;
  }
}
