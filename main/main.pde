/*
*    ICE2D
*    Copyright (C) 2019 May Thiellier
*
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

ArrayList<Cylinder> engine = new ArrayList<Cylinder>();
float bore = 86;
float stroke = 86;
float rpm = 30;
// 1 rotation is 2Pi
// 1 minute at 60fps is 3600 frames
// So increment each frame with:
float rpmIncrement = TWO_PI/3600;
float time = 0;
// crank layouts
float[] i3 = {0, TWO_PI/3, TWO_PI*2/3};
float[] i4 = {0, PI, PI, 0};
float[] i5 = {0, radians(216), radians(144), radians(72), radians(288)};
float[] i6 = {0, TWO_PI/3, TWO_PI*2/3, TWO_PI*2/3, TWO_PI/3, 0};
// gif stuff
int totalFrames = 60;
int frameCounter = 0;
boolean record = false;

void setup() {
  size(1200, 600);
  frameRate(60);
  for (float x : i5) {
    Cylinder c = new Cylinder(bore, stroke, x);
    engine.add(c);
  }
}

void draw() {  
  render();
  
  if (record) {
    saveFrame("output/gif-"+nf(frameCounter, 3)+".png");
    frameCounter++;
    if (frameCounter == totalFrames) {
      exit();
    }
  }
}

void render() {
  background(0);
  stroke(255);
  noFill();
  translate(150, 300);
  engine.get(0).drawFront(time);
  translate(100, 0);
  for (Cylinder c : engine) {
    translate(100, 0);
    c.drawSide(time);
  }
  
  time += rpm*rpmIncrement;
}
