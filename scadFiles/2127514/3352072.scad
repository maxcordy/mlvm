// lucina
// 2017-02-21

// preview[view:south, tilt:top]

// the number of faces
faces = 4; //[2,3,4,5,6]

// the type of weight
whichWeight = "5/16";   //[5/16, M8]

// corner radius in mm; > 0 causes timeout but Create Thing still works
radius = 2;  //[0:.5:3]

/* [Hidden] */
$fn = 60;
x = 0; y = 1; z = 2;
thick = 2.5;
offset = 22;
bearing = [22.1, 22.1, 7]; // 608 bearing
sae = [.577*25.4, .5 * 25.4, 7]; // 5/16 hex nut
metric = [15, 13, 7];   // M8 hex nut
step = 360 / faces;
stop = (faces-1) * step;
enlarge = 1.8;
weight = (whichWeight == "5/16") ? sae : metric;
echo(whichWeight, weight[x], weight[y], weight[z]);

module surprise(rad, wt) {
   diam = wt[x]*enlarge;
   eye = diam / 7.5;
   rotate([0, 0, -90])
      difference() {
         fcylinder(bearing[z], diam, rad);
         union() {
            translate([-diam/7.5, diam/4, 0])
               scale([1, 1.2, 1])            
                  cylinder(bearing[z]*2, d=eye, center=true);
            translate([diam/7.5, diam/4, 0])
               scale([1, 1.2, 1])            
                  cylinder(bearing[z]*2, d=eye, center=true);
            translate([0, -diam/7.75, 0])
               cylinder(bearing[z]*2, d=wt[x], center=true, $fn = 6);
         }
      }
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
            fcylinder(bearing[z], bearing[x]+2*thick, radius);
            translate([(bearing[x]+ weight[x]*enlarge)/2+thick/3, 0, 0])
               surprise(radius, weight);
         }
      }
   }
   // bearing hole
   cylinder(h=2*bearing[z], d=bearing[x], center=true);
}
