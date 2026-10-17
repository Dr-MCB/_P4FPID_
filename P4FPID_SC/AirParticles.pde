class Particle {
  PVector pos;
  PVector vel;
  ArrayList<PVector> trail;
  float refY;
  float amplitude = 50;
  float frequency = 0.00005;
  float dt = 5 ;
  Particle(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    trail = new ArrayList<PVector>();
    refY = y;
  }


  void followFlow() {
    float NoisyNumber = noise(refY + pos.x*0.0001);
    pos.x += dt*NoisyNumber;
    pos.y = refY - amplitude*NoisyNumber * cos(NoisyNumber*frequency * degrees(pos.x));
    trail.add(pos.copy());
    if (trail.size() > 20) {
      trail.remove(0);
    }
  }

  void wrapAround() {
    if (pos.x >= maxX) pos.x -= maxX;
    if (pos.x < minX)  pos.x += maxX;
    if (pos.y >= maxY) pos.y -= maxY;
    if (pos.y < minY)  pos.y += maxY;
  }

  void show() {
    stroke(#00FFF0);
    strokeWeight(2);
    for (int i =1; i < trail.size(); i ++) {
      if (abs(trail.get(i).x - trail.get(i-1).x) < width /2 &&
        abs(trail.get(i).y - trail.get(i-1).y) < height/2)
        line(trail.get(i).x, trail.get(i).y, trail.get(i-1).x, trail.get(i-1).y);
    }
    stroke(0);
    strokeWeight(1);
  }
}
void InitializeAirParticles() {
  particles = new ArrayList<Particle>();
  int nParticles = 20;
  for (int i = 0; i < nParticles; i++) {
    float y = map(i, 0, nParticles - 1, minY, maxY);
    particles.add(new Particle(0, y));
  }
}

void displayAirParticles() {
  if (debugStart_b.activated) {
    if (PerlineX.size() - 1 > 0) {
      Airspeed = int(map(PerlineX.get(PerlineX.size() - 1), Bmin, Bmax, 1, 10));
    }
  }
  for (int i =0; i < 11-Airspeed; i ++)
    for (Particle p : particles) {
      p.followFlow();
      p.wrapAround();
      p.show();
    }
}


void displayWinds() {
  noFill();
  rect(5, 425, 640, 55, 5);
  stroke(0);
  strokeWeight(0.5);
  for (int i = 5; i < 645; i+=10)
    line(i, 425, i, 480);
  stroke(255, 0, 0);
  strokeWeight(1);
  if (noisyWinds.activated) {
    float I = 640 / max((simulationSteps), 1);
    if (debugStart_b.activated) {
      for (int j =int(max(PerlineX.size()- simulationSteps, 0)); j < PerlineX.size()-1; j ++) {
        int i = j - int(max(PerlineX.size()- simulationSteps, 0));
        line(5 + I * i, map(PerlineX.get(j), Bmin, Bmax, 425, 480),
          5 + I * (i+1), map(PerlineX.get(j+1), Bmin, Bmax, 425, 480));
      }
    } else {
      for (int i =0; i < simulationSteps - 1; i ++) {
        line(5 + I * i, map(PerlineX.get(i), Bmin, Bmax, 425, 480),
          5 + I * (i+1), map(PerlineX.get(i+1), Bmin, Bmax, 425, 480));
      }
    }
  } else {
    line(5, 450, 645, 450);
  }
}


void resetPerlineNoise() {
  PerlineX.clear();
  if (noisyWinds.activated) {
    int refT = int(random(100));
    noiseSeed(refT);
    for (int i =0; i <= simulationSteps; i ++) {
      PerlineX.append(map(noise(i*Ts), 0, 1, Bmin, Bmax));
    }
  } else {
    for (int i =0; i <= simulationSteps; i ++) {
      PerlineX.append(constB);
    }
  }
}

void GenerateOnlineNoise() {
}
