// heart-hex-gen
// lucina
// 2017-02-04
//
// the number of hearts
hearts = 4; //[2,3,4,5,6]
// the type of nut
whichNut = "M8";   //[5/16, M8]
// corner radius in mm
radius = 2.5;  //[0:.5:3]
/* [Hidden] */
$fn = 40;
x = 0; y = 1; z = 2;
bearing = [22.1, 22.1, 7];
thick = 4;
space = 3;
metric = [15, 13, 7];   // M8 hex nut
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
nut = (whichNut=="M8") ? metric : sae;
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

module filletedHeart(sz, rad) {
rotate([0, 0, 45])
   union(){
      fcube(sz, sz, 7, rad);
      translate([0, sz*.44, 0])
         fcylinder(7, sz, rad);
      translate([sz*.44, 0, 0])
         rotate([0, 0, -90])
            fcylinder(7, sz, rad);
   }
}
difference() {
   union() {
      fcylinder(bearing[z], bearing[x]+2*thick, radius);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + 4.5, 0, 0])
               rotate([0, 0, -90])
                  filletedHeart(size, radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+size)/2 + 6.5, 0, 0])
               rotate([0, 0, 30])
                  cylinder(h=2*bearing[z], d=nut[x], center=true, $fn=6);
      }
   }
}
