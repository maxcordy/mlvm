// Based on http://www.thingiverse.com/thing:13631 by Triffid Hunter
// 2012-01-24
// Modified for LM6UU, open bearing, and  options

// preview[view:north, tilt:top]

// Nominal Sizes:


// Internal Diameter
id= 6; // [0:30]

// External Diameter
od= 12.0; // [0:30] 

// Length
length = 19;  // [0:40] 

//  lm6uu id, od, length are nominally 6,12,19  
// lm8uu are 8 16.0 25 

// External Clearance
clearance=1; [0:5]

lm8uu_id=id-0.8;  // ???
lm8uu_od=od-clearance;
lm8uu_length = length -clearance;

// Open a 60 degree slot
open=0;  // [0:closed,1:open]  // cut a 60 degree slot out of the side for an open bearing

// rib height
id_clearance = 1; // [0:5]

// number of ribs
n = 5; //[0:10]

// Layer height (for computing twisted ribs)
layer_height = 0.2;

// Facets
$fn=32;

//!plate();
!bushing();

module plate(ii=3,jj=4,spacing=4){
  interval=lm8uu_od+spacing;
  for ( i = [0 :  ii -1 ]) {
    for (j = [0 : jj -1 ]) {
    translate([i*interval,j*interval,0]) bushing();
   }
  }
}


module bushing() { 
difference() {
	cylinder(r=lm8uu_od / 2, h=lm8uu_length - layer_height);
	difference() {
		cylinder(r=lm8uu_id / 2 + id_clearance, h=lm8uu_length - layer_height);
		linear_extrude(height = lm8uu_length - layer_height, twist = 540 / n, slices = (lm8uu_length - layer_height))
			for (i=[0:360/n]) {
				rotate(360 / n * i)
					translate([lm8uu_id / 2 / sqrt(2), lm8uu_id / 2 / sqrt(2)])
						square([lm8uu_id, lm8uu_id]);
			}
	}
	translate([0, 0, -1 + layer_height])
		cylinder(r1=lm8uu_id / 2 + id_clearance + 1, r2=0, h=lm8uu_id / 2 + id_clearance + 1);
	translate([0, 0, lm8uu_length - layer_height * 2 - (lm8uu_id / 2 + id_clearance)])
		cylinder(r2=lm8uu_id / 2 + id_clearance + 1, r1=0, h=lm8uu_id / 2 + id_clearance + 1);
	translate([0, 0, -1])
		cylinder(r=id/2, h=lm8uu_length + 2);
    if(open) {
	     rotate(360/5+5) translate([0, lm8uu_od/2, -1]) rotate(30) cylinder($fn=3,r=lm8uu_od/2,h=lm8uu_length+2);

	}
}
}
