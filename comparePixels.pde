// I think the first part of this comes from Shiffman's Background Subtract example: 
// http://www.learningprocessing.com/examples/chapter-16/example-16-13/ 
// Possibly from a different Danical Shiffman example,
// possibly also from one of Golan Levin's examples. I'm afraid I don't remember... 

void comparePixels() {
  for (int x = 0; x < width; x ++ ) {
    for (int y = 0; y < height; y ++ ) {
      //motionColor = color(random(0,255),random(0,255),random(0,255),50);

      int loc = x + y*width;            
      color current = pixels[loc];
      color previous = background.pixels[loc];

      float r1 = current >> 16 & 0xFF;
      float g1 = current >> 8 & 0xFF;
      float b1 = current & 0xFF;
      float r2 = previous >> 16 & 0xFF;
      float g2 = previous >> 8 & 0xFF;
      float b2 = previous & 0xFF;
      float diff = abs(dist(r1, g1, b1, r2, g2, b2));
      if (onoff[loc] == 0) {
        if (diff > threshold) { 
          pixels[loc] = motionColor;       // set pixel to color if motion detected
          onoff[loc] = fadeTime;           // set fadeTime per pixel
        }
        else pixels[loc] = color(255);
      }
      else if (onoff[loc] > 0) {           // only decrease if positive
        //motionColor = color(random(0,55),random(150,255),random(150,255)); // Colored noise!!
        pixels[loc] = motionColor;  
        onoff[loc] = onoff[loc]-1;         // decrease fadeTime counter per pixel
        background.pixels[loc] = current;  // refresh background color per pixel
      }
    }
  }
}
