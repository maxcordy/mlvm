$fs=.5;
diameter_of_rod=12.75;
diameter_of_cone_large=15;
diameter_of_cone_small=2;
diameter_of_starter_hole=3;
diameter_of_dasey_hole=2;
diameter_of_inner_hole=4.5;
diameter_of_dasey_stem_small=2.5;
diameter_of_dasey_stem_large=4.5;
diameter_of_spacer=11.75;
height_of_rod=100;
height_of_cone=15;
height_of_starter_hole=80;
height_of_single_dasey_stem=20;
height_of_spacer=10;
size_of_spacer=5;
wall_thickness=1;
dasey_thickness=1.5;
number_of_dasey_holes=12;

module body(){
	union(){
		difference(){
			cylinder(r=diameter_of_rod/2,h=height_of_rod,$fn=number_of_dasey_holes);
			translate([0,0,height_of_rod-diameter_of_dasey_stem_small-height_of_single_dasey_stem])cylinder(r=diameter_of_inner_hole/2,h=height_of_single_dasey_stem*2);
			translate([0,0,height_of_starter_hole])translate([0,0,-diameter_of_rod/2])rotate([0,90,0])translate([0,0,-diameter_of_rod])cylinder(r=diameter_of_starter_hole/2,h=diameter_of_rod*2);
			difference(){
				translate([0,0,height_of_rod-height_of_spacer-size_of_spacer])cylinder(r=diameter_of_rod,h=size_of_spacer);
				translate([0,0,height_of_rod-height_of_spacer-2*size_of_spacer])cylinder(r=diameter_of_spacer/2,h=3*size_of_spacer);
			}
		}
		hull(){
			cylinder(r=diameter_of_cone_large/2,h=1);
			translate([0,0,-height_of_cone])sphere(r=diameter_of_cone_small);
		}
	}
}

module dasey(){
	union(){
		difference(){
			union(){
				for(dasey_index=[1:number_of_dasey_holes]){
					rotate([0,0,dasey_index*360/number_of_dasey_holes])translate([diameter_of_rod/2+diameter_of_dasey_hole,0,0])cylinder(r=wall_thickness+diameter_of_dasey_hole/2,h=dasey_thickness);
				}
				cylinder(r=diameter_of_rod/2+diameter_of_dasey_hole,h=dasey_thickness);
			}
			for(dasey_index=[1:number_of_dasey_holes]){
				rotate([0,0,dasey_index*360/number_of_dasey_holes])translate([diameter_of_rod/2+diameter_of_dasey_hole,0,-.1])cylinder(r=diameter_of_dasey_hole/2,h=dasey_thickness+2);
			}
		}
		hull(){
			translate([0,0,dasey_thickness+height_of_single_dasey_stem])sphere(r=diameter_of_dasey_stem_small/2);
			cylinder(r=diameter_of_dasey_stem_large/2,h=dasey_thickness);
			translate([0,0,-height_of_single_dasey_stem])sphere(r=diameter_of_dasey_stem_small/2);
		}
	}
}

body();
translate([0,0,height_of_rod+1])dasey();
