/* [Global] */
//Select type of joint
type = 1; // [1:Type 1, 2:Type 2]
// select your machine's tolerance
tolerance = 0.1;
//minimum material around rods
walls = 2.5;
//diameter of vertical rod
rod_1_diameter = 4;
//shape of rod 1
shape_1 = 0; // [0:Round, 1:Square]
//diameter of horizontal rod
rod_2_diameter = 6;

/* [Type 1] */
//shape of rod 2
shape_2 = 1; // [0:Round, 1:Square]
//enable or disable minimum distance between rods (min = walls + rod_1_radius + rod_2_radius + tolerance)
minimum_distance = 0; // [0:False, 1:True]
//distance between rods, applicable if you disable minimum distance
rods_distance = 15;

/* [Type 2] */
//rod 2 length inside plastic
rod_2_length = 10;
//put 0 to disable nut
nut_thickness = 2.5;
//put 0 to disable nut and increase distance between rods using nut thickness parameter 
nut_length = 8;

/* [Hidden] */
$fn=100;
rod_1_d = rod_1_diameter + tolerance;
rod_2_d = rod_2_diameter + tolerance;
rod_1_height = rod_2_d + walls*2;
rod_2_height = rod_1_d + walls*2;
nut_thick = nut_thickness + tolerance;
nut_len = nut_length +tolerance;

if (type == 1){
	if (((rods_distance < (walls + (rod_1_d+rod_2_d)/2)) || (minimum_distance == 1 ))){
		rod1(rod_2_height);
		rod2((walls + (rod_1_d+rod_2_d)/2));
	}
	else{
		rod1(rod_2_height);
		rod2(rods_distance);
	}
}

if (type == 2){
	if (rod_2_height < nut_len + walls*2){
		rod1(nut_len + walls*2);
		rod2(rods_distance, nut_len + walls*2);
	}
	else{
		rod1(rod_2_height);
		rod2(rods_distance,rod_2_height);
	}
}

module rod1(cyl_1_d){
	if (type == 1){
		difference(){
			union(){
				translate([0,-(rod_2_height)/2,0])cube([rod_1_d/2+walls,rod_2_height,rod_1_height]);
				cylinder(d=rod_2_height,h=rod_1_height);
				if (shape_1 == 1){translate([-(rod_1_d/2+walls),-(rod_2_height)/2,0])cube([rod_2_height/2,rod_2_height,rod_1_height]);}
			}
			translate([0,0,-100])cylinder(d=rod_1_d,h=rod_1_height+200);
		}
	}
	else{
		difference(){
			union(){
				translate([0,-(cyl_1_d)/2,0])cube([cyl_1_d/2,cyl_1_d,rod_1_height]);
				cylinder(d=cyl_1_d,h=rod_1_height);
				if (shape_1 == 1){translate([-cyl_1_d/2,-cyl_1_d/2,0])cube([cyl_1_d/2,cyl_1_d,rod_1_height]);}
			}
			translate([0,0,-100])cylinder(d=rod_1_d,h=rod_1_height+200);
		}
	}
}

module rod2 (rods_dist, cyl_1_d){
	if (type == 1){
		echo("minimum rods distance", (walls + (rod_1_d+rod_2_d)/2));
		echo("rods distance:", rods_dist);
		difference(){
			union(){
				translate([rod_1_d/2,-rod_2_height/2,0])cube([rods_dist-rod_1_d/2,rod_2_height,rod_1_height]);
				translate([rods_dist,-rod_2_height/2,rod_1_height/2])rotate([270,0,0])cylinder(d=rod_2_d+walls*2,h=rod_2_height);
				if (shape_2 == 1){translate([rods_dist,-rod_2_height/2,0])cube([rod_1_height/2,rod_2_height,rod_1_height]);}
			}
			translate([rods_dist,-rod_2_height/2-100,rod_1_height/2])rotate([270,0,0])cylinder(d=rod_2_d,h=rod_2_height+200);
		}
	}
	else{
		difference(){
			translate([cyl_1_d/2,-cyl_1_d/2,0])cube([nut_thick,cyl_1_d,rod_1_height]);
			translate([cyl_1_d/2,-nut_len/2,-1])cube([nut_thick+1,nut_len,rod_1_height+2]);
		}
		difference(){
			translate([cyl_1_d/2+nut_thick,-cyl_1_d/2,0])cube([rod_2_length,cyl_1_d,rod_1_height]);
			translate([cyl_1_d/2+nut_thick-1,0,rod_1_height/2])rotate([0,90,0])cylinder(d=rod_2_d, h=rod_2_length+2);
		}
	}
}