use <write/Write.scad>

// preview[view:west, tilt:side]

/* [Text] */
text_string = "Rocket!";
text_height = 11;//[0:100]
text_font = "write/orbitron.dxf"; //[write/Letters.dxf, write/BlackRose.dxf, write/orbitron.dxf, write/knewave.dxf, write/braille.dxf]
text_horizontal_offset = 5; //[-50:50]
text_vertical_offset = 0; //[-10:10]
text_direction = 1; //[1:forward,-1:reverse]
// diameter of holiday light body

/* [Misc] */
light_diameter = 8.5;
part = 0; //[0:body, 1:text]

/* [Hidden] */

/* illuminated rocket xmas tree ornament
by Rocket hacker (Andy Soukup)

derived from
http://www.thingiverse.com/thing:37750/#remixes
Gian Pablo Villamil
December 2012

all dimensions in mm

*/

module loop() {
	rotate([0,90,0]) difference() {
		cylinder(r=3,h=2,center=true,$fn=16);
		cylinder(r=1.5,h=3,center=true,$fn=16);
	}
}

module fin(span, sweep, root, tip){
	intersection() {
		scale([0.3,1,1]) rotate([sweep+90,0,0])	cylinder(r1=root/2,r2=tip/2,h=span);
		cylinder(r=20,h=80,center=true);
	}
}

module hull_profile(hull_profile_rad,hull_profile_len) {
	hull_truncfactor = .79; //smaller makes bottom bigger
	hull_lenfactor = 2; //smaller is rounder

	hull_sqr_x = hull_profile_rad;
	hull_sqr_y = hull_profile_len / (hull_truncfactor * hull_lenfactor*2);
	hull_cir_rad = (pow(hull_sqr_y,2)+pow(hull_sqr_x,2))/(2*hull_sqr_x);
	hull_cir_dx = hull_cir_rad - hull_sqr_x;
	hull_sqr_dy = (hull_truncfactor-0.5)*hull_sqr_y*2;

	translate([0,hull_sqr_dy*hull_lenfactor]){
		scale([1,hull_lenfactor]) intersection() {
			translate([-hull_cir_dx,0]) circle(r=hull_cir_rad,$fn=64);
			translate([0,-hull_sqr_dy]) square([hull_cir_rad+1,hull_sqr_y*2]);
		}
	}
}

module pod_profile() {
	scale([1,2]) translate([-10,0])	difference() {
		translate([0,0]) circle(r=15,$fn=64);
		translate([-20,-20]) square([30,40]);
		translate([10,-20])	square([10,20]);
	}
}

module pod() {
	difference(){
		union(){
			rotate_extrude(convexity=10,$fn=32)	pod_profile();
			sphere(5,$fn=32);
		}
		//translate([0,0,-10+2])cube([10,10,10],center=true); //truncate bottom
	}
}

module pod_fin() {
	union(){
		rotate([0,0,90]) fin(40,45,20,10);
		translate([20,0,-31.5]) pod();
		difference(){ //fin support
			translate([8.5,-0.5,-38]) cube([5.5,1,25]);
			translate([0,0,-0.2]) rotate([0,0,90]) fin(40,45,20,10);
		}
	}
}

module hull(hull_rotated_profile_rad, hull_retated_profile_len) {
	rotate_extrude(convexity=10,$fn=64) hull_profile(hull_rotated_profile_rad, hull_retated_profile_len);
}

module ornament_light_hole(measured_light_diameter = 8.5){
	light_dia = measured_light_diameter+1; //measured + clearance
	light_hole_height = 10; //decided value
	light_hole_taper = 1.25; //diameter change of hole
	light_hole_thickness = 1.5; //wall thickness
	light_hole_wing_num = 3; //number of slits
	light_hole_r1 = (light_dia + light_hole_taper/2)/2; //the larger radius
	light_hole_r2 = (light_dia - light_hole_taper/2)/2; //the smaller radius
	light_hole_lip_width = 1; //this lip stops the light from going in too far

	difference() { 		
		cylinder (h = light_hole_height+light_hole_thickness, r1 = light_hole_r1+light_hole_thickness, r2 = light_hole_r2+light_hole_thickness);
		translate([0,0,-0.01]) cylinder (h = light_hole_height+0.01, r1 = light_hole_r1, r2 = light_hole_r2,$fn=64);
		cylinder (h = light_hole_height*2,r=light_hole_r2-light_hole_lip_width);
		for ( light_hole_wing_id = [0 : light_hole_wing_num]) {
			rotate([0,0,light_hole_wing_id*360/light_hole_wing_num])translate([-light_hole_thickness/2,0,light_hole_thickness*2]) cube (size = [light_hole_thickness, light_hole_r1+light_hole_thickness, light_hole_height]);
		}
	}
}

module assembly(assembly_light_dia) {
	hull_dz = -30;
	hull_len = 82.5;
	hull_rad = 10.5;
	hull_shell_thickness = 1;
	light_hole_dia = 11;

	union(){
		difference() {
			union(){
				translate([0,0,hull_dz]) hull(hull_rad,hull_len);
				translate([0,0,-10]) for (i=[0:2]){
					rotate([0,0,i*120])	pod_fin();
				}
				translate([0,10,-6]) loop(); //ornament hanging loop
			}
			translate([0,0,hull_shell_thickness+hull_dz]) hull(hull_rad-hull_shell_thickness,hull_len-2.1*hull_shell_thickness);
			translate([0,0,-hull_shell_thickness+hull_dz]) cylinder(h = hull_shell_thickness*3,r = light_hole_dia/2);
			translate([0,0,-49+2]) cylinder (h = 5, r = 25, center = true);
		}
		translate([0,0,hull_dz])ornament_light_hole(assembly_light_dia);
	}
}


module rocket_named(rocket_text_string = "Rocket!", rocket_text_height = 11,rocket_text_font = "write/orbitron.dxf",rocket_text_horizontal_offset = 8,rocket_text_vertical_offset = 0,rocket_text_direction = 1,rocket_light_diameter = 8.5,rocket_part = 0){
	if ( rocket_part == 0) {
	//module rocket_ornament_body(){
		difference(){
			mirror([(rocket_text_direction-1)/-2,0,0]) assembly(rocket_light_diameter);
			//mirror([(rocket_text_direction-1)/-2,0,0]) import("rocket_ornament_illuminated.stl");
			difference(){
				translate([rocket_text_direction*-11,rocket_text_vertical_offset,rocket_text_horizontal_offset]) rotate([0,rocket_text_direction*-90,0]) write(rocket_text_string,t=22,h=rocket_text_height,center=true,font = rocket_text_font);
				translate([0,0,-30])cylinder (h = 15, r = 13/2); //this is to stop the text from cutting off the light holder
			}
		}
	} else {
	//module rocket_ornament_text(){
		intersection(){
			mirror([(rocket_text_direction-1)/-2,0,0]) assembly(rocket_light_diameter);
			//mirror([(rocket_text_direction-1)/-2,0,0]) import("rocket_ornament_illuminated.stl");
			difference(){
				translate([rocket_text_direction*-11,rocket_text_vertical_offset,rocket_text_horizontal_offset]) rotate([0,rocket_text_direction*-90,0]) write(rocket_text_string,t=22,h=rocket_text_height,center=true,font = rocket_text_font);
				translate([0,0,-30])cylinder (h = 15, r = 13/2); //this is to stop the text from cutting off the light holder
			}
		}
	}
}

rocket_named(rocket_text_string = text_string, rocket_text_height = text_height,rocket_text_font = text_font,rocket_text_horizontal_offset = text_horizontal_offset,rocket_text_vertical_offset = text_vertical_offset,rocket_text_direction = text_direction,rocket_light_diameter = light_diameter,rocket_part = part);


//pod_fin();