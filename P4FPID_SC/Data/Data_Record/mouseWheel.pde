void mouseWheel(MouseEvent event) {
  if (keyPressed && key == 'x') {
    I2max = int(Bound__(50, 1, I2max + event.getCount()));
    if (dataUploaded) {
      bar.UpdatePrgB(I2max * playCounter, I2max * recordTime);
    }
  } else if (keyPressed && key == 'y')
    V2max = int(Bound__(250, 1, V2max + event.getCount()*20));
}
