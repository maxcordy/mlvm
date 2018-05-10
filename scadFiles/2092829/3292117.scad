// heart-hex-gen
// lucina
// 2017-02-07
// preview[view:south, tilt:top]

// the number of hearts
hearts = 3; //[2,3,4,5,6]
// the type of nut
whichNut = "5/16";   //[5/16, M8]
// corner radius in mm
radius = 2;  //[0:.5:2.5]
/* [Hidden] */
// rotate heart
rotateHeart = "yes"; //[yes, no]
$fn = 60;
x = 0; y = 1; z = 2;
bearing = [22.1, 22.1, 7];
thick = 4;
metric = [15, 13, 7];   // M8 hex nut
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
nut = (whichNut=="M8") ? metric : sae;
space = (rotateHeart=="yes") ? 6.5: 4.5;
nutSpace = (rotateHeart=="yes") ? 6.5: 5;
heartAngle = (rotateHeart=="yes") ? 0 : -90;
nutAngle = (rotateHeart=="yes") ? 30 : 0;
size = 17;
step = 360 / hearts;
stop = (hearts-1) * step;

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module fcube(x, y, z, rad) {
   translate([rad-x/2, rad-y/2, rad-z/2])
      minkowski() {
         cube([x-2*rad, y-2*rad, z-2*rad]);
         sphere(rad);
      }
}
module fHeart(size, radius) {
   translate([0, -size/12, 0])
      rotate([0, 0,45])
         union() {
            fcube(size, size, 7, radius);
            translate([0, size/2.6, 0])
               rotate([0, 0, -10])
                  fcylinder(7, size, radius);
            translate([size/2.6, 0, 0])
               rotate([0, 0, 100])
                  fcylinder(7, size, radius);
         }
}

difference() {
   union() {
      fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + space, 0, 0])
               rotate([0, 0, heartAngle])
                  fHeart(size, radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + nutSpace, 0, 0])
               rotate([0, 0, nutAngle])
                  cylinder(h=2*bearing[z], d=nut[x], center=true, $fn=6);
      }
   }
}
