/*

Customizable drawer box
Gian Pablo Villamil
August 4, 2014

Marc Bailey
April 30, 2016

v1 first iteration
v2 added drawer handle
v3 added full fillets, tweaked wall thickness and corner handling
v4 added text label
v5 added hex patterning on the sides
v6 added dimple stop to drawers and box
v7 Simplified and added drawer function which takes row & col options
*/

part="drawer"; //[drawer,cabinet]
//part="cabinet"; //[drawer,cabinet]
COLS = 5; // [1,2,3,4,5,6]

// there seems to be a bug when rows > 2 
ROWS = 2; // [1,2]

// (top to bottom)
DRAWER_HEIGHT = 15;

// (front to back)
DRAWER_DEPTH = 59;
DRAWER_WIDTH = 80;

// Wall thickness
WALL_THICK = 1.6;

// thickness of dividers between drawer slots
INNER_WALL_THICK = 0.6;


// How many drawers?
NUM_DRAWERS = 5;

/* [Text] */
DRAW_TEXT = "yes"; // [yes,no]

// Label on the drawer
MESSAGE = "TEXT";

// Embossed?
EMBOSSED = "yes"; // [yes,no]

/* [Hidden] */
// Text font
TEXT_FONT = "Archivo Black";

// Text height
TEXT_HEIGHT = 6;

// Text spacing
TEXT_SPACING = 1;

// Shift text to the right (negative goes left)
TEXT_SHIFT_RIGHT = 0;

//Shift text up
TEXT_SHIFT_UP = 2;

// Handle size?
HANDLE_SIZE = 10;

// Corner radius?
DRAWER_CORNER_RAD = 2;

CLEARANCE = 0.25;

// Floor thickness
FLOOR_THICK = 1.2;

// Rounded fillets?
FILLETS = true;

india = 6 ;  // inner diameter for holes in drawer cabinet
spacing = 1.2;  // spacing between holes in drawer cabinet
dia = india + (spacing * 2);

hoff = india+spacing;
voff = sqrt(pow(hoff,2)-pow(hoff/2,2));

$fn = 32;
NOFILLETS = !FILLETS;
WALL_WIDTH = WALL_THICK + 0.001; // Hack to trick Makerware into making the right number of filament widths
INNER_WALL_WIDTH = INNER_WALL_THICK + 0.001; // Hack to trick Makerware into making the right number of filament widths
INNER_FILLET = DRAWER_CORNER_RAD-(WALL_WIDTH/1.25);


BOX_HEIGHT = NUM_DRAWERS*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH;

//BOX_WIDTH = DRAWER_WIDTH+CLEARANCE*2+INNER_WALL_WIDTH*2;
BOX_WIDTH = DRAWER_WIDTH+CLEARANCE*2+WALL_WIDTH*2;
BOX_DEPTH = DRAWER_DEPTH+CLEARANCE+WALL_WIDTH;

thick = WALL_THICK + 0.2;
bumprad = 1;

earthick = 0.6;
earrad = 10 ;

print_part();

module print_part() {
	if (part == "drawer") {
        drawer(COLS,ROWS);
    } else {
		cabinet();
	}
}



module drawer(COLS,ROWS) {
    slot_width = (DRAWER_WIDTH-(COLS-1)*INNER_WALL_WIDTH-2*WALL_WIDTH)/COLS;
    slot_depth = (DRAWER_DEPTH-(ROWS+1)*WALL_WIDTH)/ROWS;
    
    difference() {
		drawerbase();
    for (col=[0:ROWS-1])
        for (row=[0:COLS-1])
            translate([WALL_WIDTH+slot_width/2+(INNER_WALL_WIDTH+slot_width)*row-DRAWER_WIDTH/2,WALL_WIDTH+slot_depth/2+(WALL_WIDTH+slot_depth)*col-DRAWER_DEPTH/2,FLOOR_THICK+DRAWER_CORNER_RAD/2])
            roundedBox([slot_width,slot_depth,DRAWER_HEIGHT+DRAWER_CORNER_RAD],INNER_FILLET,NOFILLETS);

    }
};


module cabinet() {
	translate([-BOX_WIDTH/2,-BOX_DEPTH/2,0])
	union () {
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
		for (i=[0:NUM_DRAWERS-1]) {
			translate([BOX_WIDTH/2,DRAWER_CORNER_RAD*2,i*(DRAWER_HEIGHT+CLEARANCE*2+WALL_WIDTH)+WALL_WIDTH-0.1])
			{
				scale([1,1,0.9]) half_sphere(bumprad);
				translate([0,0,DRAWER_HEIGHT+CLEARANCE*2+0.2]) rotate([180,0,0])
				scale([1,1,0.9]) half_sphere(bumprad);
			}
		}

// mouse ears
translate([-earrad/2,BOX_DEPTH,-earrad/2]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
translate([BOX_WIDTH+earrad/2,BOX_DEPTH,-earrad/2]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
translate([-earrad/2,BOX_DEPTH,BOX_HEIGHT+earrad/2]) rotate([90,0,0]) cylinder(r=earrad,h=earthick);
translate([BOX_WIDTH+earrad/2,BOX_DEPTH,BOX_HEIGHT+earrad/2]) rotate([90,0,0]) cylinder(r=earrad,earthick);

	}
};

module drawerbase() {
	union() {
		difference() {
			translate([0,0,DRAWER_CORNER_RAD/2]) roundedBox([DRAWER_WIDTH,DRAWER_DEPTH,DRAWER_HEIGHT+DRAWER_CORNER_RAD],DRAWER_CORNER_RAD,NOFILLETS);
			translate([0,0,DRAWER_HEIGHT]) cube([DRAWER_WIDTH+1, DRAWER_DEPTH+1,DRAWER_HEIGHT],center=true);
			translate([0,-DRAWER_DEPTH/2+DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1.]) sphere(bumprad);
			translate([0,DRAWER_DEPTH/2-DRAWER_CORNER_RAD*2,-DRAWER_HEIGHT/2]) scale([1.2,1.2,1.]) sphere(bumprad);

			if(EMBOSSED == "yes" && DRAW_TEXT=="yes") {
			  translate([TEXT_SHIFT_RIGHT,-DRAWER_DEPTH/2+WALL_WIDTH/4,TEXT_SHIFT_UP]) rotate([90,0,0])linear_extrude(WALL_WIDTH/2)
			    text(MESSAGE,font=TEXT_FONT,size=TEXT_HEIGHT,spacing=TEXT_SPACING,valign="center",halign="center");
			}
		}

   	translate([0,-DRAWER_DEPTH/2,-DRAWER_HEIGHT/2+FLOOR_THICK]) 
        handle();

	if(EMBOSSED == "no" && DRAW_TEXT=="yes") {
	  translate([TEXT_SHIFT_RIGHT,-DRAWER_DEPTH/2+WALL_WIDTH/4,TEXT_SHIFT_UP]) rotate([90,0,0])linear_extrude(WALL_WIDTH/2) text(MESSAGE,font=TEXT_FONT,size=TEXT_HEIGHT,spacing=TEXT_SPACING,valign="center",halign="center");
	}

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
    //difference() {
    //    cylinder(h = DRAWER_WIDTH/4, r=HANDLE_SIZE, center = true);
    //    translate([-2,-2,0])   cylinder(h = DRAWER_WIDTH/4+1, r=HANDLE_SIZE, center = true);
    //}
    
        
	difference() { 
		translate([-DRAWER_WIDTH/8,0,-FLOOR_THICK]) 
			cube([DRAWER_WIDTH/4,DRAWER_CORNER_RAD,DRAWER_CORNER_RAD],center=false);
		translate([-DRAWER_WIDTH/8-1,DRAWER_CORNER_RAD,-FLOOR_THICK+DRAWER_CORNER_RAD]) rotate([0,90,0])  
			cylinder(h=DRAWER_WIDTH/4+2,r=DRAWER_CORNER_RAD);
		};
};

module holes(width,height) {
	ROWS = width / hoff - DRAWER_CORNER_RAD;
	COLS = height / voff - DRAWER_CORNER_RAD;

	translate([hoff*1.3,0,voff*2])
	for (i=[0:COLS-1]) {
		for (j=[0:ROWS-1]){
			translate([j*hoff+i%2*(hoff/2),0,i*voff])
			rotate([90,90,0]) rotate([0,0,0]) cylinder(h=thick,r=india/2,$fn=6);
		}
	}
}

module half_sphere(rad) {
	difference() {
		sphere(rad);
		translate([-rad,-rad,-rad])
		cube([rad*2,rad*2,rad]);
	}
}

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


