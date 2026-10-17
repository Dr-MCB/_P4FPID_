void mouseDragged() {
  float per = bar.DragProgB();
  playCounter = int(per*recordTime);
}
void keyPressed() {
  if (keyCode == UP) {
    Y2g +=50;
  } else if (keyCode == DOWN) {
    Y2g -=50;
  } else if (keyCode == RIGHT) {
    playCounter= int(min(playCounter + 5, recordTime));
    bar.UpdatePrgB(playCounter * I2max, recordTime * I2max);
  } else if (keyCode == LEFT) {
    playCounter = int(max(playCounter - 5, 1));
    bar.UpdatePrgB(playCounter * I2max, recordTime * I2max);
  }
}
