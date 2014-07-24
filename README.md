Per-Pixel Motion Detection 
==========================

Processing sketch based on background subtraction to detect movement in a webcam feed (or video). Like regular background subtraction but works automagically on a per-pixel basis. 

Screen is divided into a variable number of regions. If the amount of movement in a region is above the set threshold, the number of pixels with movement is sent via OSC i.e. on port 9001: /3/5476 (/Region #/# of pixels).

Start by playing with the threshold and fadeTime variables! 

Dependencies
------------
Requires oscP5/netP5 library.

