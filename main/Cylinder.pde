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
  
  Cylinder(float b, float s, float o, float r) {
    bore = b;
    stroke = s;
    crankOffset = o;
    crankRadius = r;
  }
  
  float crankY(float time) {
    return crankRadius * sin(time + crankOffset);
  }
  
  float pistonY(float time) {
    return crankRadius*-sin(time + crankOffset) + sqrt(pow(stroke, 2) - pow(crankRadius, 2)*pow(-cos(time + crankOffset), 2));
  }
}
