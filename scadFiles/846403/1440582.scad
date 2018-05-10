/*
Name: OpenSCAD model of a customizable direct drive extruder 1.75mm/3mm with J-Head/E3D/Bowden mount (V1.2)
Author: Jons Collasius from Germany/Hamburg

License: CC BY-NC-SA 4.0
License URL: https://creativecommons.org/licenses/by-nc-sa/4.0/
*/

/* [Global] */
// ######## global variables ########
// resolution of any round object (segment length, lower = more details)
fnr 						= 0.4;
// width of a single wall, should match your slicer settings
extrusion_width 			= 0.6;	
// how many lines should a normal wall have (i.e. 0.6(extrusion_width)*6(normal_wall_factor)= 3.6mm wall width)
normal_wall_factor 			= 4;	
// how many lines should a thick wall have
thick_wall_factor 			= 6;		
// diameter of your filament. 3mm works fine with large nozzels (>=1mm diameter)
filament_d 					= 1.75;	// [1.75:1.75mm, 3:3mm]
// diameter of the hobbed section of your hobbed bolt. measure this as precisley as possible.
gear_d 						= 7.34;	
// the alignment of the motor (seen from the front of the printer)
motor_alignment				= 0; //[0:motor on the right side,1:motor on the left side]
// would you like to create a mount for a press fit bowden adapter?
bowden_mount				= 1; //[0:no - without bowden mount,1:yes - with bowden mount]
// would you like to use a bowden adapter instead of a hotend (make a bowden extruder)
bowden_extruder				= 0; //[0:no - without bowden mount,1:yes - with bowden mount]
// outer diameter of your bowden tubing
bowden_d 					= 4.5;	
// outer diameter of the threaded section of your bowden coupling 
bowden_coupling_thread_d	= 9.75;	
// hight of the threaded section of your bowden coupling 
bowden_coupling_thread_h	= 10;		
// mounting hole distance (should match the distance on your carriage)
mounthole_dist				= 20;		
// diameter of the bearing of the lever
bearing_d 					= 16;		
// hight of the bearing of the lever
bearing_h 					= 5;		
// center bore diameter of the bearing of the lever
bearing_bore_d 				= 5;		
// diameter of the appropriate washer for the bearing axle. this washer isn't used and only needed for calculations.
bearing_washer_d 			= 10;		

/* [Hidden] */
// [screw_r, screw_head_r, screw_head_h, name]
screw_m3	= [1.6,		2.84,	3,		"screw M3"];
// [nut_r(biggest side), nut_d(smalles side), nut_h, name]
nut_m3		= [3.04,	5.5,	2.4,	"nut M3 DIN 934/ISO 4033/ISO 8673"];
// [washer_r, washer_h, washer_inner_r, name]
washer_m3	= [3.5,		0.5,	1.6,	"washer M3 DIN 125 A/ISO 7089"];
// [width, screw offset, screw_r, core_r, body_hight, axis_length, name]
nema17 		= [42.3,	15.5,	screw_m3[0],	11.20,	40,	24,	"NEMA 17 stepper motors"];

fan_titan_tfd_b5015_h = 14.77;

// ######## calculated variables ########
filament_r 					= filament_d/2;	
gear_r 						= gear_d/2;	
bearing_r 					= bearing_d/2;		
bearing_bore_r 				= bearing_bore_d/2;		
bearing_washer_r 			= bearing_washer_d/2;		
bowden_r 					= bowden_d/2;	
bowden_coupling_thread_r	= bowden_coupling_thread_d/2;	
wall_width 					= extrusion_width*normal_wall_factor;
thickwall_width 			= extrusion_width*thick_wall_factor;
lever_width 				= nema17[5]-wall_width*2;

// ######## calculated variables ########
print_part();

// #####################################################################################################################################
module print_part() {
	mirror([0,motor_alignment,0]) {
		rotate([0,-90,0]) translate([0,0,0]) extruder();
		translate([0,-nema17[0]/2-lever_width-1-wall_width,nema17[0]/2]) rotate([-90,0,90]) lever();
		%translate([0,0,0]) rotate([180,0,0]) bom();
		%rotate([0,-90,0]) lever();
	}
}

// #####################################################################################################################################
module extruder() {
	difference() {
		union() {
			// main body
			rotate([0,90,0]) linear_extrude(height=nema17[5]) polygon(points=[[-15.5,-21.15],[-21.15,-15.5],[-21.15,15.5],[-15.5,21.15],[15.5,21.15],[21.15,15.5],[21.15,-15.5],[15.5,-21.15]]);
			// bottom round lever corner
			translate([0,nema17[1],-nema17[1]]) rotate([0,90,0]) fncylinder(r=nema17[0]/2-nema17[1], h=nema17[5]);
			if(bowden_mount) {
				// top bowden coupling mount
				translate([nema17[5]/2,gear_r+filament_r,nema17[0]/2-1]) fncylinder(r=bowden_coupling_thread_r+wall_width, h=bowden_coupling_thread_h+1);
			}
			if(bowden_extruder) {
				// bottom bowden coupling mount
				translate([nema17[5]/2,gear_r+filament_r,-nema17[0]/2-bowden_coupling_thread_h+1]) fncylinder(r=bowden_coupling_thread_r+wall_width, h=bowden_coupling_thread_h+1);
			} else {
				// bottom j-head mount
				translate([0,gear_r+filament_r,-nema17[0]/2-13-2]) centercube([nema17[5]/2,12+screw_m3[0]*2+washer_m3[0]*2,13+3],y=true);
				// bottom j-head mount top
				translate([0,gear_r+filament_r-(12+screw_m3[0]*2+washer_m3[0]*2)-1,-nema17[0]/2-13-2]) centercube([nema17[5]/2-1,12+screw_m3[0]*2+washer_m3[0]*2,13+1],y=true);
			}
			// carriage mounting
			for(i=[0,1]) translate([wall_width+washer_m3[0]+i*mounthole_dist,-nema17[0]/2+thickwall_width,0]) rotate([90,0,0]) fncylinder(r=wall_width+washer_m3[0], h=thickwall_width);
			translate([wall_width+washer_m3[0],-nema17[0]/2,0]) centercube([mounthole_dist,thickwall_width,(wall_width+washer_m3[0])*2],z=true);	
		}
		// nema17 mounting holes		
		rotate([0,90,0]) for(i=[0:2]) rotate([0,0,i*90-180]) translate([nema17[1],nema17[1],0]) fncylinder(r=nema17[2],h=nema17[5],enlarge=1);
		// center hole
		difference() {
			rotate([0,90,0]) fncylinder(r=pyth(a=nema17[1],b=nema17[1])-thickwall_width-screw_m3[0],h=nema17[5],enlarge=1);	
			difference() {
				translate([-1,gear_r+filament_r-wall_width,nema17[1]]) centercube([nema17[5]+2,nut_m3[2]+1+wall_width*2,nut_m3[1]+wall_width*2],z=true);
				rotate([0,90,0]) fncylinder(r=nema17[3],h=nema17[5],enlarge=1);	
			}
			if(bowden_extruder) translate([nema17[5]/2,gear_r+filament_r,0]) rotate([0,180,0]) fncylinder(r=filament_r+wall_width,h=nema17[0]);	
		}
		// filament hole
		translate([nema17[5]/2,gear_r+filament_r,0]) rotate([0,0,0]) fncylinder(r=filament_r+0.25,h=nema17[0]*2,center=true);	
		// bottom bowden hole
		if(bowden_extruder == 0) translate([nema17[5]/2,gear_r+filament_r,0]) rotate([0,180,0]) fncylinder(r=bowden_r,h=nema17[0]);	
		// lever cutout bottom cylinder
		translate([-1,nema17[1],-nema17[1]]) rotate([0,90,0]) fncylinder(r=nema17[0]/2-nema17[1]+1, h=lever_width+wall_width+1.25);
		difference() {
			// lever cutout center
			translate([-1,0,0]) centercube([lever_width+wall_width+1.25,nema17[0]/2+1,bearing_r*2+2], z=true);
			if(bowden_extruder) translate([nema17[5]/2,gear_r+filament_r,-gear_r]) rotate([0,180,0]) fncylinder(r=filament_r+wall_width,h=nema17[0]);	
		}
		// lever cutout, rotated 2°
		orotate([2,0,0],[0,nema17[1],-nema17[1]]) translate([-1,nema17[1]-1,0]) centercube([lever_width+wall_width+1.25,nema17[0]/2+1,nema17[0]+2], z=true);
		// lever fastener screw holes
		for(i=[-1,1]) translate([nema17[5]/2+i*(lever_width/2-4),nema17[0]/2,nema17[1]]) rotate([90,0,0]) fncylinder(r=screw_m3[0], h=nema17[0]/2+nema17[1]-wall_width-screw_m3[0]);
		// lever fastener nut hole
		translate([-1,gear_r+filament_r,nema17[1]]) centercube([nema17[5]+2,nut_m3[2]+1,nut_m3[1]],z=true);
		// top bowden coupling mount hole
		translate([nema17[5]/2,gear_r+filament_r,nema17[0]/2]) fncylinder(r=bowden_coupling_thread_r, h=bowden_coupling_thread_h+1);
		if(bowden_extruder) {
			translate([nema17[5]/2,gear_r+filament_r,-nema17[0]/2-bowden_coupling_thread_h-1]) fncylinder(r=bowden_coupling_thread_r, h=bowden_coupling_thread_h+1);
			translate([lever_width/2+wall_width,gear_r+filament_r*2+bearing_r,0]) rotate([0,90,0]) fncylinder(r=bearing_r+1, h=lever_width, center=true);
			rotate([180,90,0]) translate([0,0,-nema17[5]/2]) fncylinder(r=gear_r+1, h=lever_width, center=true);
		} else {
			// bottom j-head mount
			translate([nema17[5]/2,gear_r+filament_r,-nema17[0]/2-14-2]) fncylinder(r=16/2,h=13+2);
			translate([nema17[5]/2,gear_r+filament_r,-nema17[0]/2-14-1]) fncylinder(r=4,h=13+2);
			// bottom j-head mount screw holes
			for(i=[-1,1]) translate([0,gear_r+filament_r+i*(6+screw_m3[0]),-nema17[0]/2-14+5.5-1]) rotate([0,90,0]) fncylinder(r=screw_m3[0], h=nema17[5]/2,enlarge=1);
			// bottom j-head mount top
			translate([nema17[5]/2,gear_r+filament_r-(12+screw_m3[0]*2+washer_m3[0]*2)-1,-nema17[0]/2-14-2]) {
				translate([0,0,0]) fncylinder(r=16/2,h=4);
				translate([0,0,0]) fncylinder(r=12/2,h=10);
				translate([0,0,9]) fncylinder(r=16/2,h=6.5);
			}
			// bottom j-head mount top screw holes
			for(i=[-1,1]) translate([0,gear_r+filament_r+i*(6+screw_m3[0])-(12+screw_m3[0]*2+washer_m3[0]*2)-1,-nema17[0]/2-14+5.5-1]) rotate([0,90,0])
				fncylinder(r=screw_m3[0], h=nema17[5]/2,enlarge=1);
		}
		// carriage mounting screw holes
		for(i=[0,1]) translate([wall_width+washer_m3[0]+i*mounthole_dist,0,0]) rotate([90,0,0]) fncylinder(r=screw_m3[0], h=nema17[0]/2+1);
		// carriage mounting washer holes
		for(i=[0,1]) translate([wall_width+washer_m3[0]+i*mounthole_dist,0,0]) rotate([90,0,0]) fncylinder(r=washer_m3[0]+0.5, h=nema17[0]/2-thickwall_width);
	}
} 

// #####################################################################################################################################
module lever() {
	difference() {
		union() {
			// main lever body
			translate([0,nema17[1],-nema17[0]/2+(nema17[0]/2-nema17[1])]) cube([lever_width+wall_width,nema17[0]/2-nema17[1],nema17[0]-(nema17[0]/2-nema17[1])]);
			// lever mouning post
			translate([0,nema17[1],-nema17[1]]) rotate([0,90,0]) fncylinder(r=nema17[0]/2-nema17[1], h=lever_width+wall_width);
			// bearing post
			translate([wall_width,gear_r+filament_r*2+bearing_r,0]) rotate([0,90,0]) fncylinder(r=bearing_washer_r, h=lever_width);
			translate([wall_width,gear_r+filament_r*2+bearing_r,-bearing_washer_r]) cube([lever_width,nema17[0]/2-(gear_r+filament_r*2+bearing_r),bearing_washer_r*2]);
		}
		// center cutout
		translate([wall_width,0,0]) difference() {
			translate([lever_width/2,0,0]) cube([bearing_h+2,nema17[0]+2,bearing_r*2+2], center=true);
			for(i=[-1,1]) translate([lever_width/2,gear_r+filament_r*2+bearing_r,0]) rotate([0,i*90,0])
				translate([0,0,bearing_h/2]) fncylinder(r=bearing_bore_r+1.3, r2=bearing_washer_r, h=1,enlarge=0.05);
		}
		// bearing mounting holes
		translate([wall_width,gear_r+filament_r*2+bearing_r,0]) rotate([0,90,0]) fncylinder(r=bearing_bore_r-0.15, h=lever_width,enlarge=1);
		// lever mouning post hole
		translate([0,nema17[1],-nema17[1]]) rotate([0,90,0]) fncylinder(r=screw_m3[0], h=lever_width+wall_width,enlarge=1);
		// tensioner cutouts
		for(i=[-1,1]) {
			translate([lever_width/2+wall_width+i*(lever_width/2-4),nema17[0]/2,nema17[1]]) {
				rotate([90,0,0]) fncylinder(r=screw_m3[0], h=nema17[0]/2-nema17[1],enlarge=1);
				translate([0,1,0]) rotate([90,0,0]) centercube([screw_m3[0]*2,nema17[0]/2-nema17[1]+1,nema17[0]/2-nema17[1]+2],x=true);
			}
		}
	}
	// the bearing
	%translate([lever_width/2+wall_width,gear_r+filament_r*2+bearing_r,0]) rotate([0,90,0]) fncylinder(r=bearing_r, h=bearing_h, center=true);
}

// #####################################################################################################################################
// motor, filament and gear
module bom() {
	// nema17 main body with screw holes
	linear_extrude(height=nema17[4]) polygon(points=[[-15.5,-21.15],[-21.15,-15.5],[-21.15,15.5],[-15.5,21.15],[15.5,21.15],[21.15,15.5],[21.15,-15.5],[15.5,-21.15]]);
	// nema17 axis
	translate([0,0,-nema17[5]]) fncylinder(r=2.5,h=nema17[5]);
	// nema17 center cylinder
	translate([0,0,-2]) fncylinder(r=nema17[3],h=2);
	// filament
	translate([0,-gear_r-filament_r,-nema17[5]/2]) rotate([0,90,0]) fncylinder(r=filament_r,h=nema17[0]*2,center=true);
	// filament gear
	translate([0,0,-nema17[5]/2]) rotate([0,0,0]) fncylinder(r=gear_r, h=bearing_h*2, center=true);
}

// #####################################################################################################################################
// a rewritten cylinder, with enlarge and dynamic fn
module fncylinder(r,r2,h,fn,center=false,enlarge=0){
	translate(center==false?[0,0,-enlarge]:[0,0,-h/2-enlarge]) {
		if (fn==undef) {
			if (r2==undef) {
				cylinder(r=r,h=h+enlarge*2,$fn=floor(2*r*3.14/fnr));
			} else {
				cylinder(r=r,r2=r2,h=h+enlarge*2,$fn=floor(2*r*3.14/fnr));
			}
		} else {
			if (r2==undef) {
				cylinder(r=r,h=h+enlarge*2,$fn=fn);
			} else {
				cylinder(r=r,r2=r2,h=h+enlarge*2,$fn=fn);
			}
		}
	}
}

// #####################################################################################################################################
// rotate the object from a different center
module orotate(rotate,offset) {
	translate(offset) rotate(rotate) translate(-offset) children();
}

// #####################################################################################################################################
// this cube can be centered on any axis
module centercube(xyz=[10,10,10],x=false,y=false,z=false) {
	translate([x==true?-xyz[0]/2:0,y==true?-xyz[1]/2:0,z==true?-xyz[2]/2:0]) cube(xyz);
}
// #####################################################################################################################################
// pythagoras yeah!
function pyth(a,b,c)			=(a==undef)?sqrt(pow(c,2)-pow(b,2)):(b==undef)?sqrt(pow(c,2)-pow(a,2)):(c==undef)?sqrt(pow(a,2)+pow(b,2)):undef;

