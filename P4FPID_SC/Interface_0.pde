void MainInterface() {
  
  if (ruleEditing && face==1 && Rules_Edit_b.activated) {
    show_Rules();
  } else if (surface_3D) {
    draw_3DSurface();
  } else if (dispIndex == 2) {
    animateProcess();
  } else {
    drawGraph();
  }
  DrawGraphSettings();
  drawMFsShapes();
  drawMVsCtrButtons();
  drawMFsConfig();
  drawBlockDiagram();
  Launch_GA_optimization();
  if (Rules_anim_b.activated && (dispIndex ==0 || dispIndex ==2))
    Animate_Rules();
}
