// lucina
// 2017-02-09

// preview[view:south, tilt:top]

// the number of peripheral objects
objects = 3; //[2,3,4]
// the type of weight
whichWeight = "5/16";   //[bearing, 5/16, M8]
// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 0;  //[0:.5:3]
// angle of the peripheral objects: 2 objects: use ~120, 4 objects: use ~170
rotation = 150;  //[115:5:170]
/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
space = 2;
bearing = [22.1, 22.1, 7];
metric = [15, 13, 7];   // M8 hex nut
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
weight = (whichWeight == "bearing") ? bearing : (whichWeight == "5/16") ? sae : metric;
echo(whichWeight, weight[x], weight[y], weight[z]);
step = 360 / objects;
stop = (objects-1) * step;
outerR = weight[x]+2*space-radius;
resolution = ( whichWeight == "bearing" ) ? 40 : 6;

module yin(rad) {
   translate([0, -outerR/2, 0])
      minkowski() {
      union() {
         difference() {
            cylinder(h = bearing[z]-2*rad, r = outerR, center = true);
            union() {
               translate([0, -(outerR/2), 0])
                  cylinder(h = bearing[z]*2, r = outerR/2, center=true);
               translate([outerR/2, 0, 0])
                  cube([outerR, 2*outerR, 2*bearing[z]], center=true);
            }
         }
         translate([0, outerR/2, 0])
            cylinder(h = bearing[z]-2*rad, r = outerR/2, center=true);
      }
      sphere(rad);
   }
}

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
difference() {
   union() {
      fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([bearing[x]/2 + thick/2 + outerR/2, 0, 0])
               rotate([0, 0, -rotation])
                  yin(radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([bearing[x]/2 + thick/2 + outerR/2, 0, 0])
               rotate([0, 0, 30])
                  cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
      }
   }
}
