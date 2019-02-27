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

float bore = 86;
float stroke = 215;
float crankRadius = 43;
ArrayList<Cylinder> engine = new ArrayList<Cylinder>();
float engineSpeed = 800;
float time = 0;
// crank layouts
float[] i4 = {0, PI, PI, 0};
float[] i6 = {0, TWO_PI/3, TWO_PI*2/3, TWO_PI*2/3, TWO_PI/3, 0};

void setup() {
  size(1200, 800);
  for (float x : i6) {
    Cylinder c = new Cylinder(bore, stroke, x, crankRadius);
    engine.add(c);
  }
}

void draw() {
  background(0);
  stroke(255);
  translate(200, 500);
  
  for (Cylinder c : engine) {
    translate(100, 0);
    float crankY = c.crankY(time);
    float pistonY = -c.pistonY(time);
    line(0, crankY, 0, pistonY);
    fill(255);
    // connect first bit
    line(-bore/2 - 7, 0, -bore/2, 0);
    // start crank
    line(-bore/2, 0, -bore/4, 0);
    // crank to rod
    line(-bore/4, 0, -bore/4, crankY);
    // rod
    line(-bore/4, crankY, bore/4, crankY);
    // rod to crank
    line(bore/4, crankY, bore/4, 0);
    // end crank
    line(bore/4, 0, bore/2, 0);
    // connect last bit
    line(bore/2, 0, bore/2 + 7, 0);
    ellipse(0, c.crankY(time), 8, 8);
    noFill();
    rect(-bore/2, pistonY - bore/2, bore, bore);
  }
  
  time += engineSpeed/15000;
}
