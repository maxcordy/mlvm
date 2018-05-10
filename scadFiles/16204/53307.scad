cube_x=65;
cube_y=45;
cube_z=10;
rd=5;

slot_x=59;
slot_y=10;
slot_z=10;



module rectangle_round(cube_x,cube_y,cube_z){
	union(){
		//round coners
		intersection(){
			cube(cube_x,cube_y,cube_z);
			translate([rd,rd,cube_z/2]) #round_corner(cube_x,cube_y,cube_z);
		}
		intersection(){
			cube(cube_x,cube_y,cube_z);
			translate([cube_x-rd,rd,cube_z/2]) #round_corner(cube_x,cube_y,cube_z);
		}
		intersection(){
			cube(cube_x,cube_y,cube_z);
			translate([rd,cube_y-rd,cube_z/2]) #round_corner(cube_x,cube_y,cube_z);
		}
		intersection(){
			cube(cube_x,cube_y,cube_z);	
			translate([cube_x-rd,cube_y-rd,cube_z/2]) #round_corner(cube_x,cube_y,cube_z);
		}

		color([0,1,0,1]) translate([0,rd,0]) cube([cube_x,cube_y-2*rd,cube_z]);
		color([0,1,0,1]) translate([rd,0,0]) cube([cube_x-2*rd,cube_y,cube_z]);
	}

	module round_corner(cube_x,cube_y,cube_z){
		cylinder(h=cube_z,r=rd,$fn=50, center=true);
	}
}


//plate
//rotate([180,0,0]) translate([0,0,-cube_z-1]){
	difference(){
		union(){
			//main plate
			translate([0,0,0]) rectangle_round(cube_x,cube_y,cube_z);
			//top plate
			translate([0.5,0.5,cube_z]) rectangle_round(cube_x-1,cube_y-1,0.5);
		}
		//slot
		color([1,0,0,1]) translate([(cube_x-slot_x)/2,5,5]) rotate([-25,0,0])#cube([slot_x,slot_y,slot_z*2]);
	}
	//bottom plate
	//translate([1,1,0]) rectangle_round(cube_x-2,cube_y-2,1);

//}