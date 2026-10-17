void mouseReleased() {
  InputDragged = false;
  progBar.ProgDragged = false;
  scrBar.Pdragged =  false;
  l1Drag = l2Drag =false;
  rangeDrag[0] = rangeDrag[1] =rangeDrag[2] =rulesBarDrag = rulesAnimDragDEr = rulesAnimDragEr = false;
  MainInterfaceMouseReleased();
  if (face==1) {
    Interface1MouseReleased();
  } else if (face==2) {
    Interface2MouseReleased();
  } else if (face == 3) {
    Interface3MouseReleased();
  } else if (face == 4) {
    Interface4MouseReleased();
  }
}
