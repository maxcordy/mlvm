// ninja star hex spinner
// lucina
// 2017-02-03
// preview[view:south, tilt:top]

// the number of points for the star
points = 4;  //[3,4,5,6]
// the y to x aspect ratio for the star points
yAspect = 1.7;   //[1.3:0.1:2.1]
// the type of nut
whichNut = "M8";   //[5/16, M8]
/* [Hidden] */
$fn = 40;
x = 0; y = 1; z = 2;
bearing = [22.1, 22.1, 7];
thick = 4;
filRad = 2;
metric = [15, 13, 7];   // M8 hex nut
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
nut = (whichNut=="M8") ? metric : sae;
space = 7.5;
cornerHole = 2 + (7-points) * 1.25;
yHoleOffset = points * 2 + 7;
//angleOffset = 4 + 9/yAspect;
xOffset = nut[x]+thick*2+space * yAspect;

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module ftriangle(z, x, y, rad) {
   translate([0, y/4, 0])
   rotate([0, 0, 90])
      minkowski() {
         scale([y/x, 1, 1])
         cylinder(h=z-2*rad, d=x-2*rad, $fn = 3, center=true);
         sphere(rad, center=true);
      }
}
module point(wid) {
   ftriangle(bearing[z], wid, yAspect*wid, filRad);
}

difference() {
   union() {
      cylinder(h=bearing[z], d=bearing[x] + 2*thick, center=true, $fn=20);
      // points
      step = 360 / points;
      stop = (points-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x])/2-1, 0, 0])
               rotate([0, 0, -90])
                  point(nut[x]+thick*2+space);
      }
   }
   // holes
   cornerHoleOffset = 1.7 * points;
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      step = 360 / points;
      stop = (points-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(bearing[x]+nut[x])/2+thick/2, 0, 0])
               cylinder(h=2*bearing[z], d=nut[x], center=true, $fn=6);
         rotate([0, 0, angle-step/2])
            translate([bearing[x]/2+cornerHoleOffset, 0, 0])
               cylinder(h=2*bearing[z], d=cornerHole, center=true);
         rotate([0, 0, angle])
            translate([xOffset, 4.5, 0])
               cylinder(h=2*bearing[z], d=5, center=true);
         rotate([0, 0, angle])
            translate([xOffset, -4.5, 0])
               cylinder(h=2*bearing[z], d=5, center=true);

      }
   }
}