number_of_points=5;//[5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
height=1;//[1:10]
inner_radius=15;//[15:30]
//The amount added to the inner radius
outer_radius=10;//[1:50]
use <write/Write.scad>

parametric_star(number_of_points, height, inner_radius, inner_radius+outer_radius) ;
//-- This script was derived from Parametric star
//-- (c)  2010 Juan Gonzalez-Gomez (Obijuan) juan@iearobotics.com
//-- GPL license

//-- The 2*N points of an N-ponted star are calculated as follows:
//-- There are two circunferences:  the inner and outer.  Outer points are located
//-- at angles: 0, 360/N, 360*2/N and on the outer circunference
//-- The inner points have the same angular distance but they are 360/(2*N) rotated
//-- respect to the outers. They are located on the inner circunference

module parametric_star(N, h, ri, re) {

  //-- Calculate and draw a 2D tip of the star
 //-- INPUT: 
 //-- n: Number of the tip (from 0 to N-1)
  module tipstar(n) {
     i1 =  [ri*cos(-360*n/N+360/(N*2)), ri*sin(-360*n/N+360/(N*2))];
    e1 = [re*cos(-360*n/N), re*sin(-360*n/N)];
    i2 = [ri*cos(-360*(n+1)/N+360/(N*2)), ri*sin(-360*(n+1)/N+360/(N*2))];
    polygon([ i1, e1, i2]);
  }

  //-- Draw the 2D star and extrude
  
   //-- The star is the union of N 2D tips. 
   //-- A inner cylinder is also needed for filling
   //-- A flat (2D) star is built. The it is extruded
    linear_extrude(height=h) 
    union() {
      for (i=[0:N-1]) {
         tipstar(i);
      }
      rotate([0,0,360/(2*N)]) circle(r=ri+ri*0.01,$fn=N);
    }
}
