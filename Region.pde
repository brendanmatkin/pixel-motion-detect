boolean found = false; 
FloatList avgHeight = new FloatList(); 

class Region {
  float xMax, checkWidth, xMin;
  int trigger; 
  float c; 
  
  Region (float _xMax, float _rWidth, int _trigger) {
    xMax = _xMax;
    checkWidth = _rWidth;
    xMin = _xMax - _rWidth;
    trigger = _trigger;
  }
  void update() {
    fill(0, 150, 50, 100);
    found = false;
    c = 0;
    for (float x = xMin; x < xMax; x++) {
      for (float y = 0; y < height; y++) {
        int loc = int(x) + int(y)*width;
        if (pixels[loc] == motionColor) {
          c++;
          avgHeight.append(height-y);
          if (c > error) {
            fill(150, 40, 20, 100);
            found = true; 
            continue;
          }
        }
      }
    }
    if (found) {
      float averageY = 0;
      for (int i = 0; i < avgHeight.size(); i++) {
        averageY += avgHeight.get(i);
      }
      averageY /= float(avgHeight.size());
      //println(trigger, average);
      avgHeight.clear();
      
      String mess = "a";
      // this was for something more specific but I'm leaving it commented for example:
      /*if (trigger == 4) {
        mess = "/q";
        c = map(c,0,40000,10,200);
      }
      else {
        mess = "/f"+trigger;
        c = map(c,0,40000,100,5000);
      }*/
      mess = "/"+trigger;
      OscMessage myMessage = new OscMessage(mess);
      myMessage.add(c);
      oscP5.send(myMessage, pureData);
    } 
    else {
      // do other stuff? (when there is no movement detected)
    }
    // draw the regions - only for visual reference, comment out to see only movement. 
    stroke(0, 50);
    line(xMin, 0, xMin, height);
    noStroke();
    rect(xMin, 0, checkWidth, 10);
  }
}

