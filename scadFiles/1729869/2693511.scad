/*
Copyright (C) 2016 Wolf Ruedi Christen
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.

    ------------------------------------------------------------
    
    Designed for: Nuki - Smart Doorlock: http://nuki.io
    
    I needed a support for the adhesive B-plate: the width
    of less than 30mm wasn't enough to hold my Nuki in place.

    Contact: wolf+nuki-bplate@urspace.ch
    
    ------------------------------------------------------------
    
    Thanks to Sergio Vilches for the roundCornersCube()-function
*/

// Don't generate smaller facets than these mm
$fs = 0.1;  
// Don't generate larger angles than these degrees
$fa = 3;    

// use rounded outer-borders (1) or not (0)
rounded = 1;
// depth or thickness: usually thickness of the doorplate + cutout_depth_offset (mm)
depth = 9.5;
// given by B-plate diameter (mm)
head_radius = 25;
// given by B-plate width (mm)
body_width = 54;
// measured from keyhole-center + 5 (mm)
body_length = 66;
// inner-cutout-width: given by the doorplate-width (mm)
cutout_width = 31;
// given by the doorplate-length: measured from keyhole-center (mm)
cutout_length = 61;
// 0.4 mm (or at least 2 layers) seems a good value (mm)
cutout_depth_offset = 0.4;
// additional screwhole: set to 0 to remove (mm)
screwhole_diameter = 12;
// screwhole offset: measured from keyhole-center (mm)
screwhole_distance = 45;

rotate([0,180,0]) difference () {
    union () {
        // circle
        linear_extrude(depth) circle(head_radius);
        // body
        if (rounded==1) {
        translate([0,body_length/2+5,depth/2]) roundCornersCube(body_width,body_length,depth,5); // rounded-version
        } else {
            translate([0,body_length/2+2.5,0]) linear_extrude(depth) square([body_width,body_length+5],center=true); // edged-version
        }
    }
    // cutout
    translate([0,cutout_length/2-head_radius/2,-0.1]) linear_extrude(depth-cutout_depth_offset+0.1) square([cutout_width,cutout_length+head_radius],center=true);
    // cylindercase-hole
    linear_extrude(depth+1) circle(10);
    translate([0,12.5,0]) linear_extrude(depth+1) square([12,25],center=true);
    // screwhole
    translate([0,screwhole_distance,0]) linear_extrude(depth+1) circle(screwhole_diameter/2);
}
            


/*
http://codeviewer.org/view/code:1b36 
Copyright (C) 2011 Sergio Vilches
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
Contact: s.vilches.e@gmail.com


    ----------------------------------------------------------- 
                 Round Corners Cube (Extruded)                
      roundCornersCube(x,y,z,r) Where:                        
         - x = Xdir width                                     
         - y = Ydir width                                     
         - z = Height of the cube                             
         - r = Rounding radious                               
                                                              
      Example: roundCornerCube(10,10,2,1);                    
     *Some times it's needed to use F6 to see good results!   
 	 ----------------------------------------------------------- 
*/
// Test it!
// roundCornersCube(10,5,2,1);


module createMeniscus(h,radius) // This module creates the shape that needs to be substracted from a cube to make its corners rounded.
difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
   translate([radius/2+0.1,radius/2+0.1,0]){
      cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
   }

   cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
}


module roundCornersCube(x,y,z,r)  // Now we just substract the shape we have created in the four corners
difference(){
   cube([x,y,z], center=true);

translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
      rotate(0){  
         createMeniscus(z,r); // And substract the meniscus
      }
   }
   translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
      rotate(90){
         createMeniscus(z,r); // But this time we have to rotate the meniscus 90 deg
      }
   }
      translate([-x/2+r,-y/2+r]){ // ... 
      rotate(180){
         createMeniscus(z,r);
      }
   }
      translate([x/2-r,-y/2+r]){
      rotate(270){
         createMeniscus(z,r);
      }
   }
}





