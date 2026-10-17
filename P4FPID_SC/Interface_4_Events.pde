void Interface4MousePressed() {
  if (AdaptiveC_b.press()) {
    AdaptiveC_b.activated = !AdaptiveC_b.activated;
    AdaptiveC2_b.activated = AdaptiveC_b.activated;
    //if (!AdaptiveC_b.activated)
    //  MF[(maxs[0]+1)/2][0].a2 = MF[(maxs[0]+1)/2][0].a3 = 0;
    //else
    //  if (BABS.activated)
    //    MaxSaturations[2] = 0.5;
    //  else
    //    MaxSaturations[2] = 100;
    update_2Dplot();
  } else if (resetGains.press()) {
    Ke = Kde = Ky1 = Ky2 = 1;
    update_2Dplot();
  }
}

void Interface4MouseReleased() {
  AdaptiveC_b.release();
  resetGains.release();
}
