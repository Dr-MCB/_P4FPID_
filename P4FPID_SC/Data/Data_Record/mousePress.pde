void mousePressed() {
  if (sys2_b.press()) {
    sys2_b.activated = ! sys2_b.activated;
  } else if (er2_b.press()) {
    er2_b.activated = ! er2_b.activated;
  } else if (der2_b.press()) {
    der2_b.activated = ! der2_b.activated;
  } else if (ctr2_b.press()) {
    ctr2_b.activated = ! ctr2_b.activated;
  } else if (Y1_b.press()) {
    Y1_b.activated = ! Y1_b.activated;
  } else if (Y2_b.press()) {
    Y2_b.activated = ! Y2_b.activated;
  } else if (Y3_b.press()) {
    Y3_b.activated = ! Y3_b.activated;
  } else if (grid2_b.press()) {
    grid2_b.activated = ! grid2_b.activated;
  } else if (speedUp_b.press()) {
    Speed = int(max(1, Speed - 1));
  } else if (speedDown_b.press()) {
    Speed = int(max(1, Speed + 1));
  } else if (play_b.press() && dataUploaded) {
    play_b.activated = ! play_b.activated;
    //dataUploaded = true;
  } else if (forward_b.press()) {
    forward_b.activated = ! forward_b.activated;
    backward_b.activated = ! forward_b.activated;
    direction = 1;
  } else if (backward_b.press()) {
    backward_b.activated = ! backward_b.activated;
    forward_b.activated = ! backward_b.activated;
    direction = -1;
  } else if (adjust_b.press()) {
    Recrestore();
    I2max = 10;
    playCounter = 1;
    Speed = 5;
    scl_x = 50;
    scl_w = max(1150*1150/max(recordTime * I2max, 1150), 10);
  } else if (importFrom.press()) {
    importFrom.pressed = false;
    selectFolder("Select a folder to save the Data:", "folderSelected");
  }
}

void folderSelected(File selection) {
  if (selection != null) {
    import_Path = selection.getAbsolutePath().replace('\\', '/');
    import_Path += "/";
    Recrestore();
  }
}
