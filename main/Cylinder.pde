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

class Cylinder {
  float bore;
  float stroke;
  float crankOffset;
  float crankRadius;
  
  Cylinder(float b, float s, float o) {
    bore = b;
    stroke = s;
    crankOffset = o;
    crankRadius = stroke/2;
  }
  
  float crankX(float time) {
    return crankRadius * cos(time + crankOffset);
  }
  
  float crankY(float time) {
    return crankRadius * sin(time + crankOffset);
  }
  
  float pistonX() {
    return 0;
  }
  
  float pistonY(float time) {
    return crankRadius*-sin(time + crankOffset) + sqrt(pow(stroke, 2) - pow(crankRadius, 2)*pow(-cos(time + crankOffset), 2));
  }
  
  void drawFront(float time) {
    float crankX = this.crankX(time);
    float crankY = this.crankY(time);
    float pistonX = this.pistonX();
    float pistonY = -this.pistonY(time);
    // piston
    rect(-bore/2, pistonY - bore/2, bore, bore/2);
    // rod
    line(crankX, crankY, pistonX, pistonY);
    // crank
    line(0, 0, crankX, crankY);
  }
  
  void drawSide(float time) {
    float crankY = this.crankY(time);
    float pistonY = -this.pistonY(time);
    // piston
    rect(-bore/2, pistonY - bore/2, bore, bore/2);
    // rod
    line(0, crankY, 0, pistonY);
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
  }
}
