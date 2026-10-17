float  Bound__(float a, float b, float value) {
  if (value > a)
    value = a;
  else if (value < b)
    value = b;
  return value;
}

double DBound__(double value, double a) {
  if (value > a)
    value = a;
  else if (value < -a)
    value = -a;
  return value;
}

int  IBound__(float a, float b, float value) {
  if (value > a)
    value = a;
  else if (value < b)
    value = b;
  return int(value);
}


float Gaussian(float d1, float d2, float d3) {
  return (exp(-0.5*pow(((d1-d2)/d3), 2)));
}

void  settingbounds() {
  if (typing[0] == '[' && typing[typing_counter-1]== ']' ) {
    int c=0;
    int cc=5;
    int k = 5;
    if (name_index==2) {
      if (typing_counter>=2) {
        for (int i=1; i<typing_counter-2; i++) {
          if (typing[i]==';')
            c++;
        }
        if ((c==cc-1 && MF[inumber][iinumber].type >1)
          || (c==cc-2 && MF[inumber][iinumber].type  == 1)) {
          String[] bound= new String[MF[inumber][iinumber].type];
          bound= split(String.copyValueOf(typing, 1, typing_counter-2)+';', ';');
          if (MF[inumber][iinumber].type ==3) {
            for (int j =1; j < 5; j ++) {
              VerifyMFAssignment(iinumber, inumber, j, float(bound[j-1]), float(bound[k]));
            }
          } else {
            if (MF[inumber][iinumber].type ==2)
              MF[inumber][iinumber].Gauss = Bound__(12, 1, float(bound[4]));
            else
            k = 4;
            VerifyMFAssignment(iinumber, inumber, 1, float(bound[0]), float(bound[k]));
            VerifyMFAssignment(iinumber, inumber, 2, float(bound[1]), float(bound[k]));
            VerifyMFAssignment(iinumber, inumber, 3, float(bound[1]), float(bound[k]));
            VerifyMFAssignment(iinumber, inumber, 4, float(bound[2]), float(bound[k]));
          }
        }
      }
    } else if (name_index>=10 && name_index<=13) {
      for (int i=1; i<typing_counter-2; i++) {
        if (typing[i]==';')
          c++;
      }
      String[] bound= new String[c+1];
      bound= split(String.copyValueOf(typing, 1, typing_counter-2) + ';', ';');
      for (int i=0; i<=c; i++) {
        transfer_fct[i][name_index-10]=float(bound[i]);
      }
      if (name_index==10) {
        nomenator=c;
      } else if (name_index==11) {
        denomenator=c;
      }
    }
  }
}

void text_Disply(float x, float y) {
  text(String.copyValueOf(typing, 0, typing_counter)+Cursor, x-textWidth(String.copyValueOf(typing, 0, typing_counter))/2, y);
}

void textCaseVar(int NF, int ind, float value, float x, float y) {
  if (name_index== ind)
    text_Disply(x, y);
  else
    text(nf(value, 0, NF), x-textWidth(nf(value, 0, NF))/2, y);
}

void textBox(int ind, String value, float x, float y) {
  if (name_index== ind)
    text_Disply(x, y);
  else
    text(value, x-textWidth(value)/2, y);
}


float  setTextWidth(int z, int txtWidth, String txt) {
  textSize(z);
  float sizeTxt = textWidth(txt);
  float zz = z;
  while (sizeTxt > txtWidth) {
    zz-=0.5;
    textSize(zz);
    sizeTxt = textWidth(txt);
  }
  return zz;
}
