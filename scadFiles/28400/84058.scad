bowden_tube_diameter = 6.5; // inside diameter of the tube hole
bowden_jaw_bottom = 15; // outside diameter of the jaw clamp
bowden_jaw_top = 12;  // outside diameter of the jaw clamp
jaw_height = 32;
body_height = 6;

//bowden_for_hotend = 1; // 0 for extruder attachement (no hotend hole).

hotend_holder_width = 19; // width/length of square holder for hotend.
hotend_screw_diameter = 4;
hotend_diameter = 13;
hotend_height = 6; // height of the hole for the hotend
hotend_screws_spacing = (hotend_diameter/2);

zipties_width = 3;
zipties_depth = 2;


// setup code for objects:
clamp(jaw_height, body_height, bowden_for_hotend=1);

translate([0, 25, 0])
	clamp(jaw_height, body_height, bowden_for_hotend=0);

// Increase cooling time per layer for the thin riser.
translate([0, -20, jaw_height/2]) cube([20, 3, jaw_height], center=true);



module clamp(h, base, bowden_for_hotend=0){
  difference(){
    union() {
      // Clamp cone for M8 nut.
      cylinder(r1=bowden_jaw_bottom/2, r2=bowden_jaw_top/2, h=h);
      // Gradual cone base.
      //translate([0, 0, base]) cylinder(r1=10, r2=0, h=12, center=true);
      // Base middle.
      translate([0, 0, base/2]) {
			//cylinder(r=11, h=base, center=true);
			if(bowden_for_hotend == 1)
				cube([hotend_holder_width, hotend_holder_width, base], center=true);
			cube([46, 12, base], center=true);
      }
      // Shoulders around screw holes.
      for (x = [-23, 23]) {
			translate([x, 0, base/2]) cylinder(r=6, h=base, center=true);
      }
    }
    // Bowden cable through hole.
    cylinder(r=bowden_tube_diameter/2, h=jaw_height+2, $fn=12);
    // Three sided cutout.
    for (a = [0:120:359]) {
      rotate([0, 0, a]) translate([4, 0, base+1+h/2])
		cube([bowden_jaw_top, 1, h], center=true);
    }

	// zip ties slots
		translate([0, 0, body_height+2]) {
			difference() {
				cylinder(r=(bowden_jaw_bottom+1)/2, h=zipties_width, center=true);
				cylinder(r=(bowden_jaw_bottom-zipties_depth)/2, h=zipties_width, center=true);
			}
		}
		translate([0, 0, jaw_height-3]) {
			difference() {
				cylinder(r=(bowden_jaw_top+1)/2, h=zipties_width, center=true);
				cylinder(r=(bowden_jaw_top-zipties_depth)/2, h=zipties_width, center=true);
			}
		}
		translate([0, 0, (jaw_height/2)+2.5]) {
			difference() {
				cylinder(r=(bowden_jaw_top+2)/2, h=zipties_width, center=true);
				cylinder(r=(bowden_jaw_top-zipties_depth/2)/2, h=zipties_width, center=true);
			}
		}

    // Holder for PEEK insulator (e.g. MakerGear GrooveMount).
	if(bowden_for_hotend == 1) {
		translate([0,0,hotend_height/2])
	    	cylinder(r=hotend_diameter/2, h=hotend_height, center=true);
		for(x = [hotend_screws_spacing,-hotend_screws_spacing])
			translate([x, 0, hotend_height/2])
				rotate([90,0,0])
					cylinder(r=4/2, h=80, center=true);
	}

    // Nut traps and screw holes.
    for (x = [-25, 25]) {
      translate([x, 0, base/2]) {
			cylinder(r = 2.2, h=base+1, center=true, $fn=12);
			rotate([0, 0, 0]) cylinder(r=4.1, h=base, $fn=6);
      }
      translate([x*1.2, 0, base]) cube([6, 20, base], center=true);
    }
  }
}
