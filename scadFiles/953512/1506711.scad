// Ball Valves
// Ball valves are great for projects, but I'm always a little floored by the price.  
// Like $15 bucks for 5 cents worth of plastic?  Really?  And my idea calls for... about 30 of them so...
//
// This is licensed under creative commons, attribution, share-alike.
// To fulfil the "attribution" requirement, please link to:
//	http://www.thingiverse.com/thing:953512
//
// INSTRUCTIONS:
// 1) print the ball and seals with max resolution and sand to mate
// 2) other parts can be less precise
// 3) Insert both seals, then the ball and handle.  Glue housing insert in place last of all.
//
// TODO:
// 1) Add some chord math so seals fit better
// 2) Make the generated model more printable (orientation, supports, etc)
// 3) Improve customizer options
// 4) Pipe attachment (see http://www.thingiverse.com/thing:436659)
// 5) O-ring for handle shaft (see http://www.thingiverse.com/thing:225603)
// 6) Handle attachment to ball 
// 7) Add servo alternative (again, see http://www.thingiverse.com/thing:436659)

/* [main] */

// what do you want to see?
view=0; //[0:assembled,1:TODO buildplate for hires parts,2:TODO buildplate for std res parts]

// show parts cut away for visualization (turn off before printing)
cutaway=1; // [0:false,1:true]

// How to attach to pipe
pipe_connection=0; // [0:TODO Not yet implemented]

// inside diameter for fluid
flow_dia=20;

// 0=auto, based on flow_dia
ball_dia=0;

// Thickness of the seat around the perimeter
seat_thickness=3;

// Thickness of the seat vertically
seat_h=2;

// Thickness of the housing walls
housing_thickness=2;

// How tall the 90 degree stop is
stop_cutout_h=2;


/* [handle] */

handle_screw_dia=3;

handle_countersink_dia=8;

// if 0, auto-calculate
handle_shaft_dia=0;

// within housing
handle_inset=5;

// beyond housing
handle_outset=10;

handle_len=60;

// if 0, auto-calculate
handle_w=0;

handle_thick=3;

/* [advanced] */

show_housing=1; // [0:false,1:true]

show_housing_insert=1; // [0:false,1:true]

show_handle=1; // [0:false,1:true]

show_right_seal=1; // [0:false,1:true]

show_left_seal=1; // [0:false,1:true]

show_ball=1; // [0:false,1:true]

hires_facets=128;

stdres_facets=64;

/* [hidden] */

module ball(ball_dia){
	rotate([0,90,0]) difference(){
		sphere(r=ball_dia/2);
		translate([0,0,-ball_dia/2]) cylinder(r=flow_dia/2,h=ball_dia*2);
	}
}

module seat(ball_dia){
	// TODO: need some chord math to get positioning and sphere cutout correct
	translate([ball_dia/2,0,0]) rotate([0,-90,0]) difference(){
		cylinder(r=flow_dia/2+seat_thickness,h=seat_h); // main shape
		translate([0,0,-seat_h/2]) cylinder(r=flow_dia/2,h=seat_h*2); // hole
		translate([0,0,ball_dia/2-0.01]) sphere(r=ball_dia/2,$fn=64); // ball
	}
}

module housing_insert(ball_dia,handle_shaft_dia){
	lead_in=30;
	difference(){
		translate([lead_in,0,0]) rotate([0,-90,0]) difference(){
			cylinder(r=ball_dia/2,h=lead_in);
			translate([0,0,lead_in]) sphere(r=ball_dia/2);
			translate([0,0,-lead_in/2]) cylinder(r=flow_dia/2,h=lead_in*2);
			translate([0,0,lead_in-ball_dia/2]) cylinder(r=flow_dia/2+seat_thickness,h=ball_dia); // seat
		}
		cylinder(r=handle_shaft_dia/2,h=ball_dia); // handle
	}
}

module housing(ball_dia,handle_shaft_dia){
	lead_in=30;
	rotate([0,90,0]) translate([0,0,-ball_dia/2]) difference(){
		union() { // body
			translate([0,0,-lead_in]) cylinder(r=ball_dia/2+housing_thickness,h=lead_in*2+ball_dia/2);
			translate([-handle_outset,0,ball_dia/2]) rotate([0,-90,0]) cylinder(r=handle_shaft_dia/2+housing_thickness,h=ball_dia/2); // shaft hole
		}
		// inside core
		translate([0,0,ball_dia/2]) cylinder(r=ball_dia/2,h=lead_in); // outlet with clearance for housing_insert
		translate([0,0,-lead_in]) cylinder(r=flow_dia/2,h=lead_in*2); // inlet
		translate([0,0,ball_dia/2])sphere(r=ball_dia/2); // ball clearance
		cylinder(r=flow_dia/2+seat_thickness,h=ball_dia); // seat recess
		translate([0,0,ball_dia/2]) rotate([0,-90,0]) cylinder(r=handle_shaft_dia/2,h=ball_dia); // shaft hole
		// stop
		translate([-(ball_dia/2+handle_outset-stop_cutout_h),0,0]) rotate([0,-90,0]) cube([ball_dia,ball_dia,stop_cutout_h*2]);
	}
}

module handle(ball_dia,handle_shaft_dia,handle_w){
	handle_total=handle_thick+handle_outset+handle_inset;
	translate([0,0,ball_dia/2+handle_inset]) difference(){
		union(){
			cylinder(r=handle_shaft_dia/2,h=handle_inset,$fn=4);
			translate([0,0,handle_inset]) cylinder(r=handle_shaft_dia/2,h=handle_outset+handle_thick);
			translate([0,0,handle_inset+handle_outset]) linear_extrude(handle_thick) hull(){ // handle
				translate([-handle_len,0,0]) circle(r=handle_w);
				circle(r=handle_w);
			}
			translate([0,0,handle_inset+handle_outset-stop_cutout_h]) intersection(){ // stop
				cylinder(r=handle_shaft_dia/2+housing_thickness,h=stop_cutout_h);
				translate([-handle_shaft_dia,0,0]) cube([handle_shaft_dia,handle_shaft_dia,stop_cutout_h]);
			}
		}
		translate([0,0,-handle_total/2]) cylinder(r=handle_screw_dia/2,h=handle_total*2); // screw hole
		translate([0,0,handle_total-handle_thick]) cylinder(r=handle_countersink_dia/2,h=handle_total*2); // screw countersink
	}
}

module main($fn=64){
	ball_dia=ball_dia>0?ball_dia:flow_dia*2.0;
	handle_shaft_dia=handle_shaft_dia>0?handle_shaft_dia:ball_dia*2/3;
	handle_w=handle_w>0?handle_w:handle_shaft_dia*2/3;

	if(show_housing_insert==1) color([0.5,0.5,0.5]) difference() {
		housing_insert(ball_dia=ball_dia,handle_shaft_dia=handle_shaft_dia);
		if(cutaway==1) translate([-100,-195,-100]) cube([200,200,200]);
	}
	if(show_ball==1) color([0,0,1]) ball(ball_dia=ball_dia,$fn=hires_facets);
	if(show_left_seal==1) color([1,1,1]) seat(ball_dia=ball_dia,$fn=hires_facets);
	if(show_right_seal==1) color([1,1,1]) mirror([1,0,0]) seat(ball_dia=ball_dia,$fn=hires_facets);

	if(show_housing==1) difference() {
		housing(ball_dia=ball_dia,handle_shaft_dia=handle_shaft_dia);
		if(cutaway==1) translate([-100,-200,-100]) cube([200,200,200]);
	}
	if(show_handle==1) handle(ball_dia=ball_dia,handle_shaft_dia,handle_shaft_dia,handle_w=handle_w);
}

main($fn=stdres_facets);