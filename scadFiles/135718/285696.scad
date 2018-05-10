//--------------------------------------------------------------------------------------------------
//	Involute Blower
//	http://www.thingiverse.com/thing:135718
//	http://thingiverse.com/Benjamin
//
//   Thanks to "Bezier Library for OpenScad" by Chad Kirby
//   http://www.thingiverse.com/thing:86713
//   and Involute Gears library by Greg Frost
//   http://www.thingiverse.com/thing:3575
//--------------------------------------------------------------------------------------------------

// preview[view:south_west, tilt:top]

output="assembly_sans";//[assembly,assembly_sans,fan,shell_bottom,shell_top,crank,end,gear_driven,gear_idler,gear_drive,nozzle]
blades_shape="forward";//[straight,involute,forward,backward]

fan_diameter = 70;
blade_straight_number = 12; 
blade_involute_number = 10; 
blade_forward_number = 18; 

// Increase before .stl creation (e.g. 60)
shell_segments = 16;
nut_width = 13;
nut_thickness = 7;
washer_thickness = 1.5;
rod_dia = 8;
rod_margin = 3;
clearance = 0.25;

blade_thickness = 1.5;
blade_top_width = 12;
blade_angle = 20;
blade_forw_radius = 30;

support_thickness = 12;
support_width = 16;
support_end_dia = 24;

output_dia = 20;
output_inner_dia=16;
output_rounding = 2;
output_width = 24;
output_thickness = 3;
output_length = 25;

nozzle_dia = 5;
nozzle_length = 50;
nozzle_thickness = 1.5;

gear_teeth_A = 11;
gear_teeth_B = 59;
gear_thickness_A = 18;
gear_thickness_B = 6;
gear_circular_pitch = 340;
gear_teeth_C = 9;
gear_teeth_D = 61;
gear_thickness_C = 14;
gear_thickness_D = 7;
gear_circular_pitch_CD = 350;

//distance separating holes axis
crank_spacing = 100;
crank_thickness = 10;
crank_delta = 20;
crank_hole_margin = 8;
//-----------------------------------------------------------

module void(){}
fan_dia = 100;
fan_margin = 2.4;
fan_precision = 36;
fan_thickness = 3;
off_y_fan = 9;
off_x_fan = 0;

from = -270;
to = 180;
section_w= 46;
section_h= 80;
inc = (to-from)/shell_segments;
radius=0.125;
precision = 6;

shell_thickness = 4;
end_thickness = 7;
shell_scale = fan_diameter/100;
inv_scale = 1/shell_scale;
fan_height = shell_scale*(section_h - 2*shell_thickness) - 2*clearance - washer_thickness;
end_thickness = 2*output_thickness + 1;
shell_cut = "yes";//[yes,no]
pi = 3.1415926535897932384626433832795*1;
//-----------------------------------------------------------
gear_pitch_A = (gear_teeth_A * gear_circular_pitch / 180)/2;
gear_pitch_B = (gear_teeth_B * gear_circular_pitch / 180)/2;
gear_pitch_C = (gear_teeth_C * gear_circular_pitch_CD / 180)/2;
gear_pitch_D = (gear_teeth_D * gear_circular_pitch_CD / 180)/2;

dist_AB = gear_pitch_A + gear_pitch_B;
dist_CD = gear_pitch_C + gear_pitch_D;

gear_margin = 0;
gear_invol_number = 5;
gear_invol_min_width = 6;
gear_invol_max_width = 12;
gear_inv_radk = 0.15*1.2;
gear_inv_from = -360 ;
gear_inv_to = 0;
gear_inv_seg = 60;
gear_inv_off_x = rod_dia;
gear_inv_off_y = 0;
gear_inc = (gear_inv_to - gear_inv_from)/gear_inv_seg;
gear_size_range = gear_invol_max_width - gear_invol_min_width;

blade_invol_min_width = 3;
blade_invol_max_width = 9;
blade_inv_radk = 0.15*3;
blade_inv_from = -360 ;
blade_inv_to = 0;
blade_inv_seg = 60;
blade_inv_off_x = 0;
blade_inv_off_y = 0;
blade_inc = (blade_inv_to - blade_inv_from)/blade_inv_seg;
blade_size_range = blade_invol_max_width - blade_invol_min_width;
blade_involute_top_flat = 8;

pitch_radius_D = gear_pitch_D;
pitch_diameter_D = gear_pitch_D;
base_radius_D = pitch_radius_D*cos(28);
pitch_diametrial_D = gear_teeth_D / pitch_diameter_D;
addendum_D = 1/pitch_diametrial_D;
outer_radius_D = pitch_radius_D+addendum_D;
dedendum_D = addendum_D + 0.25;
root_radius_D = pitch_radius_D-dedendum_D;

pitch_radius_B = gear_pitch_B;
pitch_diameter_B = gear_pitch_B;
base_radius_B = pitch_radius_B*cos(28);
pitch_diametrial_B = gear_teeth_B / pitch_diameter_B;
addendum_B = 1/pitch_diametrial_B;
outer_radius_B = pitch_radius_B+addendum_B;
dedendum_B = addendum_B + 0.25;
root_radius_B = pitch_radius_B-dedendum_B;


nbo = (1+sqrt(5))/2;
x=25;

//------------------------------------------------------------------------------------------------
if (output=="nozzle") {
	nozzle();
}
//------------------------------------------------------------------------------------------------
if (output=="end") {
	end();
}
//------------------------------------------------------------------------------------------------
if (output=="gear_idler") {
	gear_idler();
}
//------------------------------------------------------------------------------------------------
if (output=="gear_drive") {
	gear_drive();
}
//------------------------------------------------------------------------------------------------
if (output=="gear_driven") {
	gear_A();	
}
//------------------------------------------------------------------------------------------------
if (output=="assembly") {
rotate([0, 0, 0]) {
	scaled_shell("yes");

	/*translate([0, 0, shell_scale*section_h])
	rotate([180, 0, 0])
	%shell_top();*/

	translate([off_x_fan*shell_scale, off_y_fan*shell_scale, shell_thickness*shell_scale])
	fan();	

	translate([-dist_AB - dist_CD,-rod_dia/2 - crank_hole_margin, -35])
	rotate([-90, 0, 0])
	#crank();

	translate([0, 0, -5])
	rotate([180, 0, 0])
	test_gears();
}
}
//------------------------------------------------------------------------------------------------
if (output=="assembly_sans") {
	scaled_shell("yes");
	translate([off_x_fan*shell_scale, off_y_fan*shell_scale, shell_thickness*shell_scale + 0.1])
	fan();	
	translate([-dist_AB - dist_CD,fan_diameter/2 + 10, 0])
	crank();
	*translate([0, 0, shell_scale*section_h])
	rotate([180, 0, 0])
	shell_top();
}
//------------------------------------------------------------------------------------------------
if (output=="fan") {
	fan();
}
//------------------------------------------------------------------------------------------------
if (output=="shell") {
	scaled_shell("no");
}
//------------------------------------------------------------------------------------------------
if (output=="shell_bottom") {
	scaled_shell("yes");
}

//------------------------------------------------------------------------------------------------
if (output=="shell_top") {
	shell_top();
}
//------------------------------------------------------------------------------------------------
if (output=="crank") {
	crank();
}
//------------------------------------------------------------------------------------------------
module nozzle() {
translate([0, 0, output_length/4])
difference() {
	union() {
	cylinder(r1=(output_dia+1)/2 + nozzle_thickness, r2=nozzle_thickness + output_dia/2, h=output_length/2, center=true, $fn=2*fan_precision);
	translate([0, 0, nozzle_length/2 + output_length/4 - 0.01])
	cylinder(r1=nozzle_thickness + output_dia/2, r2=nozzle_dia/2 + nozzle_thickness, h=nozzle_length, center=true, $fn=2*fan_precision);

	}

	cylinder(r1=(output_dia+1)/2, r2=output_dia/2, h=output_length/2 + 0.01, center=true, $fn=2*fan_precision);
	
	translate([0, 0, nozzle_length/2 + output_length/4 - 0.01])
	cylinder(r1=output_dia/2, r2=nozzle_dia/2, h=nozzle_length + 0.01, center=true, $fn=2*fan_precision);
}
}
//------------------------------------------------------------------------------------------------
module shell_top() {
difference() {
	translate([0, 0, shell_scale*section_h])
	rotate([180, 0, 0])
	scaled_shell("no");

	translate([0, 0,section_h+ shell_scale*section_h/2])
	cube([300, 300, 2*section_h], center=true);
}
}
//------------------------------------------------------------------------------------------------
module scaled_shell(pCut="no") {
scale(shell_scale) {
	shell(pCut);
	shell_output(pCut);
}	
}
//------------------------------------------------------------------------------------------------
module fan() {
color("orange") {
	if (blades_shape=="straight") {
		translate([0, 0, fan_height/2])
		difference() {
			union() {
				translate([0, 0, -fan_height/2 + fan_thickness/2])
				cylinder (r=fan_diameter/2, h=fan_thickness, center=true,$fn=fan_precision);
				for (i=[0:blade_straight_number-1]) {
					rotate([0, 0, i*360/blade_straight_number])
					translate([0, fan_diameter/4, 0])
					cube([blade_thickness, fan_diameter/2, fan_height], center=true);
				}
				translate([0, 0, fan_thickness])
				cylinder (r=1.6*nut_width/2, h=fan_height, center=true, $fn=fan_precision);
			}
	
			translate([0, 0, fan_height/2])
			sphere(r=fan_diameter/2 - blade_top_width, $fn=36);
			translate([0, 0, -fan_height/2 + fan_thickness])
			nut(nut_width, nut_thickness *4);
			cylinder (r=rod_dia/2, h=fan_height*2, center=true, $fn=fan_precision);
		}
	}
	if (blades_shape=="involute") {
		difference() {
			union() {
				translate([0, 0, fan_thickness/2])
				cylinder (r=fan_diameter/2, h=fan_thickness, center=true,$fn=fan_precision);
				translate([0, 0, nut_thickness/2 + fan_thickness -0.1])
				cylinder (r=nut_width/2 +3, h=nut_thickness, center=true,$fn=fan_precision);
	
				for (i=[0:blade_involute_number-1]) {
					rotate([0, 0, i*(360/blade_involute_number)])
					intersection() {
						translate([blade_inv_off_x, blade_inv_off_y, 0])
						invol_blade(i);
						translate([0, 0, fan_height/2])
						cylinder(r=fan_diameter/2, h=fan_height, center=true, $fn=36);
					}
				}
			}
			translate([0, 0, fan_height])
			sphere(r=fan_diameter/2-blade_involute_top_flat, $fn=36);
		
			translate([0, 0, fan_thickness])
			nut(nut_width, fan_height);
			cylinder (r=rod_dia/2 + clearance, h=fan_height*2.1, center=true, $fn=fan_precision);
		}
	}
	if (blades_shape=="forward") {
		difference() {
			union() {
				translate([0, 0, fan_thickness/2])
				cylinder (r=fan_diameter/2, h=fan_thickness, center=true,$fn=fan_precision);
				translate([0, 0, nut_thickness/2 + fan_thickness -0.1])
				cylinder (r1=nut_width, r2=1.5*nut_width/2, h=nut_thickness, center=true,$fn=fan_precision);
				translate([0, 0, fan_height - fan_thickness/4])
				cylinder (r=fan_diameter/2, h=fan_thickness/2, center=true,$fn=fan_precision);
				for (i=[0:blade_forward_number-1]) {
					rotate([0, 0, i*(360/blade_forward_number)])
					forw_blade(i);
				}
			}
			translate([0, 0, fan_thickness])
			nut(nut_width, fan_height*1.1);
			translate([0, 0, fan_height/2 - 0.1])
			cylinder (r=rod_dia/2 + clearance, h=fan_height*1.1, center=true, $fn=fan_precision);
			translate([0, 0, fan_height - fan_thickness/2])
			cylinder (r=(fan_diameter/2)-blade_top_width, h=fan_thickness*1.1, center=true,$fn=fan_precision);
		}
	}
	if (blades_shape=="backward") {
		difference() {
			union() {
				translate([0, 0, fan_thickness/2])
				cylinder (r=fan_diameter/2, h=fan_thickness, center=true,$fn=fan_precision);
				translate([0, 0, nut_thickness/2 + fan_thickness -0.1])
				cylinder (r1=nut_width, r2=1.5*nut_width/2, h=nut_thickness, center=true,$fn=fan_precision);
				translate([0, 0, fan_height - fan_thickness/4])
				cylinder (r=fan_diameter/2, h=fan_thickness/2, center=true,$fn=fan_precision);
				scale([-1, 1, 1])
				for (i=[0:blade_forward_number-1]) {
					rotate([0, 0, i*(360/blade_forward_number)])
					forw_blade(i);
				}
			}
			translate([0, 0, fan_thickness])
			nut(nut_width, fan_height*1.1);
			translate([0, 0, fan_height/2 - 0.1])
			cylinder (r=rod_dia/2 + clearance, h=fan_height*1.1, center=true, $fn=fan_precision);
			translate([0, 0, fan_height - fan_thickness/2])
			cylinder (r=(fan_diameter/2)-blade_top_width, h=fan_thickness*1.1, center=true,$fn=fan_precision);
		}
	}

}//color
}
//------------------------------------------------------------------------------------------------
module forw_blade(pI) {
translate([(-blade_top_width)/2 + fan_diameter/2, 0, fan_height/2])
rotate([0, 0, blade_angle]) {
	intersection() {
		cube([blade_top_width, blade_thickness*4, fan_height], center=true);	
		translate([0, blade_forw_radius-blade_thickness/2, 0])
		difference() {
			cylinder(r=blade_forw_radius, h=fan_height, center=true, $fn=fan_precision*4);
			cylinder(r=blade_forw_radius-blade_thickness, h=fan_height*1.1, center=true, $fn=fan_precision*4);
		}
	}
}
}
//------------------------------------------------------------------------------------------------
module invol_blade(pI) {
for (j=[blade_inv_from:blade_inc:blade_inv_to]) {
	hull() {
		pointIn(0.01,blade_invol_max_width - abs(blade_size_range*j/(blade_inv_to - blade_inv_from)), fan_height, invol(blade_inv_radk, 360 + j), j);
		pointIn(0.01,blade_invol_max_width -  abs(blade_size_range*j/(blade_inv_to - blade_inv_from)), fan_height, invol(blade_inv_radk, 360 + j +blade_inc), j+blade_inc);
		}
	}
}
//------------------------------------------------------------------------------------------------
module nut (width = 13, height = 7, clear = 0.25) {
	translate([0, 0,height/2])
	rotate([0, 0, 90])
	cylinder (r=(width+clear)/cos(30)/2, h=height, center=true, $fn = 6);
}
//-------------------------------------------------------------------------------------------------
module shell (pCut="no") {
difference() {
	union() {
		for (i=[from:inc:to-inc]) {
			hull () {
				pointIn(1, section_w, section_h, invol(radius, 360 + i), i);
				pointIn(1, section_w, section_h, invol(radius, 360 + i + inc), i+inc);
			}
			linear_extrude(height=shell_thickness+0.1) 
			polygon([[0,0], invol(radius, 360+i), invol(radius, 360+i+inc)]);

		}

		translate([off_x_fan, off_y_fan, section_h - shell_thickness/2])
		cylinder (r=fan_dia/2 + 1, h=shell_thickness, center=true, $fn=8);

		translate([off_x_fan, off_y_fan, inv_scale*support_thickness/2])
		translate([-inv_scale*dist_AB, 0, 0])
		cylinder(r=inv_scale*support_width/2, h=inv_scale*support_thickness, center=true, $fn=fan_precision);			

		hull () {
			pointIn(1, section_w - 2*shell_thickness, inv_scale*support_thickness, invol(radius, 360 + 70), 70);
			pointIn(1, section_w - 2*shell_thickness, inv_scale*support_thickness, invol(radius, 360 + 110), 110);

			translate([off_x_fan, off_y_fan, inv_scale*support_thickness/2])
			translate([-inv_scale*dist_AB, 0, 0])
			cube([inv_scale*support_width, 1.2*inv_scale*support_width, inv_scale*support_thickness], center=true);
			//cylinder(r=inv_scale*support_dia/2, h=inv_scale*support_thickness, center=true, $fn=fan_precision);
		}

		hull () {
			translate([off_x_fan, off_y_fan, inv_scale*support_thickness/2])
			translate([-inv_scale*dist_AB, 0, 0])
			cylinder(r=1.2*inv_scale*support_width/2, h=inv_scale*support_thickness, center=true, $fn=fan_precision);
			translate([off_x_fan, off_y_fan, inv_scale*support_thickness/2])
			translate([-inv_scale*(dist_AB+dist_CD), 0, 0])
			cylinder(r=inv_scale*support_width/2, h=inv_scale*support_thickness, center=true, $fn=fan_precision);
		}

		translate([off_x_fan, off_y_fan, inv_scale*(support_thickness*1.5)/2])
		translate([-inv_scale*(dist_AB+dist_CD+clearance), 0, 0])
		cylinder(r=inv_scale*support_end_dia/2, h=inv_scale*(support_thickness*1.5), center=true, $fn=fan_precision);

		hull () {
			translate([off_x_fan, off_y_fan, inv_scale*(support_thickness*1.5)/2])
			translate([-inv_scale*(dist_AB+dist_CD+clearance), 0, 0])
			cylinder(r=inv_scale*rod_dia/2, h=inv_scale*(support_thickness*1.5), center=true, $fn=fan_precision);
			translate([off_x_fan, off_y_fan, 0])
			translate([-inv_scale*(dist_AB), 0, 0.5])
			cube([inv_scale*rod_dia/2, inv_scale*rod_dia/2, 1], center=true);
		}

		pointIn(end_thickness*inv_scale, section_w, section_h, invol(radius, 360 + to), to);
	}

	translate([0, 0, shell_thickness])
	for (i=[from:inc:to-inc]) {
		hull () {
			pointIn(1, section_w-2*shell_thickness, section_h-2*shell_thickness-0.05, invol(radius, 360 + i + 1), i);
			pointIn(1, section_w-2*shell_thickness, section_h-2*shell_thickness-0.05,  invol(radius, 360 + i + inc + 1), i+inc);
		}	
	}

	translate([off_x_fan, off_y_fan, section_h/2])
	cylinder (r=fan_dia/2 +fan_margin, h=section_h - 2*shell_thickness, center=true, $fn=fan_precision);

	translate([off_x_fan, off_y_fan, section_h])
	cylinder (r=(fan_dia/2 - blade_top_width*inv_scale), h=4*shell_thickness, center=true, $fn=fan_precision);

	translate([off_x_fan, off_y_fan, 0])
	cylinder (r=inv_scale*rod_dia/2, h=3*fan_height, center=true, $fn=fan_precision);

	translate([off_x_fan - dist_AB*inv_scale, off_y_fan, 0])
	cylinder (r=inv_scale*rod_dia/2, h=3*fan_height, center=true, $fn=fan_precision);

	translate([off_x_fan -(dist_AB+dist_CD+clearance)*inv_scale, off_y_fan, 0])
	cylinder (r=inv_scale*(rod_dia/2 + clearance), h=3*fan_height, center=true, $fn=fan_precision);

	translate([off_x_fan, off_y_fan, 0])
	translate([-inv_scale*(dist_AB), 0, -0.1])
	nut(inv_scale*nut_width, inv_scale*(nut_thickness-1));

	translate([0, 0, (section_h - output_width*inv_scale)/2])
	pointIn(output_thickness*inv_scale, output_width*inv_scale, output_width*inv_scale, invol(radius, 360 + to), to);
	translate([invol(radius, 360 + to)[0], invol(radius, 360 + to)[1], section_h/2])
	rotate([0, 90, to])
	cylinder(r=inv_scale*(output_dia/2 + clearance), h=12, $fn=24, center=true);	

	if (pCut == "yes") {
		translate([0, 0,section_h+ section_h/2])
		cube([300, 300, 2*section_h], center=true);
	}

	}
}
//-------------------------------------------------------------------------------------------------
module shell_output(pCut="no") {
difference() {
	pointIn(end_thickness*inv_scale, section_w, section_h, invol(radius, 360 + to), to);

	translate([0, 0, (section_h - output_width*inv_scale)/2])
	pointIn(output_thickness*inv_scale, output_width*inv_scale, output_width*inv_scale, invol(radius, 360 + to), to);
	translate([invol(radius, 360 + to)[0], invol(radius, 360 + to)[1], section_h/2])
	rotate([0, 90, to])
	cylinder(r=inv_scale*(output_dia/2 + clearance), h=12, $fn=24, center=true);

	if (pCut == "yes") {
		translate([0, 0, section_h + section_h/2])
		cube([300, 300, 2*section_h], center=true);
	}
}
}
//------------------------------------------------------------------------------------------------
module end() {
	difference() {
		union() {
			cylinder(r=output_dia/2 -clearance, h=output_length, $fn=fan_precision);
			translate([0, 0, (output_thickness-clearance)/2])
			roundBox(output_width, output_width, output_thickness - clearance, output_rounding);
		}
		cylinder(r=output_inner_dia/2, h=output_length*2.2, center=true, $fn=fan_precision);
	}
}
//------------------------------------------------------------------------------------------------
module crank() {
difference() {
	union() {
		*cylinder(r=rod_dia/2 + crank_hole_margin, h=crank_thickness, $fn=fan_precision, center=true);
	
		translate([0, 0, rod_dia/2 + crank_hole_margin])
		rotate([90, 0, 0])
		cylinder(r=rod_dia/2 + crank_hole_margin, h=crank_thickness, $fn=fan_precision, center=true);

		translate([crank_spacing, crank_delta, rod_dia/2 + crank_hole_margin])
		rotate([90, 0, 0])
		cylinder(r=rod_dia/2 + crank_hole_margin, h=crank_thickness, $fn=fan_precision, center=true);


		BezWall( [  	[rod_dia/2 + crank_hole_margin,0],
					[-5 + crank_spacing/3,0],[5+rod_dia/2 + crank_hole_margin, crank_delta],
					[crank_spacing/3,crank_delta]
					],
				width = crank_thickness, height = rod_dia + crank_hole_margin*2, steps = 24, centered = true );

	
		translate([(rod_dia/2+crank_hole_margin)/2+0.1, 0, rod_dia/2 + crank_hole_margin])
		cube([rod_dia/2+crank_hole_margin+0.1, crank_thickness, rod_dia+2*crank_hole_margin], center=true);

		translate([crank_spacing/3+(crank_spacing - crank_spacing/3)/2, crank_delta, rod_dia/2 + crank_hole_margin])
		cube([crank_spacing - crank_spacing/3 +0.1, crank_thickness, rod_dia+2*crank_hole_margin], center=true);

		*translate([crank_spacing, 0, crank_delta])
		cylinder(r=rod_dia/2 + crank_hole_margin, h=crank_thickness, $fn=fan_precision, center=true);
	}

	translate([0, 0, rod_dia/2 + crank_hole_margin])
	rotate([90, 0, 0])
	cylinder(r=rod_dia/2 + clearance, h=2*crank_thickness, $fn=fan_precision, center=true);
	translate([crank_spacing, crank_delta, rod_dia/2 + crank_hole_margin])
	rotate([90, 0, 0])
	cylinder(r=rod_dia/2 + clearance, h=2*crank_thickness, $fn=fan_precision, center=true);

	translate([0, 0, rod_dia/2 + crank_hole_margin])
	rotate([90, 0, 180])
	nut(nut_width, nut_thickness);

	translate([crank_spacing, crank_delta, rod_dia/2 + crank_hole_margin])
	rotate([90, 0, 0])
	nut(nut_width, nut_thickness);

}
}
//------------------------------------------------------------------------------------------------
module test_gears() {
translate ([0,0,0])
gear_A();
translate ([-dist_AB,0,0]) 
gear_idler();
translate ([-dist_AB - dist_CD,0, gear_thickness_D + gear_thickness_B + gear_thickness_C/2 - gear_thickness_D/2])
rotate([180, 0, 0])
gear_drive();
}
//------------------------------------------------------------------------------------------------
module gear_A() {
difference() {
	gear (number_of_teeth=gear_teeth_A,
		circular_pitch=gear_circular_pitch,
		gear_thickness=gear_thickness_A,
		rim_thickness=gear_thickness_A,
		rim_width=5,
		hub_thickness=gear_thickness_A,
		hub_diameter = rod_dia + rod_margin*2,
		bore_diameter=rod_dia + clearance,
		backlash=0.25,
		circles=0);	
	translate([0, 0, gear_thickness_A - nut_thickness + 1])
	nut(nut_width, nut_thickness);
}	
}
//------------------------------------------------------------------------------------------------
module gear_B() {
difference() {
	gear (number_of_teeth=gear_teeth_B,
		circular_pitch=gear_circular_pitch,
		gear_thickness=0,
		rim_thickness=gear_thickness_B,
		rim_width=4,
		hub_thickness=0.5*gear_thickness_B,
		hub_diameter = nut_width + rod_margin*2,
		bore_diameter=rod_dia + clearance + 1,
		circles=0,
		backlash=0.25);
}
}
//------------------------------------------------------------------------------------------------
module gear_C() {
	gear (number_of_teeth=gear_teeth_C,
		circular_pitch=gear_circular_pitch_CD,
		gear_thickness=gear_thickness_C,
		rim_thickness=gear_thickness_C,
		rim_width=1,
		hub_thickness=gear_thickness_C,
		hub_diameter = rod_dia + rod_margin*2,
		bore_diameter=rod_dia + clearance + 1,
		circles=0,
		backlash=0.25);
}
//------------------------------------------------------------------------------------------------
module gear_D() {
	gear (number_of_teeth=gear_teeth_D,
		circular_pitch=gear_circular_pitch_CD,
		gear_thickness=0,
		rim_thickness=gear_thickness_D,
		rim_width=4,
		hub_thickness=gear_thickness_D,
		hub_diameter = 2*gear_margin + rod_dia,
		bore_diameter=rod_dia + clearance,
		circles=0,
		backlash=0.25);
}
//------------------------------------------------------------------------------------------------
module gear_drive() {
difference() {
	union() {
		gear_D();	
		for (j=[0:gear_invol_number-1]) {
		rotate([0, 0, j*(360/gear_invol_number)])
			intersection() { 
			translate([gear_inv_off_x, gear_inv_off_y, 0])
			for (i=[gear_inv_from:gear_inc:gear_inv_to]) {
				hull() {
					pointIn(0.1,gear_invol_max_width - abs(gear_size_range*i/(gear_inv_to - gear_inv_from)), gear_thickness_D, invol(gear_inv_radk, 360 + i), i);
					pointIn(0.1,gear_invol_max_width -  abs(gear_size_range*i/(gear_inv_to - gear_inv_from)), gear_thickness_D, invol(gear_inv_radk, 360 + i +gear_inc), i+gear_inc);
				}
			}
				translate([0, 0, gear_thickness_D/2])
				cylinder(r=root_radius_D - 1.5, h=gear_thickness_D, center=true, $fn=36);
			}//inter
		}
		translate([0, 0, gear_thickness_D/2 + nut_thickness/2  - 0.1])
		cylinder(r=1.8*nut_width/2, h=nut_thickness-1, center=true, $fn=fan_precision);
	}//union

	cylinder(r=rod_dia/2, h=3*gear_thickness_D, center=true, $fn=fan_precision);
	
	translate([0, 0, gear_thickness_D/2 + 1])
	nut(nut_width, nut_thickness*2);
}
}
//------------------------------------------------------------------------------------------------
module gear_idler() {
difference() {
	union() {
		gear_B();

		for (j=[0:gear_invol_number-1]) {
			rotate([0, 0, j*(360/gear_invol_number)])
				intersection() {
				translate([gear_inv_off_x, gear_inv_off_y, 0])
				for (i=[gear_inv_from:gear_inc:gear_inv_to]) {
					hull() {
						pointIn(0.1,gear_invol_max_width - abs(gear_size_range*i/(gear_inv_to - gear_inv_from)), gear_thickness_D, invol(gear_inv_radk, 360 + i), i);
				pointIn(0.1,gear_invol_max_width -  abs(gear_size_range*i/(gear_inv_to - gear_inv_from)), gear_thickness_D, invol(gear_inv_radk, 360 + i +gear_inc), i+gear_inc);
					}
				}
					translate([0, 0, gear_thickness_B/2])
					cylinder(r=root_radius_B - 1.5, h=gear_thickness_B, center=true, $fn=36);
				}//inter
			}// for
		translate([0, 0, gear_thickness_B -0.1])
		gear_C();
	}

	translate([0, 0, gear_thickness_B +gear_thickness_C - 1])
	cylinder(r=rod_dia/2 + 2*clearance, h=2*(gear_thickness_B +gear_thickness_C), center=true, $fn=fan_precision);

}
}
//------------------------------------------------------------------------------------------------
module roundBox(bw, bh, bt, rb) {
	union () {
		cube([(bw-2*rb)*1.05, (bh-2*rb)*1.05, bt], center=true);
		translate ([(bw-rb)/2, 0, 0])
		cube([rb, bh-2*rb, bt], center=true);
		translate ([-(bw-rb)/2, 0, 0])
		cube([rb, bh-2*rb, bt], center=true);
		translate ([0, -(bh-rb)/2, 0])
		cube([bw-2*rb, rb, bt], center=true);
		translate ([0, (bh-rb)/2, 0])
		cube([bw-2*rb, rb, bt], center=true);
		translate ([(-bw+2*rb)/2, (bh-2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=24);
		translate ([(bw-2*rb)/2, (bh-2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=24);
		translate ([(-bw+2*rb)/2, (-bh+2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=24);
		translate ([(bw-2*rb)/2, (-bh+2*rb)/2, 0])
		cylinder (r=rb, h = bt, center=true, $fn=24);
	}
}
//-------------------------------------------------------------------------------------------------
module cyl_section(pRadius, pPos, pA, pRatio) {
	color("tomato")
	translate([pPos[0], pPos[1], pRadius])
	rotate([0, 90, pA])
	cylinder(r=pRadius, h=1, $fn=precision, center=true);
}
//-------------------------------------------------------------------------------------------------
module pointIn(pT=1, pW, pH, pPos, pA) {
	translate([pPos[0], pPos[1], pH/2])
	rotate([0, 0, pA])
	translate([0, 0, 0])
	cube([pT, pW, pH],center=true);
}
//-------------------------------------------------------------------------------------------------
function invol(pR, pA) = [- pR * (cos(pA) + pA * sin(pA)), - pR * (sin(pA) - pA * cos(pA))];
//-------------------------------------------------------------------------------------------------



































//-------------------------------------------------------------------------------
//------------- Bevel gears by Greg Frost ---------------------------------------
//-------------------------------------------------------------------------------


module gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=10,
	hub_diameter=15,
	bore_diameter=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false)
{
	if (circular_pitch==false && diametral_pitch==false)
		echo("MCAD ERROR: gear module needs either a diametral_pitch or circular_pitch");

	//Convert diametrial pitch to our native circular pitch
	circular_pitch = (circular_pitch!=false?circular_pitch:180/diametral_pitch);

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Base Circle
	base_radius = pitch_radius*cos(pressure_angle);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;
	backlash_angle = backlash / pitch_radius * 180 / pi;
	half_thick_angle = (360 / number_of_teeth - backlash_angle) / 4;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_curcumference=pi*circle_orbit_diameter;

	// Limit the circle size to 90% of the gear face.
	circle_diameter=
		min (
			0.70*circle_orbit_curcumference/circles,
			(rim_radius-hub_diameter/2)*0.9);

	difference()
	{
		union ()
		{
			difference ()
			{
				linear_exturde_flat_option(flat=flat, height=rim_thickness, convexity=10, twist=twist)
				gear_shape (
					number_of_teeth,
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);

				if (gear_thickness < rim_thickness)
					translate ([0,0,gear_thickness])
					cylinder (r=rim_radius,h=rim_thickness-gear_thickness+1);
			}
			if (gear_thickness > rim_thickness)
				linear_exturde_flat_option(flat=flat, height=gear_thickness)
				circle (r=rim_radius);
			if (flat == false && hub_thickness > gear_thickness)
				translate ([0,0,gear_thickness])
				linear_exturde_flat_option(flat=flat, height=hub_thickness-gear_thickness)
				circle (r=hub_diameter/2);
		}
		translate ([0,0,-1])
		linear_exturde_flat_option(flat =flat, height=2+max(rim_thickness,hub_thickness,gear_thickness))
		circle (r=bore_diameter/2);
		if (circles>0)
		{
			for(i=[0:circles-1])
				rotate([0,0,i*360/circles])
				translate([circle_orbit_diameter/2,0,-1])
				linear_exturde_flat_option(flat =flat, height=max(gear_thickness,rim_thickness)+3)
				circle(r=circle_diameter/2);
		}
	}
}

module linear_exturde_flat_option(flat =false, height = 10, center = false, convexity = 2, twist = 0)
{
	if(flat==false)
	{
		linear_extrude(height = height, center = center, convexity = convexity, twist= twist) child(0);
	}
	else
	{
		child(0);
	}

}

module gear_shape (
	number_of_teeth,
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	union()
	{
		rotate (half_thick_angle) circle ($fn=number_of_teeth*2, r=root_radius);

		for (i = [1:number_of_teeth])
		{
			rotate ([0,0,i*360/number_of_teeth])
			{
				involute_gear_tooth (
					pitch_radius = pitch_radius,
					root_radius = root_radius,
					base_radius = base_radius,
					outer_radius = outer_radius,
					half_thick_angle = half_thick_angle,
					involute_facets=involute_facets);
			}
		}
	}
}

module involute_gear_tooth (
	pitch_radius,
	root_radius,
	base_radius,
	outer_radius,
	half_thick_angle,
	involute_facets)
{
	min_radius = max (base_radius,root_radius);

	pitch_point = involute (base_radius, involute_intersect_angle (base_radius, pitch_radius));
	pitch_angle = atan2 (pitch_point[1], pitch_point[0]);
	centre_angle = pitch_angle + half_thick_angle;

	start_angle = involute_intersect_angle (base_radius, min_radius);
	stop_angle = involute_intersect_angle (base_radius, outer_radius);

	res=(involute_facets!=0)?involute_facets:($fn==0)?5:$fn/4;

	union ()
	{
		for (i=[1:res])
		assign (
			point1=involute (base_radius,start_angle+(stop_angle - start_angle)*(i-1)/res),
			point2=involute (base_radius,start_angle+(stop_angle - start_angle)*i/res))
		{
			assign (
				side1_point1=rotate_point (centre_angle, point1),
				side1_point2=rotate_point (centre_angle, point2),
				side2_point1=mirror_point (rotate_point (centre_angle, point1)),
				side2_point2=mirror_point (rotate_point (centre_angle, point2)))
			{
				polygon (
					points=[[0,0],side1_point1,side1_point2,side2_point2,side2_point1],
					paths=[[0,1,2,3,4,0]]);
			}
		}
	}
}

// Mathematical Functions
//===============

// Finds the angle of the involute about the base radius at the given distance (radius) from it's center.
//source: http://www.mathhelpforum.com/math-help/geometry/136011-circle-involute-solving-y-any-given-x.html

function involute_intersect_angle (base_radius, radius) = sqrt (pow (radius/base_radius, 2) - 1) * 180 / pi;

// Calculate the involute position for a given base radius and involute angle.

function rotated_involute (rotate, base_radius, involute_angle) =
[
	cos (rotate) * involute (base_radius, involute_angle)[0] + sin (rotate) * involute (base_radius, involute_angle)[1],
	cos (rotate) * involute (base_radius, involute_angle)[1] - sin (rotate) * involute (base_radius, involute_angle)[0]
];

function mirror_point (coord) =
[
	coord[0],
	-coord[1]
];

function rotate_point (rotate, coord) =
[
	cos (rotate) * coord[0] + sin (rotate) * coord[1],
	cos (rotate) * coord[1] - sin (rotate) * coord[0]
];

function involute (base_radius, involute_angle) =
[
	base_radius*(cos (involute_angle) + involute_angle*pi/180*sin (involute_angle)),
	base_radius*(sin (involute_angle) - involute_angle*pi/180*cos (involute_angle))
];



























/* 
  Bezier functions for OpenScad
  Generated from BezierScad.coffee from darwin at Fri May 10 2013 22:59:02 GMT-0700 (PDT)
  Supports Bezier interpolation with 1-8 controls
  Sources/Inspirations:
    http://en.wikipedia.org/wiki/Bézier_curve
    http://www.cs.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/bezier-der.html
    http://www.thingiverse.com/thing:8443

Copyright (c) 2013 Chad Kirby

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/




module BezLine(ctlPts, width = [1], resolution = 4, centered = false, showCtls = true) {
  hodoPts = hodograph(ctlPts);
  if (showCtls) {
    for (pt = ctlPts) {
      % translate([pt[0], pt[1], 0]) circle(1);
    }
  }
  if (resolution == 2) {
    if (centered) {
      polygon([
        PerpAlongBez(0/3, ctlPts, dist = BezI(0/3, width)/2, hodograph = hodoPts), PerpAlongBez(1/3, ctlPts, dist = BezI(1/3, width)/2, hodograph = hodoPts), PerpAlongBez(2/3, ctlPts, dist = BezI(2/3, width)/2, hodograph = hodoPts), PerpAlongBez(3/3, ctlPts, dist = BezI(3/3, width)/2, hodograph = hodoPts), PerpAlongBez(3/3, ctlPts, dist = BezI(3/3, width)/-2, hodograph = hodoPts), PerpAlongBez(2/3, ctlPts, dist = BezI(2/3, width)/-2, hodograph = hodoPts), PerpAlongBez(1/3, ctlPts, dist = BezI(1/3, width)/-2, hodograph = hodoPts), PerpAlongBez(0/3, ctlPts, dist = BezI(0/3, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/3, ctlPts), PointAlongBez(1/3, ctlPts), PointAlongBez(2/3, ctlPts), PointAlongBez(3/3, ctlPts), PerpAlongBez(3/3, ctlPts, dist = BezI(3/3, width), hodograph = hodoPts), PerpAlongBez(2/3, ctlPts, dist = BezI(2/3, width), hodograph = hodoPts), PerpAlongBez(1/3, ctlPts, dist = BezI(1/3, width), hodograph = hodoPts), PerpAlongBez(0/3, ctlPts, dist = BezI(0/3, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 3) {
    if (centered) {
      polygon([
        PerpAlongBez(0/7, ctlPts, dist = BezI(0/7, width)/2, hodograph = hodoPts), PerpAlongBez(1/7, ctlPts, dist = BezI(1/7, width)/2, hodograph = hodoPts), PerpAlongBez(2/7, ctlPts, dist = BezI(2/7, width)/2, hodograph = hodoPts), PerpAlongBez(3/7, ctlPts, dist = BezI(3/7, width)/2, hodograph = hodoPts), PerpAlongBez(4/7, ctlPts, dist = BezI(4/7, width)/2, hodograph = hodoPts), PerpAlongBez(5/7, ctlPts, dist = BezI(5/7, width)/2, hodograph = hodoPts), PerpAlongBez(6/7, ctlPts, dist = BezI(6/7, width)/2, hodograph = hodoPts), PerpAlongBez(7/7, ctlPts, dist = BezI(7/7, width)/2, hodograph = hodoPts), PerpAlongBez(7/7, ctlPts, dist = BezI(7/7, width)/-2, hodograph = hodoPts), PerpAlongBez(6/7, ctlPts, dist = BezI(6/7, width)/-2, hodograph = hodoPts), PerpAlongBez(5/7, ctlPts, dist = BezI(5/7, width)/-2, hodograph = hodoPts), PerpAlongBez(4/7, ctlPts, dist = BezI(4/7, width)/-2, hodograph = hodoPts), PerpAlongBez(3/7, ctlPts, dist = BezI(3/7, width)/-2, hodograph = hodoPts), PerpAlongBez(2/7, ctlPts, dist = BezI(2/7, width)/-2, hodograph = hodoPts), PerpAlongBez(1/7, ctlPts, dist = BezI(1/7, width)/-2, hodograph = hodoPts), PerpAlongBez(0/7, ctlPts, dist = BezI(0/7, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/7, ctlPts), PointAlongBez(1/7, ctlPts), PointAlongBez(2/7, ctlPts), PointAlongBez(3/7, ctlPts), PointAlongBez(4/7, ctlPts), PointAlongBez(5/7, ctlPts), PointAlongBez(6/7, ctlPts), PointAlongBez(7/7, ctlPts), PerpAlongBez(7/7, ctlPts, dist = BezI(7/7, width), hodograph = hodoPts), PerpAlongBez(6/7, ctlPts, dist = BezI(6/7, width), hodograph = hodoPts), PerpAlongBez(5/7, ctlPts, dist = BezI(5/7, width), hodograph = hodoPts), PerpAlongBez(4/7, ctlPts, dist = BezI(4/7, width), hodograph = hodoPts), PerpAlongBez(3/7, ctlPts, dist = BezI(3/7, width), hodograph = hodoPts), PerpAlongBez(2/7, ctlPts, dist = BezI(2/7, width), hodograph = hodoPts), PerpAlongBez(1/7, ctlPts, dist = BezI(1/7, width), hodograph = hodoPts), PerpAlongBez(0/7, ctlPts, dist = BezI(0/7, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 4) {
    if (centered) {
      polygon([
        PerpAlongBez(0/15, ctlPts, dist = BezI(0/15, width)/2, hodograph = hodoPts), PerpAlongBez(1/15, ctlPts, dist = BezI(1/15, width)/2, hodograph = hodoPts), PerpAlongBez(2/15, ctlPts, dist = BezI(2/15, width)/2, hodograph = hodoPts), PerpAlongBez(3/15, ctlPts, dist = BezI(3/15, width)/2, hodograph = hodoPts), PerpAlongBez(4/15, ctlPts, dist = BezI(4/15, width)/2, hodograph = hodoPts), PerpAlongBez(5/15, ctlPts, dist = BezI(5/15, width)/2, hodograph = hodoPts), PerpAlongBez(6/15, ctlPts, dist = BezI(6/15, width)/2, hodograph = hodoPts), PerpAlongBez(7/15, ctlPts, dist = BezI(7/15, width)/2, hodograph = hodoPts), PerpAlongBez(8/15, ctlPts, dist = BezI(8/15, width)/2, hodograph = hodoPts), PerpAlongBez(9/15, ctlPts, dist = BezI(9/15, width)/2, hodograph = hodoPts), PerpAlongBez(10/15, ctlPts, dist = BezI(10/15, width)/2, hodograph = hodoPts), PerpAlongBez(11/15, ctlPts, dist = BezI(11/15, width)/2, hodograph = hodoPts), PerpAlongBez(12/15, ctlPts, dist = BezI(12/15, width)/2, hodograph = hodoPts), PerpAlongBez(13/15, ctlPts, dist = BezI(13/15, width)/2, hodograph = hodoPts), PerpAlongBez(14/15, ctlPts, dist = BezI(14/15, width)/2, hodograph = hodoPts), PerpAlongBez(15/15, ctlPts, dist = BezI(15/15, width)/2, hodograph = hodoPts), PerpAlongBez(15/15, ctlPts, dist = BezI(15/15, width)/-2, hodograph = hodoPts), PerpAlongBez(14/15, ctlPts, dist = BezI(14/15, width)/-2, hodograph = hodoPts), PerpAlongBez(13/15, ctlPts, dist = BezI(13/15, width)/-2, hodograph = hodoPts), PerpAlongBez(12/15, ctlPts, dist = BezI(12/15, width)/-2, hodograph = hodoPts), PerpAlongBez(11/15, ctlPts, dist = BezI(11/15, width)/-2, hodograph = hodoPts), PerpAlongBez(10/15, ctlPts, dist = BezI(10/15, width)/-2, hodograph = hodoPts), PerpAlongBez(9/15, ctlPts, dist = BezI(9/15, width)/-2, hodograph = hodoPts), PerpAlongBez(8/15, ctlPts, dist = BezI(8/15, width)/-2, hodograph = hodoPts), PerpAlongBez(7/15, ctlPts, dist = BezI(7/15, width)/-2, hodograph = hodoPts), PerpAlongBez(6/15, ctlPts, dist = BezI(6/15, width)/-2, hodograph = hodoPts), PerpAlongBez(5/15, ctlPts, dist = BezI(5/15, width)/-2, hodograph = hodoPts), PerpAlongBez(4/15, ctlPts, dist = BezI(4/15, width)/-2, hodograph = hodoPts), PerpAlongBez(3/15, ctlPts, dist = BezI(3/15, width)/-2, hodograph = hodoPts), PerpAlongBez(2/15, ctlPts, dist = BezI(2/15, width)/-2, hodograph = hodoPts), PerpAlongBez(1/15, ctlPts, dist = BezI(1/15, width)/-2, hodograph = hodoPts), PerpAlongBez(0/15, ctlPts, dist = BezI(0/15, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/15, ctlPts), PointAlongBez(1/15, ctlPts), PointAlongBez(2/15, ctlPts), PointAlongBez(3/15, ctlPts), PointAlongBez(4/15, ctlPts), PointAlongBez(5/15, ctlPts), PointAlongBez(6/15, ctlPts), PointAlongBez(7/15, ctlPts), PointAlongBez(8/15, ctlPts), PointAlongBez(9/15, ctlPts), PointAlongBez(10/15, ctlPts), PointAlongBez(11/15, ctlPts), PointAlongBez(12/15, ctlPts), PointAlongBez(13/15, ctlPts), PointAlongBez(14/15, ctlPts), PointAlongBez(15/15, ctlPts), PerpAlongBez(15/15, ctlPts, dist = BezI(15/15, width), hodograph = hodoPts), PerpAlongBez(14/15, ctlPts, dist = BezI(14/15, width), hodograph = hodoPts), PerpAlongBez(13/15, ctlPts, dist = BezI(13/15, width), hodograph = hodoPts), PerpAlongBez(12/15, ctlPts, dist = BezI(12/15, width), hodograph = hodoPts), PerpAlongBez(11/15, ctlPts, dist = BezI(11/15, width), hodograph = hodoPts), PerpAlongBez(10/15, ctlPts, dist = BezI(10/15, width), hodograph = hodoPts), PerpAlongBez(9/15, ctlPts, dist = BezI(9/15, width), hodograph = hodoPts), PerpAlongBez(8/15, ctlPts, dist = BezI(8/15, width), hodograph = hodoPts), PerpAlongBez(7/15, ctlPts, dist = BezI(7/15, width), hodograph = hodoPts), PerpAlongBez(6/15, ctlPts, dist = BezI(6/15, width), hodograph = hodoPts), PerpAlongBez(5/15, ctlPts, dist = BezI(5/15, width), hodograph = hodoPts), PerpAlongBez(4/15, ctlPts, dist = BezI(4/15, width), hodograph = hodoPts), PerpAlongBez(3/15, ctlPts, dist = BezI(3/15, width), hodograph = hodoPts), PerpAlongBez(2/15, ctlPts, dist = BezI(2/15, width), hodograph = hodoPts), PerpAlongBez(1/15, ctlPts, dist = BezI(1/15, width), hodograph = hodoPts), PerpAlongBez(0/15, ctlPts, dist = BezI(0/15, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 5) {
    if (centered) {
      polygon([
        PerpAlongBez(0/31, ctlPts, dist = BezI(0/31, width)/2, hodograph = hodoPts), PerpAlongBez(1/31, ctlPts, dist = BezI(1/31, width)/2, hodograph = hodoPts), PerpAlongBez(2/31, ctlPts, dist = BezI(2/31, width)/2, hodograph = hodoPts), PerpAlongBez(3/31, ctlPts, dist = BezI(3/31, width)/2, hodograph = hodoPts), PerpAlongBez(4/31, ctlPts, dist = BezI(4/31, width)/2, hodograph = hodoPts), PerpAlongBez(5/31, ctlPts, dist = BezI(5/31, width)/2, hodograph = hodoPts), PerpAlongBez(6/31, ctlPts, dist = BezI(6/31, width)/2, hodograph = hodoPts), PerpAlongBez(7/31, ctlPts, dist = BezI(7/31, width)/2, hodograph = hodoPts), PerpAlongBez(8/31, ctlPts, dist = BezI(8/31, width)/2, hodograph = hodoPts), PerpAlongBez(9/31, ctlPts, dist = BezI(9/31, width)/2, hodograph = hodoPts), PerpAlongBez(10/31, ctlPts, dist = BezI(10/31, width)/2, hodograph = hodoPts), PerpAlongBez(11/31, ctlPts, dist = BezI(11/31, width)/2, hodograph = hodoPts), PerpAlongBez(12/31, ctlPts, dist = BezI(12/31, width)/2, hodograph = hodoPts), PerpAlongBez(13/31, ctlPts, dist = BezI(13/31, width)/2, hodograph = hodoPts), PerpAlongBez(14/31, ctlPts, dist = BezI(14/31, width)/2, hodograph = hodoPts), PerpAlongBez(15/31, ctlPts, dist = BezI(15/31, width)/2, hodograph = hodoPts), PerpAlongBez(16/31, ctlPts, dist = BezI(16/31, width)/2, hodograph = hodoPts), PerpAlongBez(17/31, ctlPts, dist = BezI(17/31, width)/2, hodograph = hodoPts), PerpAlongBez(18/31, ctlPts, dist = BezI(18/31, width)/2, hodograph = hodoPts), PerpAlongBez(19/31, ctlPts, dist = BezI(19/31, width)/2, hodograph = hodoPts), PerpAlongBez(20/31, ctlPts, dist = BezI(20/31, width)/2, hodograph = hodoPts), PerpAlongBez(21/31, ctlPts, dist = BezI(21/31, width)/2, hodograph = hodoPts), PerpAlongBez(22/31, ctlPts, dist = BezI(22/31, width)/2, hodograph = hodoPts), PerpAlongBez(23/31, ctlPts, dist = BezI(23/31, width)/2, hodograph = hodoPts), PerpAlongBez(24/31, ctlPts, dist = BezI(24/31, width)/2, hodograph = hodoPts), PerpAlongBez(25/31, ctlPts, dist = BezI(25/31, width)/2, hodograph = hodoPts), PerpAlongBez(26/31, ctlPts, dist = BezI(26/31, width)/2, hodograph = hodoPts), PerpAlongBez(27/31, ctlPts, dist = BezI(27/31, width)/2, hodograph = hodoPts), PerpAlongBez(28/31, ctlPts, dist = BezI(28/31, width)/2, hodograph = hodoPts), PerpAlongBez(29/31, ctlPts, dist = BezI(29/31, width)/2, hodograph = hodoPts), PerpAlongBez(30/31, ctlPts, dist = BezI(30/31, width)/2, hodograph = hodoPts), PerpAlongBez(31/31, ctlPts, dist = BezI(31/31, width)/2, hodograph = hodoPts), PerpAlongBez(31/31, ctlPts, dist = BezI(31/31, width)/-2, hodograph = hodoPts), PerpAlongBez(30/31, ctlPts, dist = BezI(30/31, width)/-2, hodograph = hodoPts), PerpAlongBez(29/31, ctlPts, dist = BezI(29/31, width)/-2, hodograph = hodoPts), PerpAlongBez(28/31, ctlPts, dist = BezI(28/31, width)/-2, hodograph = hodoPts), PerpAlongBez(27/31, ctlPts, dist = BezI(27/31, width)/-2, hodograph = hodoPts), PerpAlongBez(26/31, ctlPts, dist = BezI(26/31, width)/-2, hodograph = hodoPts), PerpAlongBez(25/31, ctlPts, dist = BezI(25/31, width)/-2, hodograph = hodoPts), PerpAlongBez(24/31, ctlPts, dist = BezI(24/31, width)/-2, hodograph = hodoPts), PerpAlongBez(23/31, ctlPts, dist = BezI(23/31, width)/-2, hodograph = hodoPts), PerpAlongBez(22/31, ctlPts, dist = BezI(22/31, width)/-2, hodograph = hodoPts), PerpAlongBez(21/31, ctlPts, dist = BezI(21/31, width)/-2, hodograph = hodoPts), PerpAlongBez(20/31, ctlPts, dist = BezI(20/31, width)/-2, hodograph = hodoPts), PerpAlongBez(19/31, ctlPts, dist = BezI(19/31, width)/-2, hodograph = hodoPts), PerpAlongBez(18/31, ctlPts, dist = BezI(18/31, width)/-2, hodograph = hodoPts), PerpAlongBez(17/31, ctlPts, dist = BezI(17/31, width)/-2, hodograph = hodoPts), PerpAlongBez(16/31, ctlPts, dist = BezI(16/31, width)/-2, hodograph = hodoPts), PerpAlongBez(15/31, ctlPts, dist = BezI(15/31, width)/-2, hodograph = hodoPts), PerpAlongBez(14/31, ctlPts, dist = BezI(14/31, width)/-2, hodograph = hodoPts), PerpAlongBez(13/31, ctlPts, dist = BezI(13/31, width)/-2, hodograph = hodoPts), PerpAlongBez(12/31, ctlPts, dist = BezI(12/31, width)/-2, hodograph = hodoPts), PerpAlongBez(11/31, ctlPts, dist = BezI(11/31, width)/-2, hodograph = hodoPts), PerpAlongBez(10/31, ctlPts, dist = BezI(10/31, width)/-2, hodograph = hodoPts), PerpAlongBez(9/31, ctlPts, dist = BezI(9/31, width)/-2, hodograph = hodoPts), PerpAlongBez(8/31, ctlPts, dist = BezI(8/31, width)/-2, hodograph = hodoPts), PerpAlongBez(7/31, ctlPts, dist = BezI(7/31, width)/-2, hodograph = hodoPts), PerpAlongBez(6/31, ctlPts, dist = BezI(6/31, width)/-2, hodograph = hodoPts), PerpAlongBez(5/31, ctlPts, dist = BezI(5/31, width)/-2, hodograph = hodoPts), PerpAlongBez(4/31, ctlPts, dist = BezI(4/31, width)/-2, hodograph = hodoPts), PerpAlongBez(3/31, ctlPts, dist = BezI(3/31, width)/-2, hodograph = hodoPts), PerpAlongBez(2/31, ctlPts, dist = BezI(2/31, width)/-2, hodograph = hodoPts), PerpAlongBez(1/31, ctlPts, dist = BezI(1/31, width)/-2, hodograph = hodoPts), PerpAlongBez(0/31, ctlPts, dist = BezI(0/31, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/31, ctlPts), PointAlongBez(1/31, ctlPts), PointAlongBez(2/31, ctlPts), PointAlongBez(3/31, ctlPts), PointAlongBez(4/31, ctlPts), PointAlongBez(5/31, ctlPts), PointAlongBez(6/31, ctlPts), PointAlongBez(7/31, ctlPts), PointAlongBez(8/31, ctlPts), PointAlongBez(9/31, ctlPts), PointAlongBez(10/31, ctlPts), PointAlongBez(11/31, ctlPts), PointAlongBez(12/31, ctlPts), PointAlongBez(13/31, ctlPts), PointAlongBez(14/31, ctlPts), PointAlongBez(15/31, ctlPts), PointAlongBez(16/31, ctlPts), PointAlongBez(17/31, ctlPts), PointAlongBez(18/31, ctlPts), PointAlongBez(19/31, ctlPts), PointAlongBez(20/31, ctlPts), PointAlongBez(21/31, ctlPts), PointAlongBez(22/31, ctlPts), PointAlongBez(23/31, ctlPts), PointAlongBez(24/31, ctlPts), PointAlongBez(25/31, ctlPts), PointAlongBez(26/31, ctlPts), PointAlongBez(27/31, ctlPts), PointAlongBez(28/31, ctlPts), PointAlongBez(29/31, ctlPts), PointAlongBez(30/31, ctlPts), PointAlongBez(31/31, ctlPts), PerpAlongBez(31/31, ctlPts, dist = BezI(31/31, width), hodograph = hodoPts), PerpAlongBez(30/31, ctlPts, dist = BezI(30/31, width), hodograph = hodoPts), PerpAlongBez(29/31, ctlPts, dist = BezI(29/31, width), hodograph = hodoPts), PerpAlongBez(28/31, ctlPts, dist = BezI(28/31, width), hodograph = hodoPts), PerpAlongBez(27/31, ctlPts, dist = BezI(27/31, width), hodograph = hodoPts), PerpAlongBez(26/31, ctlPts, dist = BezI(26/31, width), hodograph = hodoPts), PerpAlongBez(25/31, ctlPts, dist = BezI(25/31, width), hodograph = hodoPts), PerpAlongBez(24/31, ctlPts, dist = BezI(24/31, width), hodograph = hodoPts), PerpAlongBez(23/31, ctlPts, dist = BezI(23/31, width), hodograph = hodoPts), PerpAlongBez(22/31, ctlPts, dist = BezI(22/31, width), hodograph = hodoPts), PerpAlongBez(21/31, ctlPts, dist = BezI(21/31, width), hodograph = hodoPts), PerpAlongBez(20/31, ctlPts, dist = BezI(20/31, width), hodograph = hodoPts), PerpAlongBez(19/31, ctlPts, dist = BezI(19/31, width), hodograph = hodoPts), PerpAlongBez(18/31, ctlPts, dist = BezI(18/31, width), hodograph = hodoPts), PerpAlongBez(17/31, ctlPts, dist = BezI(17/31, width), hodograph = hodoPts), PerpAlongBez(16/31, ctlPts, dist = BezI(16/31, width), hodograph = hodoPts), PerpAlongBez(15/31, ctlPts, dist = BezI(15/31, width), hodograph = hodoPts), PerpAlongBez(14/31, ctlPts, dist = BezI(14/31, width), hodograph = hodoPts), PerpAlongBez(13/31, ctlPts, dist = BezI(13/31, width), hodograph = hodoPts), PerpAlongBez(12/31, ctlPts, dist = BezI(12/31, width), hodograph = hodoPts), PerpAlongBez(11/31, ctlPts, dist = BezI(11/31, width), hodograph = hodoPts), PerpAlongBez(10/31, ctlPts, dist = BezI(10/31, width), hodograph = hodoPts), PerpAlongBez(9/31, ctlPts, dist = BezI(9/31, width), hodograph = hodoPts), PerpAlongBez(8/31, ctlPts, dist = BezI(8/31, width), hodograph = hodoPts), PerpAlongBez(7/31, ctlPts, dist = BezI(7/31, width), hodograph = hodoPts), PerpAlongBez(6/31, ctlPts, dist = BezI(6/31, width), hodograph = hodoPts), PerpAlongBez(5/31, ctlPts, dist = BezI(5/31, width), hodograph = hodoPts), PerpAlongBez(4/31, ctlPts, dist = BezI(4/31, width), hodograph = hodoPts), PerpAlongBez(3/31, ctlPts, dist = BezI(3/31, width), hodograph = hodoPts), PerpAlongBez(2/31, ctlPts, dist = BezI(2/31, width), hodograph = hodoPts), PerpAlongBez(1/31, ctlPts, dist = BezI(1/31, width), hodograph = hodoPts), PerpAlongBez(0/31, ctlPts, dist = BezI(0/31, width), hodograph = hodoPts)
      ]);
    }
  } else if (resolution == 6) {
    if (centered) {
      polygon([
        PerpAlongBez(0/63, ctlPts, dist = BezI(0/63, width)/2, hodograph = hodoPts), PerpAlongBez(1/63, ctlPts, dist = BezI(1/63, width)/2, hodograph = hodoPts), PerpAlongBez(2/63, ctlPts, dist = BezI(2/63, width)/2, hodograph = hodoPts), PerpAlongBez(3/63, ctlPts, dist = BezI(3/63, width)/2, hodograph = hodoPts), PerpAlongBez(4/63, ctlPts, dist = BezI(4/63, width)/2, hodograph = hodoPts), PerpAlongBez(5/63, ctlPts, dist = BezI(5/63, width)/2, hodograph = hodoPts), PerpAlongBez(6/63, ctlPts, dist = BezI(6/63, width)/2, hodograph = hodoPts), PerpAlongBez(7/63, ctlPts, dist = BezI(7/63, width)/2, hodograph = hodoPts), PerpAlongBez(8/63, ctlPts, dist = BezI(8/63, width)/2, hodograph = hodoPts), PerpAlongBez(9/63, ctlPts, dist = BezI(9/63, width)/2, hodograph = hodoPts), PerpAlongBez(10/63, ctlPts, dist = BezI(10/63, width)/2, hodograph = hodoPts), PerpAlongBez(11/63, ctlPts, dist = BezI(11/63, width)/2, hodograph = hodoPts), PerpAlongBez(12/63, ctlPts, dist = BezI(12/63, width)/2, hodograph = hodoPts), PerpAlongBez(13/63, ctlPts, dist = BezI(13/63, width)/2, hodograph = hodoPts), PerpAlongBez(14/63, ctlPts, dist = BezI(14/63, width)/2, hodograph = hodoPts), PerpAlongBez(15/63, ctlPts, dist = BezI(15/63, width)/2, hodograph = hodoPts), PerpAlongBez(16/63, ctlPts, dist = BezI(16/63, width)/2, hodograph = hodoPts), PerpAlongBez(17/63, ctlPts, dist = BezI(17/63, width)/2, hodograph = hodoPts), PerpAlongBez(18/63, ctlPts, dist = BezI(18/63, width)/2, hodograph = hodoPts), PerpAlongBez(19/63, ctlPts, dist = BezI(19/63, width)/2, hodograph = hodoPts), PerpAlongBez(20/63, ctlPts, dist = BezI(20/63, width)/2, hodograph = hodoPts), PerpAlongBez(21/63, ctlPts, dist = BezI(21/63, width)/2, hodograph = hodoPts), PerpAlongBez(22/63, ctlPts, dist = BezI(22/63, width)/2, hodograph = hodoPts), PerpAlongBez(23/63, ctlPts, dist = BezI(23/63, width)/2, hodograph = hodoPts), PerpAlongBez(24/63, ctlPts, dist = BezI(24/63, width)/2, hodograph = hodoPts), PerpAlongBez(25/63, ctlPts, dist = BezI(25/63, width)/2, hodograph = hodoPts), PerpAlongBez(26/63, ctlPts, dist = BezI(26/63, width)/2, hodograph = hodoPts), PerpAlongBez(27/63, ctlPts, dist = BezI(27/63, width)/2, hodograph = hodoPts), PerpAlongBez(28/63, ctlPts, dist = BezI(28/63, width)/2, hodograph = hodoPts), PerpAlongBez(29/63, ctlPts, dist = BezI(29/63, width)/2, hodograph = hodoPts), PerpAlongBez(30/63, ctlPts, dist = BezI(30/63, width)/2, hodograph = hodoPts), PerpAlongBez(31/63, ctlPts, dist = BezI(31/63, width)/2, hodograph = hodoPts), PerpAlongBez(32/63, ctlPts, dist = BezI(32/63, width)/2, hodograph = hodoPts), PerpAlongBez(33/63, ctlPts, dist = BezI(33/63, width)/2, hodograph = hodoPts), PerpAlongBez(34/63, ctlPts, dist = BezI(34/63, width)/2, hodograph = hodoPts), PerpAlongBez(35/63, ctlPts, dist = BezI(35/63, width)/2, hodograph = hodoPts), PerpAlongBez(36/63, ctlPts, dist = BezI(36/63, width)/2, hodograph = hodoPts), PerpAlongBez(37/63, ctlPts, dist = BezI(37/63, width)/2, hodograph = hodoPts), PerpAlongBez(38/63, ctlPts, dist = BezI(38/63, width)/2, hodograph = hodoPts), PerpAlongBez(39/63, ctlPts, dist = BezI(39/63, width)/2, hodograph = hodoPts), PerpAlongBez(40/63, ctlPts, dist = BezI(40/63, width)/2, hodograph = hodoPts), PerpAlongBez(41/63, ctlPts, dist = BezI(41/63, width)/2, hodograph = hodoPts), PerpAlongBez(42/63, ctlPts, dist = BezI(42/63, width)/2, hodograph = hodoPts), PerpAlongBez(43/63, ctlPts, dist = BezI(43/63, width)/2, hodograph = hodoPts), PerpAlongBez(44/63, ctlPts, dist = BezI(44/63, width)/2, hodograph = hodoPts), PerpAlongBez(45/63, ctlPts, dist = BezI(45/63, width)/2, hodograph = hodoPts), PerpAlongBez(46/63, ctlPts, dist = BezI(46/63, width)/2, hodograph = hodoPts), PerpAlongBez(47/63, ctlPts, dist = BezI(47/63, width)/2, hodograph = hodoPts), PerpAlongBez(48/63, ctlPts, dist = BezI(48/63, width)/2, hodograph = hodoPts), PerpAlongBez(49/63, ctlPts, dist = BezI(49/63, width)/2, hodograph = hodoPts), PerpAlongBez(50/63, ctlPts, dist = BezI(50/63, width)/2, hodograph = hodoPts), PerpAlongBez(51/63, ctlPts, dist = BezI(51/63, width)/2, hodograph = hodoPts), PerpAlongBez(52/63, ctlPts, dist = BezI(52/63, width)/2, hodograph = hodoPts), PerpAlongBez(53/63, ctlPts, dist = BezI(53/63, width)/2, hodograph = hodoPts), PerpAlongBez(54/63, ctlPts, dist = BezI(54/63, width)/2, hodograph = hodoPts), PerpAlongBez(55/63, ctlPts, dist = BezI(55/63, width)/2, hodograph = hodoPts), PerpAlongBez(56/63, ctlPts, dist = BezI(56/63, width)/2, hodograph = hodoPts), PerpAlongBez(57/63, ctlPts, dist = BezI(57/63, width)/2, hodograph = hodoPts), PerpAlongBez(58/63, ctlPts, dist = BezI(58/63, width)/2, hodograph = hodoPts), PerpAlongBez(59/63, ctlPts, dist = BezI(59/63, width)/2, hodograph = hodoPts), PerpAlongBez(60/63, ctlPts, dist = BezI(60/63, width)/2, hodograph = hodoPts), PerpAlongBez(61/63, ctlPts, dist = BezI(61/63, width)/2, hodograph = hodoPts), PerpAlongBez(62/63, ctlPts, dist = BezI(62/63, width)/2, hodograph = hodoPts), PerpAlongBez(63/63, ctlPts, dist = BezI(63/63, width)/2, hodograph = hodoPts), PerpAlongBez(63/63, ctlPts, dist = BezI(63/63, width)/-2, hodograph = hodoPts), PerpAlongBez(62/63, ctlPts, dist = BezI(62/63, width)/-2, hodograph = hodoPts), PerpAlongBez(61/63, ctlPts, dist = BezI(61/63, width)/-2, hodograph = hodoPts), PerpAlongBez(60/63, ctlPts, dist = BezI(60/63, width)/-2, hodograph = hodoPts), PerpAlongBez(59/63, ctlPts, dist = BezI(59/63, width)/-2, hodograph = hodoPts), PerpAlongBez(58/63, ctlPts, dist = BezI(58/63, width)/-2, hodograph = hodoPts), PerpAlongBez(57/63, ctlPts, dist = BezI(57/63, width)/-2, hodograph = hodoPts), PerpAlongBez(56/63, ctlPts, dist = BezI(56/63, width)/-2, hodograph = hodoPts), PerpAlongBez(55/63, ctlPts, dist = BezI(55/63, width)/-2, hodograph = hodoPts), PerpAlongBez(54/63, ctlPts, dist = BezI(54/63, width)/-2, hodograph = hodoPts), PerpAlongBez(53/63, ctlPts, dist = BezI(53/63, width)/-2, hodograph = hodoPts), PerpAlongBez(52/63, ctlPts, dist = BezI(52/63, width)/-2, hodograph = hodoPts), PerpAlongBez(51/63, ctlPts, dist = BezI(51/63, width)/-2, hodograph = hodoPts), PerpAlongBez(50/63, ctlPts, dist = BezI(50/63, width)/-2, hodograph = hodoPts), PerpAlongBez(49/63, ctlPts, dist = BezI(49/63, width)/-2, hodograph = hodoPts), PerpAlongBez(48/63, ctlPts, dist = BezI(48/63, width)/-2, hodograph = hodoPts), PerpAlongBez(47/63, ctlPts, dist = BezI(47/63, width)/-2, hodograph = hodoPts), PerpAlongBez(46/63, ctlPts, dist = BezI(46/63, width)/-2, hodograph = hodoPts), PerpAlongBez(45/63, ctlPts, dist = BezI(45/63, width)/-2, hodograph = hodoPts), PerpAlongBez(44/63, ctlPts, dist = BezI(44/63, width)/-2, hodograph = hodoPts), PerpAlongBez(43/63, ctlPts, dist = BezI(43/63, width)/-2, hodograph = hodoPts), PerpAlongBez(42/63, ctlPts, dist = BezI(42/63, width)/-2, hodograph = hodoPts), PerpAlongBez(41/63, ctlPts, dist = BezI(41/63, width)/-2, hodograph = hodoPts), PerpAlongBez(40/63, ctlPts, dist = BezI(40/63, width)/-2, hodograph = hodoPts), PerpAlongBez(39/63, ctlPts, dist = BezI(39/63, width)/-2, hodograph = hodoPts), PerpAlongBez(38/63, ctlPts, dist = BezI(38/63, width)/-2, hodograph = hodoPts), PerpAlongBez(37/63, ctlPts, dist = BezI(37/63, width)/-2, hodograph = hodoPts), PerpAlongBez(36/63, ctlPts, dist = BezI(36/63, width)/-2, hodograph = hodoPts), PerpAlongBez(35/63, ctlPts, dist = BezI(35/63, width)/-2, hodograph = hodoPts), PerpAlongBez(34/63, ctlPts, dist = BezI(34/63, width)/-2, hodograph = hodoPts), PerpAlongBez(33/63, ctlPts, dist = BezI(33/63, width)/-2, hodograph = hodoPts), PerpAlongBez(32/63, ctlPts, dist = BezI(32/63, width)/-2, hodograph = hodoPts), PerpAlongBez(31/63, ctlPts, dist = BezI(31/63, width)/-2, hodograph = hodoPts), PerpAlongBez(30/63, ctlPts, dist = BezI(30/63, width)/-2, hodograph = hodoPts), PerpAlongBez(29/63, ctlPts, dist = BezI(29/63, width)/-2, hodograph = hodoPts), PerpAlongBez(28/63, ctlPts, dist = BezI(28/63, width)/-2, hodograph = hodoPts), PerpAlongBez(27/63, ctlPts, dist = BezI(27/63, width)/-2, hodograph = hodoPts), PerpAlongBez(26/63, ctlPts, dist = BezI(26/63, width)/-2, hodograph = hodoPts), PerpAlongBez(25/63, ctlPts, dist = BezI(25/63, width)/-2, hodograph = hodoPts), PerpAlongBez(24/63, ctlPts, dist = BezI(24/63, width)/-2, hodograph = hodoPts), PerpAlongBez(23/63, ctlPts, dist = BezI(23/63, width)/-2, hodograph = hodoPts), PerpAlongBez(22/63, ctlPts, dist = BezI(22/63, width)/-2, hodograph = hodoPts), PerpAlongBez(21/63, ctlPts, dist = BezI(21/63, width)/-2, hodograph = hodoPts), PerpAlongBez(20/63, ctlPts, dist = BezI(20/63, width)/-2, hodograph = hodoPts), PerpAlongBez(19/63, ctlPts, dist = BezI(19/63, width)/-2, hodograph = hodoPts), PerpAlongBez(18/63, ctlPts, dist = BezI(18/63, width)/-2, hodograph = hodoPts), PerpAlongBez(17/63, ctlPts, dist = BezI(17/63, width)/-2, hodograph = hodoPts), PerpAlongBez(16/63, ctlPts, dist = BezI(16/63, width)/-2, hodograph = hodoPts), PerpAlongBez(15/63, ctlPts, dist = BezI(15/63, width)/-2, hodograph = hodoPts), PerpAlongBez(14/63, ctlPts, dist = BezI(14/63, width)/-2, hodograph = hodoPts), PerpAlongBez(13/63, ctlPts, dist = BezI(13/63, width)/-2, hodograph = hodoPts), PerpAlongBez(12/63, ctlPts, dist = BezI(12/63, width)/-2, hodograph = hodoPts), PerpAlongBez(11/63, ctlPts, dist = BezI(11/63, width)/-2, hodograph = hodoPts), PerpAlongBez(10/63, ctlPts, dist = BezI(10/63, width)/-2, hodograph = hodoPts), PerpAlongBez(9/63, ctlPts, dist = BezI(9/63, width)/-2, hodograph = hodoPts), PerpAlongBez(8/63, ctlPts, dist = BezI(8/63, width)/-2, hodograph = hodoPts), PerpAlongBez(7/63, ctlPts, dist = BezI(7/63, width)/-2, hodograph = hodoPts), PerpAlongBez(6/63, ctlPts, dist = BezI(6/63, width)/-2, hodograph = hodoPts), PerpAlongBez(5/63, ctlPts, dist = BezI(5/63, width)/-2, hodograph = hodoPts), PerpAlongBez(4/63, ctlPts, dist = BezI(4/63, width)/-2, hodograph = hodoPts), PerpAlongBez(3/63, ctlPts, dist = BezI(3/63, width)/-2, hodograph = hodoPts), PerpAlongBez(2/63, ctlPts, dist = BezI(2/63, width)/-2, hodograph = hodoPts), PerpAlongBez(1/63, ctlPts, dist = BezI(1/63, width)/-2, hodograph = hodoPts), PerpAlongBez(0/63, ctlPts, dist = BezI(0/63, width)/-2, hodograph = hodoPts)
      ]);
    } else {
      polygon([
        PointAlongBez(0/63, ctlPts), PointAlongBez(1/63, ctlPts), PointAlongBez(2/63, ctlPts), PointAlongBez(3/63, ctlPts), PointAlongBez(4/63, ctlPts), PointAlongBez(5/63, ctlPts), PointAlongBez(6/63, ctlPts), PointAlongBez(7/63, ctlPts), PointAlongBez(8/63, ctlPts), PointAlongBez(9/63, ctlPts), PointAlongBez(10/63, ctlPts), PointAlongBez(11/63, ctlPts), PointAlongBez(12/63, ctlPts), PointAlongBez(13/63, ctlPts), PointAlongBez(14/63, ctlPts), PointAlongBez(15/63, ctlPts), PointAlongBez(16/63, ctlPts), PointAlongBez(17/63, ctlPts), PointAlongBez(18/63, ctlPts), PointAlongBez(19/63, ctlPts), PointAlongBez(20/63, ctlPts), PointAlongBez(21/63, ctlPts), PointAlongBez(22/63, ctlPts), PointAlongBez(23/63, ctlPts), PointAlongBez(24/63, ctlPts), PointAlongBez(25/63, ctlPts), PointAlongBez(26/63, ctlPts), PointAlongBez(27/63, ctlPts), PointAlongBez(28/63, ctlPts), PointAlongBez(29/63, ctlPts), PointAlongBez(30/63, ctlPts), PointAlongBez(31/63, ctlPts), PointAlongBez(32/63, ctlPts), PointAlongBez(33/63, ctlPts), PointAlongBez(34/63, ctlPts), PointAlongBez(35/63, ctlPts), PointAlongBez(36/63, ctlPts), PointAlongBez(37/63, ctlPts), PointAlongBez(38/63, ctlPts), PointAlongBez(39/63, ctlPts), PointAlongBez(40/63, ctlPts), PointAlongBez(41/63, ctlPts), PointAlongBez(42/63, ctlPts), PointAlongBez(43/63, ctlPts), PointAlongBez(44/63, ctlPts), PointAlongBez(45/63, ctlPts), PointAlongBez(46/63, ctlPts), PointAlongBez(47/63, ctlPts), PointAlongBez(48/63, ctlPts), PointAlongBez(49/63, ctlPts), PointAlongBez(50/63, ctlPts), PointAlongBez(51/63, ctlPts), PointAlongBez(52/63, ctlPts), PointAlongBez(53/63, ctlPts), PointAlongBez(54/63, ctlPts), PointAlongBez(55/63, ctlPts), PointAlongBez(56/63, ctlPts), PointAlongBez(57/63, ctlPts), PointAlongBez(58/63, ctlPts), PointAlongBez(59/63, ctlPts), PointAlongBez(60/63, ctlPts), PointAlongBez(61/63, ctlPts), PointAlongBez(62/63, ctlPts), PointAlongBez(63/63, ctlPts), PerpAlongBez(63/63, ctlPts, dist = BezI(63/63, width), hodograph = hodoPts), PerpAlongBez(62/63, ctlPts, dist = BezI(62/63, width), hodograph = hodoPts), PerpAlongBez(61/63, ctlPts, dist = BezI(61/63, width), hodograph = hodoPts), PerpAlongBez(60/63, ctlPts, dist = BezI(60/63, width), hodograph = hodoPts), PerpAlongBez(59/63, ctlPts, dist = BezI(59/63, width), hodograph = hodoPts), PerpAlongBez(58/63, ctlPts, dist = BezI(58/63, width), hodograph = hodoPts), PerpAlongBez(57/63, ctlPts, dist = BezI(57/63, width), hodograph = hodoPts), PerpAlongBez(56/63, ctlPts, dist = BezI(56/63, width), hodograph = hodoPts), PerpAlongBez(55/63, ctlPts, dist = BezI(55/63, width), hodograph = hodoPts), PerpAlongBez(54/63, ctlPts, dist = BezI(54/63, width), hodograph = hodoPts), PerpAlongBez(53/63, ctlPts, dist = BezI(53/63, width), hodograph = hodoPts), PerpAlongBez(52/63, ctlPts, dist = BezI(52/63, width), hodograph = hodoPts), PerpAlongBez(51/63, ctlPts, dist = BezI(51/63, width), hodograph = hodoPts), PerpAlongBez(50/63, ctlPts, dist = BezI(50/63, width), hodograph = hodoPts), PerpAlongBez(49/63, ctlPts, dist = BezI(49/63, width), hodograph = hodoPts), PerpAlongBez(48/63, ctlPts, dist = BezI(48/63, width), hodograph = hodoPts), PerpAlongBez(47/63, ctlPts, dist = BezI(47/63, width), hodograph = hodoPts), PerpAlongBez(46/63, ctlPts, dist = BezI(46/63, width), hodograph = hodoPts), PerpAlongBez(45/63, ctlPts, dist = BezI(45/63, width), hodograph = hodoPts), PerpAlongBez(44/63, ctlPts, dist = BezI(44/63, width), hodograph = hodoPts), PerpAlongBez(43/63, ctlPts, dist = BezI(43/63, width), hodograph = hodoPts), PerpAlongBez(42/63, ctlPts, dist = BezI(42/63, width), hodograph = hodoPts), PerpAlongBez(41/63, ctlPts, dist = BezI(41/63, width), hodograph = hodoPts), PerpAlongBez(40/63, ctlPts, dist = BezI(40/63, width), hodograph = hodoPts), PerpAlongBez(39/63, ctlPts, dist = BezI(39/63, width), hodograph = hodoPts), PerpAlongBez(38/63, ctlPts, dist = BezI(38/63, width), hodograph = hodoPts), PerpAlongBez(37/63, ctlPts, dist = BezI(37/63, width), hodograph = hodoPts), PerpAlongBez(36/63, ctlPts, dist = BezI(36/63, width), hodograph = hodoPts), PerpAlongBez(35/63, ctlPts, dist = BezI(35/63, width), hodograph = hodoPts), PerpAlongBez(34/63, ctlPts, dist = BezI(34/63, width), hodograph = hodoPts), PerpAlongBez(33/63, ctlPts, dist = BezI(33/63, width), hodograph = hodoPts), PerpAlongBez(32/63, ctlPts, dist = BezI(32/63, width), hodograph = hodoPts), PerpAlongBez(31/63, ctlPts, dist = BezI(31/63, width), hodograph = hodoPts), PerpAlongBez(30/63, ctlPts, dist = BezI(30/63, width), hodograph = hodoPts), PerpAlongBez(29/63, ctlPts, dist = BezI(29/63, width), hodograph = hodoPts), PerpAlongBez(28/63, ctlPts, dist = BezI(28/63, width), hodograph = hodoPts), PerpAlongBez(27/63, ctlPts, dist = BezI(27/63, width), hodograph = hodoPts), PerpAlongBez(26/63, ctlPts, dist = BezI(26/63, width), hodograph = hodoPts), PerpAlongBez(25/63, ctlPts, dist = BezI(25/63, width), hodograph = hodoPts), PerpAlongBez(24/63, ctlPts, dist = BezI(24/63, width), hodograph = hodoPts), PerpAlongBez(23/63, ctlPts, dist = BezI(23/63, width), hodograph = hodoPts), PerpAlongBez(22/63, ctlPts, dist = BezI(22/63, width), hodograph = hodoPts), PerpAlongBez(21/63, ctlPts, dist = BezI(21/63, width), hodograph = hodoPts), PerpAlongBez(20/63, ctlPts, dist = BezI(20/63, width), hodograph = hodoPts), PerpAlongBez(19/63, ctlPts, dist = BezI(19/63, width), hodograph = hodoPts), PerpAlongBez(18/63, ctlPts, dist = BezI(18/63, width), hodograph = hodoPts), PerpAlongBez(17/63, ctlPts, dist = BezI(17/63, width), hodograph = hodoPts), PerpAlongBez(16/63, ctlPts, dist = BezI(16/63, width), hodograph = hodoPts), PerpAlongBez(15/63, ctlPts, dist = BezI(15/63, width), hodograph = hodoPts), PerpAlongBez(14/63, ctlPts, dist = BezI(14/63, width), hodograph = hodoPts), PerpAlongBez(13/63, ctlPts, dist = BezI(13/63, width), hodograph = hodoPts), PerpAlongBez(12/63, ctlPts, dist = BezI(12/63, width), hodograph = hodoPts), PerpAlongBez(11/63, ctlPts, dist = BezI(11/63, width), hodograph = hodoPts), PerpAlongBez(10/63, ctlPts, dist = BezI(10/63, width), hodograph = hodoPts), PerpAlongBez(9/63, ctlPts, dist = BezI(9/63, width), hodograph = hodoPts), PerpAlongBez(8/63, ctlPts, dist = BezI(8/63, width), hodograph = hodoPts), PerpAlongBez(7/63, ctlPts, dist = BezI(7/63, width), hodograph = hodoPts), PerpAlongBez(6/63, ctlPts, dist = BezI(6/63, width), hodograph = hodoPts), PerpAlongBez(5/63, ctlPts, dist = BezI(5/63, width), hodograph = hodoPts), PerpAlongBez(4/63, ctlPts, dist = BezI(4/63, width), hodograph = hodoPts), PerpAlongBez(3/63, ctlPts, dist = BezI(3/63, width), hodograph = hodoPts), PerpAlongBez(2/63, ctlPts, dist = BezI(2/63, width), hodograph = hodoPts), PerpAlongBez(1/63, ctlPts, dist = BezI(1/63, width), hodograph = hodoPts), PerpAlongBez(0/63, ctlPts, dist = BezI(0/63, width), hodograph = hodoPts)
      ]);
    }
  }
}
module BezWall( 
  ctlPts, 
  width = 1, 
  height = 1, 
  steps = 16,
  widthCtls = [], 
  heightCtls = [], 
  centered = false, 
  showCtlR = 1
) {
  hodoPts = hodograph(ctlPts);
  if (showCtlR > 0) {
    for (pt = ctlPts) {
      % translate([pt[0], pt[1], 0]) circle(showCtlR);
    }
  }
  triangles = [ [0,2,1], [0,3,2], [0,4,5], [0,1,4], [0,6,3], [0,5,6], [4,6,5], [4,7,6], [1,2,7], [1,7,4], [2,3,6], [2,6,7], ];
  for(step = [steps-1 : 1])
  {
    assign(
      t1 = step/(steps-1), 
      t0 = (step-1)/(steps-1)
    ) {
    assign(
      hgt0 = len(heightCtls) > 0 ? BezI(t0, heightCtls) : height,
      hgt1 = len(heightCtls) > 0 ? BezI(t1, heightCtls) : height,
      wid0 = len(widthCtls) > 0 ? BezI(t0, widthCtls) : width, 
      wid1 = len(widthCtls) > 0 ? BezI(t1, widthCtls) : width
    ) {
      if (centered) {
        assign(
          p0 = PerpAlongBez(t0, ctlPts, dist = -wid0/2, hodograph = hodoPts),
          p1 = PerpAlongBez(t0, ctlPts, dist = wid0/2, hodograph = hodoPts),
          p4 = PerpAlongBez(t1, ctlPts, dist = wid1/2, hodograph = hodoPts),
          p5 = PerpAlongBez(t1, ctlPts, dist = -wid1/2, hodograph = hodoPts)
        ) {
          if (hgt0 == 0 && hgt1 == 0 ) {
            polygon([ p5, p0, p1, p4 ]);
          } else if (hgt0 == hgt1) {
            linear_extrude(height = hgt0, convexity = 2) polygon([ p5, p0, p1, p4 ]);
          } else {
            polyhedron(
              points =[
                [p0[0],p0[1],0], // 0
                [p1[0],p1[1],0], // 1
                [p1[0],p1[1],hgt0], // 2
                [p0[0],p0[1],hgt0], // 3
                [p4[0],p4[1],0], // 4
                [p5[0],p5[1],0], // 5
                [p5[0],p5[1],hgt1], // 6
                [p4[0],p4[1],hgt1], // 7
              ],
              triangles = triangles,
              convexity = 2
            );
          }
        }
      } else {
        assign(
          p0 = PointAlongBez(t0, ctlPts),
          p1 = PerpAlongBez(t0, ctlPts, dist = wid0, hodograph = hodoPts),
          p4 = PerpAlongBez(t1, ctlPts, dist = wid1, hodograph = hodoPts),
          p5 = PointAlongBez(t1, ctlPts)
        ) {
          if (hgt0 == 0 && hgt1 == 0 ) {
            polygon([ p5, p0, p1, p4 ]);
          } else if (hgt0 == hgt1) {
            linear_extrude(height = hgt0, convexity = 2) polygon([ p5, p0, p1, p4 ]);
          } else {
            polyhedron(
              points =[
                [p0[0],p0[1],0], // 0
                [p1[0],p1[1],0], // 1
                [p1[0],p1[1],hgt0], // 2
                [p0[0],p0[1],hgt0], // 3
                [p4[0],p4[1],0], // 4
                [p5[0],p5[1],0], // 5
                [p5[0],p5[1],hgt1], // 6
                [p4[0],p4[1],hgt1], // 7
              ],
              triangles = triangles,
              convexity = 2
            );
          }
        }
      }
    } }
  }
}

module BezArc(ctlPts, focalPoint, steps=12, height = 1, heightCtls = [], showCtlR = 1)
{
  if (showCtlR > 0) {
    for (pt = ctlPts) {
      % translate([pt[0], pt[1], 0]) circle(showCtlR);
    }
  }
  triangles = [
    [0,2,1],
    [3,4,5],
    [1,5,4],
    [2,5,1],
    [0,1,4],
    [0,4,3],
    [0,5,2],
    [0,3,5],
    ];
  for(step = [steps-1 : 1])
  {
    assign(
      t1 = step/(steps-1), 
      t0 = (step-1)/(steps-1),
      fp = [focalPoint[0], focalPoint[1], len(heightCtls) > 0 ? BezI(0, heightCtls) : height]
    ) {
    assign(
      hgt0 = len(heightCtls) > 0 ? BezI(t0, heightCtls) : height,
      hgt1 = len(heightCtls) > 0 ? BezI(t1, heightCtls) : height,
      p0 = PointAlongBez(t0, ctlPts), 
      p1 = PointAlongBez(t1, ctlPts)
    ) {
      if (hgt0 == 0 && hgt1 == 0 ) {
        polygon([ focalPoint, p0, p1 ]);
      } else if (hgt0 == hgt1 || false) {
        linear_extrude(height = hgt0, convexity = 2) polygon([ focalPoint, p0, p1 ]);
      } else {
        polyhedron( // not manifold
          points = [
            [focalPoint[0], focalPoint[1], 0],  // 0
            [p1[0], p1[1], 0],                  // 1
            [p0[0], p0[1], 0],                  // 2
            [focalPoint[0], focalPoint[1], hgt0], // 3
            [p1[0], p1[1], hgt1],               // 4
            [p0[0], p0[1], hgt0],               // 5
            [focalPoint[0], focalPoint[1], hgt1], // 6
          ],
          triangles = triangles,
          convexity = 2
        );
      }
    } }
  }
}
function PointAlongBez(t, ctlPts) = 
  len(ctlPts) == 1 ? PointAlongBez1(t, ctlPts) : 
  len(ctlPts) == 2 ? PointAlongBez2(t, ctlPts) : 
  len(ctlPts) == 3 ? PointAlongBez3(t, ctlPts) : 
  len(ctlPts) == 4 ? PointAlongBez4(t, ctlPts) : 
  len(ctlPts) == 5 ? PointAlongBez5(t, ctlPts) : 
  len(ctlPts) == 6 ? PointAlongBez6(t, ctlPts) : 
  len(ctlPts) == 7 ? PointAlongBez7(t, ctlPts) : 
  len(ctlPts) == 8 ? PointAlongBez8(t, ctlPts) :
  [];

function BezI(t, ctls) = 
  len(ctls) == 1 ? BezI1(t, ctls) : 
  len(ctls) == 2 ? BezI2(t, ctls) : 
  len(ctls) == 3 ? BezI3(t, ctls) : 
  len(ctls) == 4 ? BezI4(t, ctls) : 
  len(ctls) == 5 ? BezI5(t, ctls) : 
  len(ctls) == 6 ? BezI6(t, ctls) : 
  len(ctls) == 7 ? BezI7(t, ctls) : 
  len(ctls) == 8 ? BezI8(t, ctls) :
  [];

function PointAlongBez1(t, ctlPts) = [ 
  BezI1(t, [ctlPts[0][0]]), 
  BezI1(t, [ctlPts[0][1]]) 
];
function PointAlongBez2(t, ctlPts) = [ 
  BezI2(t, [ctlPts[0][0], ctlPts[1][0]]), 
  BezI2(t, [ctlPts[0][1], ctlPts[1][1]]) 
];
function PointAlongBez3(t, ctlPts) = [ 
  BezI3(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0]]), 
  BezI3(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1]]) 
];
function PointAlongBez4(t, ctlPts) = [ 
  BezI4(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0]]), 
  BezI4(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1]]) 
];
function PointAlongBez5(t, ctlPts) = [ 
  BezI5(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0]]), 
  BezI5(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1]]) 
];
function PointAlongBez6(t, ctlPts) = [ 
  BezI6(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0], ctlPts[5][0]]), 
  BezI6(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1], ctlPts[5][1]]) 
];
function PointAlongBez7(t, ctlPts) = [ 
  BezI7(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0], ctlPts[5][0], ctlPts[6][0]]), 
  BezI7(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1], ctlPts[5][1], ctlPts[6][1]]) 
];
function PointAlongBez8(t, ctlPts) = [ 
  BezI8(t, [ctlPts[0][0], ctlPts[1][0], ctlPts[2][0], ctlPts[3][0], ctlPts[4][0], ctlPts[5][0], ctlPts[6][0], ctlPts[7][0]]), 
  BezI8(t, [ctlPts[0][1], ctlPts[1][1], ctlPts[2][1], ctlPts[3][1], ctlPts[4][1], ctlPts[5][1], ctlPts[6][1], ctlPts[7][1]]) 
];

function PerpAlongBez(t, ctlPts, dist = 1, hodograph = []) = 
  len(ctlPts) == 2 ? PerpAlongBez2(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 3 ? PerpAlongBez3(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 4 ? PerpAlongBez4(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 5 ? PerpAlongBez5(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 6 ? PerpAlongBez6(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 7 ? PerpAlongBez7(t, ctlPts, dist, hodograph) : 
  len(ctlPts) == 8 ? PerpAlongBez8(t, ctlPts, dist, hodograph) :
  [];

function PerpAlongBez2(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez2(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez1( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez3(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez3(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez2( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez4(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez4(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez3( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez5(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez5(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez4( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez6(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez6(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez5( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez7(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez7(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez6( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );

function PerpAlongBez8(t, ctlPts, dist = 1, hodograph = []) = 
  pSum( 
    PointAlongBez8(t, ctlPts), 
    rot90cw( 
      normalize( 
        PointAlongBez7( t, (len(hodograph) > 1) ? hodograph : hodograph(ctlPts) ),
        dist 
      ) 
    )
  );


function hodograph(p) = 
  len(p) == 2 ? 
    [ pDiff(p[1], p[0]) ] :  
  len(p) == 3 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]) ] :  
  len(p) == 4 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]) ] :  
  len(p) == 5 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]) ] :  
  len(p) == 6 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]), pDiff(p[5], p[4]) ] :  
  len(p) == 7 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]), pDiff(p[5], p[4]), pDiff(p[6], p[5]) ] :  
  len(p) == 8 ? 
    [ pDiff(p[1], p[0]), pDiff(p[2], p[1]), pDiff(p[3], p[2]), pDiff(p[4], p[3]), pDiff(p[5], p[4]), pDiff(p[6], p[5]), pDiff(p[7], p[6]) ] : 
  [];

function BezI1(t, ctls) =
  (ctls[0])
  ;

function BezI2(t, ctls) =
  ((1-t) * ctls[0]) +
  (t * ctls[1])
  ;

function BezI3(t, ctls) =
  (pow(1-t, 2) * ctls[0]) +
  (2 * t * (1-t) * ctls[1]) +
  (pow(t, 2) * ctls[2])
  ;

function BezI4(t, ctls) =
  (pow(1-t, 3) * ctls[0]) +
  (3 * t * pow(1-t, 2) * ctls[1]) +
  (3 * pow(t, 2) * (1-t) * ctls[2]) +
  (pow(t, 3) * ctls[3])
  ;

function BezI5(t, ctls) =
  (pow(1-t, 4) * ctls[0]) +
  (4 * t * pow(1-t, 3) * ctls[1]) +
  (6 * pow(t, 2) * pow(1-t, 2) * ctls[2]) +
  (4 * pow(t, 3) * (1-t) * ctls[3]) +
  (pow(t, 4) * ctls[4])
  ;

function BezI6(t, ctls) =
  (pow(1-t, 5) * ctls[0]) +
  (5 * t * pow(1-t, 4) * ctls[1]) +
  (10 * pow(t, 2) * pow(1-t, 3) * ctls[2]) +
  (10 * pow(t, 3) * pow(1-t, 2) * ctls[3]) +
  (5 * pow(t, 4) * (1-t) * ctls[4]) +
  (pow(t, 5) * ctls[5])
  ;

function BezI7(t, ctls) =
  (pow(1-t, 6) * ctls[0]) +
  (6 * t * pow(1-t, 5) * ctls[1]) +
  (15 * pow(t, 2) * pow(1-t, 4) * ctls[2]) +
  (20 * pow(t, 3) * pow(1-t, 3) * ctls[3]) +
  (15 * pow(t, 4) * pow(1-t, 2) * ctls[4]) +
  (6 * pow(t, 5) * (1-t) * ctls[5]) +
  (pow(t, 6) * ctls[6])
  ;

function BezI8(t, ctls) =
  (pow(1-t, 7) * ctls[0]) +
  (7 * t * pow(1-t, 6) * ctls[1]) +
  (21 * pow(t, 2) * pow(1-t, 5) * ctls[2]) +
  (35 * pow(t, 3) * pow(1-t, 4) * ctls[3]) +
  (35 * pow(t, 4) * pow(1-t, 3) * ctls[4]) +
  (21 * pow(t, 5) * pow(1-t, 2) * ctls[5]) +
  (7 * pow(t, 6) * (1-t) * ctls[6]) +
  (pow(t, 7) * ctls[7])
  ;

function x(p) = p[0];
function y(p) = p[1];
function dx(p1, p2) = x(p1) - x(p2);
function dy(p1, p2) = y(p1) - y(p2);
function sx(p1, p2) = x(p1) + x(p2);
function sy(p1, p2) = y(p1) + y(p2);

function dist(p1, p2 = [0,0]) = sqrt( pow( dx(p1,p2), 2) + pow( dy(p1,p2), 2) );
function normalize(p, n = 1) = pScale( p, n / dist( p ) );

function pSum(p1, p2) = [sx(p1, p2), sy(p1, p2)];
function pDiff(p1, p2) = [dx(p1, p2), dy(p1, p2)];
function pScale(p, v) = [x(p)*v, y(p)*v];

function rot90cw(p) = [y(p), -x(p)];
function rot90ccw(p) = [-y(p), x(p)];
function rot(p, a) = [
  x(p) * cos(a) - y(p) * sin(a),
  x(p) * sin(a) - y(p) * cos(a),
];
function rotAbout(p1, p2, a) = pSum(rot(pDiff(p1, p2), a), p2); // rotate p1 about p2









