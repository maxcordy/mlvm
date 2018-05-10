//------------------------------------------------------------
//	Stencil-o-Matic
//
//	input comes from:
//	http://chaaawa.com/stencil_factory/
//   or
//   http://chaaawa.com/stencil_factory_js/
//
//	http://thingiverse.com/Benjamin
//	http://www.thingiverse.com/thing:55821
//------------------------------------------------------------

// preview[view:south, tilt:top]

// paste here after "Convert&Copy"
input = "no_input";

stencil_thickness = 1;
stencil_width = 90;
margin = 10;

// If you don't want to center
offX = 0;
offY = 0;

handle = "no"; //[no, yes]
handle_orientation = 45;
handle_x = -28;
handle_y = 42;
handle_length = 25;
handle_width = 2;
handle_height = 10;

module void() {}

dispo_width = stencil_width - 2*margin;

points_array = (input=="no_input"?  [[179,268],[[199.26,15.12],[189.19,15.56],[181.5,16.45],[175.52,17.83],[169.55,19.42],[163.57,21.55],[157.55,24.22],[151.62,27.5],[145.87,31.09],[140.35,35.49],[135,40.71],[130.05,46.71],[125.52,53],[121.87,59.06],[119.06,64.5],[117.12,69.21],[115.55,73.5],[114.31,77.65],[113.16,82],[112.07,87.29],[110.96,93.7],[110.36,99.39],[110.49,102.95],[111.13,105],[136.96,105],[158.46,104.73],[163.39,103.42],[163.83,101.08],[164.04,97.67],[164.46,93.04],[165.44,87.75],[167.04,82.4],[168.96,77.59],[171.9,73.02],[175.98,68.21],[180.98,63.93],[186.13,60.62],[192.15,58.45],[201.05,58],[208.86,58.34],[214.1,59.16],[217.74,60.82],[221.73,63.19],[225.41,66.46],[228.34,70.28],[230.39,74.63],[231.97,79.15],[232.75,85.01],[232.85,92.65],[232.01,100.96],[229.51,107.41],[225.45,113.48],[218.91,119.91],[211.35,126.37],[203.83,132.63],[197.2,138.54],[191.77,144.13],[187.33,150.15],[183.1,157.07],[179.62,164.83],[176.98,172.85],[175.42,181.69],[175.22,192.28],[175.5,203.5],[199,203.5],[222.5,203.5],[222.74,198.5],[223.25,193.21],[224.15,187.5],[225.64,181.94],[227.6,177],[230.92,172.02],[235.69,166.37],[243.47,159.38],[254,151.21],[264.03,143.56],[270.61,137.84],[274.46,133.36],[277.95,128.69],[281.05,123.47],[283.96,117.69],[286.32,111.7],[288.09,106],[289.06,98.48],[289.47,88],[289.05,76.45],[287.17,68],[284.48,60.83],[281.31,54.14],[276.58,47.41],[270.1,40.14],[262.4,33.38],[254.68,28.12],[246.8,24.2],[238.72,20.92],[230.05,18.48],[220.76,16.55],[210.43,15.49],[199.26,15.12]],[[198.05,226.08],[178.93,226.28],[170.25,226.66],[169.27,232.87],[169,254.48],[169.27,277.23],[170.58,282.39],[179.4,282.82],[198.38,283],[218.91,282.73],[225.8,281.8],[226.73,274.94],[227,254.5],[226.73,234.06],[225.8,227.2],[218.87,226.29],[198.05,226.08]]]: input);

input_width = points_array[0][0];
input_height= points_array[0][1];
tVersion = points_array[0][2] == undef ? 0: points_array[0][2];
sTrace = dispo_width/input_width;
stencil_height = input_height*sTrace + 2*margin;

//-------------------------------------------------------------------------------
if (tVersion == 0) {
	difference() {
		translate([0, 0, stencil_thickness/2])
		cube([stencil_width, stencil_height, stencil_thickness], center=true);
	
		translate([offX, offY, -stencil_thickness/2])
		scale([sTrace, -sTrace, 1])
		translate([-400/2, -300/2, 0])
		union() {
			for (i = [1:len(points_array) -1] ) {
				linear_extrude(height=stencil_thickness*2) {polygon(points_array[i]);}
			}
		}
	}
}
//-------------------------------------------------------------------------------
if (tVersion == 1) {
	difference() {
		translate([0, 0, stencil_thickness/2])
		cube([stencil_width, stencil_height, stencil_thickness], center=true);

		translate([offX, offY, -stencil_thickness/2])
		scale([sTrace, -sTrace, 1])
		translate([-input_width/2, -input_height/2, 0]) 
		union() {
			for (i = [1:len(points_array) -1] ) {
				if (points_array[i][0] == 1) {
					linear_extrude(height=stencil_thickness*2) {polygon(points_array[i][1]);}
				}
			}
		}
	} 
} 
//-------------------------------------------------------------------------------
if (handle == "yes") {
	translate ([handle_x, handle_y,  handle_height/2])
	rotate([0, 0, handle_orientation])
	cube([handle_length, handle_width, handle_height], center=true);
}

