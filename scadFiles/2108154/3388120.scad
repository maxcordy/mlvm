// lucina
// 2017-02-23

// preview[view:south, tilt:top]

// the number of rays
rays = 3; //[1,2,3,4,5,6]

// the weights per ray
numWeights = 2;   //[1, 2, 3, 4]

// mm to extend ray if only 1 weight per ray
extra = 0;  //[0:1:20]

// the type of weight
whichWeight = "5/16";   //[bearing, 5/16, 3/8, 1/2, M8, M10, M12, penny, nickel, dime, quarter]

// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 2;  //[0:.5:3]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 3;
space = 3;
bearing = [22.1, 22.1, 7]; //608 bearing
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
sae38 = [.650*25.4,.562*25.4, 7];	// 3/8 
sae12 = [.866*25.4, .75*25.4, 7];	// 1/2
metric = [15, 13, 7];   // M8 hex nut
metric10 = [19.6, 17, 7];   // M10 hex nut
metric12 = [21.9, 19, 7];   // M12 hex nut
penny = [19.05, 19.05,1.55];  //x4
nickel = [21.21, 21.21, 1.95]; //x3
dime = [17.91, 17.91, 1.35]; //x5
quarter = [24.26, 24.26, 1.75];  // x4
step = 360 / rays;
stop = (rays-1) * step;
weight = (whichWeight == "bearing") ? bearing :
   (whichWeight == "5/16") ? sae :
   (whichWeight == "3/8") ? sae38 :
   (whichWeight == "1/2") ? sae12 :
   (whichWeight == "M8") ? metric :
   (whichWeight == "M10") ? metric10 :
   (whichWeight == "M12") ? metric12 :
   (whichWeight == "penny") ? penny :
   (whichWeight == "nickel") ? nickel :
   (whichWeight == "dime") ? dime : quarter;
echo(whichWeight, weight[x], weight[y], weight[z]);
resolution = (whichWeight == "5/16") ? 6 :
(whichWeight == "3/8") ? 6 :
(whichWeight == "1/2") ? 6 :
(whichWeight == "M8") ? 6 :
(whichWeight == "M10") ? 6 :
(whichWeight == "M12") ? 6 : 60;

module node(rad, wt) {
   fcylinder(bearing[z], wt[x]+2*space, rad);
}

module fcylinder(z, x, rad) {
   translate([0, 0, rad-z/2])
      minkowski() {
         cylinder(h=z-2*rad, d=x-2*rad, center=true);
         sphere(rad);
      }
}

difference() {
   union() {
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
		   hull() {
			  fcylinder(bearing[z], bearing[x]+2*thick, radius);
			  for ( n = [0 : 1 : numWeights-1] ) {
				 if ( numWeights == 1 && n == 0) {
					translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
					   node(radius, weight);
				 }
				 else {
					translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
					   node(radius, weight);
				 }
			  }
		   }
         }
      }
   }
   // holes
   union() {
      cylinder(h=2*bearing[z], d=bearing[x], center=true);
      for ( angle = [0 : step : stop] ) {
         rotate([0, 0, angle]) {
            for ( n = [0 : 1 : numWeights-1] ) {
               if ( numWeights == 1 && n == 0 ) {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space) + extra, 0, 0])
                     rotate([0, 0, 30])
                        cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
               }
               else {
                  translate([(bearing[x]+weight[y])/2 + thick + n*(weight[y] + space), 0, 0])
                     rotate([0, 0, 30])
                        cylinder(h=2*bearing[z], d=weight[x], center=true, $fn=resolution);
               }
            }
         }
      }
   }
}
