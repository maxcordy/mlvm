// section spinner
// lucina
// 2017-02-28
// preview[view:south, tilt:top]

// number of sections for the spinner
sections = 3;  //[1, 2, 3, 4, 5]
// type of weight
whichWeight = "bearing";   //[bearing, 5/16, 3/8, 1/2, M8, M10, M12]
// edge roundness
radius = 2; //[0:.5:3]
/* [Hidden] */
//$fn = 16;    //debug
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
bearing = [22.1, 22.1, 7]; //608 bearing
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
sae38 = [.650*25.4,.562*25.4, 7];	// 3/8 
sae12 = [.866*25.4, .75*25.4, 7];	// 1/2
metric = [15, 13, 7];   // M8 hex nut
metric10 = [19.6, 17, 7];   // M10 hex nut
metric12 = [21.9, 19, 7];   // M12 hex nut
weight = (whichWeight == "bearing") ? bearing :
   (whichWeight == "5/16") ? sae :
   (whichWeight == "3/8") ? sae38 :
   (whichWeight == "1/2") ? sae12 : 
   (whichWeight == "M8") ? metric :
   (whichWeight == "M10") ? metric10 : metric12;
echo(whichWeight, weight[x], weight[y], weight[z]);
resolution = (whichWeight == "bearing") ? 60 : 6;
space = 16;
a = (weight[x]+space);

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad);
         sphere(rad);
      }
}
module ftriangle(z, x, y, rad) {
   rotate([0, 0, -90])
      translate([-rad, 0, 0])
         minkowski() {
            intersection() {
               translate([-(x-2*rad), 0, 0])
                  cylinder(h=z-2*rad, r=x-2*rad, $fn = 3, center=true);
               cylinder(h=z-2*rad, r=x-2*rad, center=true);
            }
            sphere(r=rad, center=true);
         }
}
module section(rad) {
   ftriangle(bearing[z], a, a, rad);
}

difference() {
   union() {
      fcylinder(bearing[z], bearing[x] + 2*thick, radius);
      // sections
      step = 360 / sections;
      stop = (sections-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            rotate([0, 0, -90])
                  section(radius);
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      step = 360 / sections;
      stop = (sections-1) * step;
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle])
            translate([(weight[x]+bearing[x])/2+thick, 0, 0])
               cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
      }
   }
}
