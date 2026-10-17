class DropdownChecklist {
  String title;
  float x, y, w;
  float itemHeight = 25;
  boolean expanded = false;
  String[] options;
  boolean[] selected;
  color[] lineColors;
  boolean withLines;
  boolean withPoints;

  DropdownChecklist(String title, float x, float y, float w, String[] options, color[] lineColors,
    boolean withLines, boolean withPoints) {
    this.title = title;
    this.x = x;
    this.y = y;
    this.w = w;
    this.options = options;
    this.lineColors = lineColors;
    this.selected = new boolean[options.length];
    this.withLines = withLines;
    this.withPoints = withPoints;
  }

  void display() {
    strokeWeight(1);
    fill(200, 250);
    stroke(0);
    strokeWeight(2);
    if (overRect(rmouseX, rmouseY, x, y, w, itemHeight))
      fill(#FCDF94);
    rect(x, y, w, itemHeight, 5); // Main dropdown button

    fill(0);
    triangle(x+w-15, y+itemHeight-10, x+w-10, y + 10, x+w-5, y+itemHeight-10);
    line(x+w-20, y, x+w-20, y + itemHeight);
    text(title, x + (w-textWidth(title))/2, y + itemHeight*0.7);

    if (expanded) {
      for (int i = 0; i < options.length; i++) {
        float itemY = y - itemHeight * (i + 1);

        // Background for option


        // Draw checkbox
        float cbX = x + 10;
        float cbY = itemY + 7;
        float cbSize = 15;

        strokeWeight(1);
        fill(200, 250);
        stroke(0);
        if (overRect(rmouseX, rmouseY, x, itemY, w, itemHeight))
          fill(255);
        rect(x, itemY, w, itemHeight, 5);

        fill(255);
        stroke(0);
        rect(cbX, cbY, cbSize, cbSize, 5);
        strokeWeight(1);
        // Check mark if selected
        if (selected[i]) {
          strokeWeight(2);
          stroke(0);
          line(cbX + 2, cbY + cbSize / 2, cbX + cbSize / 2, cbY + cbSize - 3);
          line(cbX + cbSize / 2, cbY + cbSize - 3, cbX + cbSize - 2, cbY + 3);
        }

        // Draw colored line for the graph if selected
        if (selected[i]) {
          strokeWeight(3);
          stroke(lineColors[i]);
          line(x + w - 40, itemY + itemHeight / 2, x + w - 10, itemY + itemHeight / 2);
          if (withPoints)
            ellipse(x + w - 25, itemY + itemHeight / 2, 10, 10);
          strokeWeight(1); // reset
        }

        // Option label
        strokeWeight(1);
        fill(0);
        stroke(0);
        text(options[i], x + 30, itemY + itemHeight / 1.5);
      }
    }
  }

  void handleClick(float mx, float my) {
    if (overRect(mx, my, x, y, w, itemHeight)) {
      expanded = !expanded;
    } else if (expanded) {
      for (int i = 0; i < options.length; i++) {
        float itemY = y - itemHeight * (i + 1);
        if (overRect(mx, my, x, itemY, w, itemHeight)) {
          selected[i] = !selected[i];
        }
      }
    }
  }

  boolean overRect(float mx, float my, float rx, float ry, float rw, float rh) {
    return (mx > rx && mx < rx + rw && my > ry && my < ry + rh);
  }
}





class DropdownSimple {
  String[] options;
  String selectedLabel;
  float x, y, w, itemHeight = 25;
  boolean expanded = false;
  int selectedItemIndex = 0;

  DropdownSimple(String defaultLabel, float x, float y, float w, String[] options) {
    this.selectedLabel = defaultLabel;
    this.x = x;
    this.y = y;
    this.w = w;
    this.options = options;
  }

  void display() {
    // Dropdown header
    strokeWeight(2);
    fill(200, 250);
    stroke(0);
    if (overRect(rmouseX, rmouseY, x, y, w, itemHeight))
      fill(color(#FCDF94));
    rect(x, y, w, itemHeight, 5);
    fill(0);
    fill(0);
    triangle(x+w-15, y+itemHeight-10, x+w-10, y + 10, x+w-5, y+itemHeight-10);
    line(x+w-20, y, x+w-20, y + itemHeight);
    text(selectedLabel, x + 5, y + itemHeight*0.7);

    // Options when expanded
    if (expanded) {
      for (int i = 0; i < options.length; i++) {
        float itemY = y - itemHeight * (i + 1);
        strokeWeight(1);
        fill(200);
        stroke(0);
        if (overRect(rmouseX, rmouseY, x, itemY, w, itemHeight))
          fill(color(#FCDF94));
        rect(x, itemY, w, itemHeight, 5);
        fill(0);
        text(options[i], x + 5, itemY + itemHeight*0.7);
      }
    }
  }

  boolean handleClick(float mx, float my) {
    boolean itemSlected = false;
    if (overRect(mx, my, x, y, w, itemHeight)) {
      expanded = !expanded;
    } else if (expanded) {
      for (int i = 0; i < options.length; i++) {
        float itemY = y - itemHeight * (i + 1);
        if (overRect(mx, my, x, itemY, w, itemHeight)) {
          selectedLabel = options[i];
          selectedItemIndex = i;
          expanded = false;
          itemSlected = true;
          break;
        }
      }
    } else {
      expanded = false;
    }
    return itemSlected;
  }

  boolean overRect(float mx, float my, float rx, float ry, float rw, float rh) {
    return (mx > rx && mx < rx + rw && my > ry && my < ry + rh);
  }
}

void initializeDropdownLists() {
  String[] itemsat = {"E Max-Sat", "dE Max-Sat", "Sys Max-Sat:"};
  String[] itemDispModes = {"Graph", "Block-D", "Process"};
  String[] engines = {"Euler", "Rk 2nd", "Rk 3rd", "Rk 4th", "RkF45"};
  String[] labels = {"Setpoint", "System", "Error (E)", "(E) Derivative", "Control (C)",
    "Y1", "Y2 ", "Y3", "theta", "dtheta/dt", "d2theta/dt2'"};

  ODedropdown = new DropdownSimple("Runge-Kutta", 200, 745, 80, engines);
  Signalsdropdown = new DropdownChecklist("Signals", 0, 745, 200, labels, graphColor, true, false);
  Signalsdropdown.selected[1] = Signalsdropdown.selected[0] = true;

  maxSats = new DropdownSimple("Max Saturations", 1000, 590, 130, itemsat);
  dispMode = new DropdownSimple("Graph", 280, 745, 105, itemDispModes);


  maxSats.selectedLabel = "E Max-Sat:";
  maxSats.itemHeight = 30;
  ODedropdown.selectedLabel = "Rk 4th";
  dispMode.selectedLabel = "Process";
  //dispIndex = dispMode.selectedItemIndex = 2;
}
