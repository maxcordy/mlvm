/*

Customizable drawer box
Gian Pablo Villamil
August 4, 2014

v1 first iteration
v2 added drawer handle
v3 added full fillets, tweaked wall thickness and corner handling
v4 added text label
v5 added hex patterning on the sides

*/

use<write.scad>;

/* [Global] */

// Which one would you like to see?
part = "drawerbox"; // [drawer1:1 section drawer,drawer2:2 section drawer,drawer3:3 section drawer, drawer4:4 section drawer, drawerbox:drawer housing]

/* [Basic] */

// How many drawers?
NUM_DRAWERS = 5;

// How high?
DRAWER_HEIGHT = 15;

// How deep?
DRAWER_DEPTH = 59;

// How wide?
DRAWER_WIDTH = 80;

// Label on the drawer
MESSAGE = " ";

// Text height
TEXT_HEIGHT = 6;

/* [Pattern] */

india = 6 ;
spacing = 1;
dia = india + (spacing * 2);



hoff = india+spacing;
voff = sqrt(pow(hoff,2)-pow(hoff/2,2));


/* [Advanced] */

// Handle size?
HANDLE_SIZE = 10;

// Corner radius?
DRAWER_CORNER_RAD = 2;

// Clearance
CLEARANCE = 0.5;

// Wall thickness
WALL_THICK = 1.6;

// Floor thickness
FLOOR_THICK = 1.2;

// Rounded fillets?
FILLETS = true;


/* [Hidden] */

$fn = 32;
NOFILLETS = !FILLETS;
WALL_WIDTH = WALL_THICK + 0.001; // Hack to trick Makerware into making the right number of filament widths
INNER_FILLET = DRAWER_CORNER_RAD-(WALL_WIDTH/1.25);

BOX_HEIGHT = NUM_DRAWERS*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH;
BOX_WIDTH = DRAWER_WIDTH+CLEARANCE*2+WALL_WIDTH*2;
BOX_DEPTH = DRAWER_DEPTH+CLEARANCE+WALL_WIDTH;

thick = WALL_THICK + 0.2;

//  
print_part();

module print_part() {
	if (part == "drawer1") {
		drawer1();
	} else if (part == "drawer2") {
		drawer2();
	} else if (part == "drawer3") {
		drawer3();
	} else if (part == "drawer4") {
		drawer4();
	} else {
		drawerbox();
	}
}


module drawerbox() {
	translate([-BOX_WIDTH/2,-BOX_DEPTH/2,0])
	difference () {
		cube([BOX_WIDTH,BOX_DEPTH,BOX_HEIGHT]);
		for (i=[0:NUM_DRAWERS-1]) {
			translate([WALL_WIDTH,-1,i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH])
			cube([DRAWER_WIDTH+CLEARANCE*2,DRAWER_DEPTH+CLEARANCE+1,DRAWER_HEIGHT+CLEARANCE*2]);
		}
	translate([0,BOX_DEPTH+0.1,0])
	holes(BOX_WIDTH,BOX_HEIGHT);
	rotate([0,0,90]) translate([hoff/2,0.1,0]) holes(BOX_DEPTH,BOX_HEIGHT);
	rotate([0,0,90]) translate([hoff/2,-BOX_WIDTH+WALL_WIDTH+0.1,0]) holes(BOX_DEPTH,BOX_HEIGHT);
	}
};

module drawer1() {
	difference() {
		drawerbase();
		 translate([0,0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH-(WALL_WIDTH*2),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
	}	
};

module drawer2() {
	difference() {
		drawerbase();
		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
}
};

module drawer3() {
	difference() {
		drawerbase();
		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),0,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH-(WALL_WIDTH*2),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);


		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,-(DRAWER_DEPTH/4-WALL_WIDTH/4),FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
}

};

module drawer4() {
	difference() {
		drawerbase();
		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

		translate([-(DRAWER_WIDTH/4-WALL_WIDTH/4),-(DRAWER_DEPTH/4-WALL_WIDTH/4),FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,DRAWER_DEPTH/4-WALL_WIDTH/4,FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);


		translate([DRAWER_WIDTH/4-WALL_WIDTH/4,-(DRAWER_DEPTH/4-WALL_WIDTH/4),FLOOR_THICK+DRAWER_CORNER_RAD/2])
			roundedBox([DRAWER_WIDTH/2-(WALL_WIDTH*1.5),DRAWER_DEPTH/2-(WALL_WIDTH*1.5),DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);
}};

module drawer6() {};

module drawerbase() {
	union() {
	difference() {
	translate([0,0,DRAWER_CORNER_RAD/2]) roundedBox([DRAWER_WIDTH,DRAWER_DEPTH,DRAWER_HEIGHT+DRAWER_CORNER_RAD],DRAWER_CORNER_RAD,NOFILLETS);
	translate([0,0,DRAWER_HEIGHT]) cube([DRAWER_WIDTH+1, DRAWER_DEPTH+1,DRAWER_HEIGHT],center=true);}
translate([0,-DRAWER_DEPTH/2,-DRAWER_HEIGHT/2+FLOOR_THICK]) handle();

translate([-DRAWER_WIDTH/2+DRAWER_CORNER_RAD,-DRAWER_DEPTH/2+0.5,-DRAWER_HEIGHT/4+DRAWER_CORNER_RAD/2]) rotate([90,0,0]) write(MESSAGE,h=TEXT_HEIGHT,font="Orbitron.dxf");
};
};

module handle() {

	difference() {
		roundedBox([DRAWER_WIDTH/4,HANDLE_SIZE*2,FLOOR_THICK*2],2,true);
		translate([0,HANDLE_SIZE,0]) cube([DRAWER_WIDTH/4+1,HANDLE_SIZE*2,FLOOR_THICK*2+1],center=true);
	};
	
	difference() { 
		translate([0,-DRAWER_CORNER_RAD/2,FLOOR_THICK+DRAWER_CORNER_RAD/2]) 
			cube([DRAWER_WIDTH/4,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=true);
		translate([-DRAWER_WIDTH/8-1,-DRAWER_CORNER_RAD,FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=DRAWER_WIDTH/4+2,r=DRAWER_CORNER_RAD);
		};

	difference() { 
		translate([-DRAWER_WIDTH/8,0,-FLOOR_THICK]) 
			cube([DRAWER_WIDTH/4,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=false);
		translate([-DRAWER_WIDTH/8-1,DRAWER_CORNER_RAD,-FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=DRAWER_WIDTH/4+2,r=DRAWER_CORNER_RAD);
		};
};

module holes(width,height) {
	cols = width / hoff - DRAWER_CORNER_RAD;
	rows = height / voff - DRAWER_CORNER_RAD;

	translate([hoff*1.3,0,voff*2])
	for (i=[0:rows-1]) {
		for (j=[0:cols-1]){
			translate([j*hoff+i%2*(hoff/2),0,i*voff])
			rotate([90,90,0]) rotate([0,0,0]) cylinder(h=thick,r=india/2,$fn=6);
		}
	}
}

// translate([DRAWER_WIDTH/2+WALL_WIDTH+CLEARANCE,DRAWER_DEPTH/2,DRAWER_HEIGHT/2+FLOOR_THICK+CLEARANCE])
// drawerbase();
// handle();
// drawer1();
// drawer2();
// drawer3();
// drawer4();
// translate([-BOX_WIDTH/2,-BOX_DEPTH-thick,BOX_HEIGHT/2]) 
// drawerbox();
// holes(BOX_WIDTH,BOX_HEIGHT);
%cube([200,200,1],center=true);

// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: BSD

// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}


