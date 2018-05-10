//	LM Destop Container Creator
//
// Creates numerous desktop containers with images of cool 
// Lockheed Martin hardware etched in the outer shell.
//
// Designed to work with Thingiverse Customizer.
//
// Open SCAD model by Walter A. Kuhn
//	October 2016

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Object Parameters that are controlled by customizer

/* [Container Shape] */

// Type of Container to Make
style = 0;	// [0:Container, 1:Flowerpot, 2:Coaster]
// For Style=Flowerpot, which .stl would you like to generate?
part2print = "Both"; // [Pot:Flowerpot,Pan:Drip Pan,Both:Both]
// Number of sides, or <3 for round container
nsides = 6;	// [1:20]
// Amount of "twist" in degrees
xtwist = 30;	// [0:360]
// Number of internal compartments
nsections = 3;		// [1:8] 

/* [Container Size] */

// Height of container in mm
hgt = 80;  // [20:5:200]
// Diameter at base (mm)
base_diam = 50;  // [20:200]
// Diameter at top (mm)
top_diam = 65;	// [20:200]
// Thickness of bottom floor (mm)
base_thickness = 2;	// [0.6:0.2:5]
// Thickness of container sides (mm)
wall_thickness = 1.6;  // [1.2:0.2:5]
// Height of top rim in mm (or 0 to suppress)
rim_height = 5.4;	// [0:0.2:20]
// Thickness of top rim in mm (or 0 to suppress)
rim_thickness = 3.2; // [0:0.2:10]
// Compartment divider wall thickness
div_thick = 1.2;	// [1.0:0.2:4]

/* [Images Etched] */

// Depth of images etched into side walls (mm)
etch_depth = 1;  // [0:0.2:3.2]
// First Image to embed in container
image1 = 8; // [0:None, 1:C130, 2:F16, 3:F22, 4:F35_JSF, 5:F117, 6:KMAX, 7:LCS, 8:LM_Star, 9:Longbow, 10:MEADS_Launcher,11:MEADS_Radar, 12:PAC-3_MSE, 13:PTDS, 14:SR71, 15:U2]
// Second Image to embed in container
image2 = 4; // [0:None, 1:C130, 2:F16, 3:F22, 4:F35_JSF, 5:F117, 6:KMAX, 7:LCS, 8:LM_Star, 9:Longbow, 10:MEADS_Launcher,11:MEADS_Radar, 12:PAC-3_MSE, 13:PTDS, 14:SR71, 15:U2]
// Third Image to embed in container
image3 = 5; // [0:None, 1:C130, 2:F16, 3:F22, 4:F35_JSF, 5:F117, 6:KMAX, 7:LCS, 8:LM_Star, 9:Longbow, 10:MEADS_Launcher,11:MEADS_Radar, 12:PAC-3_MSE, 13:PTDS, 14:SR71, 15:U2]
// Fourth Image to embed in container
image4 = 11; // [0:None, 1:C130, 2:F16, 3:F22, 4:F35_JSF, 5:F117, 6:KMAX, 7:LCS, 8:LM_Star, 9:Longbow, 10:MEADS_Launcher,11:MEADS_Radar, 12:PAC-3_MSE, 13:PTDS, 14:SR71, 15:U2]
// Fifth Image to embed in container
image5 = 14; // [0:None, 1:C130, 2:F16, 3:F22, 4:F35_JSF, 5:F117, 6:KMAX, 7:LCS, 8:LM_Star, 9:Longbow, 10:MEADS_Launcher,11:MEADS_Radar, 12:PAC-3_MSE, 13:PTDS, 14:SR71, 15:U2]
// Sixth Image to embed in container
image6 = 15; // [0:None, 1:C130, 2:F16, 3:F22, 4:F35_JSF, 5:F117, 6:KMAX, 7:LCS, 8:LM_Star, 9:Longbow, 10:MEADS_Launcher,11:MEADS_Radar, 12:PAC-3_MSE, 13:PTDS, 14:SR71, 15:U2]


/* [Hidden] */
// Other inputs not controlled by customizer

xslices = 100;	// # slices for extrusion
tray_scale = 1.3;	// flower pot tray is wider than the pot bottom by this scale factor
tol = 0.1;	// "extra" dimension used in a few places to ensure sufficent overlaps
circle_nsides = 100;	// number of sides used for a circle
gap_width = 0.5;		// Gap between object and support (mm) used when etching depth >= wall thickness

// Misc variables
inner_shell_thickness = max(0,wall_thickness-etch_depth);	// thickness of solid inner shell
outer_shell_thickness = etch_depth;	// thickness of perforated outer shell
drain = (style == 1);	// If true, put a drain hole in the bottom
coaster = (style == 2);		// If true, print a coaster (i.e. no walls)

// Average radius of container
midrad = (base_diam+top_diam)/4;


/////////////////////////////////////////////////////////////////
// Beginning of modules

/////////////////////////////////////////////////////////////////
// LM Star Logos - adapted from LM_StarLogo.scad by Keith Rogers

/*
module StarLogo_2D(centerLoc,width,rot)
// Create the Lockheed Martin Star Logo
// This version may have problems printing at small sizes, as points of the star 
// are actually points.
{
translate(centerLoc)
rotate(rot)

// This 2D version eliminates the linear extrude, but retains the scaling of the original module
//linear_extrude(height = depth, center = true, convexity = 10, twist = 0)scale([width/874, width/874, 0])
scale([width/874, width/874])

translate([-437,-183,0])   // Now centered at (0,0)
translate([-121, -32, 0])  // Bounding box now at (0,0),(874,366)
polygon(points = [
[   121,   255 ],
[   743,   258 ],
[   875,   398 ],
[   839,   258 ],
[   995,   257 ],
[   814,   166 ],
[   776,    32 ],
[   800,   158 ],
[   552,    39 ],
[   805,   177 ],
[   818,   240 ],
[   744,   241 ],
[   652,   157 ],
[   727,   241 ],
[   761,   257 ],
[   835,   326 ],
[   822,   257 ],
[   835,   240 ],
[   914,   238 ],
[   821,   187 ],
],  
paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13],
[14,15,16],[17,18,19]]);
}
*/

module StarLogo2_2D(centerLoc,width,rot)
// Create the Lockheed Martin Star Logo
// Aspect ratio is 2.4 to 1
// Thin points have been thickened for printability at small sizes.
// Should print OK for width >= 30

{
translate(centerLoc)
rotate(rot)

// This 2D version eliminates the linear extrude, but retains the scaling of the original module
//linear_extrude(height = depth, center = true, convexity = 10, twist = 0)scale([width/874, width/874, 0])
scale([width/874, width/874])

translate([-437,-183,0])   // Now centered at (0,0)
translate([-121, -32, 0])  // Bounding box now at (0,0),(874,366)
polygon(points = [
[   121,   255 ],  // 0 
[   743,   258 ],  // 1
[   875,   398 ],  // 2
[   839,   258 ],  // 3
[   995,   257 ],  // 4
[   814,   166 ],  // 5
[   776,    32 ],  // 6
[   765.4,   32 ],  // 7
[   800,   158 ],  // 8
[   552,    39 ],  // 9
[   546,    45 ],  // 10
[   805,   177 ],  // 11
[   818,   240 ],  // 12
[   744,   241 ],  // 13
[   652,   157 ],  // 14
[   646,   163],   // 15
[   727,   241 ],  // 16
[   121,   246.4], // 17 (366*NozzleWidth/17) for NW = 0.4
[   761,   257 ],  // 18
[   835,   326 ],  // 19
[   822,   257 ],  // 20
[   835,   240 ],  // 21 
[   914,   238 ],  // 22
[   821,   187 ],  // 23
],  
paths = [[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16, 17],
[18,19,20], [21,22,23]]);
}


///////////////////////////////////////////////////////////////////
// Module to print the container

module print_container() {

	// First print the outer wall which has image cutouts.  
	if (outer_shell_thickness > 0 && coaster==false) {
	
		// This difference is used to etch cutouts in outer shell
		difference() {
		
			// Determine vertical offset - used to offset alternating holes if the container is tall
			xoffset = max(0,(hgt-2*PI*midrad/6)/4);
			delta_twist = xtwist*xoffset/hgt;
		
			// Create outer shell
			shell (nsides, hgt, base_diam, top_diam, outer_shell_thickness, xtwist, xslices);
			
			// Start angle and Angle between cutouts - varies with #sides
			start_angle = [0,0,30,45,54,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			delta_angle = [60,60,120,90,72,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60];
	
			// Use support if the etching goes all the way through the side wall
			support = inner_shell_thickness <= 0;

			// Make up to 6 cutouts in the outer shell - one per side up to a max of 6
			if (image1>0) translate([0,0,xoffset]) 
				cutout(start_angle[nsides-1]+0*delta_angle[nsides-1]-xtwist/2-delta_twist, image1, hgt, midrad, nsides, support);
			if (image2>0) translate([0,0,-xoffset]) 
				cutout(start_angle[nsides-1]+1*delta_angle[nsides-1]-xtwist/2+delta_twist, image2, hgt, midrad, nsides, support);
			if (image3>0) translate([0,0,xoffset]) 
				cutout(start_angle[nsides-1]+2*delta_angle[nsides-1]-xtwist/2-delta_twist, image3, hgt, midrad, nsides, support);
			if (image4>0 && (nsides>3 || nsides<3)) translate([0,0,-xoffset]) 
				cutout(start_angle[nsides-1]+3*delta_angle[nsides-1]-xtwist/2+delta_twist, image4, hgt, midrad, nsides, support);
			if (image5>0 && (nsides>4 || nsides<3)) translate([0,0,xoffset]) 
				cutout(start_angle[nsides-1]+4*delta_angle[nsides-1]-xtwist/2-delta_twist, image5, hgt, midrad, nsides, support);
			if (image6>0 && (nsides>5 || nsides<3)) translate([0,0,-xoffset]) 
				cutout(start_angle[nsides-1]+5*delta_angle[nsides-1]-xtwist/2+delta_twist, image6, hgt, midrad, nsides, support);
		}
	}
	
	// Second add a solid inner shell - or suppress if thickness = 0
	if (inner_shell_thickness > 0 && coaster==false) {
		shell (nsides, hgt, base_diam-2*outer_shell_thickness+tol, top_diam-2*outer_shell_thickness+tol, inner_shell_thickness, xtwist, xslices);
	}
	
	// Third, create internal compartment dividers
	if (coaster==false && nsections > 1) {
		dividers (nsections, div_thick, nsides, hgt, base_diam, top_diam, outer_shell_thickness, xtwist, xslices);
	}
	
	// Fourth, add the bottom.  Optionally put drain hole in bottom (flowerpot) or etch an image in the bottom (coaster).
	if (drain) {
		difference(){
			bottom (nsides, base_diam, base_thickness, hgt, xtwist);
			translate([0,0,-tol]) bottom (1, base_diam/9, base_thickness+2*tol);
		}
	} else {
	
		// If this is a coaster, then etch image1 into the bottom
		difference () {
		
			// Create the bottom
			bottom (nsides, base_diam, base_thickness, hgt, xtwist);
	
			// Etch the image
			if (coaster) {
				translate([0,0,base_thickness-etch_depth])
				linear_extrude(height = base_thickness, center = false, convexity = 10) {
					scale ([base_diam*0.7/100,base_diam*0.7/100])
					lm_shape(image1);
				}
			}
		}
	}
	
	// Fifth, add upper rim - suppress if thickness or height is zero
	if (rim_height > 0 && rim_thickness > 0) {
		
		// Translate to top of container side wall
		if (coaster==false) {
			translate ([0,0,hgt-tol])
			rotate([0,0,-xtwist])
			shell (nsides, hgt = rim_height, base_diam=top_diam+rim_thickness-inner_shell_thickness-outer_shell_thickness, 
				top_diam=top_diam+rim_thickness-inner_shell_thickness-outer_shell_thickness, thickness = rim_thickness, xtwist=0);
	
		// If this is a coaster, don't translate upward, and match to base diameter rather than top diameter
		} else {
			shell (nsides, hgt = rim_height, base_diam=base_diam+2*rim_thickness-tol, 
				top_diam=base_diam+rim_thickness-inner_shell_thickness-outer_shell_thickness, thickness = rim_thickness, xtwist=0);
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////
// Module to make a drip pan for the flowerpot

module print_pan () {

	// Make the floor.   
	bottom (nsides, base_diam*tray_scale+2*base_thickness, base_thickness, hgt, xtwist);

	// Make the rim
	shell (nsides, hgt = rim_height, base_diam=base_diam*tray_scale+2*rim_thickness-tol, top_diam=base_diam*tray_scale+2*rim_thickness-tol, thickness = rim_thickness, xtwist=0);

}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module to create a hollow shell. 
//		nsides = 1 (for cylinder) or #sides for regular polygon shaped container
//		hgt = height of shell (mm)
//		base_diam = diameter at bottom (mm)
//		top_diam = diameter at top (mm)
//		thickness = wall thickness (mm)
//		xtwist = degrees of twist
//		xslices = number of slices (if twisted)

module shell (nsides = 1, hgt = 50, base_diam = 40, top_diam = 50, thickness = 2, xtwist = 0, xslices = 100 ) {
	tol = 0.01;	// used to get clean top and bottom

	// Form shell as the difference of two linear extrusions
	difference() {

		// Larger extrusion uses offset method to enlarge the shell
		linear_extrude(height = hgt, center = false, convexity = 10, twist = xtwist, slices = xslices, scale=top_diam/base_diam)

 		offset(r = thickness) {

			// Use circle with small #sides to create a polygon
			if (nsides > 2){
				circle(r = base_diam/2-thickness, $fn=nsides);
			} else {
				circle(r = base_diam/2-thickness, $fn=circle_nsides);
			}
		}

		// Smaller radius extrusion.  Expand height to get a clean top & bottom surface.
		translate([0,0,-tol])
		linear_extrude(height = hgt+2*tol, center = false, convexity = 10, twist = xtwist, slices = xslices, scale=(top_diam-thickness)/(base_diam-thickness))
		if (nsides > 2){
			circle(r = base_diam/2-thickness, $fn=nsides);
		} else {
			circle(r = base_diam/2-thickness, $fn=circle_nsides);
		}

	// End of difference
	}
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module to create compartment dividers 
//		ndiv = number of compartments (and dividers)
//		div_thick = divider wall thickness (mm)
//		nsides = 1 (for cylinder) or #sides for regular polygon shaped container
//		hgt = height of shell (mm)
//		base_diam = diameter at bottom (mm)
//		top_diam = diameter at top (mm)
//		shell_thick = wall thickness (mm)
//		xtwist = degrees of twist
//		xslices = number of slices (if twisted)


module dividers (ndiv = 1, div_thick = 1, nsides = 1, hgt = 50, base_diam = 40, top_diam = 50, shell_thick = 2, xtwist = 0, xslices = 100 ) {
	tol = 0.01;	// used to get clean top and bottom

	// If there are compartments
	if (ndiv > 1) {	

		// form the intersection of the radial dividers with the container shape
		intersection() {

			// Unite the multiple dividers into one object
			union(){

				// loop through the dividers
				for (idiv = [1:ndiv]) {

					// Calculate the azimuth angle for this divider
					angle = idiv*360/ndiv+45;

					// Rotate the divider to the correct azimuth
					rotate([0,0,angle])
	
					// Create the divider
					translate([0, -div_thick/2, 0]) cube([max(base_diam,top_diam),div_thick, hgt*0.97],center = false);

				// Next divider
				}

			// End of union
			}

			// Volume enclosed by the inner shell - limits the size of the dividers
			linear_extrude(height = hgt, center = false, convexity = 10, twist = xtwist, slices = xslices, 
				scale=(top_diam-2*outer_shell_thickness)/(base_diam-2*outer_shell_thickness))
	 		offset (r = inner_shell_thickness) {
				if (nsides > 2){
					circle(r = base_diam/2-outer_shell_thickness-inner_shell_thickness, $fn=nsides);
				} else {
					circle(r = base_diam/2-outer_shell_thickness-inner_shell_thickness, $fn=circle_nsides);
				}
			}

		// End of the interscetion
		}

	}	// end of if there are dividers
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Module to create a flat bottom (or top?) for the container consistent with "shell" module
//		nsides = 1 (cylinder) or #sides for polygon shaped container
//		shell_hgt = height of shell (mm)
//		diam = diameter at bottom (mm)
//		thickness = floor thickness (mm)
//		xtwist = degrees of twist used in shell

module bottom (nsides = 1, diam = 40, thickness = 2, shell_hgt = 40, shell_xtwist = 0) {

	// This is just a very short section of the linear extrusion in "shell" method
	linear_extrude(height = thickness, center = false, convexity = 10, twist = shell_xtwist*thickness/shell_hgt)
	if (nsides > 2){
		circle(r = diam/2, $fn=nsides);
	} else {
		circle(r = diam/2, $fn=circle_nsides);
	}

}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This module reads a polygon and converts it to a shape used for cutting the outer shell
// This version just cuts the outline, leaving the middle to act as a support
// This version is used when the inner shell thickness is zero - so outer shell needs support
//		angle = azimuth of the cut (deg)
//		iopt = index controlling which image is used
//		hgt = container height
//		midrad = container radius at cutout (i.e. middle)
//		support = true to add a support inside the hole (use with a through-hole)
//
// This version relies on embedding images within the OpenSCAD file module lm_shape

module cutout(angle = 0, iopt=1, hgt = 50, midrad = 45, nsides = 6, support = false) {

	// Width & height of hole is set to about 1/6th the circumference
	xscale = [1,1,2,1.5,1.2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];	// scales image up if only a few sides
	wdth = min(0.80*midrad*xscale[nsides-1],hgt);

	// positon the "hole"
	translate([0,0,hgt/2])
	rotate([0,0,angle])
	rotate([90,0,0])

	// Convert the image polygon to a 3D object
	linear_extrude(height = 2*midrad, center = true, convexity = 16, scale = 1, center=false) { 

		// Get the hole outline polygon
		gap_delta = 100*gap_width/midrad;	// equivalent gap width in pre-scaled image
		scale([wdth/100,wdth/100]) 		// rescales max dimension from 100mm to wdth
		difference() {
			lm_shape(iopt);
			if (support) offset (delta = -gap_delta) lm_shape(iopt);
		}
	}
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////
// This module loads an outline shape (e.g. polygon) of a selected LM product
// iopt = 0 for None
//        1 for C130
//        2 for F16
//        3 for F22 
//        4 for F35 
//        5 for F117 
//        6 for KMAX 
//        7 for LCS 
//			 8 for LM Star Logo
//        9 for Apache Longbow Helicopter
//        10 for MEADS Launcher 
//        11 for MEADS Radar 
//        12 for PAC-3 MSE Intercepotor 
//        13 for PTDS 
//        14 for SR71 
//        15 for U2
// Note: shapes are pre-scaled to a max width/height of 100 and are centered at (0,0)

module lm_shape(iopt = 1) {
	// option 1 is C130
	if (iopt==1) polygon(points = [ [-5.54, -14.96], [-5.96, -14.75], [-6.33, -14.47], 
    [-6.64, -14.14], [-6.88, -13.78], [-7.14, -13.40], [-7.44, -13.24], 
    [-7.81, -13.30], [-8.29, -13.57], [-8.90, -13.88], [-9.55, -14.02], 
    [-10.20, -14.00], [-10.81, -13.79], [-11.35, -13.42], [-11.80, -12.90], 
    [-12.13, -12.24], [-12.35, -11.46], [-12.42, -11.22], [-12.59, -11.07], 
    [-12.96, -10.95], [-13.65, -10.81], [-14.15, -10.71], [-14.60, -10.64], 
    [-14.96, -10.59], [-15.18, -10.58], [-15.32, -10.58], [-15.45, -10.57], 
    [-15.56, -10.53], [-15.64, -10.49], [-16.16, -10.32], [-17.15, -10.10], 
    [-18.21, -9.90], [-18.91, -9.82], [-19.08, -9.81], [-19.25, -9.78], 
    [-19.40, -9.74], [-19.52, -9.69], [-19.94, -9.54], [-20.67, -9.37], 
    [-21.58, -9.19], [-22.59, -9.02], [-23.11, -8.94], [-23.69, -8.84], 
    [-24.27, -8.72], [-24.77, -8.62], [-26.48, -8.25], [-28.07, -7.95], 
    [-29.39, -7.74], [-30.30, -7.64], [-30.66, -7.62], [-30.96, -7.58], 
    [-31.18, -7.53], [-31.29, -7.48], [-31.68, -7.31], [-32.51, -7.12], 
    [-33.50, -6.95], [-34.38, -6.86], [-34.80, -6.82], [-35.19, -6.75], 
    [-35.58, -6.63], [-35.96, -6.47], [-36.26, -6.33], [-36.54, -6.22], 
    [-36.76, -6.15], [-36.90, -6.12], [-36.98, -6.11], [-37.05, -6.09], 
    [-37.10, -6.05], [-37.14, -6.01], [-37.22, -5.95], [-37.42, -5.86], 
    [-37.70, -5.74], [-38.04, -5.63], [-38.39, -5.51], [-38.71, -5.40], 
    [-38.97, -5.32], [-39.12, -5.26], [-39.24, -5.23], [-39.28, -5.27], 
    [-39.27, -5.41], [-39.21, -5.67], [-39.14, -6.19], [-39.23, -6.68], 
    [-39.47, -7.15], [-39.84, -7.57], [-40.12, -7.80], [-40.36, -7.92], 
    [-40.62, -7.96], [-40.99, -7.93], [-41.34, -7.88], [-41.61, -7.79], 
    [-41.84, -7.64], [-42.09, -7.39], [-42.31, -7.13], [-42.45, -6.89], 
    [-42.51, -6.64], [-42.53, -6.31], [-42.48, -5.82], [-42.34, -5.38], 
    [-42.11, -5.00], [-41.79, -4.68], [-41.66, -4.57], [-41.58, -4.48], 
    [-41.55, -4.42], [-41.57, -4.40], [-41.71, -4.37], [-41.96, -4.27], 
    [-42.31, -4.12], [-42.70, -3.94], [-43.10, -3.76], [-43.48, -3.61], 
    [-43.78, -3.51], [-43.96, -3.48], [-44.07, -3.47], [-44.17, -3.44], 
    [-44.25, -3.41], [-44.30, -3.36], [-44.38, -3.31], [-44.53, -3.23], 
    [-44.74, -3.15], [-44.98, -3.08], [-45.22, -3.00], [-45.43, -2.91], 
    [-45.58, -2.81], [-45.66, -2.73], [-45.75, -2.58], [-45.83, -2.57], 
    [-45.89, -2.70], [-45.92, -2.94], [-45.96, -3.28], [-46.10, -3.53], 
    [-46.32, -3.69], [-46.62, -3.74], [-46.95, -3.69], [-47.16, -3.52], 
    [-47.26, -3.23], [-47.25, -2.82], [-47.23, -2.61], [-47.23, -2.42], 
    [-47.25, -2.29], [-47.30, -2.22], [-47.34, -2.17], [-47.38, -2.09], 
    [-47.41, -2.00], [-47.41, -1.90], [-47.49, -1.75], [-47.70, -1.54], 
    [-48.04, -1.27], [-48.50, -0.95], [-49.32, -0.36], [-49.80, 0.17], 
    [-50.00, 0.70], [-49.95, 1.29], [-49.59, 2.16], [-48.99, 2.78], 
    [-48.11, 3.18], [-46.91, 3.41], [-46.02, 3.51], [-45.48, 3.64], 
    [-45.07, 3.86], [-44.61, 4.26], [-44.36, 4.49], [-44.14, 4.67], 
    [-43.96, 4.80], [-43.86, 4.84], [-43.73, 4.91], [-43.46, 5.11], 
    [-43.09, 5.39], [-42.67, 5.75], [-41.94, 6.32], [-41.33, 6.68], 
    [-40.70, 6.90], [-39.94, 7.03], [-39.65, 7.06], [-39.35, 7.10], 
    [-39.06, 7.14], [-38.83, 7.16], [-37.67, 7.22], [-36.05, 7.19], 
    [-34.43, 7.09], [-33.29, 6.95], [-32.98, 6.89], [-32.57, 6.82], 
    [-32.13, 6.75], [-31.70, 6.69], [-31.12, 6.61], [-30.28, 6.46], 
    [-29.29, 6.27], [-28.27, 6.06], [-26.81, 5.77], [-25.96, 5.66], 
    [-25.59, 5.73], [-25.58, 5.97], [-25.60, 6.06], [-25.56, 6.12], 
    [-25.47, 6.15], [-25.32, 6.16], [-24.97, 6.12], [-24.62, 6.01], 
    [-24.40, 5.89], [-24.41, 5.80], [-24.47, 5.76], [-24.52, 5.69], 
    [-24.56, 5.61], [-24.57, 5.52], [-24.48, 5.39], [-24.17, 5.26], 
    [-23.52, 5.10], [-22.45, 4.88], [-21.61, 4.73], [-20.88, 4.61], 
    [-20.34, 4.55], [-20.08, 4.54], [-19.97, 4.59], [-19.84, 4.67], 
    [-19.73, 4.79], [-19.63, 4.91], [-19.53, 5.09], [-19.52, 5.23], 
    [-19.61, 5.40], [-19.82, 5.64], [-19.97, 5.81], [-20.10, 5.98], 
    [-20.18, 6.12], [-20.21, 6.22], [-20.05, 6.51], [-19.64, 6.79], 
    [-19.11, 7.00], [-18.56, 7.09], [-18.40, 7.12], [-18.28, 7.24], 
    [-18.17, 7.51], [-18.04, 7.98], [-17.93, 8.38], [-17.79, 8.81], 
    [-17.64, 9.22], [-17.50, 9.55], [-17.37, 9.83], [-17.27, 10.09], 
    [-17.20, 10.29], [-17.18, 10.41], [-17.06, 10.80], [-16.78, 11.41], 
    [-16.47, 11.99], [-16.25, 12.30], [-16.03, 12.35], [-15.92, 12.12], 
    [-15.93, 11.58], [-16.05, 10.69], [-16.15, 10.05], [-16.24, 9.37], 
    [-16.32, 8.72], [-16.37, 8.19], [-16.45, 7.12], [-14.92, 7.04], 
    [-13.50, 6.91], [-11.53, 6.70], [-9.50, 6.45], [-7.93, 6.22], 
    [-7.47, 6.15], [-6.23, 7.93], [-5.51, 8.96], [-5.08, 9.50], 
    [-4.76, 9.72], [-4.39, 9.81], [-3.28, 9.79], [-1.64, 9.58], 
    [0.03, 9.27], [1.24, 8.92], [1.39, 8.87], [1.58, 8.81], 
    [1.79, 8.74], [2.01, 8.69], [2.47, 8.55], [2.89, 8.39], 
    [3.18, 8.23], [3.29, 8.12], [3.32, 8.08], [3.41, 8.03], 
    [3.53, 7.98], [3.69, 7.94], [3.84, 7.90], [3.95, 7.85], 
    [4.02, 7.80], [4.02, 7.76], [4.04, 7.59], [4.15, 7.21], 
    [4.32, 6.68], [4.54, 6.04], [4.81, 5.24], [4.96, 4.72], 
    [5.00, 4.42], [4.94, 4.27], [4.90, 4.17], [4.97, 4.04], 
    [5.19, 3.85], [5.57, 3.59], [6.37, 3.06], [6.95, 1.26], 
    [7.24, 0.38], [7.46, -0.18], [7.63, -0.50], [7.78, -0.61], 
    [7.89, -0.66], [7.97, -0.74], [8.03, -0.83], [8.05, -0.94], 
    [8.07, -1.08], [8.19, -1.17], [8.43, -1.23], [8.83, -1.29], 
    [9.15, -1.33], [9.41, -1.39], [9.61, -1.45], [9.70, -1.50], 
    [9.80, -1.61], [9.91, -1.60], [10.02, -1.45], [10.14, -1.16], 
    [10.24, -0.93], [10.34, -0.80], [10.45, -0.73], [10.59, -0.73], 
    [10.74, -0.78], [10.84, -0.88], [10.92, -1.06], [10.99, -1.33], 
    [11.06, -1.65], [11.15, -1.82], [11.31, -1.88], [11.59, -1.89], 
    [12.42, -1.92], [14.62, -2.00], [18.76, -2.16], [25.40, -2.43], 
    [27.12, -2.49], [28.31, -2.51], [29.07, -2.49], [29.52, -2.42], 
    [30.04, -2.20], [30.53, -1.88], [30.88, -1.54], [30.96, -1.28], 
    [30.95, -1.21], [30.95, -1.16], [30.97, -1.15], [31.01, -1.16], 
    [31.29, -0.93], [32.01, -0.08], [33.25, 1.47], [35.05, 3.78], 
    [35.56, 4.44], [36.08, 5.11], [36.56, 5.72], [36.92, 6.18], 
    [37.34, 6.71], [37.57, 7.05], [37.61, 7.19], [37.47, 7.14], 
    [37.41, 7.11], [37.38, 7.11], [37.38, 7.14], [37.41, 7.20], 
    [37.46, 7.25], [37.51, 7.29], [37.57, 7.30], [37.62, 7.28], 
    [37.86, 7.48], [38.57, 8.33], [39.96, 10.10], [42.25, 13.07], 
    [43.08, 14.11], [43.66, 14.71], [44.16, 14.99], [44.71, 15.08], 
    [46.11, 14.94], [47.57, 14.49], [48.73, 13.90], [49.21, 13.29], 
    [49.23, 13.16], [49.26, 12.94], [49.32, 12.67], [49.38, 12.37], 
    [49.49, 11.31], [49.52, 9.28], [49.46, 5.91], [49.32, 0.81], 
    [49.24, -1.83], [49.17, -4.23], [49.13, -6.13], [49.11, -7.27], 
    [49.10, -7.92], [49.07, -8.44], [49.03, -8.80], [48.98, -8.96], 
    [48.93, -9.01], [48.89, -9.09], [48.86, -9.18], [48.85, -9.28], 
    [48.88, -9.40], [48.96, -9.49], [49.13, -9.56], [49.38, -9.62], 
    [49.73, -9.70], [49.93, -9.79], [50.00, -9.93], [49.96, -10.12], 
    [49.86, -10.21], [49.57, -10.26], [49.02, -10.27], [48.11, -10.24], 
    [47.33, -10.22], [46.78, -10.23], [46.45, -10.26], [46.34, -10.31], 
    [46.08, -10.47], [45.33, -10.75], [44.10, -11.15], [42.40, -11.66], 
    [41.79, -11.83], [41.21, -11.87], [40.16, -11.76], [38.17, -11.47], 
    [37.11, -11.28], [36.33, -11.04], [35.76, -10.73], [35.30, -10.32], 
    [34.90, -9.86], [29.69, -11.01], [27.53, -11.48], [25.51, -11.93], 
    [23.85, -12.29], [22.77, -12.52], [22.00, -12.69], [21.18, -12.90], 
    [20.41, -13.13], [19.77, -13.34], [19.16, -13.55], [18.70, -13.68], 
    [18.35, -13.73], [18.10, -13.72], [17.79, -13.71], [17.26, -13.76], 
    [16.55, -13.87], [15.68, -14.03], [13.69, -14.40], [12.05, -14.65], 
    [10.83, -14.78], [10.08, -14.77], [9.83, -14.75], [9.64, -14.75], 
    [9.50, -14.78], [9.43, -14.84], [9.35, -14.90], [9.22, -14.93], 
    [9.04, -14.94], [8.81, -14.91], [8.57, -14.89], [8.37, -14.89], 
    [8.21, -14.92], [8.10, -14.98], [7.94, -15.06], [7.68, -15.07], 
    [7.28, -15.00], [6.66, -14.85], [5.18, -14.52], [2.96, -14.08], 
    [0.87, -13.68], [-0.20, -13.51], [-0.36, -13.50], [-0.52, -13.48], 
    [-0.66, -13.44], [-0.78, -13.40], [-0.91, -13.34], [-1.10, -13.29], 
    [-1.33, -13.23], [-1.56, -13.19], [-1.86, -13.15], [-2.03, -13.15], 
    [-2.10, -13.22], [-2.12, -13.35], [-2.31, -13.68], [-2.75, -14.15], 
    [-3.31, -14.61], [-3.81, -14.93], [-4.20, -15.04], [-4.67, -15.08], 
    [-5.14, -15.05], [-5.54, -14.96], [-5.54, -14.96] ], convexity = 10); 
	
	//        2 for F16
	if (iopt==2) polygon(points = [ [-5.05, -17.10], [-6.16, -17.01], [-7.88, -16.88], 
    [-9.98, -16.71], [-12.22, -16.54], [-17.64, -16.13], [-18.26, -16.63], 
    [-18.63, -16.89], [-18.98, -17.04], [-19.42, -17.11], [-20.06, -17.12], 
    [-21.24, -17.12], [-21.29, -16.58], [-21.35, -16.27], [-21.49, -16.07], 
    [-21.78, -15.91], [-22.31, -15.72], [-22.75, -15.56], [-23.05, -15.41], 
    [-23.21, -15.27], [-23.27, -15.11], [-23.22, -14.90], [-23.05, -14.75], 
    [-22.67, -14.64], [-22.03, -14.53], [-21.61, -14.45], [-21.38, -14.35], 
    [-21.28, -14.19], [-21.26, -13.93], [-21.25, -13.69], [-21.19, -13.54], 
    [-21.08, -13.47], [-20.91, -13.45], [-20.69, -13.43], [-20.64, -13.24], 
    [-20.81, -12.69], [-21.21, -11.58], [-21.68, -10.30], [-22.26, -11.37], 
    [-22.53, -11.85], [-22.76, -12.17], [-22.94, -12.34], [-23.09, -12.37], 
    [-23.45, -12.29], [-24.22, -12.14], [-25.30, -11.92], [-26.57, -11.68], 
    [-29.78, -11.06], [-29.78, -9.51], [-29.78, -7.97], [-30.66, -7.87], 
    [-31.07, -7.83], [-31.55, -7.79], [-32.04, -7.76], [-32.47, -7.74], 
    [-33.41, -7.71], [-35.48, -9.51], [-36.36, -10.27], [-37.22, -11.02], 
    [-37.97, -11.66], [-38.50, -12.12], [-39.44, -12.93], [-41.71, -13.12], 
    [-43.01, -13.22], [-43.79, -13.23], [-44.32, -13.15], [-44.87, -12.94], 
    [-45.35, -12.73], [-45.65, -12.52], [-45.83, -12.26], [-45.96, -11.88], 
    [-46.19, -10.86], [-46.53, -9.09], [-46.85, -7.37], [-46.99, -6.49], 
    [-46.91, -6.45], [-46.69, -6.40], [-46.37, -6.33], [-45.97, -6.24], 
    [-44.95, -6.04], [-46.60, -5.51], [-48.25, -4.97], [-48.34, -3.84], 
    [-48.37, -3.33], [-48.38, -2.76], [-48.37, -2.20], [-48.34, -1.72], 
    [-48.25, -0.72], [-47.41, -0.36], [-46.59, 0.04], [-46.29, 0.34], 
    [-46.51, 0.53], [-47.25, 0.59], [-47.89, 0.64], [-48.34, 0.84], 
    [-48.67, 1.26], [-48.98, 1.95], [-49.15, 2.39], [-49.32, 2.80], 
    [-49.48, 3.15], [-49.59, 3.37], [-49.70, 3.57], [-49.67, 3.69], 
    [-49.45, 3.76], [-48.99, 3.83], [-48.64, 3.89], [-48.38, 3.97], 
    [-48.22, 4.06], [-48.16, 4.16], [-47.95, 4.34], [-47.35, 4.48], 
    [-46.42, 4.57], [-45.20, 4.60], [-44.73, 4.61], [-44.34, 4.64], 
    [-44.08, 4.69], [-43.98, 4.75], [-44.20, 5.24], [-44.78, 6.46], 
    [-45.63, 8.22], [-46.68, 10.35], [-48.00, 12.99], [-48.88, 14.66], 
    [-49.41, 15.54], [-49.69, 15.79], [-49.84, 15.82], [-49.93, 15.90], 
    [-49.98, 16.06], [-50.00, 16.30], [-49.98, 16.50], [-49.94, 16.68], 
    [-49.87, 16.81], [-49.79, 16.88], [-49.44, 16.93], [-48.63, 16.99], 
    [-47.32, 17.07], [-45.49, 17.17], [-45.14, 17.18], [-44.63, 17.18], 
    [-44.02, 17.18], [-43.38, 17.17], [-41.86, 17.13], [-40.29, 15.75], 
    [-39.65, 15.19], [-39.08, 14.69], [-38.64, 14.30], [-38.39, 14.07], 
    [-38.16, 13.88], [-37.80, 13.58], [-37.35, 13.22], [-36.87, 12.82], 
    [-35.67, 11.84], [-34.19, 10.61], [-32.30, 9.01], [-29.87, 6.93], 
    [-28.39, 5.68], [-27.41, 4.91], [-26.74, 4.49], [-26.21, 4.29], 
    [-25.89, 4.21], [-25.61, 4.17], [-25.41, 4.15], [-25.32, 4.16], 
    [-25.40, 4.74], [-25.73, 5.96], [-26.17, 7.35], [-26.58, 8.43], 
    [-26.74, 8.81], [-26.88, 9.17], [-26.98, 9.47], [-27.03, 9.68], 
    [-27.05, 9.83], [-27.06, 9.96], [-27.08, 10.08], [-27.09, 10.16], 
    [-27.16, 10.20], [-27.35, 10.24], [-27.61, 10.27], [-27.93, 10.28], 
    [-28.40, 10.29], [-28.66, 10.35], [-28.77, 10.51], [-28.81, 10.81], 
    [-28.86, 11.11], [-28.98, 11.30], [-29.24, 11.43], [-29.68, 11.55], 
    [-30.01, 11.65], [-30.31, 11.75], [-30.54, 11.85], [-30.67, 11.93], 
    [-30.75, 12.16], [-30.59, 12.38], [-30.21, 12.56], [-29.65, 12.68], 
    [-29.21, 12.75], [-28.97, 12.85], [-28.88, 13.02], [-28.86, 13.33], 
    [-28.86, 13.87], [-27.63, 13.86], [-26.92, 13.84], [-26.49, 13.77], 
    [-26.18, 13.59], [-25.85, 13.26], [-25.32, 12.67], [-19.81, 12.47], 
    [-14.03, 12.23], [-10.73, 12.02], [-9.24, 11.75], [-8.90, 11.38], 
    [-9.24, 11.07], [-10.33, 10.85], [-12.27, 10.74], [-15.19, 10.70], 
    [-16.88, 10.69], [-18.25, 10.66], [-19.17, 10.62], [-19.48, 10.57], 
    [-19.44, 10.53], [-19.38, 10.48], [-19.30, 10.46], [-19.23, 10.45], 
    [-18.90, 10.32], [-18.14, 9.99], [-17.06, 9.49], [-15.77, 8.87], 
    [-14.10, 8.08], [-11.96, 7.09], [-9.63, 6.01], [-7.39, 4.99], 
    [-2.30, 2.69], [-1.04, 2.72], [-0.44, 2.75], [0.28, 2.79], 
    [1.03, 2.86], [1.71, 2.93], [2.53, 3.01], [3.63, 3.12], 
    [4.89, 3.24], [6.14, 3.35], [7.39, 3.47], [8.62, 3.63], 
    [9.70, 3.79], [10.48, 3.94], [13.14, 4.53], [15.38, 4.91], 
    [17.51, 5.11], [19.84, 5.17], [21.51, 5.17], [22.67, 5.12], 
    [23.51, 5.03], [24.19, 4.89], [25.33, 4.49], [26.65, 3.91], 
    [28.01, 3.21], [29.27, 2.46], [29.94, 2.05], [30.46, 1.81], 
    [31.01, 1.67], [31.76, 1.59], [32.28, 1.53], [32.72, 1.45], 
    [33.04, 1.37], [33.18, 1.30], [33.42, 1.19], [33.99, 1.02], 
    [34.81, 0.81], [35.79, 0.59], [38.21, 0.02], [40.66, -0.66], 
    [43.00, -1.40], [45.05, -2.16], [46.12, -2.57], [46.88, -2.80], 
    [47.56, -2.90], [48.42, -2.92], [49.00, -2.93], [49.49, -2.97], 
    [49.84, -3.02], [50.00, -3.09], [49.93, -3.16], [49.63, -3.21], 
    [49.11, -3.24], [48.38, -3.25], [47.61, -3.27], [46.90, -3.32], 
    [46.29, -3.41], [45.82, -3.51], [44.57, -3.83], [43.05, -4.08], 
    [41.22, -4.28], [39.06, -4.44], [37.84, -4.52], [36.83, -4.61], 
    [36.11, -4.69], [35.81, -4.77], [35.54, -4.88], [35.13, -4.92], 
    [34.72, -4.88], [34.45, -4.77], [32.21, -4.66], [27.43, -4.56], 
    [22.67, -4.52], [20.51, -4.56], [20.52, -4.60], [20.56, -4.69], 
    [20.61, -4.80], [20.68, -4.93], [20.75, -5.10], [20.73, -5.23], 
    [20.60, -5.36], [20.36, -5.50], [19.89, -5.82], [19.52, -6.22], 
    [19.26, -6.66], [19.17, -7.10], [19.16, -7.29], [19.11, -7.47], 
    [19.05, -7.62], [18.96, -7.72], [17.36, -8.04], [14.02, -8.33], 
    [9.92, -8.53], [6.06, -8.57], [4.35, -8.55], [3.35, -8.57], 
    [2.84, -8.65], [2.59, -8.81], [2.37, -8.96], [2.00, -9.05], 
    [1.37, -9.09], [0.39, -9.10], [-1.51, -9.10], [-4.66, -10.91], 
    [-6.04, -11.70], [-7.47, -12.52], [-8.79, -13.26], [-9.81, -13.84], 
    [-10.56, -14.27], [-11.13, -14.62], [-11.45, -14.86], [-11.48, -14.95], 
    [-10.14, -15.06], [-7.75, -15.31], [-5.22, -15.61], [-3.47, -15.85], 
    [-2.85, -15.96], [-2.27, -16.07], [-1.80, -16.18], [-1.50, -16.27], 
    [-1.21, -16.44], [-1.06, -16.65], [-1.08, -16.85], [-1.27, -17.00], 
    [-1.85, -17.12], [-2.74, -17.18], [-3.84, -17.18], [-5.05, -17.10], 
    [-5.05, -17.10] ], convexity = 10); 
	
	//        3 for F22
	if (iopt==3) polygon(points = [ [-22.53, -49.53], [-23.43, -49.34], [-24.82, -49.07], 
    [-26.50, -48.75], [-28.28, -48.42], [-32.57, -47.62], [-32.57, -44.42], 
    [-32.57, -41.22], [-26.47, -37.22], [-23.37, -35.16], [-21.60, -33.93], 
    [-20.89, -33.30], [-20.97, -33.09], [-25.65, -32.03], [-29.35, -31.20], 
    [-31.83, -30.63], [-32.88, -30.38], [-33.09, -30.24], [-33.23, -29.92], 
    [-33.30, -29.33], [-33.34, -28.39], [-33.37, -26.53], [-33.52, -28.02], 
    [-33.58, -28.61], [-33.66, -29.11], [-33.73, -29.47], [-33.78, -29.63], 
    [-34.19, -29.62], [-35.22, -29.52], [-36.71, -29.34], [-38.50, -29.10], 
    [-40.60, -28.79], [-42.21, -28.50], [-43.36, -28.23], [-44.07, -27.97], 
    [-44.64, -27.68], [-45.48, -27.24], [-46.48, -26.72], [-47.52, -26.18], 
    [-50.00, -24.89], [-50.00, -22.27], [-50.00, -19.66], [-43.77, -15.36], 
    [-40.86, -13.35], [-37.55, -11.04], [-34.25, -8.72], [-31.36, -6.68], 
    [-28.70, -4.79], [-26.01, -2.88], [-23.61, -1.18], [-21.80, 0.09], 
    [-20.41, 1.08], [-19.13, 2.01], [-18.09, 2.79], [-17.45, 3.29], 
    [-17.05, 3.62], [-16.69, 3.93], [-16.40, 4.17], [-16.22, 4.31], 
    [-16.05, 4.90], [-15.77, 6.36], [-15.42, 8.47], [-15.05, 11.01], 
    [-14.68, 13.59], [-14.36, 15.80], [-14.12, 17.41], [-14.00, 18.19], 
    [-13.77, 18.65], [-13.14, 19.32], [-12.03, 20.30], [-10.34, 21.68], 
    [-8.94, 22.79], [-7.75, 23.74], [-6.90, 24.43], [-6.51, 24.76], 
    [-6.36, 25.18], [-6.19, 26.17], [-6.02, 27.63], [-5.84, 29.50], 
    [-5.49, 32.83], [-5.01, 35.99], [-4.39, 39.02], [-3.63, 41.96], 
    [-3.04, 43.83], [-2.39, 45.37], [-1.61, 46.76], [-0.60, 48.21], 
    [0.64, 49.86], [1.81, 48.10], [2.29, 47.37], [2.71, 46.68], 
    [3.03, 46.10], [3.21, 45.72], [3.32, 45.45], [3.43, 45.15], 
    [3.53, 44.86], [3.62, 44.62], [3.70, 44.40], [3.77, 44.14], 
    [3.84, 43.88], [3.89, 43.66], [3.95, 43.45], [4.06, 43.24], 
    [4.19, 43.05], [4.34, 42.90], [4.50, 42.71], [4.66, 42.37], 
    [4.81, 41.93], [4.93, 41.45], [5.03, 40.94], [5.14, 40.44], 
    [5.23, 39.99], [5.30, 39.66], [5.78, 37.31], [6.15, 34.86], 
    [6.43, 32.31], [6.61, 29.65], [6.72, 27.96], [6.83, 26.55], 
    [6.95, 25.57], [7.06, 25.17], [7.44, 24.90], [8.29, 24.26], 
    [9.49, 23.36], [10.92, 22.29], [14.54, 19.56], [15.31, 13.21], 
    [15.61, 10.70], [15.85, 8.54], [16.01, 6.97], [16.07, 6.22], 
    [16.11, 5.80], [16.30, 5.43], [16.75, 4.97], [17.57, 4.27], 
    [20.54, 2.21], [26.88, -2.02], [34.90, -7.29], [42.90, -12.49], 
    [50.00, -17.07], [49.86, -17.93], [49.80, -18.40], [49.76, -19.03], 
    [49.73, -19.76], [49.71, -20.49], [49.71, -22.20], [46.14, -24.20], 
    [42.57, -26.21], [38.70, -26.93], [37.13, -27.22], [35.73, -27.47], 
    [34.65, -27.67], [34.04, -27.78], [33.25, -27.92], [33.25, -26.86], 
    [33.24, -26.39], [33.19, -26.13], [33.12, -26.05], [33.01, -26.17], 
    [32.92, -26.39], [32.85, -26.72], [32.79, -27.12], [32.77, -27.54], 
    [32.75, -28.02], [32.68, -28.36], [32.55, -28.57], [32.35, -28.68], 
    [30.04, -29.35], [26.62, -30.32], [23.34, -31.22], [21.46, -31.72], 
    [20.96, -31.85], [20.56, -31.98], [20.29, -32.10], [20.19, -32.18], 
    [20.24, -32.27], [20.38, -32.41], [20.59, -32.57], [20.85, -32.73], 
    [21.51, -33.13], [22.81, -33.93], [24.57, -35.01], [26.60, -36.26], 
    [31.68, -39.40], [31.68, -42.64], [31.68, -45.87], [29.14, -46.51], 
    [26.18, -47.24], [23.21, -47.94], [20.87, -48.47], [19.80, -48.68], 
    [19.40, -48.49], [18.50, -48.00], [17.23, -47.27], [15.74, -46.37], 
    [14.11, -45.40], [12.49, -44.46], [11.06, -43.66], [10.01, -43.10], 
    [8.08, -42.13], [8.06, -40.87], [8.05, -40.33], [8.05, -39.81], 
    [8.06, -39.37], [8.08, -39.05], [8.08, -38.84], [8.05, -38.67], 
    [7.99, -38.55], [7.92, -38.51], [7.54, -38.70], [6.77, -39.18], 
    [5.81, -39.83], [4.83, -40.54], [4.60, -40.55], [4.18, -40.38], 
    [3.59, -40.04], [2.84, -39.53], [1.13, -38.31], [0.98, -39.56], 
    [0.92, -40.10], [0.87, -40.66], [0.84, -41.17], [0.83, -41.55], 
    [0.67, -42.23], [0.25, -42.66], [-0.33, -42.77], [-0.98, -42.53], 
    [-1.31, -42.27], [-1.50, -41.93], [-1.58, -41.37], [-1.60, -40.44], 
    [-1.61, -39.78], [-1.65, -39.25], [-1.71, -38.89], [-1.78, -38.75], 
    [-1.96, -38.84], [-2.33, -39.07], [-2.83, -39.42], [-3.41, -39.84], 
    [-3.98, -40.26], [-4.47, -40.59], [-4.82, -40.81], [-4.98, -40.87], 
    [-5.92, -40.32], [-6.96, -39.60], [-7.80, -38.92], [-8.16, -38.51], 
    [-8.25, -38.38], [-8.39, -38.97], [-8.52, -39.97], [-8.59, -41.05], 
    [-8.62, -42.50], [-10.60, -43.59], [-11.69, -44.22], [-13.17, -45.12], 
    [-14.87, -46.19], [-16.57, -47.28], [-18.14, -48.29], [-19.46, -49.11], 
    [-20.40, -49.66], [-20.82, -49.86], [-21.03, -49.83], [-21.43, -49.75], 
    [-21.95, -49.65], [-22.53, -49.53], [-22.53, -49.53] ], convexity = 10); 
	
	//        4 for F35 JSF
	if (iopt==4) polygon(points = [ [-4.20, -47.64], [-7.35, -46.73], [-9.95, -45.96], 
    [-11.73, -45.43], [-12.42, -45.20], [-12.31, -44.76], [-11.90, -43.67], 
    [-11.25, -42.08], [-10.43, -40.15], [-9.05, -36.90], [-7.86, -33.99], 
    [-7.02, -31.85], [-6.70, -30.87], [-6.87, -30.91], [-7.33, -31.12], 
    [-8.01, -31.46], [-8.84, -31.90], [-10.07, -32.54], [-10.87, -32.82], 
    [-11.55, -32.77], [-12.39, -32.47], [-13.63, -31.82], [-14.33, -31.04], 
    [-14.59, -29.88], [-14.53, -28.11], [-14.32, -25.60], [-15.90, -27.34], 
    [-16.80, -28.35], [-18.06, -29.83], [-19.53, -31.58], [-21.03, -33.40], 
    [-22.43, -35.08], [-23.64, -36.46], [-24.53, -37.39], [-24.97, -37.73], 
    [-25.60, -37.24], [-27.04, -35.93], [-29.06, -33.99], [-31.46, -31.61], 
    [-37.55, -25.50], [-35.35, -21.90], [-33.47, -18.87], [-32.14, -17.42], 
    [-30.45, -16.97], [-27.48, -16.95], [-24.97, -16.92], [-23.38, -16.79], 
    [-22.25, -16.48], [-21.14, -15.93], [-19.31, -14.90], [-27.83, -6.42], 
    [-31.13, -3.11], [-33.84, -0.38], [-35.67, 1.49], [-36.34, 2.21], 
    [-35.66, 3.45], [-34.11, 6.01], [-32.44, 8.70], [-31.38, 10.30], 
    [-30.61, 10.88], [-28.93, 11.25], [-25.63, 11.50], [-19.98, 11.72], 
    [-10.53, 12.05], [-5.41, 12.38], [-2.87, 12.90], [-1.13, 13.80], 
    [0.26, 14.74], [1.54, 16.04], [3.24, 18.29], [5.83, 22.09], 
    [8.04, 25.31], [9.74, 27.62], [11.01, 29.12], [11.94, 29.92], 
    [12.96, 30.47], [13.61, 30.45], [14.01, 29.78], [14.32, 28.37], 
    [14.43, 27.81], [14.56, 27.35], [14.70, 27.04], [14.81, 26.93], 
    [15.82, 27.72], [17.95, 29.99], [21.05, 33.59], [24.99, 38.36], 
    [28.72, 42.87], [31.23, 45.63], [33.25, 47.36], [35.53, 48.82], 
    [37.55, 50.00], [37.54, 47.80], [37.39, 45.41], [36.74, 42.83], 
    [35.28, 39.14], [32.71, 33.41], [30.04, 27.55], [28.48, 23.89], 
    [27.73, 21.78], [27.55, 20.53], [27.62, 19.95], [27.94, 19.69], 
    [28.67, 19.71], [29.95, 19.97], [31.40, 20.30], [31.40, 18.75], 
    [31.22, 17.66], [30.60, 16.07], [29.35, 13.59], [27.32, 9.89], 
    [24.99, 5.69], [23.76, 3.18], [23.23, 1.48], [23.05, -0.30], 
    [23.00, -1.52], [23.03, -2.61], [23.11, -3.47], [23.26, -4.01], 
    [26.08, -9.76], [29.82, -17.49], [33.08, -24.31], [34.48, -27.33], 
    [34.38, -27.56], [34.14, -27.99], [33.77, -28.56], [33.32, -29.20], 
    [32.87, -29.83], [32.51, -30.38], [32.26, -30.77], [32.17, -30.97], 
    [31.66, -31.98], [30.52, -33.75], [29.32, -35.44], [28.64, -36.19], 
    [27.93, -36.02], [26.27, -35.56], [23.91, -34.88], [21.08, -34.05], 
    [12.29, -31.46], [7.34, -30.04], [5.10, -29.48], [4.43, -29.47], 
    [4.12, -29.93], [4.16, -30.71], [4.56, -31.85], [5.32, -33.36], 
    [5.93, -34.47], [6.66, -35.83], [7.42, -37.26], [8.11, -38.59], 
    [9.65, -41.57], [8.72, -43.21], [7.30, -45.60], [5.89, -47.80], 
    [4.75, -49.40], [4.17, -50.00], [3.42, -49.80], [1.59, -49.29], 
    [-1.04, -48.54], [-4.20, -47.64], [-4.20, -47.64] ], convexity = 10); 
	
	//        5 for F117 Nighthawk 
	if (iopt==5) polygon(points = [ [-5.78, -35.80], [-5.92, -35.08], [-6.06, -34.36], 
    [-6.18, -33.71], [-6.27, -33.22], [-6.55, -32.39], [-6.99, -32.13], 
    [-7.43, -32.44], [-7.75, -33.32], [-7.83, -33.72], [-7.92, -33.90], 
    [-8.02, -33.88], [-8.19, -33.68], [-8.31, -33.44], [-8.38, -33.10], 
    [-8.40, -32.66], [-8.37, -32.11], [-8.32, -31.42], [-8.39, -30.96], 
    [-8.66, -30.54], [-9.18, -29.96], [-11.77, -27.16], [-15.25, -23.30], 
    [-18.38, -19.78], [-19.86, -18.03], [-20.21, -17.59], [-20.89, -16.83], 
    [-21.80, -15.86], [-22.85, -14.77], [-23.94, -13.64], [-24.99, -12.54], 
    [-25.86, -11.59], [-26.45, -10.92], [-26.92, -10.37], [-27.48, -9.74], 
    [-28.05, -9.11], [-28.56, -8.56], [-29.04, -8.05], [-29.53, -7.54], 
    [-29.96, -7.07], [-30.28, -6.72], [-31.90, -4.93], [-35.73, -0.70], 
    [-41.32, 5.49], [-48.25, 13.14], [-50.00, 15.08], [-49.44, 16.07], 
    [-49.08, 16.65], [-48.66, 17.02], [-47.93, 17.34], [-46.62, 17.76], 
    [-45.70, 18.05], [-44.87, 18.30], [-44.21, 18.50], [-43.83, 18.61], 
    [-43.29, 18.63], [-42.49, 18.43], [-41.37, 17.98], [-39.86, 17.27], 
    [-39.13, 16.93], [-38.24, 16.56], [-37.31, 16.19], [-36.44, 15.88], 
    [-35.22, 15.44], [-33.32, 14.72], [-31.01, 13.82], [-28.54, 12.85], 
    [-22.57, 10.45], [-20.94, 12.06], [-19.32, 13.67], [-12.17, 15.94], 
    [-9.38, 16.83], [-7.06, 17.57], [-5.47, 18.10], [-4.84, 18.32], 
    [-4.76, 18.39], [-4.71, 18.49], [-4.67, 18.61], [-4.65, 18.73], 
    [-4.92, 19.46], [-5.65, 21.23], [-6.73, 23.76], [-8.05, 26.80], 
    [-9.37, 29.89], [-10.49, 32.53], [-11.26, 34.45], [-11.59, 35.38], 
    [-11.65, 35.82], [-11.61, 36.15], [-11.43, 36.46], [-11.10, 36.82], 
    [-10.83, 37.07], [-10.55, 37.27], [-10.31, 37.40], [-10.13, 37.45], 
    [-9.81, 37.11], [-9.18, 36.08], [-8.25, 34.36], [-7.00, 31.94], 
    [-4.58, 27.27], [-2.46, 23.40], [-0.88, 20.75], [-0.09, 19.73], 
    [0.32, 20.14], [1.24, 21.47], [2.68, 23.77], [4.69, 27.09], 
    [6.48, 30.06], [8.04, 32.68], [9.21, 34.65], [9.82, 35.70], 
    [10.27, 36.45], [10.61, 36.87], [10.87, 36.99], [11.07, 36.82], 
    [11.17, 36.74], [11.33, 36.66], [11.52, 36.62], [11.74, 36.60], 
    [11.95, 36.58], [12.15, 36.52], [12.29, 36.42], [12.38, 36.31], 
    [11.38, 34.06], [9.02, 29.16], [6.45, 23.95], [4.78, 20.76], 
    [4.46, 20.12], [4.18, 19.40], [4.00, 18.79], [3.98, 18.46], 
    [4.60, 18.18], [6.19, 17.57], [8.51, 16.72], [11.32, 15.71], 
    [18.54, 13.16], [19.69, 11.38], [20.31, 10.45], [20.73, 9.92], 
    [21.04, 9.71], [21.33, 9.71], [22.80, 10.24], [26.28, 11.55], 
    [31.41, 13.52], [37.83, 16.00], [41.06, 17.25], [42.82, 17.78], 
    [44.02, 17.76], [45.57, 17.33], [46.50, 17.06], [47.31, 16.83], 
    [47.91, 16.64], [48.21, 16.54], [48.35, 16.49], [48.49, 16.46], 
    [48.61, 16.44], [48.70, 16.44], [48.76, 16.44], [48.81, 16.39], 
    [48.84, 16.32], [48.86, 16.22], [48.90, 16.06], [49.02, 15.80], 
    [49.21, 15.48], [49.43, 15.14], [50.00, 14.32], [48.73, 13.03], 
    [46.54, 10.88], [41.50, 5.98], [34.37, -0.95], [25.90, -9.17], 
    [14.81, -19.94], [8.25, -26.39], [5.13, -29.59], [4.34, -30.66], 
    [4.32, -30.89], [4.28, -31.08], [4.21, -31.21], [4.13, -31.25], 
    [4.05, -31.31], [3.99, -31.46], [3.95, -31.68], [3.95, -31.95], 
    [3.92, -32.56], [3.82, -33.09], [3.66, -33.47], [3.47, -33.61], 
    [3.39, -33.55], [3.32, -33.39], [3.28, -33.15], [3.27, -32.85], 
    [3.14, -32.10], [2.66, -32.06], [1.65, -32.83], [-0.07, -34.48], 
    [-1.75, -36.14], [-2.66, -36.80], [-3.18, -36.57], [-3.70, -35.57], 
    [-4.10, -34.99], [-4.44, -34.92], [-4.69, -35.34], [-4.82, -36.23], 
    [-4.95, -37.21], [-5.18, -37.45], [-5.47, -36.98], [-5.78, -35.80], 
    [-5.78, -35.80] ], convexity = 10); 
	
	//        6 for KMAX Helicopter 
	if (iopt==6) difference() { 
    polygon(points = [ [-17.72, -32.12], [-17.55, -31.52], [-17.18, -30.13], 
        [-16.50, -27.52], [-15.41, -23.27], [-14.51, -19.41], [-13.58, -14.87], 
        [-12.84, -10.86], [-12.54, -8.60], [-12.57, -8.34], [-12.64, -8.20], 
        [-12.79, -8.17], [-13.04, -8.22], [-13.62, -8.24], [-14.16, -7.97], 
        [-14.55, -7.50], [-14.70, -6.90], [-14.69, -6.62], [-14.64, -6.39], 
        [-14.58, -6.24], [-14.51, -6.18], [-14.22, -5.89], [-13.81, -5.23], 
        [-13.43, -4.49], [-13.26, -4.00], [-13.33, -3.87], [-13.51, -3.69], 
        [-13.78, -3.49], [-14.10, -3.28], [-14.43, -3.06], [-14.69, -2.83], 
        [-14.88, -2.61], [-14.94, -2.44], [-14.98, -2.31], [-15.10, -2.20], 
        [-15.27, -2.12], [-15.48, -2.09], [-15.78, -2.07], [-16.18, -2.05], 
        [-16.64, -2.02], [-17.10, -1.98], [-17.90, -1.92], [-19.27, -1.81], 
        [-21.02, -1.67], [-22.97, -1.52], [-25.06, -1.36], [-27.23, -1.19], 
        [-29.20, -1.03], [-30.73, -0.90], [-31.89, -0.81], [-32.85, -0.75], 
        [-33.51, -0.73], [-33.78, -0.74], [-33.80, -0.83], [-33.77, -1.03], 
        [-33.72, -1.30], [-33.64, -1.61], [-33.55, -2.02], [-33.54, -2.38], 
        [-33.61, -2.72], [-33.76, -3.08], [-34.01, -3.58], [-34.08, -3.86], 
        [-33.96, -3.99], [-33.64, -4.09], [-33.21, -4.37], [-32.92, -4.86], 
        [-32.81, -5.43], [-32.92, -5.95], [-33.26, -6.40], [-33.68, -6.69], 
        [-34.14, -6.78], [-34.59, -6.67], [-35.07, -6.30], [-35.32, -5.83], 
        [-35.35, -5.18], [-35.17, -4.27], [-34.95, -3.27], [-34.85, -2.37], 
        [-34.86, -1.62], [-34.98, -1.05], [-35.12, -0.87], [-35.39, -0.75], 
        [-35.84, -0.69], [-36.50, -0.67], [-37.24, -0.65], [-37.69, -0.57], 
        [-37.96, -0.39], [-38.15, -0.06], [-38.36, 0.62], [-38.41, 1.27], 
        [-38.29, 1.84], [-38.01, 2.26], [-37.53, 2.57], [-36.52, 3.14], 
        [-35.15, 3.89], [-33.55, 4.74], [-31.68, 5.74], [-30.39, 6.49], 
        [-29.62, 7.04], [-29.30, 7.41], [-29.13, 7.74], [-28.81, 8.22], 
        [-28.41, 8.78], [-27.95, 9.37], [-27.44, 10.00], [-26.89, 10.69], 
        [-26.38, 11.34], [-25.96, 11.89], [-25.52, 12.45], [-24.91, 13.17], 
        [-24.24, 13.93], [-23.57, 14.66], [-21.93, 16.16], [-20.19, 17.11], 
        [-18.05, 17.64], [-15.21, 17.87], [-13.91, 17.91], [-13.13, 19.94], 
        [-12.82, 20.75], [-12.56, 21.47], [-12.39, 22.00], [-12.32, 22.27], 
        [-12.78, 22.58], [-14.13, 22.48], [-16.28, 22.01], [-19.14, 21.18], 
        [-20.92, 20.88], [-23.45, 20.71], [-25.71, 20.70], [-26.68, 20.88], 
        [-26.52, 20.99], [-26.03, 21.07], [-25.25, 21.12], [-24.18, 21.14], 
        [-22.32, 21.20], [-20.54, 21.42], [-18.79, 21.79], [-16.98, 22.33], 
        [-15.54, 22.82], [-17.70, 22.72], [-18.98, 22.65], [-20.87, 22.54], 
        [-23.13, 22.40], [-25.49, 22.24], [-28.26, 22.08], [-31.65, 21.91], 
        [-35.22, 21.75], [-38.56, 21.62], [-43.22, 21.48], [-45.81, 21.53], 
        [-47.37, 21.89], [-48.91, 22.64], [-49.99, 23.29], [-50.00, 23.64], 
        [-48.79, 23.75], [-46.19, 23.68], [-44.41, 23.62], [-43.12, 23.61], 
        [-42.29, 23.66], [-41.91, 23.76], [-41.55, 23.87], [-40.75, 23.90], 
        [-39.48, 23.86], [-37.68, 23.76], [-35.61, 23.67], [-33.04, 23.62], 
        [-30.19, 23.61], [-27.28, 23.65], [-24.51, 23.69], [-21.75, 23.69], 
        [-19.32, 23.65], [-17.53, 23.57], [-15.77, 23.46], [-14.59, 23.45], 
        [-13.73, 23.54], [-12.93, 23.75], [-12.09, 24.03], [-11.54, 24.27], 
        [-11.35, 24.43], [-11.55, 24.49], [-11.83, 24.56], [-11.78, 24.74], 
        [-11.44, 24.96], [-10.87, 25.18], [-10.50, 25.31], [-10.19, 25.46], 
        [-9.98, 25.60], [-9.91, 25.73], [-9.85, 25.82], [-9.70, 25.87], 
        [-9.45, 25.88], [-9.11, 25.83], [-8.67, 25.79], [-8.24, 25.85], 
        [-7.76, 26.03], [-7.17, 26.34], [-5.49, 27.30], [-3.66, 28.30], 
        [-1.99, 29.19], [-0.80, 29.77], [-0.19, 30.06], [0.69, 30.48], 
        [1.70, 30.97], [2.75, 31.48], [3.72, 31.94], [4.54, 32.29], 
        [5.11, 32.50], [5.36, 32.54], [5.45, 32.43], [5.33, 32.28], 
        [4.88, 32.00], [3.93, 31.46], [3.37, 31.14], [2.87, 30.83], 
        [2.48, 30.57], [2.25, 30.40], [0.74, 29.34], [-1.68, 27.93], 
        [-4.06, 26.70], [-5.43, 26.17], [-6.19, 25.97], [-7.20, 25.51], 
        [-8.07, 24.99], [-8.39, 24.63], [-8.29, 24.53], [-8.06, 24.46], 
        [-7.74, 24.43], [-7.37, 24.43], [-6.82, 24.46], [-6.01, 24.51], 
        [-5.04, 24.56], [-4.04, 24.62], [-2.88, 24.69], [-1.50, 24.81], 
        [-0.07, 24.95], [1.23, 25.09], [2.61, 25.26], [4.25, 25.45], 
        [5.93, 25.64], [7.45, 25.81], [8.76, 25.97], [9.86, 26.14], 
        [10.62, 26.29], [10.94, 26.41], [11.48, 26.66], [12.74, 26.95], 
        [14.60, 27.28], [16.93, 27.62], [17.83, 27.75], [18.61, 27.88], 
        [19.17, 28.00], [19.45, 28.10], [20.05, 28.29], [21.30, 28.59], 
        [22.82, 28.90], [24.24, 29.15], [24.58, 29.21], [25.14, 29.32], 
        [25.85, 29.45], [26.64, 29.61], [27.44, 29.76], [28.20, 29.91], 
        [28.84, 30.03], [29.27, 30.10], [29.84, 30.20], [30.85, 30.38], 
        [32.17, 30.61], [33.64, 30.87], [37.30, 31.51], [38.75, 30.94], 
        [39.78, 30.43], [40.67, 29.83], [41.24, 29.27], [41.31, 28.91], 
        [39.97, 28.59], [37.14, 28.07], [34.17, 27.58], [32.43, 27.37], 
        [32.10, 27.35], [31.91, 27.28], [31.86, 27.14], [31.90, 26.91], 
        [31.93, 26.57], [31.59, 26.34], [30.61, 26.15], [28.75, 25.91], 
        [27.52, 25.78], [26.60, 25.74], [25.89, 25.78], [25.28, 25.91], 
        [24.10, 26.01], [21.77, 25.88], [17.79, 25.47], [11.66, 24.73], 
        [8.79, 24.38], [6.67, 24.17], [5.04, 24.05], [3.63, 24.01], 
        [2.76, 23.99], [1.82, 23.94], [0.91, 23.86], [0.16, 23.77], 
        [-1.65, 23.43], [-3.53, 23.00], [-5.00, 22.58], [-5.60, 22.30], 
        [-5.50, 22.19], [-5.24, 22.04], [-4.85, 21.87], [-4.38, 21.69], 
        [-3.17, 21.26], [-3.31, 20.18], [-3.34, 19.65], [-3.31, 19.05], 
        [-3.23, 18.44], [-3.11, 17.86], [-2.92, 17.05], [-2.90, 16.59], 
        [-3.10, 16.39], [-3.54, 16.33], [-3.83, 16.23], [-3.17, 15.99], 
        [-1.69, 15.65], [0.49, 15.24], [2.49, 14.87], [3.71, 14.55], 
        [4.31, 14.22], [4.47, 13.82], [4.57, 13.56], [4.89, 13.38], 
        [5.41, 13.27], [6.16, 13.23], [6.87, 13.12], [7.32, 12.78], 
        [7.53, 12.22], [7.48, 11.43], [7.28, 10.74], [6.93, 10.36], 
        [6.34, 10.24], [5.41, 10.34], [4.90, 10.41], [4.47, 10.46], 
        [4.17, 10.49], [4.04, 10.48], [4.00, 10.38], [3.95, 10.18], 
        [3.89, 9.89], [3.83, 9.54], [3.76, 9.05], [3.81, 8.79], 
        [4.04, 8.68], [4.50, 8.66], [5.58, 8.56], [6.77, 8.33], 
        [7.77, 8.05], [8.26, 7.79], [8.38, 7.67], [8.56, 7.55], 
        [8.80, 7.44], [9.06, 7.36], [9.41, 7.29], [9.62, 7.37], 
        [9.75, 7.67], [9.86, 8.24], [10.08, 9.27], [10.36, 9.84], 
        [10.80, 10.05], [11.50, 10.01], [12.01, 9.91], [12.65, 9.76], 
        [13.35, 9.57], [14.01, 9.36], [15.53, 8.86], [15.45, 7.51], 
        [15.37, 6.16], [16.69, 6.02], [17.26, 5.95], [17.85, 5.86], 
        [18.37, 5.78], [18.77, 5.70], [19.20, 5.62], [19.46, 5.68], 
        [19.63, 5.94], [19.79, 6.44], [19.89, 6.82], [19.97, 7.18], 
        [20.02, 7.47], [20.04, 7.66], [20.37, 7.91], [21.22, 7.94], 
        [22.42, 7.77], [23.77, 7.40], [24.64, 7.09], [25.15, 6.83], 
        [25.41, 6.56], [25.51, 6.23], [25.60, 5.89], [25.86, 5.69], 
        [26.50, 5.57], [27.67, 5.48], [30.56, 5.36], [34.43, 5.31], 
        [37.84, 5.32], [39.38, 5.41], [39.62, 6.04], [40.16, 7.66], 
        [40.93, 10.04], [41.85, 12.91], [43.34, 17.56], [44.25, 19.81], 
        [45.01, 20.43], [46.06, 20.17], [46.44, 20.06], [46.85, 19.96], 
        [47.23, 19.87], [47.54, 19.82], [47.80, 19.77], [48.06, 19.68], 
        [48.28, 19.56], [48.43, 19.42], [48.58, 19.26], [48.80, 19.07], 
        [49.07, 18.86], [49.34, 18.67], [49.60, 18.48], [49.81, 18.25], 
        [49.95, 18.03], [50.00, 17.84], [49.94, 17.49], [49.76, 16.84], 
        [49.51, 15.99], [49.20, 15.03], [48.75, 13.66], [48.12, 11.71], 
        [47.39, 9.43], [46.64, 7.09], [44.89, 1.55], [43.31, 1.39], 
        [40.53, 1.09], [38.54, 0.82], [37.33, 0.57], [36.88, 0.35], 
        [36.56, 0.13], [35.97, 0.05], [35.40, 0.11], [35.14, 0.32], 
        [34.42, 0.49], [32.80, 0.43], [31.12, 0.22], [30.20, -0.09], 
        [29.86, -0.33], [29.37, -0.42], [28.88, -0.37], [28.50, -0.16], 
        [28.26, -0.05], [27.81, 0.00], [27.13, -0.00], [26.22, -0.06], 
        [24.20, -0.23], [23.89, -1.79], [23.75, -2.40], [23.58, -2.92], 
        [23.42, -3.29], [23.28, -3.46], [22.45, -3.47], [20.98, -3.30], 
        [19.46, -3.04], [18.47, -2.78], [18.18, -2.61], [18.02, -2.41], 
        [17.98, -2.10], [18.04, -1.63], [18.18, -0.75], [16.06, -0.86], 
        [15.20, -0.92], [14.45, -1.02], [13.88, -1.14], [13.58, -1.26], 
        [13.04, -1.55], [12.37, -1.71], [11.70, -1.73], [11.19, -1.58], 
        [10.78, -1.46], [10.00, -1.42], [8.72, -1.47], [6.83, -1.60], 
        [5.23, -1.72], [3.77, -1.81], [2.61, -1.87], [1.91, -1.88], 
        [1.51, -1.89], [1.16, -1.94], [0.90, -2.00], [0.77, -2.08], 
        [0.73, -2.29], [0.74, -2.68], [0.78, -3.21], [0.85, -3.82], 
        [0.95, -4.69], [0.93, -5.30], [0.76, -5.87], [0.40, -6.59], 
        [0.07, -7.24], [-0.08, -7.66], [-0.08, -7.93], [0.06, -8.12], 
        [0.36, -8.58], [0.39, -9.15], [0.19, -9.73], [-0.23, -10.18], 
        [-0.58, -10.39], [-0.86, -10.46], [-1.13, -10.41], [-1.49, -10.23], 
        [-2.01, -9.77], [-2.20, -9.16], [-2.06, -8.41], [-1.60, -7.54], 
        [-1.25, -6.96], [-1.04, -6.43], [-0.95, -5.79], [-0.92, -4.91], 
        [-0.94, -4.04], [-1.01, -3.53], [-1.16, -3.27], [-1.44, -3.16], 
        [-2.07, -3.12], [-2.55, -3.35], [-2.85, -3.82], [-2.96, -4.51], 
        [-2.98, -5.00], [-3.05, -5.29], [-3.20, -5.43], [-3.46, -5.46], 
        [-3.71, -5.43], [-3.86, -5.30], [-3.92, -5.03], [-3.92, -4.56], 
        [-3.93, -3.66], [-4.07, -3.06], [-4.34, -2.75], [-4.73, -2.72], 
        [-4.99, -2.74], [-5.30, -2.71], [-5.64, -2.62], [-5.95, -2.49], 
        [-6.35, -2.33], [-6.82, -2.24], [-7.39, -2.22], [-8.10, -2.27], 
        [-8.86, -2.37], [-9.42, -2.52], [-9.87, -2.77], [-10.32, -3.14], 
        [-10.69, -3.51], [-10.88, -3.77], [-10.89, -3.96], [-10.76, -4.12], 
        [-10.55, -4.55], [-10.56, -5.15], [-10.74, -5.70], [-11.08, -6.00], 
        [-11.36, -6.22], [-11.63, -7.04], [-12.02, -9.00], [-12.67, -12.65], 
        [-13.23, -15.70], [-13.87, -18.74], [-14.67, -22.10], [-15.68, -26.07], 
        [-16.15, -27.87], [-16.57, -29.50], [-16.90, -30.78], [-17.10, -31.52], 
        [-17.22, -31.92], [-17.35, -32.24], [-17.49, -32.46], [-17.60, -32.54], 
        [-17.69, -32.51], [-17.74, -32.42], [-17.75, -32.29], [-17.72, -32.12], 
        [-17.72, -32.12] ], convexity = 10); 
    polygon(points = [ [-20.57, 6.37], [-20.12, 7.26], [-19.54, 8.64], 
        [-19.01, 10.05], [-18.73, 10.98], [-18.74, 11.21], [-18.88, 11.37], 
        [-19.20, 11.48], [-19.73, 11.57], [-20.24, 11.65], [-20.81, 11.77], 
        [-21.39, 11.89], [-21.89, 12.02], [-22.93, 12.18], [-23.86, 11.96], 
        [-24.75, 11.34], [-25.70, 10.26], [-26.10, 9.73], [-26.41, 9.27], 
        [-26.60, 8.94], [-26.64, 8.79], [-26.53, 8.76], [-26.33, 8.78], 
        [-26.06, 8.84], [-25.76, 8.94], [-25.34, 9.05], [-24.98, 9.07], 
        [-24.60, 8.99], [-24.15, 8.80], [-23.81, 8.61], [-23.50, 8.40], 
        [-23.27, 8.19], [-23.15, 8.00], [-23.06, 7.82], [-22.95, 7.62], 
        [-22.82, 7.43], [-22.68, 7.28], [-22.56, 7.11], [-22.46, 6.89], 
        [-22.39, 6.63], [-22.37, 6.38], [-22.34, 6.09], [-22.24, 5.91], 
        [-22.02, 5.82], [-21.66, 5.80], [-21.32, 5.83], [-21.03, 5.94], 
        [-20.78, 6.12], [-20.57, 6.37], [-20.57, 6.37] ], convexity = 10); 
	} 
	
	//        7 for LCS 
	if (iopt==7) polygon(points = [ [-46.59, -11.28], [-47.91, -9.83], [-48.77, -8.86], 
    [-49.23, -8.31], [-49.37, -8.09], [-49.40, -8.03], [-49.46, -7.94], 
    [-49.56, -7.84], [-49.68, -7.72], [-49.86, -7.54], [-49.97, -7.36], 
    [-50.00, -7.23], [-49.93, -7.18], [-49.86, -7.20], [-49.72, -7.26], 
    [-49.53, -7.35], [-49.32, -7.45], [-49.08, -7.58], [-48.90, -7.70], 
    [-48.78, -7.81], [-48.72, -7.91], [-48.67, -8.01], [-48.54, -8.06], 
    [-48.22, -8.06], [-47.63, -8.03], [-47.12, -8.02], [-46.51, -8.02], 
    [-45.88, -8.03], [-45.30, -8.07], [-44.73, -8.10], [-44.31, -8.11], 
    [-44.05, -8.10], [-43.93, -8.07], [-43.75, -8.03], [-43.29, -8.00], 
    [-42.60, -7.98], [-41.70, -7.98], [-40.51, -7.98], [-39.85, -8.00], 
    [-39.55, -8.06], [-39.43, -8.15], [-39.27, -8.25], [-38.71, -8.31], 
    [-37.40, -8.36], [-34.97, -8.42], [-33.26, -8.46], [-31.82, -8.50], 
    [-30.79, -8.54], [-30.34, -8.57], [-30.18, -8.59], [-30.09, -8.58], 
    [-30.06, -8.52], [-30.05, -8.40], [-30.08, -8.22], [-30.16, -8.09], 
    [-30.31, -8.01], [-30.51, -7.98], [-30.62, -7.97], [-30.70, -7.94], 
    [-30.74, -7.90], [-30.76, -7.83], [-30.67, -7.57], [-30.46, -7.17], 
    [-30.18, -6.75], [-29.90, -6.42], [-29.60, -6.12], [-28.35, -6.12], 
    [-27.10, -6.12], [-27.14, -6.87], [-27.19, -7.37], [-27.28, -7.68], 
    [-27.41, -7.84], [-27.62, -7.89], [-27.87, -7.92], [-28.08, -8.01], 
    [-28.22, -8.14], [-28.27, -8.30], [-28.28, -8.38], [-28.31, -8.45], 
    [-28.34, -8.51], [-28.39, -8.54], [-28.30, -8.56], [-27.98, -8.57], 
    [-27.47, -8.59], [-26.84, -8.59], [-25.18, -8.60], [-24.93, -8.30], 
    [-24.03, -7.31], [-22.62, -5.80], [-21.30, -4.42], [-20.66, -3.80], 
    [-20.51, -3.77], [-20.20, -3.75], [-19.78, -3.74], [-19.30, -3.73], 
    [-18.83, -3.72], [-18.44, -3.70], [-18.18, -3.67], [-18.08, -3.64], 
    [-18.00, -3.53], [-17.78, -3.28], [-17.47, -2.94], [-17.07, -2.53], 
    [-16.07, -1.51], [-15.25, -1.51], [-14.61, -1.49], [-14.26, -1.40], 
    [-14.12, -1.18], [-14.09, -0.76], [-14.08, -0.40], [-14.01, -0.17], 
    [-13.88, -0.04], [-13.64, 0.04], [-13.38, 0.03], [-13.20, -0.16], 
    [-13.08, -0.53], [-13.03, -1.09], [-13.03, -1.33], [-11.90, -1.31], 
    [-10.77, -1.29], [-10.77, -0.93], [-10.77, -0.58], [-10.15, -0.55], 
    [-9.53, -0.53], [-8.84, 0.20], [-8.45, 0.62], [-8.27, 0.85], 
    [-8.27, 0.94], [-8.40, 0.99], [-8.52, 1.01], [-8.67, 1.03], 
    [-8.82, 1.04], [-8.97, 1.05], [-9.17, 1.08], [-9.29, 1.13], 
    [-9.30, 1.20], [-9.19, 1.26], [-9.15, 1.32], [-9.11, 1.43], 
    [-9.08, 1.61], [-9.07, 1.85], [-9.06, 2.21], [-9.02, 2.41], 
    [-8.94, 2.48], [-8.82, 2.45], [-8.76, 2.41], [-8.72, 2.33], 
    [-8.69, 2.21], [-8.68, 2.06], [-8.66, 1.69], [-8.60, 1.47], 
    [-8.46, 1.36], [-8.21, 1.31], [-8.00, 1.30], [-7.83, 1.35], 
    [-7.66, 1.48], [-7.42, 1.72], [-7.26, 1.90], [-7.13, 2.05], 
    [-7.03, 2.17], [-7.00, 2.22], [-7.04, 2.25], [-7.15, 2.30], 
    [-7.31, 2.36], [-7.51, 2.43], [-7.72, 2.49], [-7.92, 2.56], 
    [-8.09, 2.62], [-8.20, 2.66], [-8.30, 2.70], [-8.45, 2.76], 
    [-8.62, 2.82], [-8.79, 2.89], [-9.05, 3.01], [-9.20, 3.15], 
    [-9.23, 3.29], [-9.12, 3.42], [-9.09, 3.46], [-9.07, 3.52], 
    [-9.06, 3.59], [-9.07, 3.67], [-9.08, 3.75], [-9.08, 3.84], 
    [-9.07, 3.92], [-9.04, 3.98], [-8.94, 4.06], [-8.83, 4.04], 
    [-8.73, 3.96], [-8.68, 3.82], [-8.66, 3.71], [-8.58, 3.63], 
    [-8.46, 3.57], [-8.32, 3.55], [-8.29, 3.56], [-8.26, 3.58], 
    [-8.25, 3.63], [-8.24, 3.68], [-8.23, 3.73], [-8.20, 3.77], 
    [-8.15, 3.81], [-8.09, 3.82], [-8.03, 3.82], [-8.00, 3.84], 
    [-8.01, 3.85], [-8.04, 3.87], [-8.12, 3.96], [-8.15, 4.11], 
    [-8.12, 4.28], [-8.05, 4.41], [-8.00, 4.47], [-8.00, 4.52], 
    [-8.03, 4.58], [-8.10, 4.64], [-8.19, 4.72], [-8.22, 4.81], 
    [-8.21, 4.97], [-8.15, 5.22], [-8.09, 5.49], [-8.02, 5.62], 
    [-7.91, 5.66], [-7.72, 5.66], [-7.57, 5.64], [-7.47, 5.60], 
    [-7.42, 5.55], [-7.41, 5.47], [-7.41, 5.41], [-7.40, 5.36], 
    [-7.37, 5.33], [-7.34, 5.32], [-7.28, 5.27], [-7.27, 5.14], 
    [-7.31, 4.96], [-7.40, 4.74], [-7.46, 4.63], [-7.48, 4.54], 
    [-7.48, 4.48], [-7.45, 4.45], [-7.41, 4.43], [-7.38, 4.39], 
    [-7.36, 4.35], [-7.35, 4.30], [-7.34, 4.25], [-7.31, 4.23], 
    [-7.25, 4.22], [-7.18, 4.23], [-7.09, 4.24], [-7.04, 4.23], 
    [-7.01, 4.18], [-7.00, 4.09], [-7.01, 4.01], [-7.04, 3.95], 
    [-7.08, 3.91], [-7.13, 3.90], [-7.23, 3.88], [-7.26, 3.83], 
    [-7.21, 3.75], [-7.09, 3.66], [-7.02, 3.62], [-6.95, 3.60], 
    [-6.90, 3.61], [-6.87, 3.64], [-6.77, 3.70], [-6.64, 3.72], 
    [-6.52, 3.70], [-6.47, 3.63], [-6.46, 3.60], [-6.43, 3.57], 
    [-6.38, 3.55], [-6.33, 3.55], [-6.26, 3.57], [-6.22, 3.67], 
    [-6.20, 3.88], [-6.20, 4.23], [-6.20, 4.55], [-6.19, 4.89], 
    [-6.16, 5.22], [-6.12, 5.50], [-6.09, 5.76], [-6.06, 6.06], 
    [-6.03, 6.36], [-6.03, 6.62], [-6.02, 6.83], [-6.00, 7.01], 
    [-5.98, 7.14], [-5.95, 7.20], [-5.86, 7.50], [-5.81, 8.14], 
    [-5.79, 8.76], [-5.84, 9.04], [-5.91, 9.10], [-5.93, 9.22], 
    [-5.90, 9.36], [-5.81, 9.45], [-5.75, 9.54], [-5.71, 9.78], 
    [-5.69, 10.21], [-5.68, 10.89], [-5.68, 11.81], [-5.73, 12.39], 
    [-5.85, 12.70], [-6.03, 12.83], [-6.10, 12.86], [-6.15, 12.90], 
    [-6.17, 12.95], [-6.16, 13.01], [-6.14, 13.06], [-6.13, 13.11], 
    [-6.12, 13.15], [-6.11, 13.17], [-6.08, 13.19], [-6.00, 13.20], 
    [-5.87, 13.21], [-5.72, 13.21], [-5.46, 13.19], [-5.30, 13.13], 
    [-5.24, 13.03], [-5.31, 12.92], [-5.39, 12.76], [-5.40, 12.56], 
    [-5.36, 12.39], [-5.27, 12.32], [-5.22, 12.31], [-5.18, 12.30], 
    [-5.15, 12.27], [-5.14, 12.23], [-5.15, 12.20], [-5.18, 12.17], 
    [-5.22, 12.15], [-5.28, 12.14], [-5.35, 12.10], [-5.39, 11.92], 
    [-5.40, 11.52], [-5.40, 10.84], [-5.38, 10.33], [-5.36, 9.90], 
    [-5.34, 9.61], [-5.31, 9.49], [-5.28, 9.45], [-5.25, 9.40], 
    [-5.22, 9.32], [-5.19, 9.24], [-5.17, 9.15], [-5.17, 9.09], 
    [-5.20, 9.05], [-5.25, 9.04], [-5.31, 9.02], [-5.36, 8.95], 
    [-5.40, 8.85], [-5.42, 8.71], [-5.45, 8.27], [-5.45, 7.73], 
    [-5.42, 7.26], [-5.37, 7.03], [-5.33, 6.91], [-5.32, 6.72], 
    [-5.34, 6.55], [-5.38, 6.47], [-5.41, 6.46], [-5.44, 6.43], 
    [-5.46, 6.38], [-5.47, 6.32], [-5.48, 6.18], [-5.50, 5.92], 
    [-5.54, 5.58], [-5.57, 5.19], [-5.65, 4.28], [-5.66, 3.78], 
    [-5.61, 3.58], [-5.47, 3.56], [-5.39, 3.59], [-5.32, 3.64], 
    [-5.26, 3.72], [-5.23, 3.81], [-5.12, 3.98], [-4.94, 4.06], 
    [-4.75, 4.04], [-4.64, 3.92], [-4.61, 3.85], [-4.58, 3.76], 
    [-4.54, 3.68], [-4.51, 3.60], [-4.47, 3.52], [-4.47, 3.45], 
    [-4.50, 3.39], [-4.57, 3.33], [-4.65, 3.25], [-4.67, 3.11], 
    [-4.63, 2.84], [-4.52, 2.36], [-4.36, 1.79], [-4.19, 1.51], 
    [-3.85, 1.42], [-3.23, 1.44], [-2.86, 1.46], [-2.64, 1.49], 
    [-2.53, 1.54], [-2.49, 1.63], [-2.26, 1.99], [-1.86, 2.11], 
    [-1.49, 1.99], [-1.33, 1.63], [-1.29, 1.49], [-1.20, 1.42], 
    [-1.09, 1.44], [-1.00, 1.55], [-0.95, 1.61], [-0.83, 1.66], 
    [-0.62, 1.68], [-0.31, 1.68], [0.34, 1.68], [0.40, 1.38], 
    [0.44, 1.21], [0.50, 1.11], [0.63, 1.07], [0.87, 1.05], 
    [1.10, 1.02], [1.23, 0.98], [1.30, 0.88], [1.35, 0.70], 
    [1.39, 0.53], [1.46, 0.32], [1.55, 0.10], [1.64, -0.12], 
    [1.77, -0.38], [1.87, -0.53], [1.97, -0.60], [2.10, -0.62], 
    [2.23, -0.61], [2.29, -0.56], [2.30, -0.42], [2.27, -0.16], 
    [2.24, 0.05], [2.21, 0.28], [2.18, 0.50], [2.16, 0.68], 
    [2.14, 0.88], [2.16, 1.02], [2.22, 1.14], [2.33, 1.27], 
    [2.61, 1.44], [3.00, 1.55], [3.40, 1.58], [3.70, 1.52], 
    [3.88, 1.36], [4.00, 1.13], [4.06, 0.84], [4.05, 0.53], 
    [4.02, 0.37], [3.99, 0.18], [3.96, -0.01], [3.94, -0.18], 
    [3.88, -0.53], [4.91, -0.53], [5.41, -0.53], [5.73, -0.51], 
    [5.89, -0.47], [5.94, -0.41], [7.32, -0.29], [10.39, -0.22], 
    [13.51, -0.21], [15.08, -0.29], [15.34, -0.45], [15.51, -0.65], 
    [15.64, -0.93], [15.75, -1.35], [15.81, -1.60], [15.87, -1.83], 
    [15.93, -1.99], [15.97, -2.08], [16.02, -2.11], [16.05, -2.05], 
    [16.06, -1.87], [16.08, -1.51], [16.11, -1.30], [16.17, -1.20], 
    [16.27, -1.19], [16.41, -1.29], [16.49, -1.38], [16.54, -1.48], 
    [16.55, -1.59], [16.54, -1.72], [16.53, -1.82], [16.52, -1.88], 
    [16.53, -1.91], [16.54, -1.88], [16.62, -1.79], [16.72, -1.78], 
    [16.81, -1.84], [16.88, -1.97], [16.91, -2.06], [16.94, -2.10], 
    [16.97, -2.10], [17.01, -2.05], [17.06, -2.01], [17.12, -1.98], 
    [17.19, -1.97], [17.27, -1.99], [17.37, -2.01], [17.41, -1.98], 
    [17.41, -1.88], [17.37, -1.68], [17.33, -1.52], [17.28, -1.37], 
    [17.24, -1.24], [17.20, -1.15], [17.02, -0.79], [17.05, -0.56], 
    [17.37, -0.32], [18.09, 0.04], [18.54, 0.27], [18.91, 0.45], 
    [19.17, 0.58], [19.28, 0.62], [19.39, 0.48], [19.56, 0.16], 
    [19.71, -0.19], [19.77, -0.43], [19.74, -0.52], [19.67, -0.63], 
    [19.54, -0.74], [19.37, -0.86], [19.22, -0.96], [19.09, -1.05], 
    [19.01, -1.13], [18.97, -1.17], [19.01, -1.20], [19.10, -1.22], 
    [19.24, -1.24], [19.42, -1.24], [19.86, -1.24], [19.86, -1.91], 
    [19.86, -2.57], [21.10, -2.57], [21.76, -2.58], [22.14, -2.60], 
    [22.33, -2.64], [22.41, -2.72], [22.42, -2.78], [22.42, -2.84], 
    [22.40, -2.88], [22.36, -2.90], [22.44, -3.42], [22.81, -4.53], 
    [23.27, -5.75], [23.66, -6.55], [23.84, -6.80], [24.00, -6.97], 
    [24.17, -7.08], [24.38, -7.17], [24.54, -7.23], [24.69, -7.29], 
    [24.82, -7.36], [24.89, -7.41], [24.96, -7.46], [25.07, -7.52], 
    [25.20, -7.58], [25.34, -7.62], [28.92, -7.70], [36.35, -7.72], 
    [43.73, -7.69], [47.19, -7.61], [47.46, -7.47], [47.62, -7.40], 
    [47.72, -7.38], [47.79, -7.40], [47.82, -7.41], [47.85, -7.40], 
    [47.87, -7.37], [47.87, -7.32], [47.89, -7.27], [47.93, -7.22], 
    [47.99, -7.19], [48.07, -7.16], [48.18, -7.13], [48.24, -7.06], 
    [48.28, -6.92], [48.30, -6.68], [48.32, -6.23], [48.92, -6.17], 
    [49.20, -6.15], [49.40, -6.16], [49.53, -6.18], [49.60, -6.23], 
    [49.65, -6.28], [49.71, -6.33], [49.78, -6.38], [49.84, -6.41], 
    [49.92, -6.46], [49.97, -6.58], [49.99, -6.79], [50.00, -7.12], 
    [49.99, -7.47], [49.96, -7.70], [49.90, -7.87], [49.79, -8.02], 
    [49.66, -8.25], [49.48, -8.70], [49.26, -9.40], [48.98, -10.38], 
    [48.74, -11.21], [48.53, -11.88], [48.38, -12.33], [48.30, -12.50], 
    [48.27, -12.52], [48.25, -12.56], [48.23, -12.63], [48.23, -12.72], 
    [48.22, -12.81], [48.20, -12.88], [48.17, -12.92], [48.14, -12.94], 
    [48.10, -12.95], [48.08, -12.98], [48.06, -13.02], [48.05, -13.08], 
    [46.59, -13.15], [40.29, -13.19], [26.26, -13.20], [1.61, -13.21], 
    [-44.82, -13.21], [-46.59, -11.28], [-46.59, -11.28] ], convexity = 10); 
	
	//        8 for LM Star Logo 
	if (iopt==8) StarLogo2_2D([0,0],100,0);

	//        9 for Apache Longbow Helo 
	if (iopt==9) difference() { 
    polygon(points = [ [-0.40, -29.35], [-0.47, -29.27], [-0.54, -29.15], 
        [-0.59, -28.98], [-0.63, -28.78], [-0.67, -28.56], [-0.72, -28.38], 
        [-0.80, -28.24], [-0.89, -28.14], [-0.99, -28.03], [-1.05, -27.87], 
        [-1.08, -27.60], [-1.09, -27.16], [-1.08, -26.72], [-1.05, -26.43], 
        [-0.99, -26.23], [-0.88, -26.05], [-0.79, -25.93], [-0.73, -25.81], 
        [-0.68, -25.70], [-0.66, -25.62], [-0.65, -25.57], [-0.63, -25.52], 
        [-0.60, -25.48], [-0.56, -25.45], [-0.54, -25.42], [-0.55, -25.36], 
        [-0.59, -25.28], [-0.66, -25.19], [-0.73, -25.09], [-0.79, -24.99], 
        [-0.84, -24.90], [-0.85, -24.82], [-0.88, -24.68], [-0.96, -24.41], 
        [-1.07, -24.03], [-1.21, -23.60], [-1.54, -22.72], [-1.88, -22.15], 
        [-2.29, -21.81], [-2.84, -21.62], [-3.16, -21.53], [-3.41, -21.43], 
        [-3.63, -21.29], [-3.85, -21.09], [-4.18, -20.83], [-4.56, -20.67], 
        [-5.07, -20.58], [-5.79, -20.55], [-6.21, -20.57], [-6.44, -20.65], 
        [-6.50, -20.81], [-6.42, -21.08], [-6.36, -21.22], [-6.36, -21.32], 
        [-6.42, -21.41], [-6.55, -21.53], [-6.67, -21.66], [-6.78, -21.85], 
        [-6.89, -22.10], [-7.00, -22.42], [-7.08, -22.68], [-7.17, -22.90], 
        [-7.25, -23.05], [-7.30, -23.10], [-7.43, -23.22], [-7.57, -23.50], 
        [-7.68, -23.81], [-7.70, -24.02], [-7.69, -24.09], [-7.72, -24.17], 
        [-7.77, -24.26], [-7.85, -24.34], [-7.94, -24.45], [-8.00, -24.57], 
        [-8.04, -24.72], [-8.05, -24.90], [-8.06, -25.10], [-8.09, -25.21], 
        [-8.17, -25.27], [-8.31, -25.30], [-8.46, -25.33], [-8.54, -25.42], 
        [-8.59, -25.62], [-8.62, -25.99], [-8.69, -26.50], [-8.80, -26.84], 
        [-8.99, -27.06], [-9.29, -27.21], [-9.59, -27.30], [-9.89, -27.32], 
        [-10.20, -27.26], [-10.52, -27.12], [-10.79, -26.90], [-10.93, -26.43], 
        [-10.98, -25.43], [-10.97, -23.65], [-10.95, -22.10], [-10.91, -21.23], 
        [-10.85, -20.79], [-10.73, -20.53], [-10.53, -20.19], [-11.63, -20.12], 
        [-12.08, -20.10], [-12.50, -20.07], [-12.82, -20.04], [-13.02, -20.01], 
        [-13.31, -19.96], [-13.27, -20.40], [-13.24, -20.84], [-13.55, -20.65], 
        [-13.72, -20.55], [-13.86, -20.51], [-14.00, -20.53], [-14.18, -20.60], 
        [-14.36, -20.66], [-14.50, -20.68], [-14.62, -20.66], [-14.78, -20.59], 
        [-14.94, -20.52], [-15.06, -20.49], [-15.19, -20.52], [-15.35, -20.60], 
        [-15.51, -20.67], [-15.61, -20.70], [-15.68, -20.68], [-15.73, -20.63], 
        [-15.80, -20.44], [-15.80, -20.23], [-15.74, -20.00], [-15.62, -19.78], 
        [-15.52, -19.62], [-15.47, -19.45], [-15.46, -19.24], [-15.49, -18.94], 
        [-15.52, -18.71], [-15.56, -18.52], [-15.60, -18.38], [-15.64, -18.31], 
        [-15.67, -18.27], [-15.70, -18.19], [-15.71, -18.10], [-15.72, -17.98], 
        [-15.73, -17.85], [-15.76, -17.76], [-15.82, -17.72], [-15.91, -17.70], 
        [-16.00, -17.72], [-16.06, -17.76], [-16.09, -17.85], [-16.10, -18.00], 
        [-16.11, -18.13], [-16.15, -18.28], [-16.21, -18.43], [-16.29, -18.56], 
        [-16.39, -18.72], [-16.43, -18.88], [-16.43, -19.09], [-16.38, -19.42], 
        [-16.24, -20.26], [-16.21, -20.65], [-16.30, -20.72], [-16.53, -20.58], 
        [-16.66, -20.51], [-16.77, -20.48], [-16.90, -20.49], [-17.06, -20.55], 
        [-17.22, -20.60], [-17.36, -20.62], [-17.50, -20.61], [-17.68, -20.55], 
        [-17.85, -20.50], [-17.98, -20.48], [-18.10, -20.51], [-18.23, -20.59], 
        [-18.33, -20.64], [-18.42, -20.69], [-18.50, -20.72], [-18.56, -20.73], 
        [-18.64, -20.63], [-18.65, -20.38], [-18.61, -20.06], [-18.51, -19.77], 
        [-18.42, -19.46], [-18.41, -19.05], [-18.47, -18.66], [-18.58, -18.39], 
        [-18.62, -18.31], [-18.64, -18.18], [-18.64, -18.01], [-18.63, -17.83], 
        [-18.61, -17.61], [-18.62, -17.47], [-18.67, -17.39], [-18.76, -17.35], 
        [-18.85, -17.31], [-18.90, -17.23], [-18.93, -17.10], [-18.94, -16.91], 
        [-18.92, -16.75], [-18.89, -16.58], [-18.85, -16.44], [-18.79, -16.34], 
        [-18.69, -16.09], [-18.66, -15.75], [-18.69, -15.38], [-18.79, -15.03], 
        [-18.91, -14.37], [-18.88, -13.55], [-18.71, -12.84], [-18.46, -12.48], 
        [-18.42, -12.43], [-18.39, -12.34], [-18.36, -12.20], [-18.35, -12.04], 
        [-18.34, -11.83], [-18.31, -11.70], [-18.24, -11.63], [-18.12, -11.59], 
        [-18.04, -11.56], [-17.96, -11.52], [-17.92, -11.48], [-17.90, -11.44], 
        [-17.86, -11.41], [-17.77, -11.38], [-17.62, -11.37], [-17.45, -11.36], 
        [-17.21, -11.35], [-17.07, -11.32], [-17.00, -11.26], [-16.98, -11.15], 
        [-16.97, -11.01], [-16.95, -10.80], [-16.92, -10.54], [-16.90, -10.26], 
        [-16.83, -9.59], [-18.24, -9.53], [-18.93, -9.50], [-19.75, -9.47], 
        [-20.60, -9.43], [-21.39, -9.40], [-23.13, -9.34], [-23.08, -9.71], 
        [-23.00, -10.17], [-22.92, -10.55], [-22.82, -10.85], [-22.71, -11.08], 
        [-22.57, -11.38], [-22.43, -11.90], [-22.28, -12.77], [-22.07, -14.09], 
        [-21.91, -15.32], [-21.88, -16.10], [-21.97, -16.62], [-22.21, -17.06], 
        [-23.05, -17.78], [-24.11, -18.00], [-25.15, -17.73], [-25.92, -16.96], 
        [-26.13, -16.28], [-26.42, -15.03], [-26.69, -13.64], [-26.86, -12.54], 
        [-26.87, -11.99], [-26.79, -11.53], [-26.59, -11.12], [-26.27, -10.74], 
        [-26.09, -10.56], [-25.89, -10.40], [-25.71, -10.28], [-25.56, -10.21], 
        [-25.26, -10.10], [-25.31, -9.39], [-25.33, -9.10], [-25.33, -8.84], 
        [-25.31, -8.63], [-25.28, -8.52], [-25.26, -8.43], [-25.27, -8.32], 
        [-25.32, -8.19], [-25.42, -8.04], [-25.54, -7.84], [-25.60, -7.61], 
        [-25.61, -7.28], [-25.59, -6.74], [-25.55, -5.76], [-24.97, -5.80], 
        [-22.84, -5.79], [-18.67, -5.75], [-14.58, -5.69], [-12.72, -5.65], 
        [-12.74, -5.45], [-12.81, -5.07], [-12.91, -4.71], [-12.99, -4.54], 
        [-13.02, -4.48], [-13.04, -4.31], [-13.05, -4.06], [-13.05, -3.75], 
        [-13.06, -3.22], [-13.10, -2.91], [-13.21, -2.78], [-13.39, -2.74], 
        [-13.50, -2.74], [-13.64, -2.72], [-13.78, -2.71], [-13.91, -2.68], 
        [-14.21, -2.62], [-14.19, -2.04], [-14.16, -1.46], [-13.75, -1.43], 
        [-13.59, -1.42], [-13.48, -1.39], [-13.41, -1.35], [-13.41, -1.31], 
        [-13.42, -1.26], [-13.41, -1.20], [-13.38, -1.13], [-13.33, -1.06], 
        [-13.26, -0.92], [-13.20, -0.67], [-13.16, -0.30], [-13.12, 0.19], 
        [-12.92, 1.90], [-12.40, 2.87], [-11.33, 3.31], [-9.47, 3.43], 
        [-8.76, 3.43], [-7.93, 3.42], [-7.06, 3.40], [-6.28, 3.37], 
        [-4.56, 3.29], [-4.51, 3.52], [-4.49, 3.65], [-4.45, 3.84], 
        [-4.40, 4.06], [-4.36, 4.29], [-4.29, 4.74], [-4.32, 5.02], 
        [-4.45, 5.17], [-4.71, 5.23], [-5.05, 5.26], [-5.03, 6.53], 
        [-5.02, 7.04], [-5.00, 7.46], [-4.98, 7.75], [-4.96, 7.88], 
        [-4.92, 7.91], [-4.86, 7.94], [-4.78, 7.95], [-4.68, 7.96], 
        [-4.58, 7.97], [-4.46, 8.02], [-4.35, 8.08], [-4.25, 8.16], 
        [-4.16, 8.23], [-4.06, 8.29], [-3.96, 8.31], [-3.88, 8.31], 
        [-3.80, 8.30], [-3.73, 8.32], [-3.68, 8.36], [-3.64, 8.44], 
        [-3.53, 8.57], [-3.28, 8.71], [-2.90, 8.86], [-2.39, 9.00], 
        [-2.23, 9.05], [-2.10, 9.11], [-2.02, 9.17], [-1.99, 9.23], 
        [-1.94, 9.34], [-1.81, 9.42], [-1.65, 9.46], [-1.52, 9.43], 
        [-1.48, 9.43], [-1.45, 9.49], [-1.43, 9.59], [-1.42, 9.74], 
        [-1.43, 9.96], [-1.48, 10.08], [-1.63, 10.16], [-1.92, 10.25], 
        [-2.16, 10.33], [-2.32, 10.40], [-2.41, 10.49], [-2.44, 10.59], 
        [-2.45, 10.70], [-2.42, 10.76], [-2.33, 10.79], [-2.19, 10.80], 
        [-2.08, 10.81], [-1.97, 10.82], [-1.90, 10.85], [-1.85, 10.88], 
        [-1.81, 10.92], [-1.71, 10.95], [-1.58, 10.99], [-1.43, 11.01], 
        [-1.26, 11.05], [-1.07, 11.09], [-0.90, 11.15], [-0.75, 11.22], 
        [-0.61, 11.27], [-0.47, 11.32], [-0.34, 11.36], [-0.23, 11.37], 
        [-0.14, 11.37], [-0.06, 11.40], [0.01, 11.43], [0.05, 11.46], 
        [0.11, 11.50], [0.22, 11.53], [0.37, 11.55], [0.55, 11.56], 
        [0.99, 11.56], [1.01, 12.10], [1.01, 12.32], [0.99, 12.50], 
        [0.96, 12.64], [0.92, 12.71], [0.87, 12.71], [0.78, 12.66], 
        [0.67, 12.57], [0.55, 12.45], [0.34, 12.25], [0.09, 12.18], 
        [-0.31, 12.22], [-0.98, 12.38], [-1.55, 12.45], [-2.23, 12.46], 
        [-2.79, 12.41], [-2.98, 12.31], [-3.07, 12.24], [-3.34, 12.20], 
        [-3.65, 12.20], [-3.86, 12.25], [-3.98, 12.28], [-4.24, 12.30], 
        [-4.60, 12.30], [-5.04, 12.28], [-7.68, 12.14], [-9.29, 12.07], 
        [-10.33, 12.07], [-11.27, 12.11], [-11.93, 12.16], [-12.47, 12.22], 
        [-12.88, 12.29], [-13.16, 12.36], [-13.35, 12.43], [-13.54, 12.49], 
        [-13.71, 12.54], [-13.85, 12.57], [-14.05, 12.65], [-14.10, 12.75], 
        [-14.00, 12.86], [-13.75, 12.93], [-13.59, 12.96], [-13.39, 13.00], 
        [-13.20, 13.04], [-13.02, 13.08], [-12.81, 13.12], [-12.53, 13.17], 
        [-12.21, 13.22], [-11.88, 13.26], [-11.50, 13.30], [-11.03, 13.36], 
        [-10.52, 13.43], [-10.04, 13.50], [-9.48, 13.57], [-8.77, 13.67], 
        [-8.00, 13.77], [-7.26, 13.87], [-6.27, 14.01], [-5.67, 14.12], 
        [-5.49, 14.18], [-5.74, 14.21], [-6.36, 14.24], [-6.92, 14.30], 
        [-7.38, 14.38], [-7.70, 14.49], [-7.89, 14.57], [-8.05, 14.61], 
        [-8.20, 14.61], [-8.36, 14.58], [-8.63, 14.51], [-8.79, 14.51], 
        [-8.88, 14.58], [-8.94, 14.73], [-9.04, 14.91], [-9.38, 15.03], 
        [-10.22, 15.12], [-11.79, 15.23], [-12.58, 15.28], [-13.60, 15.34], 
        [-14.72, 15.39], [-15.81, 15.44], [-18.28, 15.55], [-20.10, 15.67], 
        [-21.56, 15.81], [-22.96, 16.01], [-24.01, 16.17], [-25.53, 16.41], 
        [-27.31, 16.68], [-29.17, 16.96], [-31.01, 17.24], [-32.79, 17.51], 
        [-34.29, 17.74], [-35.32, 17.89], [-36.09, 18.01], [-36.88, 18.13], 
        [-37.60, 18.24], [-38.16, 18.33], [-38.60, 18.40], [-38.99, 18.46], 
        [-39.28, 18.52], [-39.44, 18.57], [-39.57, 18.60], [-39.80, 18.64], 
        [-40.08, 18.68], [-40.39, 18.71], [-40.73, 18.75], [-41.10, 18.80], 
        [-41.46, 18.86], [-41.76, 18.92], [-42.03, 18.97], [-42.31, 19.03], 
        [-42.56, 19.07], [-42.76, 19.10], [-43.55, 19.21], [-44.97, 19.41], 
        [-46.48, 19.64], [-47.54, 19.80], [-47.82, 19.85], [-48.19, 19.91], 
        [-48.61, 19.98], [-49.03, 20.04], [-50.00, 20.20], [-50.00, 21.10], 
        [-50.00, 22.00], [-49.74, 21.94], [-49.58, 21.91], [-49.33, 21.87], 
        [-49.04, 21.83], [-48.72, 21.78], [-48.33, 21.73], [-47.82, 21.65], 
        [-47.27, 21.57], [-46.73, 21.49], [-45.87, 21.36], [-45.09, 21.25], 
        [-44.24, 21.13], [-43.13, 20.98], [-42.60, 20.91], [-41.93, 20.81], 
        [-41.19, 20.71], [-40.48, 20.60], [-38.49, 20.32], [-35.69, 19.93], 
        [-32.87, 19.54], [-30.87, 19.27], [-30.43, 19.20], [-30.05, 19.14], 
        [-29.75, 19.08], [-29.59, 19.04], [-29.46, 19.00], [-29.22, 18.96], 
        [-28.93, 18.93], [-28.60, 18.90], [-28.24, 18.87], [-27.85, 18.83], 
        [-27.48, 18.79], [-27.18, 18.75], [-24.86, 18.43], [-22.83, 18.15], 
        [-21.32, 17.95], [-20.55, 17.86], [-20.34, 17.84], [-20.14, 17.82], 
        [-19.98, 17.79], [-19.89, 17.77], [-19.63, 17.73], [-19.02, 17.64], 
        [-18.16, 17.52], [-17.14, 17.38], [-16.05, 17.24], [-15.01, 17.10], 
        [-14.13, 16.99], [-13.54, 16.91], [-12.21, 16.74], [-11.02, 16.62], 
        [-10.05, 16.55], [-9.33, 16.54], [-8.42, 16.59], [-7.81, 16.62], 
        [-7.42, 16.66], [-7.18, 16.71], [-7.08, 16.73], [-6.98, 16.73], 
        [-6.91, 16.72], [-6.87, 16.68], [-6.82, 16.64], [-6.74, 16.61], 
        [-6.62, 16.58], [-6.50, 16.58], [-6.37, 16.57], [-6.25, 16.55], 
        [-6.16, 16.51], [-6.09, 16.48], [-5.74, 16.39], [-4.97, 16.32], 
        [-4.01, 16.27], [-3.05, 16.27], [-2.65, 16.28], [-2.36, 16.32], 
        [-2.14, 16.38], [-1.94, 16.48], [-1.63, 16.68], [-1.38, 16.45], 
        [-1.29, 16.35], [-1.21, 16.26], [-1.15, 16.19], [-1.13, 16.14], 
        [-1.11, 16.09], [-1.06, 16.00], [-0.99, 15.90], [-0.90, 15.79], 
        [-0.66, 15.52], [-0.20, 15.79], [0.03, 15.93], [0.20, 16.07], 
        [0.33, 16.23], [0.42, 16.43], [0.49, 16.63], [0.52, 16.75], 
        [0.50, 16.83], [0.43, 16.88], [0.33, 17.00], [0.29, 17.19], 
        [0.31, 17.41], [0.38, 17.62], [0.42, 17.73], [0.43, 17.85], 
        [0.41, 18.00], [0.35, 18.19], [0.30, 18.33], [0.24, 18.44], 
        [0.20, 18.50], [0.17, 18.51], [0.13, 18.51], [0.08, 18.56], 
        [0.02, 18.64], [-0.04, 18.75], [-0.12, 18.92], [-0.15, 19.05], 
        [-0.13, 19.17], [-0.05, 19.34], [0.01, 19.46], [0.05, 19.56], 
        [0.08, 19.63], [0.09, 19.66], [0.06, 19.67], [-0.03, 19.70], 
        [-0.16, 19.74], [-0.33, 19.78], [-0.61, 19.89], [-0.82, 20.05], 
        [-0.92, 20.23], [-0.91, 20.41], [-0.85, 20.47], [-0.74, 20.53], 
        [-0.58, 20.57], [-0.38, 20.61], [-0.18, 20.64], [-0.03, 20.69], 
        [0.06, 20.74], [0.09, 20.80], [0.08, 20.85], [0.03, 20.89], 
        [-0.04, 20.92], [-0.12, 20.93], [-0.22, 20.94], [-0.33, 20.97], 
        [-0.44, 21.02], [-0.53, 21.07], [-0.62, 21.15], [-0.66, 21.21], 
        [-0.65, 21.29], [-0.59, 21.40], [-0.53, 21.55], [-0.59, 21.65], 
        [-0.78, 21.73], [-1.14, 21.80], [-1.93, 21.95], [-2.69, 22.12], 
        [-3.32, 22.31], [-3.73, 22.47], [-4.07, 22.73], [-4.39, 23.11], 
        [-4.66, 23.56], [-4.84, 24.01], [-4.95, 24.82], [-4.83, 25.63], 
        [-4.51, 26.38], [-4.01, 26.98], [-3.36, 27.40], [-2.39, 27.65], 
        [-0.84, 27.77], [1.56, 27.80], [4.42, 27.74], [6.42, 27.57], 
        [7.73, 27.26], [8.51, 26.78], [9.07, 26.03], [9.36, 25.16], 
        [9.37, 24.25], [9.09, 23.35], [8.87, 22.98], [8.59, 22.65], 
        [8.29, 22.38], [7.98, 22.19], [7.51, 22.05], [6.88, 21.92], 
        [6.23, 21.82], [5.67, 21.78], [5.14, 21.78], [5.08, 21.31], 
        [5.03, 21.05], [4.98, 20.91], [4.89, 20.85], [4.73, 20.84], 
        [4.52, 20.80], [4.45, 20.70], [4.52, 20.59], [4.73, 20.51], 
        [4.88, 20.46], [4.96, 20.40], [5.01, 20.31], [5.02, 20.18], 
        [5.01, 20.03], [4.95, 19.94], [4.82, 19.87], [4.59, 19.81], 
        [4.43, 19.76], [4.29, 19.72], [4.20, 19.69], [4.17, 19.66], 
        [4.18, 19.62], [4.21, 19.53], [4.26, 19.41], [4.32, 19.27], 
        [4.37, 19.13], [4.40, 19.00], [4.41, 18.91], [4.39, 18.86], 
        [4.35, 18.82], [4.30, 18.76], [4.25, 18.69], [4.20, 18.61], 
        [4.15, 18.54], [4.09, 18.48], [4.03, 18.45], [3.99, 18.45], 
        [3.94, 18.40], [3.91, 18.25], [3.89, 17.98], [3.88, 17.61], 
        [3.89, 17.20], [3.91, 16.95], [3.94, 16.81], [4.00, 16.79], 
        [4.05, 16.83], [4.08, 16.90], [4.11, 16.99], [4.12, 17.10], 
        [4.13, 17.23], [4.19, 17.34], [4.28, 17.44], [4.44, 17.54], 
        [4.62, 17.66], [4.88, 17.85], [5.18, 18.09], [5.49, 18.36], 
        [5.80, 18.62], [6.10, 18.88], [6.36, 19.10], [6.54, 19.25], 
        [6.69, 19.37], [6.84, 19.49], [6.98, 19.61], [7.10, 19.71], 
        [7.24, 19.82], [7.43, 19.98], [7.66, 20.16], [7.89, 20.35], 
        [8.15, 20.57], [8.46, 20.83], [8.78, 21.12], [9.07, 21.38], 
        [9.32, 21.61], [9.53, 21.80], [9.69, 21.93], [9.77, 21.97], 
        [9.81, 21.99], [9.88, 22.04], [9.97, 22.11], [10.06, 22.19], 
        [10.17, 22.29], [10.32, 22.42], [10.49, 22.56], [10.65, 22.69], 
        [10.84, 22.84], [11.08, 23.05], [11.35, 23.28], [11.60, 23.51], 
        [11.82, 23.72], [12.02, 23.90], [12.16, 24.01], [12.23, 24.06], 
        [12.29, 24.09], [12.41, 24.20], [12.57, 24.35], [12.75, 24.53], 
        [12.94, 24.71], [13.10, 24.86], [13.22, 24.96], [13.28, 25.00], 
        [13.34, 25.03], [13.42, 25.09], [13.52, 25.18], [13.64, 25.29], 
        [13.75, 25.40], [13.85, 25.49], [13.92, 25.55], [13.97, 25.57], 
        [14.02, 25.60], [14.11, 25.68], [14.23, 25.80], [14.37, 25.95], 
        [14.51, 26.10], [14.64, 26.22], [14.73, 26.30], [14.79, 26.33], 
        [14.85, 26.36], [14.95, 26.44], [15.09, 26.56], [15.25, 26.71], 
        [15.41, 26.86], [15.54, 26.97], [15.64, 27.04], [15.69, 27.05], 
        [15.73, 27.06], [15.81, 27.11], [15.92, 27.20], [16.04, 27.32], 
        [16.18, 27.45], [16.34, 27.58], [16.50, 27.70], [16.65, 27.79], 
        [16.76, 27.85], [16.86, 27.92], [16.93, 27.98], [16.95, 28.03], 
        [16.97, 28.08], [17.03, 28.17], [17.12, 28.28], [17.23, 28.40], 
        [17.42, 28.60], [17.50, 28.74], [17.48, 28.89], [17.37, 29.11], 
        [17.32, 29.22], [17.29, 29.32], [17.27, 29.39], [17.28, 29.43], 
        [17.48, 29.44], [18.01, 29.44], [18.77, 29.43], [19.70, 29.41], 
        [22.08, 29.34], [22.02, 29.09], [21.91, 28.77], [21.77, 28.51], 
        [21.56, 28.29], [21.26, 28.06], [20.89, 27.80], [20.54, 27.53], 
        [20.16, 27.22], [19.75, 26.86], [19.60, 26.73], [19.46, 26.62], 
        [19.36, 26.55], [19.30, 26.52], [19.27, 26.51], [19.25, 26.47], 
        [19.23, 26.43], [19.22, 26.37], [19.21, 26.30], [19.18, 26.26], 
        [19.12, 26.25], [19.04, 26.26], [18.96, 26.27], [18.91, 26.27], 
        [18.90, 26.23], [18.91, 26.18], [18.92, 26.13], [18.92, 26.08], 
        [18.90, 26.06], [18.86, 26.05], [18.79, 26.01], [18.68, 25.93], 
        [18.53, 25.80], [18.37, 25.64], [18.21, 25.49], [18.07, 25.36], 
        [17.95, 25.27], [17.89, 25.23], [17.85, 25.22], [17.81, 25.22], 
        [17.76, 25.21], [17.72, 25.21], [17.68, 25.18], [17.63, 25.13], 
        [17.57, 25.05], [17.52, 24.96], [17.46, 24.86], [17.37, 24.77], 
        [17.28, 24.71], [17.20, 24.66], [17.09, 24.61], [16.96, 24.52], 
        [16.81, 24.40], [16.66, 24.26], [16.34, 23.95], [16.05, 23.69], 
        [15.83, 23.51], [15.71, 23.44], [15.66, 23.42], [15.58, 23.35], 
        [15.47, 23.25], [15.35, 23.13], [15.23, 23.01], [15.12, 22.92], 
        [15.04, 22.85], [14.98, 22.83], [14.93, 22.80], [14.83, 22.73], 
        [14.71, 22.64], [14.57, 22.52], [14.38, 22.35], [14.11, 22.13], 
        [13.81, 21.89], [13.51, 21.65], [13.23, 21.42], [13.02, 21.23], 
        [12.88, 21.08], [12.85, 21.00], [12.87, 20.96], [12.87, 20.95], 
        [12.85, 20.94], [12.82, 20.96], [12.73, 20.94], [12.56, 20.84], 
        [12.32, 20.68], [12.05, 20.47], [11.77, 20.25], [11.50, 20.03], 
        [11.27, 19.85], [11.11, 19.73], [10.98, 19.63], [10.82, 19.51], 
        [10.65, 19.38], [10.50, 19.26], [10.34, 19.14], [10.18, 19.02], 
        [10.02, 18.90], [9.90, 18.81], [9.78, 18.72], [9.65, 18.61], 
        [9.51, 18.50], [9.39, 18.41], [9.29, 18.32], [9.20, 18.25], 
        [9.13, 18.20], [9.08, 18.19], [9.04, 18.16], [8.95, 18.10], 
        [8.84, 18.01], [8.71, 17.89], [8.52, 17.74], [8.27, 17.55], 
        [7.98, 17.33], [7.68, 17.11], [7.38, 16.90], [7.10, 16.69], 
        [6.86, 16.49], [6.70, 16.35], [6.55, 16.19], [6.49, 16.09], 
        [6.51, 16.00], [6.60, 15.90], [7.10, 15.70], [8.07, 15.57], 
        [9.41, 15.52], [11.03, 15.55], [11.20, 15.54], [11.43, 15.51], 
        [11.71, 15.45], [12.00, 15.39], [12.35, 15.29], [12.56, 15.21], 
        [12.66, 15.12], [12.69, 15.02], [12.75, 14.91], [13.11, 14.85], 
        [14.09, 14.84], [15.98, 14.84], [20.46, 14.88], [26.96, 14.96], 
        [34.05, 15.06], [40.29, 15.16], [42.49, 15.19], [44.63, 15.22], 
        [46.47, 15.24], [47.75, 15.25], [50.00, 15.25], [50.00, 14.97], 
        [49.99, 14.82], [49.93, 14.73], [49.78, 14.68], [49.50, 14.65], 
        [49.13, 14.62], [48.47, 14.59], [47.63, 14.57], [46.69, 14.54], 
        [42.95, 14.45], [38.44, 14.32], [33.83, 14.18], [29.78, 14.06], 
        [27.37, 13.99], [25.05, 13.95], [22.69, 13.94], [20.12, 13.95], 
        [18.13, 13.96], [16.43, 13.96], [15.18, 13.95], [14.58, 13.92], 
        [14.34, 13.88], [14.06, 13.84], [13.77, 13.81], [13.52, 13.77], 
        [13.28, 13.74], [13.11, 13.69], [13.01, 13.64], [12.97, 13.58], 
        [12.89, 13.49], [12.70, 13.45], [12.49, 13.47], [12.36, 13.55], 
        [12.26, 13.62], [12.13, 13.63], [12.00, 13.58], [11.88, 13.47], 
        [11.77, 13.39], [11.54, 13.34], [11.09, 13.31], [10.35, 13.31], 
        [9.20, 13.30], [8.52, 13.27], [8.18, 13.21], [8.01, 13.11], 
        [7.94, 13.06], [7.85, 13.02], [7.76, 13.01], [7.68, 13.02], 
        [7.60, 13.04], [7.54, 13.02], [7.48, 12.99], [7.45, 12.93], 
        [7.41, 12.88], [7.35, 12.83], [7.27, 12.80], [7.18, 12.79], 
        [6.72, 12.73], [6.00, 12.59], [5.30, 12.43], [4.90, 12.31], 
        [4.81, 12.28], [4.68, 12.25], [4.53, 12.23], [4.38, 12.22], 
        [4.19, 12.24], [4.02, 12.30], [3.85, 12.41], [3.66, 12.59], 
        [3.48, 12.75], [3.33, 12.85], [3.21, 12.90], [3.10, 12.90], 
        [3.01, 12.87], [2.96, 12.80], [2.95, 12.69], [2.98, 12.51], 
        [3.01, 12.36], [3.03, 12.18], [3.05, 12.00], [3.06, 11.84], 
        [3.08, 11.66], [3.13, 11.56], [3.23, 11.50], [3.41, 11.48], 
        [3.55, 11.46], [3.67, 11.43], [3.78, 11.40], [3.84, 11.36], 
        [3.93, 11.32], [4.10, 11.28], [4.31, 11.25], [4.56, 11.22], 
        [5.06, 11.14], [5.43, 11.03], [5.70, 10.87], [5.85, 10.66], 
        [5.94, 10.46], [5.93, 10.36], [5.81, 10.34], [5.55, 10.38], 
        [5.14, 10.42], [4.91, 10.36], [4.82, 10.17], [4.81, 9.82], 
        [4.85, 9.31], [6.14, 8.96], [6.79, 8.77], [7.23, 8.62], 
        [7.51, 8.48], [7.69, 8.33], [7.80, 8.22], [7.88, 8.12], 
        [7.93, 8.03], [7.95, 7.98], [7.98, 7.93], [8.04, 7.88], 
        [8.12, 7.82], [8.23, 7.77], [8.60, 7.58], [8.80, 7.32], 
        [8.89, 6.83], [8.90, 5.99], [8.91, 5.42], [8.92, 4.84], 
        [8.94, 4.31], [8.96, 3.90], [9.03, 3.11], [10.55, 3.15], 
        [11.86, 3.16], [13.11, 3.11], [14.20, 3.02], [15.00, 2.88], 
        [15.46, 2.73], [15.84, 2.53], [16.10, 2.30], [16.19, 2.09], 
        [16.20, 2.02], [16.22, 1.96], [16.25, 1.91], [16.28, 1.88], 
        [16.32, 1.84], [16.36, 1.76], [16.40, 1.65], [16.42, 1.52], 
        [16.44, 1.36], [16.47, 1.15], [16.50, 0.94], [16.52, 0.74], 
        [16.56, 0.21], [16.58, -0.52], [16.57, -1.29], [16.53, -1.94], 
        [16.50, -2.18], [16.43, -2.49], [16.34, -2.83], [16.24, -3.16], 
        [16.12, -3.52], [16.06, -3.76], [16.06, -3.90], [16.10, -3.98], 
        [16.18, -4.14], [16.16, -4.42], [16.06, -4.71], [15.91, -4.92], 
        [15.82, -5.02], [15.73, -5.17], [15.65, -5.35], [15.58, -5.56], 
        [15.51, -5.90], [15.58, -6.08], [15.87, -6.14], [16.46, -6.15], 
        [17.04, -6.17], [18.09, -6.21], [19.45, -6.27], [20.98, -6.34], 
        [22.62, -6.42], [24.29, -6.49], [25.79, -6.55], [26.93, -6.59], 
        [29.10, -6.66], [29.04, -8.07], [29.01, -8.63], [28.97, -9.11], 
        [28.92, -9.47], [28.88, -9.65], [28.85, -9.76], [28.82, -9.93], 
        [28.80, -10.14], [28.79, -10.36], [28.78, -10.59], [28.76, -10.76], 
        [28.72, -10.85], [28.67, -10.89], [28.66, -10.90], [28.70, -10.95], 
        [28.81, -11.01], [28.95, -11.09], [29.11, -11.19], [29.25, -11.30], 
        [29.36, -11.40], [29.42, -11.49], [29.47, -11.60], [29.57, -11.74], 
        [29.70, -11.90], [29.84, -12.06], [29.98, -12.21], [30.10, -12.36], 
        [30.18, -12.48], [30.21, -12.56], [30.22, -12.62], [30.25, -12.67], 
        [30.30, -12.72], [30.36, -12.75], [30.47, -13.00], [30.45, -13.50], 
        [30.33, -14.13], [30.11, -14.72], [29.99, -15.00], [29.84, -15.35], 
        [29.68, -15.72], [29.55, -16.06], [29.41, -16.39], [29.26, -16.73], 
        [29.11, -17.02], [28.98, -17.25], [28.87, -17.42], [28.78, -17.58], 
        [28.72, -17.72], [28.69, -17.81], [28.63, -17.98], [28.46, -18.17], 
        [28.21, -18.35], [27.91, -18.50], [27.49, -18.61], [27.00, -18.64], 
        [26.50, -18.60], [26.08, -18.47], [25.59, -18.14], [25.18, -17.66], 
        [24.91, -17.09], [24.81, -16.50], [24.97, -15.83], [25.33, -14.68], 
        [25.73, -13.57], [25.98, -13.02], [26.04, -12.96], [26.10, -12.86], 
        [26.18, -12.74], [26.24, -12.61], [26.32, -12.43], [26.34, -12.27], 
        [26.33, -12.08], [26.26, -11.81], [26.18, -11.42], [26.14, -11.13], 
        [26.16, -10.94], [26.23, -10.84], [26.27, -10.79], [26.30, -10.70], 
        [26.32, -10.59], [26.33, -10.45], [26.33, -10.13], [23.78, -10.13], 
        [22.76, -10.13], [21.86, -10.15], [21.17, -10.17], [20.80, -10.19], 
        [20.36, -10.25], [20.36, -10.98], [20.38, -11.48], [20.47, -11.77], 
        [20.65, -11.92], [20.95, -11.97], [21.09, -11.99], [21.25, -12.02], 
        [21.40, -12.05], [21.53, -12.10], [21.64, -12.14], [21.74, -12.18], 
        [21.83, -12.20], [21.88, -12.21], [21.92, -12.24], [21.94, -12.33], 
        [21.96, -12.46], [21.97, -12.62], [21.98, -12.84], [22.01, -12.98], 
        [22.09, -13.07], [22.21, -13.15], [22.35, -13.22], [22.42, -13.34], 
        [22.44, -13.55], [22.42, -13.94], [22.38, -14.28], [22.32, -14.70], 
        [22.23, -15.14], [22.12, -15.56], [21.98, -16.11], [21.92, -16.43], 
        [21.94, -16.68], [22.03, -16.95], [22.11, -17.21], [22.14, -17.42], 
        [22.13, -17.65], [22.07, -17.96], [22.02, -18.19], [21.96, -18.40], 
        [21.91, -18.58], [21.87, -18.70], [21.83, -18.81], [21.77, -18.98], 
        [21.70, -19.18], [21.64, -19.39], [21.55, -19.68], [21.53, -19.87], 
        [21.57, -20.06], [21.69, -20.31], [21.79, -20.54], [21.83, -20.72], 
        [21.83, -20.87], [21.78, -21.06], [21.67, -21.39], [21.30, -21.19], 
        [21.09, -21.09], [20.94, -21.05], [20.83, -21.07], [20.68, -21.16], 
        [20.54, -21.25], [20.42, -21.27], [20.30, -21.24], [20.12, -21.15], 
        [19.94, -21.06], [19.82, -21.03], [19.70, -21.06], [19.56, -21.15], 
        [19.45, -21.21], [19.36, -21.26], [19.30, -21.28], [19.26, -21.28], 
        [19.25, -21.19], [19.28, -21.00], [19.32, -20.73], [19.38, -20.41], 
        [19.47, -19.93], [19.49, -19.65], [19.45, -19.45], [19.33, -19.22], 
        [19.25, -19.07], [19.20, -18.95], [19.18, -18.87], [19.19, -18.84], 
        [19.21, -18.83], [19.20, -18.81], [19.16, -18.77], [19.10, -18.73], 
        [19.03, -18.70], [18.97, -18.67], [18.92, -18.66], [18.90, -18.67], 
        [18.88, -18.73], [18.84, -18.87], [18.78, -19.07], [18.72, -19.31], 
        [18.64, -19.66], [18.62, -19.88], [18.66, -20.04], [18.76, -20.22], 
        [18.88, -20.45], [18.93, -20.64], [18.92, -20.83], [18.85, -21.06], 
        [18.75, -21.31], [18.40, -21.13], [18.21, -21.04], [18.07, -21.00], 
        [17.95, -21.02], [17.79, -21.10], [17.64, -21.18], [17.52, -21.20], 
        [17.39, -21.18], [17.21, -21.10], [17.04, -21.02], [16.92, -21.00], 
        [16.82, -21.01], [16.72, -21.08], [16.64, -21.13], [16.57, -21.17], 
        [16.50, -21.20], [16.46, -21.21], [16.40, -21.11], [16.38, -20.89], 
        [16.41, -20.65], [16.47, -20.49], [16.56, -20.26], [16.58, -19.91], 
        [16.54, -19.52], [16.44, -19.19], [16.36, -19.02], [16.31, -18.86], 
        [16.31, -18.70], [16.33, -18.52], [16.37, -18.33], [16.42, -18.23], 
        [16.50, -18.20], [16.64, -18.22], [16.80, -18.24], [16.93, -18.19], 
        [17.01, -18.09], [17.04, -17.93], [16.97, -17.80], [16.79, -17.71], 
        [16.56, -17.68], [16.33, -17.72], [16.14, -17.78], [16.04, -17.75], 
        [16.02, -17.61], [16.08, -17.35], [16.20, -16.84], [16.26, -16.42], 
        [16.24, -16.11], [16.15, -15.91], [16.08, -15.81], [16.04, -15.68], 
        [16.02, -15.52], [16.02, -15.32], [16.04, -15.09], [16.09, -14.97], 
        [16.18, -14.93], [16.35, -14.92], [16.66, -14.94], [16.78, -14.22], 
        [16.83, -13.94], [16.90, -13.68], [16.96, -13.49], [17.02, -13.39], 
        [17.07, -13.32], [17.10, -13.22], [17.13, -13.10], [17.14, -12.97], 
        [17.15, -12.85], [17.18, -12.75], [17.22, -12.67], [17.28, -12.63], 
        [17.34, -12.59], [17.38, -12.54], [17.41, -12.47], [17.42, -12.41], 
        [17.48, -12.22], [17.63, -12.07], [17.85, -11.97], [18.12, -11.93], 
        [18.28, -11.92], [18.38, -11.89], [18.45, -11.85], [18.47, -11.78], 
        [18.45, -11.72], [18.41, -11.69], [18.34, -11.68], [18.23, -11.70], 
        [18.11, -11.72], [18.02, -11.70], [17.95, -11.62], [17.89, -11.49], 
        [17.85, -11.34], [17.84, -11.21], [17.87, -11.07], [17.94, -10.91], 
        [18.00, -10.77], [18.04, -10.63], [18.08, -10.51], [18.09, -10.41], 
        [18.05, -10.31], [17.82, -10.25], [17.24, -10.23], [16.15, -10.22], 
        [14.20, -10.22], [14.19, -10.82], [14.17, -11.79], [14.12, -12.46], 
        [14.03, -12.98], [13.88, -13.54], [13.68, -14.20], [13.52, -14.62], 
        [13.35, -14.91], [13.12, -15.16], [12.84, -15.43], [13.55, -15.43], 
        [14.25, -15.45], [14.79, -15.50], [15.13, -15.58], [15.25, -15.68], 
        [15.26, -15.73], [15.28, -15.77], [15.33, -15.80], [15.38, -15.81], 
        [15.43, -15.82], [15.49, -15.85], [15.53, -15.90], [15.57, -15.96], 
        [15.61, -16.29], [15.62, -16.82], [15.59, -17.36], [15.53, -17.75], 
        [15.48, -17.91], [15.41, -18.15], [15.32, -18.42], [15.24, -18.70], 
        [15.05, -19.25], [14.89, -19.58], [14.71, -19.74], [14.49, -19.79], 
        [14.38, -19.80], [14.28, -19.82], [14.20, -19.85], [14.16, -19.88], 
        [14.05, -19.92], [13.78, -19.95], [13.40, -19.97], [12.93, -19.98], 
        [11.76, -19.98], [11.70, -20.43], [11.68, -20.62], [11.66, -20.82], 
        [11.65, -21.00], [11.64, -21.13], [11.63, -21.24], [11.60, -21.34], 
        [11.55, -21.43], [11.50, -21.50], [11.43, -21.57], [11.42, -21.63], 
        [11.46, -21.72], [11.56, -21.84], [11.67, -21.97], [11.73, -22.12], 
        [11.74, -22.35], [11.71, -22.70], [11.69, -22.96], [11.69, -23.19], 
        [11.71, -23.37], [11.73, -23.47], [11.83, -23.51], [11.90, -23.32], 
        [11.94, -22.93], [11.94, -22.36], [11.97, -21.53], [12.11, -20.99], 
        [12.41, -20.65], [12.89, -20.45], [13.26, -20.41], [13.61, -20.48], 
        [13.92, -20.64], [14.17, -20.90], [14.34, -21.40], [14.44, -22.27], 
        [14.46, -23.50], [14.41, -25.09], [14.34, -26.27], [14.23, -26.97], 
        [14.04, -27.35], [13.73, -27.55], [13.37, -27.63], [12.95, -27.62], 
        [12.55, -27.53], [12.26, -27.37], [12.12, -27.20], [12.02, -26.99], 
        [11.95, -26.65], [11.88, -26.11], [11.86, -25.90], [11.82, -25.73], 
        [11.79, -25.62], [11.76, -25.58], [11.56, -25.59], [11.44, -25.53], 
        [11.38, -25.38], [11.36, -25.11], [11.36, -24.88], [11.32, -24.73], 
        [11.26, -24.63], [11.16, -24.57], [10.99, -24.47], [10.87, -24.27], 
        [10.74, -23.85], [10.55, -23.10], [10.42, -22.59], [10.30, -22.21], 
        [10.18, -21.96], [10.07, -21.81], [9.93, -21.64], [9.86, -21.50], 
        [9.87, -21.36], [9.95, -21.24], [9.99, -21.17], [10.01, -21.06], 
        [10.01, -20.92], [10.00, -20.77], [9.91, -20.38], [9.66, -20.21], 
        [8.99, -20.19], [7.64, -20.28], [6.54, -20.36], [5.86, -20.43], 
        [5.49, -20.51], [5.31, -20.61], [5.20, -20.70], [5.06, -20.83], 
        [4.90, -20.97], [4.74, -21.11], [4.59, -21.25], [4.44, -21.38], 
        [4.32, -21.48], [4.24, -21.55], [4.17, -21.62], [4.06, -21.74], 
        [3.92, -21.88], [3.79, -22.04], [3.42, -22.38], [3.03, -22.60], 
        [2.64, -22.69], [2.30, -22.63], [2.19, -22.57], [2.09, -22.52], 
        [2.01, -22.48], [1.96, -22.46], [1.94, -22.46], [1.91, -22.49], 
        [1.90, -22.55], [1.89, -22.62], [1.88, -22.71], [1.84, -22.81], 
        [1.79, -22.91], [1.73, -22.99], [1.64, -23.10], [1.54, -23.27], 
        [1.43, -23.48], [1.32, -23.71], [1.21, -23.98], [1.07, -24.28], 
        [0.93, -24.59], [0.80, -24.87], [0.69, -25.10], [0.61, -25.29], 
        [0.58, -25.42], [0.58, -25.47], [0.61, -25.48], [0.64, -25.52], 
        [0.66, -25.57], [0.66, -25.63], [0.68, -25.70], [0.71, -25.79], 
        [0.76, -25.89], [0.83, -25.97], [0.91, -26.10], [0.96, -26.31], 
        [0.99, -26.63], [1.00, -27.11], [0.99, -27.73], [0.94, -28.11], 
        [0.84, -28.26], [0.70, -28.21], [0.63, -28.17], [0.59, -28.21], 
        [0.57, -28.33], [0.57, -28.56], [0.53, -28.94], [0.43, -29.22], 
        [0.25, -29.39], [0.02, -29.44], [-0.09, -29.44], [-0.21, -29.41], 
        [-0.32, -29.38], [-0.40, -29.35], [-0.40, -29.35] ], convexity = 10); 
    polygon(points = [ [-0.57, -27.01], [-0.54, -26.72], [-0.43, -26.55], 
        [-0.23, -26.47], [0.05, -26.48], [0.29, -26.56], [0.46, -26.71], 
        [0.55, -26.95], [0.58, -27.31], [0.59, -27.79], [0.68, -27.34], 
        [0.74, -26.96], [0.71, -26.67], [0.61, -26.45], [0.41, -26.28], 
        [0.27, -26.19], [0.14, -26.16], [-0.00, -26.17], [-0.20, -26.22], 
        [-0.48, -26.34], [-0.65, -26.52], [-0.73, -26.81], [-0.75, -27.24], 
        [-0.72, -27.57], [-0.66, -27.62], [-0.61, -27.42], [-0.57, -27.01], 
        [-0.57, -27.01] ], convexity = 10); 
    polygon(points = [ [-8.24, -22.40], [-8.23, -22.06], [-8.20, -21.82], 
        [-8.14, -21.66], [-8.03, -21.52], [-7.94, -21.41], [-7.89, -21.32], 
        [-7.89, -21.25], [-7.94, -21.19], [-7.98, -21.12], [-8.02, -21.00], 
        [-8.04, -20.86], [-8.05, -20.72], [-8.06, -20.51], [-8.10, -20.40], 
        [-8.21, -20.36], [-8.42, -20.36], [-8.80, -20.36], [-8.66, -20.68], 
        [-8.60, -20.89], [-8.56, -21.18], [-8.53, -21.55], [-8.52, -22.00], 
        [-8.52, -22.40], [-8.50, -22.75], [-8.49, -23.01], [-8.46, -23.15], 
        [-8.38, -23.25], [-8.31, -23.14], [-8.26, -22.85], [-8.24, -22.40], 
        [-8.24, -22.40] ], convexity = 10); 
    polygon(points = [ [-10.72, -15.34], [-10.73, -15.25], [-10.75, -15.17], 
        [-10.77, -15.12], [-10.80, -15.10], [-10.85, -15.08], [-10.91, -15.01], 
        [-10.98, -14.91], [-11.05, -14.79], [-11.13, -14.55], [-11.19, -14.13], 
        [-11.23, -13.41], [-11.27, -12.31], [-11.34, -10.13], [-12.67, -10.07], 
        [-13.26, -10.04], [-13.91, -10.01], [-14.54, -9.98], [-15.06, -9.95], 
        [-16.12, -9.90], [-16.12, -10.16], [-16.11, -10.28], [-16.08, -10.41], 
        [-16.03, -10.54], [-15.98, -10.65], [-15.87, -10.91], [-15.85, -11.12], 
        [-15.92, -11.27], [-16.08, -11.35], [-16.20, -11.39], [-16.26, -11.43], 
        [-16.26, -11.48], [-16.21, -11.55], [-16.14, -11.61], [-16.04, -11.65], 
        [-15.92, -11.68], [-15.80, -11.69], [-15.65, -11.71], [-15.52, -11.75], 
        [-15.41, -11.82], [-15.31, -11.91], [-15.13, -12.15], [-14.99, -12.37], 
        [-14.92, -12.57], [-14.89, -12.74], [-14.88, -12.84], [-14.84, -12.95], 
        [-14.78, -13.07], [-14.70, -13.18], [-14.61, -13.33], [-14.55, -13.50], 
        [-14.52, -13.72], [-14.51, -14.01], [-14.51, -14.34], [-14.48, -14.53], 
        [-14.40, -14.62], [-14.27, -14.67], [-14.14, -14.71], [-14.07, -14.77], 
        [-14.05, -14.87], [-14.06, -15.03], [-14.08, -15.17], [-14.11, -15.30], 
        [-14.15, -15.42], [-14.18, -15.52], [-14.21, -15.62], [-14.17, -15.66], 
        [-14.03, -15.67], [-13.75, -15.64], [-13.45, -15.61], [-13.02, -15.59], 
        [-12.51, -15.58], [-11.98, -15.58], [-10.72, -15.34] ], convexity = 10); 
	} 
		
	//        10 for MEADS Launcher 
	if (iopt==10) difference() { 
    polygon(points = [ [23.64, -27.40], [22.82, -27.20], [22.12, -26.93], 
        [21.50, -26.55], [20.90, -26.05], [20.25, -25.45], [19.87, -25.76], 
        [19.21, -26.25], [18.59, -26.53], [17.84, -26.66], [16.75, -26.70], 
        [16.16, -26.71], [15.77, -26.76], [15.49, -26.85], [15.23, -27.02], 
        [14.72, -27.33], [14.08, -27.43], [12.99, -27.34], [11.11, -27.05], 
        [10.70, -26.97], [10.36, -26.87], [10.09, -26.75], [9.88, -26.62], 
        [9.61, -26.43], [9.36, -26.34], [9.12, -26.35], [8.84, -26.46], 
        [7.99, -26.69], [6.80, -26.75], [5.59, -26.65], [4.69, -26.40], 
        [4.50, -26.27], [4.23, -26.06], [3.92, -25.79], [3.61, -25.49], 
        [3.07, -24.89], [2.64, -24.25], [2.33, -23.57], [2.15, -22.87], 
        [2.06, -22.32], [0.92, -22.28], [0.44, -22.28], [-0.05, -22.30], 
        [-0.48, -22.34], [-0.79, -22.39], [-1.06, -22.45], [-1.38, -22.49], 
        [-1.69, -22.52], [-1.98, -22.53], [-2.31, -22.52], [-2.49, -22.56], 
        [-2.56, -22.65], [-2.58, -22.83], [-2.59, -22.98], [-2.64, -23.08], 
        [-2.75, -23.13], [-2.91, -23.14], [-3.44, -23.08], [-4.09, -22.92], 
        [-4.72, -22.70], [-5.15, -22.49], [-5.29, -22.40], [-5.40, -22.35], 
        [-5.48, -22.34], [-5.50, -22.37], [-5.60, -22.49], [-5.83, -22.50], 
        [-6.12, -22.42], [-6.40, -22.25], [-6.68, -22.08], [-7.22, -22.01], 
        [-8.31, -22.01], [-10.25, -22.08], [-12.37, -22.16], [-12.37, -22.67], 
        [-12.43, -23.25], [-12.60, -23.92], [-12.84, -24.58], [-13.15, -25.16], 
        [-13.30, -25.41], [-13.44, -25.66], [-13.56, -25.87], [-13.63, -26.02], 
        [-13.83, -26.31], [-14.14, -26.58], [-14.53, -26.81], [-14.97, -26.97], 
        [-15.19, -27.03], [-15.40, -27.10], [-15.58, -27.17], [-15.71, -27.22], 
        [-16.53, -27.35], [-17.83, -27.31], [-19.17, -27.13], [-20.10, -26.85], 
        [-20.24, -26.79], [-20.43, -26.75], [-20.65, -26.71], [-20.86, -26.70], 
        [-21.39, -26.66], [-21.86, -26.53], [-22.29, -26.30], [-22.72, -25.95], 
        [-23.34, -25.22], [-23.85, -24.32], [-24.20, -23.39], [-24.33, -22.54], 
        [-24.34, -22.37], [-24.37, -22.24], [-24.42, -22.16], [-24.49, -22.13], 
        [-25.16, -22.20], [-26.42, -22.38], [-27.65, -22.57], [-28.22, -22.67], 
        [-28.25, -22.75], [-28.30, -22.94], [-28.37, -23.22], [-28.45, -23.56], 
        [-28.64, -24.23], [-28.86, -24.81], [-29.14, -25.31], [-29.47, -25.75], 
        [-29.60, -25.91], [-29.70, -26.07], [-29.77, -26.20], [-29.80, -26.29], 
        [-29.82, -26.37], [-29.88, -26.45], [-29.97, -26.52], [-30.08, -26.59], 
        [-30.23, -26.66], [-30.42, -26.75], [-30.62, -26.85], [-30.82, -26.95], 
        [-31.00, -27.04], [-31.16, -27.10], [-31.28, -27.13], [-31.36, -27.13], 
        [-31.39, -27.12], [-31.42, -27.13], [-31.44, -27.17], [-31.45, -27.22], 
        [-31.55, -27.29], [-31.88, -27.33], [-32.48, -27.33], [-33.41, -27.31], 
        [-34.44, -27.27], [-35.10, -27.21], [-35.51, -27.12], [-35.80, -26.99], 
        [-36.01, -26.87], [-36.27, -26.76], [-36.54, -26.65], [-36.79, -26.57], 
        [-37.61, -26.19], [-38.31, -25.57], [-38.88, -24.72], [-39.30, -23.68], 
        [-39.53, -22.89], [-41.27, -22.89], [-43.00, -22.89], [-43.65, -22.06], 
        [-44.03, -21.59], [-44.30, -21.34], [-44.55, -21.25], [-44.91, -21.23], 
        [-45.34, -21.18], [-45.84, -20.93], [-46.64, -20.30], [-47.99, -19.15], 
        [-48.15, -19.02], [-48.35, -18.85], [-48.56, -18.68], [-48.77, -18.53], 
        [-48.98, -18.34], [-49.14, -18.15], [-49.24, -17.95], [-49.30, -17.73], 
        [-49.34, -17.33], [-49.28, -17.08], [-49.10, -16.95], [-48.80, -16.91], 
        [-48.56, -16.90], [-48.43, -16.84], [-48.38, -16.69], [-48.37, -16.40], 
        [-48.38, -16.15], [-48.42, -15.99], [-48.49, -15.91], [-48.61, -15.89], 
        [-48.86, -15.83], [-49.02, -15.64], [-49.10, -15.30], [-49.11, -14.79], 
        [-49.08, -14.40], [-49.02, -14.16], [-48.93, -14.01], [-48.78, -13.92], 
        [-48.63, -13.83], [-48.54, -13.68], [-48.50, -13.42], [-48.50, -13.00], 
        [-48.48, -12.63], [-48.44, -12.32], [-48.38, -12.07], [-48.29, -11.88], 
        [-48.08, -11.57], [-48.92, -11.57], [-49.28, -11.56], [-49.56, -11.53], 
        [-49.75, -11.48], [-49.85, -11.41], [-49.89, -11.14], [-49.94, -10.54], 
        [-49.97, -9.69], [-49.99, -8.68], [-50.00, -6.92], [-49.90, -5.96], 
        [-49.64, -5.55], [-49.15, -5.46], [-48.69, -5.46], [-47.54, -2.38], 
        [-46.39, 0.71], [-39.87, 0.74], [-37.14, 0.74], [-35.04, 0.73], 
        [-33.67, 0.70], [-33.12, 0.65], [-33.01, 0.54], [-32.89, 0.35], 
        [-32.78, 0.09], [-32.68, -0.21], [-32.58, -0.53], [-32.49, -0.84], 
        [-32.41, -1.12], [-32.34, -1.33], [-32.28, -1.57], [-32.20, -1.94], 
        [-32.11, -2.39], [-32.02, -2.88], [-31.81, -4.04], [-30.59, -4.08], 
        [-30.05, -4.11], [-29.66, -4.16], [-29.42, -4.21], [-29.32, -4.29], 
        [-29.24, -4.36], [-29.06, -4.41], [-28.78, -4.44], [-28.39, -4.45], 
        [-27.52, -4.45], [-27.48, -2.89], [-27.45, -1.33], [-24.30, -1.30], 
        [-21.15, -1.26], [-21.15, -0.98], [-21.12, -0.83], [-21.01, -0.70], 
        [-20.80, -0.59], [-20.45, -0.46], [-20.17, -0.38], [-19.92, -0.32], 
        [-19.73, -0.30], [-19.62, -0.31], [-19.53, -0.42], [-19.50, -0.57], 
        [-19.54, -0.71], [-19.66, -0.80], [-19.73, -0.83], [-19.75, -0.85], 
        [-19.73, -0.87], [-19.66, -0.87], [-19.58, -1.01], [-19.53, -1.46], 
        [-19.50, -2.30], [-19.50, -3.61], [-19.49, -4.75], [-19.46, -5.63], 
        [-19.42, -6.19], [-19.37, -6.42], [-19.32, -6.57], [-19.28, -6.92], 
        [-19.25, -7.44], [-19.24, -8.08], [-19.23, -8.69], [-19.21, -9.20], 
        [-19.18, -9.54], [-19.13, -9.66], [-19.08, -9.51], [-19.03, -9.11], 
        [-18.98, -8.52], [-18.94, -7.79], [-18.89, -7.05], [-18.84, -6.43], 
        [-18.79, -5.99], [-18.74, -5.79], [-18.69, -5.70], [-18.64, -5.56], 
        [-18.59, -5.39], [-18.54, -5.21], [-18.40, -4.73], [-18.14, -4.46], 
        [-17.67, -4.35], [-16.87, -4.32], [-15.68, -4.32], [-15.68, -3.31], 
        [-15.67, -2.73], [-15.61, -2.33], [-15.44, -1.97], [-15.14, -1.50], 
        [-14.60, -0.69], [-12.69, -0.74], [-11.94, -0.76], [-11.31, -0.79], 
        [-10.87, -0.82], [-10.68, -0.85], [-10.36, -0.87], [-9.58, -0.89], 
        [-8.43, -0.90], [-7.06, -0.91], [-5.53, -0.91], [-3.99, -0.93], 
        [-2.61, -0.96], [-1.57, -0.99], [0.40, -1.07], [0.69, -1.58], 
        [0.85, -1.95], [0.94, -2.62], [0.97, -4.03], [0.98, -6.64], 
        [0.97, -8.65], [0.95, -10.06], [0.91, -10.91], [0.85, -11.19], 
        [0.79, -11.20], [0.71, -11.23], [0.63, -11.27], [0.56, -11.32], 
        [0.48, -11.38], [0.38, -11.47], [0.27, -11.55], [0.16, -11.64], 
        [0.03, -11.73], [0.03, -11.78], [0.17, -11.78], [0.47, -11.74], 
        [0.71, -11.70], [0.91, -11.66], [1.08, -11.61], [1.17, -11.57], 
        [1.33, -11.48], [1.67, -11.29], [2.15, -11.03], [2.70, -10.74], 
        [4.61, -9.73], [5.70, -9.14], [6.20, -8.84], [6.36, -8.69], 
        [6.51, -8.53], [6.74, -8.37], [7.01, -8.25], [7.28, -8.19], 
        [8.24, -7.76], [10.02, -6.85], [11.76, -5.90], [12.59, -5.37], 
        [12.78, -5.19], [13.08, -5.01], [13.37, -4.89], [13.56, -4.88], 
        [13.62, -4.89], [13.70, -4.87], [13.80, -4.83], [13.90, -4.76], 
        [14.02, -4.69], [14.16, -4.63], [14.30, -4.59], [14.42, -4.58], 
        [14.53, -4.57], [14.63, -4.54], [14.70, -4.51], [14.74, -4.47], 
        [14.94, -4.26], [15.31, -4.05], [15.71, -3.90], [15.99, -3.87], 
        [16.13, -3.89], [16.29, -3.87], [16.47, -3.80], [16.66, -3.71], 
        [16.91, -3.57], [17.27, -3.37], [17.70, -3.13], [18.15, -2.89], 
        [19.40, -2.23], [20.51, -1.64], [21.73, -0.99], [23.33, -0.13], 
        [24.66, 0.59], [25.38, 1.02], [25.65, 1.27], [25.66, 1.45], 
        [25.56, 1.75], [25.36, 2.38], [25.11, 3.23], [24.82, 4.21], 
        [24.10, 6.71], [23.41, 6.51], [23.10, 6.44], [22.87, 6.40], 
        [22.70, 6.41], [22.60, 6.45], [22.40, 6.82], [22.15, 7.46], 
        [21.96, 8.09], [21.92, 8.45], [22.11, 8.64], [22.50, 8.87], 
        [22.93, 9.08], [23.23, 9.16], [23.29, 9.18], [23.32, 9.23], 
        [23.33, 9.30], [23.32, 9.39], [22.44, 12.39], [21.74, 14.76], 
        [21.25, 16.40], [21.01, 17.20], [20.87, 17.71], [20.86, 18.04], 
        [21.01, 18.28], [21.34, 18.54], [21.62, 18.74], [21.76, 18.91], 
        [21.81, 19.10], [21.78, 19.36], [21.76, 19.62], [21.80, 19.82], 
        [21.95, 20.00], [22.21, 20.22], [22.49, 20.41], [22.86, 20.61], 
        [23.28, 20.81], [23.71, 20.98], [24.42, 21.26], [25.00, 21.53], 
        [25.40, 21.77], [25.54, 21.93], [25.54, 21.97], [25.53, 22.02], 
        [25.53, 22.07], [25.53, 22.12], [25.85, 22.45], [26.57, 23.02], 
        [27.33, 23.55], [27.77, 23.79], [27.84, 23.80], [27.89, 23.82], 
        [27.93, 23.86], [27.95, 23.90], [28.02, 24.00], [28.23, 24.20], 
        [28.54, 24.45], [28.91, 24.74], [29.43, 25.11], [29.95, 25.41], 
        [30.51, 25.67], [31.17, 25.92], [31.71, 26.11], [32.23, 26.27], 
        [32.67, 26.40], [32.97, 26.47], [33.28, 26.54], [33.75, 26.68], 
        [34.32, 26.87], [34.91, 27.08], [35.48, 27.27], [35.98, 27.42], 
        [36.34, 27.51], [36.53, 27.53], [36.67, 27.39], [36.84, 27.02], 
        [37.06, 26.35], [37.36, 25.32], [37.97, 23.17], [38.64, 20.83], 
        [39.23, 18.78], [39.60, 17.53], [39.64, 17.45], [39.70, 17.40], 
        [39.77, 17.38], [39.85, 17.39], [40.04, 17.40], [40.22, 17.30], 
        [40.36, 17.13], [40.41, 16.92], [40.43, 16.80], [40.48, 16.65], 
        [40.54, 16.48], [40.63, 16.31], [40.73, 16.11], [40.77, 15.96], 
        [40.75, 15.85], [40.68, 15.73], [40.60, 15.65], [40.51, 15.58], 
        [40.42, 15.54], [40.34, 15.52], [40.27, 15.49], [40.25, 15.39], 
        [40.28, 15.18], [40.37, 14.86], [40.45, 14.58], [40.52, 14.31], 
        [40.58, 14.09], [40.62, 13.93], [40.68, 13.74], [40.78, 13.40], 
        [40.90, 12.96], [41.05, 12.47], [41.19, 11.98], [41.32, 11.54], 
        [41.41, 11.20], [41.47, 11.01], [41.76, 9.96], [42.32, 8.03], 
        [42.93, 5.91], [43.40, 4.27], [43.56, 3.72], [43.75, 3.08], 
        [43.94, 2.42], [44.11, 1.82], [44.38, 0.87], [44.69, -0.21], 
        [45.06, -1.50], [45.50, -3.05], [45.67, -3.60], [45.79, -3.88], 
        [45.93, -3.97], [46.14, -3.96], [46.32, -3.95], [46.44, -3.98], 
        [46.53, -4.07], [46.60, -4.21], [46.64, -4.34], [46.67, -4.46], 
        [46.70, -4.56], [46.71, -4.64], [46.73, -4.71], [46.76, -4.81], 
        [46.81, -4.93], [46.88, -5.05], [46.95, -5.31], [46.91, -5.57], 
        [46.78, -5.77], [46.58, -5.84], [46.45, -5.88], [46.40, -6.00], 
        [46.43, -6.24], [46.53, -6.61], [46.61, -6.88], [46.73, -7.30], 
        [46.87, -7.80], [47.02, -8.32], [47.21, -8.99], [47.47, -9.88], 
        [47.75, -10.86], [48.03, -11.82], [48.42, -13.20], [48.62, -14.04], 
        [48.66, -14.49], [48.56, -14.68], [48.52, -14.72], [48.50, -14.80], 
        [48.49, -14.88], [48.51, -14.98], [48.51, -15.18], [48.36, -15.36], 
        [47.98, -15.56], [47.33, -15.82], [46.85, -15.99], [46.45, -16.09], 
        [46.07, -16.13], [45.64, -16.13], [45.25, -16.11], [45.00, -16.13], 
        [44.86, -16.19], [44.79, -16.30], [44.71, -16.40], [44.56, -16.51], 
        [44.34, -16.62], [44.09, -16.72], [43.84, -16.81], [43.65, -16.89], 
        [43.52, -16.95], [43.49, -16.98], [43.76, -16.98], [44.45, -16.95], 
        [45.47, -16.90], [46.70, -16.83], [47.94, -16.77], [48.97, -16.73], 
        [49.68, -16.72], [49.97, -16.75], [50.00, -16.81], [50.00, -16.89], 
        [49.97, -16.99], [49.92, -17.08], [49.72, -17.20], [49.24, -17.33], 
        [48.39, -17.48], [47.09, -17.68], [44.12, -18.09], [42.13, -18.32], 
        [40.45, -18.44], [38.44, -18.50], [37.14, -18.53], [35.95, -18.57], 
        [35.01, -18.61], [34.43, -18.65], [33.61, -18.72], [33.57, -20.45], 
        [33.55, -21.13], [33.51, -21.71], [33.47, -22.12], [33.42, -22.30], 
        [33.32, -22.74], [33.29, -23.54], [33.32, -24.33], [33.42, -24.73], 
        [33.47, -24.80], [33.51, -24.92], [33.53, -25.07], [33.54, -25.25], 
        [33.55, -25.45], [33.59, -25.58], [33.65, -25.66], [33.73, -25.69], 
        [33.81, -25.71], [33.87, -25.77], [33.91, -25.87], [33.92, -26.00], 
        [33.93, -26.13], [33.96, -26.23], [34.00, -26.30], [34.05, -26.32], 
        [34.10, -26.35], [34.14, -26.43], [34.17, -26.55], [34.18, -26.70], 
        [34.16, -26.90], [34.11, -27.02], [33.98, -27.10], [33.77, -27.15], 
        [33.53, -27.18], [33.19, -27.19], [32.80, -27.20], [32.40, -27.19], 
        [31.44, -27.15], [31.41, -26.50], [31.40, -26.20], [31.42, -25.97], 
        [31.48, -25.80], [31.57, -25.69], [31.64, -25.60], [31.70, -25.47], 
        [31.75, -25.31], [31.76, -25.16], [31.78, -25.01], [31.82, -24.87], 
        [31.88, -24.77], [31.95, -24.71], [32.05, -24.63], [32.10, -24.42], 
        [32.14, -24.07], [32.14, -23.51], [32.14, -22.38], [31.70, -22.38], 
        [31.51, -22.37], [31.35, -22.32], [31.23, -22.26], [31.15, -22.17], 
        [31.09, -22.10], [31.04, -22.14], [30.99, -22.30], [30.94, -22.59], 
        [30.85, -23.23], [30.22, -23.34], [29.85, -23.42], [29.63, -23.54], 
        [29.48, -23.75], [29.33, -24.15], [29.23, -24.43], [29.14, -24.66], 
        [29.05, -24.83], [29.00, -24.91], [28.89, -25.05], [28.75, -25.30], 
        [28.62, -25.60], [28.52, -25.91], [28.31, -26.28], [27.92, -26.67], 
        [27.43, -27.03], [26.93, -27.28], [26.23, -27.45], [25.40, -27.53], 
        [24.51, -27.51], [23.64, -27.40], [23.64, -27.40] ], convexity = 10); 
    polygon(points = [ [15.20, -11.53], [15.54, -11.37], [15.98, -11.30], 
        [16.35, -11.34], [16.46, -11.49], [16.69, -11.67], [17.61, -11.78], 
        [19.31, -11.82], [21.87, -11.80], [23.77, -11.76], [24.86, -11.72], 
        [25.38, -11.64], [25.55, -11.53], [25.82, -11.36], [26.25, -11.30], 
        [26.64, -11.34], [26.76, -11.49], [26.85, -11.63], [27.21, -11.73], 
        [27.83, -11.80], [28.66, -11.82], [29.10, -11.81], [29.34, -11.78], 
        [29.45, -11.70], [29.47, -11.57], [29.40, -11.40], [29.24, -11.31], 
        [29.05, -11.32], [28.90, -11.44], [28.85, -11.49], [28.75, -11.53], 
        [28.64, -11.56], [28.51, -11.57], [28.39, -11.56], [28.29, -11.53], 
        [28.23, -11.49], [28.20, -11.44], [28.18, -11.39], [28.11, -11.35], 
        [28.02, -11.32], [27.90, -11.31], [27.73, -11.29], [27.61, -11.17], 
        [27.50, -10.92], [27.37, -10.48], [27.24, -9.88], [27.29, -9.51], 
        [27.55, -9.30], [28.06, -9.19], [28.27, -9.15], [28.45, -9.11], 
        [28.58, -9.07], [28.65, -9.03], [28.65, -8.92], [28.61, -8.70], 
        [28.54, -8.40], [28.44, -8.06], [28.30, -7.56], [28.09, -6.86], 
        [27.85, -6.04], [27.61, -5.21], [27.37, -4.40], [27.15, -3.65], 
        [26.97, -3.04], [26.86, -2.66], [26.77, -2.36], [26.65, -1.94], 
        [26.51, -1.48], [26.38, -1.01], [26.25, -0.59], [26.13, -0.25], 
        [26.02, -0.03], [25.96, 0.05], [25.02, -0.43], [22.83, -1.58], 
        [20.08, -3.04], [17.49, -4.43], [17.08, -4.66], [16.83, -4.83], 
        [16.71, -4.98], [16.70, -5.10], [16.70, -5.22], [16.63, -5.34], 
        [16.50, -5.49], [16.28, -5.64], [16.09, -5.77], [15.90, -5.88], 
        [15.74, -5.95], [15.64, -5.97], [15.49, -6.01], [15.28, -6.15], 
        [15.00, -6.36], [14.66, -6.67], [14.39, -6.88], [14.10, -7.06], 
        [13.79, -7.20], [13.51, -7.27], [12.52, -7.72], [10.72, -8.66], 
        [9.00, -9.61], [8.23, -10.12], [8.14, -10.25], [7.92, -10.39], 
        [7.64, -10.51], [7.37, -10.56], [7.23, -10.59], [7.01, -10.67], 
        [6.74, -10.79], [6.45, -10.93], [6.06, -11.14], [5.90, -11.25], 
        [5.94, -11.30], [6.16, -11.31], [6.34, -11.32], [6.47, -11.36], 
        [6.55, -11.42], [6.58, -11.50], [6.72, -11.66], [7.36, -11.74], 
        [8.77, -11.78], [11.24, -11.77], [13.23, -11.75], [14.38, -11.72], 
        [14.95, -11.65], [15.20, -11.53], [15.20, -11.53] ], convexity = 10); 
	} 
	
	//        11 for MEADS Radar 
	if (iopt==11) difference() { 
    polygon(points = [ [-33.18, -40.23], [-33.32, -40.19], [-33.50, -40.14], 
        [-33.70, -40.09], [-33.88, -40.04], [-34.28, -39.87], [-34.80, -39.57], 
        [-35.36, -39.19], [-35.86, -38.77], [-36.03, -38.63], [-36.24, -38.48], 
        [-36.46, -38.32], [-36.68, -38.17], [-36.93, -38.01], [-37.12, -37.84], 
        [-37.27, -37.65], [-37.39, -37.43], [-37.53, -37.13], [-37.64, -36.90], 
        [-37.74, -36.71], [-37.86, -36.49], [-37.91, -36.39], [-37.95, -36.25], 
        [-37.99, -36.09], [-38.03, -35.94], [-38.08, -35.57], [-39.88, -35.57], 
        [-40.65, -35.57], [-41.26, -35.54], [-41.68, -35.51], [-41.89, -35.46], 
        [-42.09, -35.33], [-42.27, -35.14], [-42.39, -34.95], [-42.44, -34.77], 
        [-42.45, -34.71], [-42.48, -34.65], [-42.53, -34.62], [-42.59, -34.60], 
        [-42.65, -34.58], [-42.72, -34.53], [-42.78, -34.46], [-42.83, -34.37], 
        [-42.88, -34.27], [-42.95, -34.17], [-43.03, -34.08], [-43.11, -34.02], 
        [-43.19, -33.97], [-43.25, -33.91], [-43.30, -33.84], [-43.31, -33.78], 
        [-43.34, -33.71], [-43.44, -33.66], [-43.62, -33.64], [-43.90, -33.63], 
        [-44.21, -33.62], [-44.42, -33.59], [-44.58, -33.52], [-44.73, -33.39], 
        [-44.83, -33.30], [-44.94, -33.22], [-45.04, -33.17], [-45.11, -33.15], 
        [-45.18, -33.13], [-45.24, -33.08], [-45.30, -33.00], [-45.35, -32.91], 
        [-45.40, -32.81], [-45.47, -32.73], [-45.55, -32.68], [-45.63, -32.66], 
        [-45.72, -32.65], [-45.82, -32.60], [-45.91, -32.53], [-46.00, -32.44], 
        [-46.09, -32.35], [-46.20, -32.26], [-46.32, -32.17], [-46.44, -32.11], 
        [-46.54, -32.05], [-46.63, -31.98], [-46.69, -31.92], [-46.71, -31.86], 
        [-46.73, -31.80], [-46.78, -31.73], [-46.86, -31.67], [-46.95, -31.61], 
        [-47.04, -31.56], [-47.12, -31.49], [-47.17, -31.42], [-47.19, -31.36], 
        [-47.21, -31.30], [-47.25, -31.25], [-47.31, -31.22], [-47.38, -31.21], 
        [-47.47, -31.19], [-47.56, -31.15], [-47.64, -31.09], [-47.71, -31.01], 
        [-47.79, -30.92], [-47.90, -30.82], [-48.03, -30.72], [-48.16, -30.64], 
        [-48.37, -30.50], [-48.54, -30.30], [-48.69, -30.03], [-48.83, -29.67], 
        [-48.87, -29.48], [-48.87, -29.33], [-48.80, -29.16], [-48.67, -28.94], 
        [-48.52, -28.75], [-48.39, -28.62], [-48.25, -28.54], [-48.09, -28.51], 
        [-47.92, -28.48], [-47.82, -28.43], [-47.78, -28.33], [-47.77, -28.15], 
        [-47.78, -27.96], [-47.82, -27.86], [-47.92, -27.82], [-48.10, -27.81], 
        [-48.45, -27.77], [-48.65, -27.61], [-48.74, -27.26], [-48.75, -26.66], 
        [-48.75, -26.26], [-48.77, -25.96], [-48.80, -25.74], [-48.85, -25.62], 
        [-48.90, -25.54], [-48.91, -25.47], [-48.87, -25.39], [-48.78, -25.28], 
        [-48.68, -25.19], [-48.55, -25.13], [-48.39, -25.11], [-48.18, -25.11], 
        [-47.76, -25.15], [-47.82, -24.66], [-47.87, -24.16], [-47.89, -23.80], 
        [-47.86, -23.53], [-47.80, -23.28], [-47.69, -22.96], [-48.53, -22.96], 
        [-48.87, -22.95], [-49.17, -22.94], [-49.39, -22.91], [-49.51, -22.88], 
        [-49.56, -22.81], [-49.62, -22.68], [-49.66, -22.51], [-49.69, -22.32], 
        [-49.72, -22.12], [-49.77, -21.93], [-49.82, -21.77], [-49.87, -21.66], 
        [-49.97, -21.46], [-50.00, -21.25], [-49.96, -21.07], [-49.86, -20.93], 
        [-49.76, -20.71], [-49.72, -20.35], [-49.73, -20.01], [-49.81, -19.81], 
        [-49.88, -19.35], [-49.91, -18.40], [-49.88, -17.46], [-49.81, -17.00], 
        [-49.77, -16.95], [-49.74, -16.88], [-49.72, -16.78], [-49.71, -16.67], 
        [-49.65, -16.20], [-49.46, -15.87], [-49.15, -15.66], [-48.72, -15.59], 
        [-48.58, -15.58], [-48.42, -15.56], [-48.25, -15.52], [-48.11, -15.48], 
        [-47.93, -15.40], [-47.83, -15.30], [-47.77, -15.13], [-47.73, -14.84], 
        [-47.69, -14.61], [-47.63, -14.41], [-47.56, -14.25], [-47.48, -14.14], 
        [-47.41, -14.02], [-47.34, -13.86], [-47.28, -13.65], [-47.24, -13.42], 
        [-47.20, -13.19], [-47.14, -12.99], [-47.07, -12.83], [-47.00, -12.73], 
        [-46.92, -12.63], [-46.85, -12.48], [-46.80, -12.30], [-46.76, -12.10], 
        [-46.72, -11.90], [-46.66, -11.71], [-46.59, -11.56], [-46.51, -11.46], 
        [-46.43, -11.38], [-46.37, -11.27], [-46.33, -11.15], [-46.32, -11.04], 
        [-46.29, -10.73], [-46.21, -10.41], [-46.10, -10.16], [-45.99, -10.03], 
        [-45.94, -9.98], [-45.88, -9.88], [-45.83, -9.74], [-45.80, -9.58], 
        [-45.76, -9.39], [-45.70, -9.25], [-45.61, -9.15], [-45.49, -9.09], 
        [-43.12, -9.03], [-38.15, -9.00], [-33.16, -9.00], [-30.73, -9.06], 
        [-30.64, -9.09], [-30.56, -9.16], [-30.49, -9.24], [-30.45, -9.32], 
        [-30.41, -9.42], [-30.35, -9.53], [-30.28, -9.64], [-30.20, -9.73], 
        [-30.12, -9.86], [-30.05, -10.05], [-30.00, -10.29], [-29.96, -10.60], 
        [-29.92, -10.91], [-29.86, -11.18], [-29.79, -11.42], [-29.70, -11.61], 
        [-29.61, -11.81], [-29.53, -12.08], [-29.48, -12.43], [-29.45, -12.91], 
        [-29.38, -13.74], [-29.21, -14.16], [-28.79, -14.31], [-27.99, -14.33], 
        [-27.42, -14.34], [-27.04, -14.36], [-26.81, -14.41], [-26.68, -14.48], 
        [-26.63, -14.55], [-26.58, -14.62], [-26.54, -14.68], [-26.53, -14.73], 
        [-26.45, -14.76], [-26.23, -14.79], [-25.91, -14.81], [-25.51, -14.82], 
        [-24.48, -14.82], [-24.53, -13.82], [-24.55, -13.40], [-24.58, -12.98], 
        [-24.61, -12.62], [-24.64, -12.36], [-24.66, -12.15], [-24.66, -11.98], 
        [-24.64, -11.86], [-24.60, -11.78], [-24.56, -11.72], [-24.53, -11.65], 
        [-24.50, -11.57], [-24.49, -11.50], [-24.48, -11.41], [-24.44, -11.32], 
        [-24.38, -11.22], [-24.30, -11.13], [-24.12, -11.02], [-23.69, -10.96], 
        [-22.71, -10.94], [-20.91, -10.94], [-17.71, -10.94], [-17.65, -10.72], 
        [-17.60, -10.61], [-17.52, -10.49], [-17.41, -10.37], [-17.29, -10.26], 
        [-17.10, -10.13], [-16.90, -10.05], [-16.62, -10.02], [-16.19, -10.01], 
        [-15.79, -10.02], [-15.51, -10.05], [-15.33, -10.11], [-15.20, -10.20], 
        [-15.08, -10.31], [-15.04, -10.39], [-15.08, -10.48], [-15.19, -10.62], 
        [-15.29, -10.80], [-15.35, -11.10], [-15.37, -11.65], [-15.38, -12.60], 
        [-15.38, -14.33], [-14.94, -14.33], [-14.73, -14.32], [-14.54, -14.28], 
        [-14.37, -14.21], [-14.22, -14.12], [-13.97, -14.00], [-13.33, -13.94], 
        [-11.82, -13.92], [-8.96, -13.92], [-6.08, -13.93], [-4.43, -13.97], 
        [-3.66, -14.07], [-3.40, -14.23], [-3.18, -14.27], [-2.59, -14.30], 
        [-1.61, -14.32], [-0.25, -14.33], [1.59, -14.34], [2.68, -14.39], 
        [3.23, -14.48], [3.46, -14.65], [3.49, -14.74], [3.51, -14.89], 
        [3.53, -15.08], [3.54, -15.29], [3.55, -15.54], [3.59, -15.76], 
        [3.65, -15.96], [3.74, -16.13], [3.83, -16.32], [3.90, -16.55], 
        [3.96, -16.84], [3.99, -17.16], [4.03, -17.47], [4.09, -17.79], 
        [4.16, -18.08], [4.24, -18.31], [4.33, -18.53], [4.40, -18.82], 
        [4.45, -19.13], [4.49, -19.45], [4.53, -20.15], [7.99, -20.15], 
        [9.85, -20.15], [10.86, -20.13], [11.24, -20.08], [11.22, -20.00], 
        [11.12, -19.91], [11.06, -19.81], [11.02, -19.67], [11.01, -19.51], 
        [11.06, -19.20], [11.23, -18.97], [11.52, -18.82], [11.97, -18.74], 
        [12.22, -18.70], [12.40, -18.66], [12.52, -18.60], [12.56, -18.55], 
        [12.57, -18.49], [12.60, -18.43], [12.65, -18.36], [12.70, -18.31], 
        [12.77, -18.22], [12.81, -18.09], [12.84, -17.91], [12.85, -17.68], 
        [12.83, -17.35], [12.73, -17.16], [12.52, -17.07], [12.15, -17.05], 
        [12.03, -17.03], [11.90, -16.99], [11.78, -16.93], [11.69, -16.85], 
        [11.60, -16.78], [11.52, -16.72], [11.45, -16.67], [11.39, -16.66], 
        [11.32, -16.69], [11.20, -16.79], [11.04, -16.93], [10.86, -17.11], 
        [10.66, -17.30], [10.50, -17.43], [10.37, -17.50], [10.28, -17.50], 
        [10.17, -17.47], [10.00, -17.45], [9.78, -17.44], [9.55, -17.43], 
        [9.23, -17.42], [9.00, -17.37], [8.80, -17.24], [8.54, -17.00], 
        [8.10, -16.57], [8.10, -15.76], [8.11, -15.37], [8.15, -14.97], 
        [8.21, -14.58], [8.29, -14.23], [8.37, -13.87], [8.45, -13.43], 
        [8.52, -12.96], [8.57, -12.52], [8.63, -12.10], [8.69, -11.70], 
        [8.76, -11.35], [8.82, -11.11], [8.89, -10.90], [8.96, -10.62], 
        [9.02, -10.31], [9.07, -10.02], [9.12, -9.74], [9.18, -9.47], 
        [9.25, -9.26], [9.32, -9.12], [9.38, -8.96], [9.45, -8.69], 
        [9.50, -8.34], [9.55, -7.94], [9.59, -7.54], [9.65, -7.16], 
        [9.71, -6.86], [9.77, -6.65], [9.84, -6.42], [9.91, -6.04], 
        [9.98, -5.56], [10.03, -5.02], [10.09, -4.49], [10.15, -4.01], 
        [10.22, -3.64], [10.28, -3.42], [10.34, -3.24], [10.41, -2.95], 
        [10.47, -2.60], [10.52, -2.22], [10.56, -1.85], [10.62, -1.51], 
        [10.69, -1.25], [10.75, -1.09], [10.82, -0.92], [10.89, -0.63], 
        [10.95, -0.25], [11.01, 0.19], [11.06, 0.61], [11.12, 0.99], 
        [11.19, 1.28], [11.25, 1.44], [11.31, 1.60], [11.36, 1.87], 
        [11.41, 2.21], [11.45, 2.61], [11.49, 3.03], [11.55, 3.49], 
        [11.62, 3.91], [11.69, 4.26], [11.77, 4.61], [11.85, 5.04], 
        [11.92, 5.51], [11.98, 5.96], [12.03, 6.36], [12.10, 6.73], 
        [12.16, 7.01], [12.22, 7.17], [12.28, 7.32], [12.35, 7.59], 
        [12.40, 7.94], [12.45, 8.32], [12.50, 8.71], [12.56, 9.06], 
        [12.63, 9.33], [12.70, 9.49], [12.77, 9.66], [12.84, 9.94], 
        [12.89, 10.31], [12.94, 10.77], [12.99, 11.22], [13.04, 11.69], 
        [13.11, 12.11], [13.17, 12.44], [13.24, 12.76], [13.31, 13.17], 
        [13.38, 13.62], [13.43, 14.04], [13.49, 14.44], [13.55, 14.81], 
        [13.62, 15.11], [13.68, 15.30], [13.74, 15.49], [13.80, 15.77], 
        [13.86, 16.12], [13.90, 16.49], [13.95, 16.88], [14.01, 17.22], 
        [14.08, 17.47], [14.16, 17.64], [14.24, 17.82], [14.31, 18.09], 
        [14.36, 18.46], [14.41, 18.93], [14.45, 19.36], [14.50, 19.77], 
        [14.56, 20.11], [14.62, 20.35], [14.68, 20.57], [14.74, 20.88], 
        [14.79, 21.24], [14.83, 21.61], [14.89, 22.20], [14.98, 22.64], 
        [15.08, 22.92], [15.19, 23.01], [15.22, 23.03], [15.25, 23.07], 
        [15.27, 23.13], [15.27, 23.20], [15.30, 23.30], [15.36, 23.43], 
        [15.44, 23.58], [15.55, 23.71], [15.66, 23.86], [15.77, 24.02], 
        [15.85, 24.19], [15.90, 24.32], [15.94, 24.45], [15.98, 24.57], 
        [16.04, 24.68], [16.09, 24.76], [16.29, 25.16], [16.51, 25.85], 
        [16.71, 26.68], [16.83, 27.46], [16.88, 27.84], [16.95, 28.19], 
        [17.02, 28.46], [17.08, 28.62], [17.14, 28.76], [17.20, 29.00], 
        [17.25, 29.30], [17.28, 29.63], [17.32, 29.98], [17.37, 30.26], 
        [17.43, 30.46], [17.50, 30.57], [17.57, 30.67], [17.65, 30.81], 
        [17.72, 30.98], [17.78, 31.16], [17.84, 31.34], [17.91, 31.51], 
        [17.98, 31.65], [18.04, 31.74], [18.09, 31.83], [18.16, 31.95], 
        [18.22, 32.10], [18.27, 32.25], [18.33, 32.39], [18.39, 32.53], 
        [18.46, 32.64], [18.52, 32.71], [18.58, 32.78], [18.64, 32.88], 
        [18.69, 32.99], [18.72, 33.11], [18.76, 33.24], [18.83, 33.36], 
        [18.92, 33.47], [19.02, 33.55], [19.11, 33.63], [19.18, 33.71], 
        [19.23, 33.79], [19.25, 33.87], [19.26, 33.95], [19.30, 34.04], 
        [19.34, 34.15], [19.40, 34.24], [19.58, 34.39], [19.84, 34.46], 
        [20.14, 34.45], [20.46, 34.35], [20.72, 34.30], [20.96, 34.39], 
        [21.13, 34.59], [21.19, 34.86], [21.20, 35.02], [21.24, 35.22], 
        [21.28, 35.45], [21.34, 35.67], [21.43, 35.93], [21.52, 36.10], 
        [21.63, 36.22], [21.77, 36.30], [21.96, 36.41], [22.08, 36.61], 
        [22.16, 36.97], [22.22, 37.57], [22.26, 37.88], [22.32, 38.18], 
        [22.39, 38.44], [22.47, 38.64], [22.54, 38.82], [22.61, 39.05], 
        [22.67, 39.32], [22.71, 39.58], [22.78, 40.00], [22.88, 40.26], 
        [23.02, 40.35], [23.19, 40.27], [23.27, 40.17], [23.31, 40.00], 
        [23.31, 39.70], [23.29, 39.21], [23.25, 38.79], [23.19, 38.33], 
        [23.11, 37.89], [23.04, 37.52], [22.96, 37.17], [22.89, 36.79], 
        [22.83, 36.43], [22.79, 36.14], [22.75, 35.87], [22.69, 35.60], 
        [22.61, 35.36], [22.53, 35.17], [22.44, 34.93], [22.38, 34.63], 
        [22.35, 34.17], [22.35, 33.46], [22.34, 32.93], [22.32, 32.46], 
        [22.30, 32.10], [22.26, 31.91], [22.20, 31.80], [22.09, 31.64], 
        [21.94, 31.46], [21.78, 31.29], [21.58, 31.06], [21.46, 30.88], 
        [21.40, 30.70], [21.39, 30.48], [21.37, 30.29], [21.33, 30.05], 
        [21.27, 29.79], [21.19, 29.55], [21.12, 29.28], [21.04, 28.95], 
        [20.98, 28.59], [20.94, 28.26], [20.90, 27.94], [20.84, 27.62], 
        [20.77, 27.33], [20.70, 27.10], [20.63, 26.90], [20.57, 26.67], 
        [20.53, 26.44], [20.52, 26.23], [20.53, 25.61], [20.52, 25.04], 
        [20.51, 24.33], [20.47, 23.31], [20.43, 22.18], [20.37, 21.53], 
        [20.28, 21.16], [20.13, 20.89], [20.06, 20.75], [19.99, 20.56], 
        [19.93, 20.34], [19.89, 20.12], [19.86, 19.90], [19.82, 19.69], 
        [19.76, 19.51], [19.70, 19.38], [19.64, 19.23], [19.58, 18.98], 
        [19.53, 18.66], [19.50, 18.30], [19.45, 17.92], [19.40, 17.58], 
        [19.33, 17.29], [19.25, 17.08], [19.17, 16.86], [19.09, 16.55], 
        [19.03, 16.16], [18.98, 15.71], [18.93, 15.30], [18.88, 14.93], 
        [18.82, 14.65], [18.77, 14.49], [18.72, 14.31], [18.66, 13.96], 
        [18.59, 13.50], [18.52, 12.97], [18.46, 12.45], [18.40, 12.01], 
        [18.36, 11.70], [18.32, 11.56], [18.30, 11.39], [18.36, 11.18], 
        [18.51, 10.98], [18.71, 10.83], [19.04, 10.61], [19.27, 10.36], 
        [19.40, 10.04], [19.44, 9.65], [19.46, 9.36], [19.52, 9.14], 
        [19.66, 8.93], [19.91, 8.63], [20.10, 8.41], [20.28, 8.18], 
        [20.42, 7.97], [20.50, 7.81], [20.56, 7.69], [20.62, 7.59], 
        [20.67, 7.52], [20.71, 7.49], [20.75, 7.47], [20.80, 7.40], 
        [20.85, 7.29], [20.90, 7.17], [20.95, 7.03], [21.03, 6.88], 
        [21.11, 6.76], [21.20, 6.67], [21.27, 6.59], [21.33, 6.51], 
        [21.37, 6.44], [21.39, 6.39], [21.40, 6.32], [21.45, 6.21], 
        [21.53, 6.08], [21.61, 5.94], [21.71, 5.79], [21.80, 5.63], 
        [21.87, 5.49], [21.91, 5.37], [22.01, 5.15], [22.18, 4.85], 
        [22.40, 4.52], [22.64, 4.19], [22.76, 4.00], [22.94, 3.68], 
        [23.17, 3.27], [23.41, 2.81], [23.64, 2.36], [23.86, 1.96], 
        [24.03, 1.64], [24.14, 1.47], [24.39, 1.10], [24.62, 0.73], 
        [24.84, 0.33], [25.07, -0.12], [25.21, -0.40], [25.35, -0.65], 
        [25.48, -0.85], [25.58, -0.97], [25.64, -1.06], [25.70, -1.18], 
        [25.74, -1.30], [25.75, -1.42], [25.76, -1.54], [25.80, -1.66], 
        [25.85, -1.76], [25.91, -1.83], [25.99, -1.91], [26.08, -2.04], 
        [26.17, -2.20], [26.25, -2.37], [26.33, -2.53], [26.41, -2.68], 
        [26.47, -2.78], [26.52, -2.83], [26.57, -2.88], [26.62, -2.98], 
        [26.67, -3.10], [26.73, -3.25], [26.78, -3.40], [26.85, -3.55], 
        [26.92, -3.67], [26.98, -3.76], [27.18, -4.02], [27.43, -4.40], 
        [27.71, -4.88], [28.01, -5.43], [28.16, -5.73], [28.30, -5.98], 
        [28.41, -6.15], [28.47, -6.23], [28.51, -6.28], [28.56, -6.37], 
        [28.62, -6.50], [28.67, -6.64], [28.73, -6.79], [28.80, -6.94], 
        [28.88, -7.05], [28.96, -7.13], [29.03, -7.20], [29.10, -7.30], 
        [29.16, -7.42], [29.19, -7.54], [29.22, -7.65], [29.26, -7.75], 
        [29.30, -7.81], [29.34, -7.83], [29.50, -8.04], [29.76, -8.51], 
        [30.01, -9.01], [30.12, -9.31], [30.13, -9.37], [30.18, -9.45], 
        [30.24, -9.55], [30.33, -9.64], [30.54, -9.90], [30.77, -10.26], 
        [31.03, -10.72], [31.33, -11.32], [31.49, -11.62], [31.65, -11.91], 
        [31.80, -12.16], [31.92, -12.32], [32.01, -12.44], [32.08, -12.55], 
        [32.13, -12.64], [32.15, -12.71], [32.16, -12.76], [32.19, -12.83], 
        [32.23, -12.90], [32.29, -12.96], [32.36, -13.07], [32.47, -13.25], 
        [32.60, -13.47], [32.73, -13.72], [32.90, -14.02], [33.04, -14.22], 
        [33.19, -14.35], [33.37, -14.43], [33.65, -14.56], [33.84, -14.76], 
        [33.96, -15.02], [34.00, -15.35], [33.98, -15.55], [33.94, -15.71], 
        [33.87, -15.84], [33.77, -15.96], [33.68, -16.04], [33.59, -16.11], 
        [33.52, -16.16], [33.47, -16.17], [33.43, -16.18], [33.38, -16.22], 
        [33.32, -16.26], [33.25, -16.32], [33.18, -16.38], [33.08, -16.42], 
        [32.97, -16.45], [32.86, -16.46], [32.73, -16.48], [32.55, -16.53], 
        [32.34, -16.61], [32.14, -16.70], [31.89, -16.82], [31.71, -16.88], 
        [31.56, -16.88], [31.42, -16.85], [30.91, -16.82], [30.06, -16.86], 
        [29.23, -16.96], [28.78, -17.08], [28.71, -17.19], [28.86, -17.27], 
        [29.23, -17.32], [29.84, -17.34], [30.22, -17.34], [30.57, -17.36], 
        [30.85, -17.39], [31.01, -17.42], [31.12, -17.46], [31.23, -17.46], 
        [31.33, -17.43], [31.42, -17.38], [31.75, -17.31], [32.70, -17.27], 
        [34.53, -17.25], [37.55, -17.24], [40.70, -17.25], [42.52, -17.27], 
        [43.37, -17.31], [43.64, -17.39], [43.71, -17.51], [43.76, -17.73], 
        [43.79, -18.06], [43.79, -18.57], [43.79, -19.59], [44.14, -19.92], 
        [44.28, -20.05], [44.41, -20.15], [44.52, -20.22], [44.58, -20.25], 
        [44.71, -20.29], [44.91, -20.43], [45.20, -20.65], [45.57, -20.95], 
        [45.71, -21.06], [45.87, -21.20], [46.02, -21.32], [46.15, -21.43], 
        [46.27, -21.53], [46.41, -21.65], [46.55, -21.77], [46.66, -21.87], 
        [46.77, -21.96], [46.87, -22.03], [46.97, -22.07], [47.04, -22.09], 
        [47.10, -22.11], [47.20, -22.16], [47.30, -22.24], [47.40, -22.33], 
        [47.53, -22.45], [47.68, -22.53], [47.89, -22.56], [48.18, -22.57], 
        [48.46, -22.58], [48.66, -22.62], [48.81, -22.68], [48.93, -22.77], 
        [49.04, -22.95], [49.10, -23.38], [49.12, -24.36], [49.13, -26.15], 
        [49.13, -27.94], [49.15, -28.92], [49.21, -29.36], [49.32, -29.56], 
        [49.46, -29.75], [49.50, -29.88], [49.42, -29.99], [49.22, -30.12], 
        [49.06, -30.22], [48.98, -30.31], [48.96, -30.42], [48.99, -30.58], 
        [49.06, -31.45], [49.03, -32.70], [48.92, -33.92], [48.75, -34.73], 
        [48.71, -34.92], [48.67, -35.24], [48.65, -35.65], [48.64, -36.10], 
        [48.65, -36.67], [48.67, -37.03], [48.73, -37.23], [48.82, -37.36], 
        [48.90, -37.46], [48.97, -37.61], [49.02, -37.79], [49.06, -38.00], 
        [49.11, -38.36], [49.18, -38.56], [49.29, -38.66], [49.47, -38.68], 
        [49.64, -38.71], [49.82, -38.81], [49.95, -38.93], [50.00, -39.06], 
        [49.96, -39.15], [49.80, -39.32], [49.51, -39.60], [49.04, -40.03], 
        [48.83, -40.20], [48.62, -40.29], [48.27, -40.32], [47.66, -40.33], 
        [47.09, -40.32], [46.76, -40.29], [46.58, -40.24], [46.49, -40.13], 
        [46.41, -40.04], [46.31, -39.98], [46.17, -39.95], [46.00, -39.94], 
        [45.64, -39.94], [45.64, -39.07], [45.64, -38.20], [45.99, -38.22], 
        [46.19, -38.22], [46.31, -38.19], [46.37, -38.10], [46.42, -37.92], 
        [46.46, -37.78], [46.51, -37.64], [46.58, -37.52], [46.64, -37.43], 
        [46.72, -37.30], [46.77, -37.07], [46.79, -36.71], [46.80, -36.17], 
        [46.80, -35.09], [46.48, -35.09], [46.24, -35.07], [46.07, -35.01], 
        [45.96, -34.89], [45.88, -34.70], [45.83, -34.59], [45.77, -34.45], 
        [45.70, -34.32], [45.62, -34.20], [45.55, -34.09], [45.49, -33.98], 
        [45.45, -33.88], [45.44, -33.81], [45.39, -33.68], [45.23, -33.46], 
        [44.96, -33.14], [44.56, -32.70], [44.49, -32.61], [44.43, -32.52], 
        [44.39, -32.44], [44.37, -32.39], [44.36, -32.34], [44.32, -32.28], 
        [44.26, -32.23], [44.18, -32.18], [44.10, -32.13], [44.04, -32.06], 
        [44.00, -32.00], [43.99, -31.93], [43.97, -31.87], [43.91, -31.79], 
        [43.84, -31.71], [43.74, -31.64], [43.65, -31.56], [43.57, -31.49], 
        [43.52, -31.41], [43.50, -31.35], [43.49, -31.29], [43.44, -31.24], 
        [43.38, -31.19], [43.30, -31.16], [43.22, -31.11], [43.13, -31.04], 
        [43.06, -30.95], [43.01, -30.85], [42.91, -30.68], [42.82, -30.70], 
        [42.74, -30.89], [42.68, -31.27], [42.64, -31.51], [42.59, -31.77], 
        [42.53, -32.01], [42.47, -32.20], [42.42, -32.41], [42.38, -32.67], 
        [42.35, -32.96], [42.34, -33.25], [42.33, -33.53], [42.30, -33.79], 
        [42.27, -34.01], [42.22, -34.16], [42.08, -34.34], [41.83, -34.48], 
        [41.52, -34.57], [41.15, -34.60], [41.00, -34.61], [40.92, -34.68], 
        [40.89, -34.84], [40.88, -35.14], [40.84, -35.59], [40.69, -35.87], 
        [40.41, -36.02], [39.96, -36.06], [39.67, -36.06], [39.50, -36.10], 
        [39.41, -36.18], [39.37, -36.32], [39.26, -36.62], [39.11, -36.96], 
        [38.94, -37.26], [38.82, -37.40], [38.79, -37.43], [38.77, -37.47], 
        [38.75, -37.53], [38.75, -37.60], [38.74, -37.67], [38.71, -37.75], 
        [38.68, -37.82], [38.63, -37.88], [38.59, -37.94], [38.55, -38.00], 
        [38.51, -38.07], [38.50, -38.14], [38.38, -38.42], [38.13, -38.77], 
        [37.82, -39.09], [37.54, -39.30], [37.41, -39.37], [37.29, -39.44], 
        [37.20, -39.50], [37.15, -39.55], [37.11, -39.59], [37.03, -39.65], 
        [36.94, -39.71], [36.83, -39.77], [36.71, -39.83], [36.58, -39.90], 
        [36.45, -39.96], [36.35, -40.02], [36.25, -40.07], [36.14, -40.13], 
        [36.03, -40.18], [35.94, -40.23], [35.67, -40.27], [35.09, -40.30], 
        [34.25, -40.32], [33.22, -40.33], [30.69, -40.33], [30.43, -40.09], 
        [30.31, -39.99], [30.16, -39.89], [30.01, -39.80], [29.88, -39.74], 
        [29.40, -39.54], [28.97, -39.33], [28.61, -39.10], [28.33, -38.88], 
        [28.20, -38.78], [28.10, -38.73], [27.97, -38.73], [27.80, -38.78], 
        [27.68, -38.84], [27.59, -38.90], [27.52, -38.96], [27.50, -39.03], 
        [27.49, -39.08], [27.47, -39.12], [27.44, -39.15], [27.40, -39.16], 
        [27.32, -39.19], [27.19, -39.26], [27.01, -39.37], [26.82, -39.50], 
        [26.62, -39.63], [26.45, -39.74], [26.33, -39.81], [26.26, -39.84], 
        [26.20, -39.86], [26.10, -39.91], [25.97, -39.99], [25.83, -40.08], 
        [25.47, -40.33], [20.40, -40.33], [17.83, -40.32], [16.24, -40.30], 
        [15.40, -40.26], [15.06, -40.19], [14.89, -40.13], [14.62, -40.06], 
        [14.28, -40.00], [13.92, -39.94], [13.33, -39.85], [12.84, -39.72], 
        [12.45, -39.56], [12.15, -39.37], [12.01, -39.26], [11.84, -39.15], 
        [11.60, -39.01], [11.23, -38.81], [11.07, -38.71], [10.92, -38.61], 
        [10.80, -38.51], [10.72, -38.43], [10.64, -38.36], [10.51, -38.27], 
        [10.37, -38.17], [10.22, -38.09], [9.59, -37.66], [9.07, -37.08], 
        [8.70, -36.42], [8.52, -35.73], [8.48, -35.41], [8.43, -35.21], 
        [8.36, -35.10], [8.25, -35.05], [7.86, -35.01], [7.12, -35.00], 
        [6.12, -35.01], [4.93, -35.05], [4.17, -35.09], [3.74, -35.14], 
        [3.55, -35.21], [3.46, -35.33], [3.39, -35.43], [3.29, -35.53], 
        [3.15, -35.63], [3.01, -35.71], [2.81, -35.79], [2.68, -35.83], 
        [2.56, -35.81], [2.44, -35.74], [2.31, -35.68], [2.11, -35.63], 
        [1.86, -35.58], [1.61, -35.55], [1.30, -35.52], [1.08, -35.48], 
        [0.93, -35.40], [0.82, -35.30], [0.71, -35.19], [0.56, -35.13], 
        [0.35, -35.10], [0.03, -35.09], [-0.46, -35.07], [-0.79, -35.02], 
        [-0.98, -34.93], [-1.07, -34.79], [-1.17, -34.68], [-1.55, -34.63], 
        [-2.45, -34.61], [-4.12, -34.60], [-7.11, -34.60], [-7.17, -34.91], 
        [-7.19, -35.04], [-7.21, -35.18], [-7.22, -35.32], [-7.23, -35.42], 
        [-7.24, -35.53], [-7.29, -35.64], [-7.35, -35.76], [-7.42, -35.86], 
        [-7.52, -36.01], [-7.58, -36.21], [-7.61, -36.49], [-7.63, -36.92], 
        [-7.63, -37.25], [-7.64, -37.54], [-7.65, -37.75], [-7.66, -37.85], 
        [-7.67, -37.90], [-7.68, -37.95], [-7.69, -38.01], [-7.70, -38.06], 
        [-7.73, -38.12], [-7.80, -38.23], [-7.91, -38.37], [-8.03, -38.51], 
        [-8.17, -38.67], [-8.33, -38.86], [-8.49, -39.04], [-8.62, -39.21], 
        [-8.74, -39.34], [-8.85, -39.45], [-8.94, -39.52], [-9.00, -39.55], 
        [-9.05, -39.56], [-9.12, -39.59], [-9.19, -39.63], [-9.26, -39.69], 
        [-9.36, -39.76], [-9.51, -39.86], [-9.69, -39.97], [-9.88, -40.08], 
        [-10.36, -40.35], [-13.62, -40.31], [-15.33, -40.28], [-16.36, -40.24], 
        [-16.91, -40.19], [-17.17, -40.10], [-17.29, -40.04], [-17.40, -39.99], 
        [-17.49, -39.95], [-17.54, -39.94], [-17.65, -39.90], [-17.89, -39.80], 
        [-18.22, -39.64], [-18.61, -39.46], [-19.45, -39.01], [-19.97, -38.61], 
        [-20.28, -38.15], [-20.48, -37.51], [-20.55, -37.25], [-20.63, -37.01], 
        [-20.72, -36.80], [-20.80, -36.65], [-20.89, -36.48], [-20.96, -36.24], 
        [-21.01, -35.92], [-21.06, -35.50], [-21.13, -34.60], [-21.40, -34.60], 
        [-21.53, -34.62], [-21.69, -34.66], [-21.85, -34.72], [-22.00, -34.79], 
        [-22.21, -34.89], [-22.51, -34.96], [-22.94, -35.01], [-23.56, -35.05], 
        [-24.22, -35.09], [-24.61, -35.14], [-24.82, -35.21], [-24.94, -35.32], 
        [-24.99, -35.42], [-25.04, -35.54], [-25.07, -35.66], [-25.08, -35.78], 
        [-25.10, -35.90], [-25.14, -36.05], [-25.22, -36.19], [-25.31, -36.32], 
        [-25.40, -36.45], [-25.48, -36.62], [-25.55, -36.81], [-25.59, -36.98], 
        [-25.67, -37.45], [-25.79, -37.77], [-26.02, -38.06], [-26.43, -38.43], 
        [-26.96, -38.85], [-27.53, -39.27], [-28.14, -39.65], [-28.75, -40.00], 
        [-29.36, -40.33], [-31.12, -40.32], [-31.83, -40.31], [-32.45, -40.29], 
        [-32.92, -40.26], [-33.18, -40.23], [-33.18, -40.23] ], convexity = 10); 
    polygon(points = [ [46.31, -28.10], [46.72, -28.53], [47.12, -29.00], 
        [47.44, -29.41], [47.60, -29.68], [47.64, -29.77], [47.69, -29.84], 
        [47.75, -29.89], [47.81, -29.91], [47.87, -29.93], [47.93, -29.98], 
        [47.98, -30.06], [48.01, -30.16], [48.04, -30.25], [48.06, -30.33], 
        [48.09, -30.38], [48.11, -30.40], [48.12, -30.30], [48.14, -30.03], 
        [48.14, -29.63], [48.15, -29.14], [46.31, -28.10] ], convexity = 10); 
    polygon(points = [ [27.95, -13.38], [28.06, -13.25], [28.16, -13.05], 
        [28.22, -12.86], [28.19, -12.78], [28.14, -12.75], [28.08, -12.67], 
        [28.01, -12.56], [27.94, -12.41], [27.86, -12.24], [27.75, -12.02], 
        [27.62, -11.78], [27.50, -11.57], [27.38, -11.35], [27.25, -11.12], 
        [27.13, -10.91], [27.04, -10.74], [26.97, -10.60], [26.89, -10.48], 
        [26.82, -10.39], [26.77, -10.33], [26.67, -10.21], [26.51, -9.94], 
        [26.31, -9.56], [26.08, -9.09], [26.01, -8.94], [25.92, -8.78], 
        [25.83, -8.63], [25.75, -8.51], [25.68, -8.40], [25.62, -8.26], 
        [25.56, -8.12], [25.52, -8.00], [25.49, -7.90], [25.45, -7.81], 
        [25.40, -7.76], [25.36, -7.73], [25.30, -7.70], [25.23, -7.61], 
        [25.14, -7.47], [25.06, -7.30], [24.98, -7.13], [24.90, -6.99], 
        [24.83, -6.90], [24.78, -6.86], [24.74, -6.83], [24.69, -6.76], 
        [24.63, -6.65], [24.58, -6.51], [24.52, -6.35], [24.43, -6.16], 
        [24.33, -5.98], [24.23, -5.82], [24.15, -5.68], [24.07, -5.54], 
        [24.02, -5.43], [24.00, -5.36], [23.99, -5.30], [23.95, -5.23], 
        [23.89, -5.14], [23.81, -5.07], [23.74, -4.99], [23.67, -4.89], 
        [23.63, -4.80], [23.62, -4.72], [23.60, -4.64], [23.56, -4.56], 
        [23.50, -4.48], [23.43, -4.41], [23.35, -4.34], [23.26, -4.24], 
        [23.18, -4.12], [23.12, -4.00], [23.06, -3.87], [23.00, -3.75], 
        [22.94, -3.64], [22.89, -3.56], [22.83, -3.48], [22.77, -3.36], 
        [22.70, -3.22], [22.64, -3.08], [22.58, -2.93], [22.50, -2.78], 
        [22.41, -2.65], [22.33, -2.55], [22.03, -2.21], [21.82, -1.94], 
        [21.69, -1.72], [21.63, -1.53], [21.59, -1.41], [21.55, -1.30], 
        [21.49, -1.20], [21.43, -1.14], [21.37, -1.07], [21.30, -0.95], 
        [21.24, -0.82], [21.18, -0.67], [21.12, -0.52], [21.05, -0.37], 
        [20.97, -0.24], [20.89, -0.14], [20.82, -0.06], [20.76, 0.02], 
        [20.72, 0.10], [20.71, 0.16], [20.68, 0.24], [20.62, 0.36], 
        [20.53, 0.50], [20.42, 0.66], [20.30, 0.81], [20.21, 0.95], 
        [20.15, 1.06], [20.12, 1.14], [20.11, 1.20], [20.07, 1.27], 
        [20.01, 1.35], [19.94, 1.42], [19.86, 1.51], [19.79, 1.62], 
        [19.73, 1.73], [19.69, 1.84], [19.65, 1.96], [19.59, 2.09], 
        [19.52, 2.22], [19.45, 2.33], [19.37, 2.44], [19.30, 2.58], 
        [19.24, 2.73], [19.20, 2.87], [19.16, 3.00], [19.10, 3.12], 
        [19.03, 3.23], [18.96, 3.30], [18.89, 3.36], [18.82, 3.45], 
        [18.76, 3.56], [18.73, 3.66], [18.70, 3.76], [18.65, 3.83], 
        [18.61, 3.89], [18.57, 3.91], [18.51, 3.94], [18.44, 4.03], 
        [18.36, 4.17], [18.27, 4.34], [18.19, 4.51], [18.11, 4.66], 
        [18.04, 4.77], [17.99, 4.83], [17.95, 4.88], [17.89, 4.98], 
        [17.84, 5.11], [17.78, 5.27], [17.73, 5.42], [17.65, 5.55], 
        [17.58, 5.65], [17.50, 5.70], [17.43, 5.74], [17.36, 5.80], 
        [17.30, 5.88], [17.26, 5.97], [17.22, 5.99], [17.18, 5.84], 
        [17.14, 5.53], [17.10, 5.07], [17.05, 4.57], [16.98, 4.05], 
        [16.91, 3.57], [16.83, 3.18], [16.75, 2.82], [16.67, 2.43], 
        [16.61, 2.05], [16.58, 1.72], [16.54, 1.43], [16.48, 1.13], 
        [16.41, 0.85], [16.34, 0.64], [16.27, 0.43], [16.20, 0.12], 
        [16.14, -0.22], [16.10, -0.57], [16.06, -0.93], [16.00, -1.30], 
        [15.93, -1.65], [15.85, -1.93], [15.78, -2.22], [15.70, -2.63], 
        [15.63, -3.09], [15.57, -3.55], [15.52, -3.99], [15.47, -4.39], 
        [15.41, -4.70], [15.37, -4.89], [15.32, -5.08], [15.26, -5.41], 
        [15.19, -5.84], [15.13, -6.32], [15.07, -6.81], [14.99, -7.27], 
        [14.91, -7.65], [14.85, -7.91], [14.78, -8.12], [14.72, -8.42], 
        [14.67, -8.75], [14.64, -9.07], [14.60, -9.39], [14.54, -9.72], 
        [14.47, -10.01], [14.40, -10.22], [14.33, -10.40], [14.26, -10.59], 
        [14.20, -10.78], [14.16, -10.92], [14.13, -11.05], [14.08, -11.16], 
        [14.02, -11.25], [13.96, -11.30], [13.83, -11.57], [13.71, -12.07], 
        [13.64, -12.58], [13.68, -12.86], [14.38, -12.98], [15.99, -13.07], 
        [18.15, -13.14], [20.46, -13.16], [21.62, -13.16], [22.60, -13.17], 
        [23.31, -13.19], [23.65, -13.22], [23.90, -13.25], [24.39, -13.29], 
        [25.04, -13.33], [25.78, -13.36], [26.51, -13.39], [27.12, -13.41], 
        [27.55, -13.43], [27.74, -13.44], [27.79, -13.44], [27.84, -13.43], 
        [27.90, -13.41], [27.95, -13.38], [27.95, -13.38] ], convexity = 10); 
    polygon(points = [ [30.66, -12.95], [30.68, -12.91], [30.68, -12.86], 
        [30.66, -12.83], [30.62, -12.80], [30.57, -12.76], [30.51, -12.68], 
        [30.46, -12.56], [30.40, -12.43], [30.35, -12.30], [30.30, -12.20], 
        [30.24, -12.13], [30.20, -12.10], [30.15, -12.06], [30.08, -11.97], 
        [29.99, -11.83], [29.91, -11.66], [29.83, -11.49], [29.75, -11.35], 
        [29.68, -11.26], [29.63, -11.23], [29.59, -11.20], [29.54, -11.12], 
        [29.48, -11.00], [29.43, -10.86], [29.37, -10.70], [29.29, -10.54], 
        [29.21, -10.39], [29.13, -10.27], [29.06, -10.16], [28.99, -10.01], 
        [28.93, -9.86], [28.89, -9.71], [28.86, -9.59], [28.81, -9.48], 
        [28.76, -9.41], [28.70, -9.38], [28.65, -9.37], [28.59, -9.32], 
        [28.55, -9.25], [28.51, -9.17], [28.47, -9.07], [28.41, -8.95], 
        [28.34, -8.84], [28.27, -8.75], [28.18, -8.65], [28.10, -8.51], 
        [28.01, -8.35], [27.94, -8.20], [27.87, -8.06], [27.81, -7.93], 
        [27.74, -7.84], [27.69, -7.79], [27.65, -7.73], [27.59, -7.63], 
        [27.54, -7.50], [27.48, -7.34], [27.43, -7.19], [27.38, -7.07], 
        [27.33, -6.99], [27.29, -6.96], [27.24, -6.93], [27.18, -6.85], 
        [27.11, -6.74], [27.04, -6.59], [26.95, -6.43], [26.85, -6.26], 
        [26.75, -6.09], [26.65, -5.96], [26.56, -5.84], [26.49, -5.72], 
        [26.45, -5.62], [26.43, -5.54], [26.42, -5.49], [26.40, -5.45], 
        [26.38, -5.42], [26.34, -5.41], [26.30, -5.37], [26.23, -5.29], 
        [26.16, -5.15], [26.09, -4.99], [26.02, -4.82], [25.94, -4.66], 
        [25.87, -4.53], [25.81, -4.44], [25.75, -4.35], [25.68, -4.23], 
        [25.61, -4.09], [25.55, -3.95], [25.49, -3.81], [25.41, -3.67], 
        [25.32, -3.56], [25.25, -3.49], [25.18, -3.43], [25.12, -3.36], 
        [25.08, -3.30], [25.07, -3.24], [25.04, -3.14], [24.94, -2.96], 
        [24.80, -2.72], [24.62, -2.45], [24.44, -2.16], [24.28, -1.88], 
        [24.15, -1.64], [24.07, -1.48], [24.02, -1.36], [23.95, -1.24], 
        [23.87, -1.13], [23.79, -1.06], [23.72, -1.00], [23.67, -0.93], 
        [23.63, -0.87], [23.62, -0.81], [23.60, -0.74], [23.55, -0.64], 
        [23.47, -0.54], [23.38, -0.43], [23.28, -0.31], [23.20, -0.18], 
        [23.12, -0.06], [23.08, 0.05], [23.04, 0.14], [23.00, 0.25], 
        [22.94, 0.34], [22.89, 0.41], [22.84, 0.50], [22.77, 0.62], 
        [22.71, 0.76], [22.65, 0.90], [22.58, 1.05], [22.51, 1.20], 
        [22.42, 1.33], [22.35, 1.43], [22.28, 1.53], [22.21, 1.65], 
        [22.15, 1.78], [22.11, 1.90], [22.07, 2.01], [22.01, 2.11], 
        [21.94, 2.20], [21.86, 2.26], [21.79, 2.31], [21.73, 2.38], 
        [21.69, 2.46], [21.68, 2.54], [21.66, 2.63], [21.61, 2.74], 
        [21.53, 2.85], [21.44, 2.97], [21.35, 3.09], [21.26, 3.23], 
        [21.19, 3.38], [21.14, 3.51], [21.11, 3.63], [21.07, 3.72], 
        [21.03, 3.79], [20.99, 3.81], [20.95, 3.85], [20.88, 3.95], 
        [20.81, 4.11], [20.74, 4.29], [20.66, 4.48], [20.59, 4.64], 
        [20.53, 4.74], [20.49, 4.78], [20.34, 4.94], [20.09, 5.30], 
        [19.84, 5.72], [19.69, 6.05], [19.64, 6.16], [19.58, 6.29], 
        [19.51, 6.42], [19.43, 6.54], [19.36, 6.65], [19.30, 6.76], 
        [19.27, 6.86], [19.25, 6.94], [19.23, 7.01], [19.18, 7.11], 
        [19.11, 7.22], [19.02, 7.33], [18.92, 7.47], [18.83, 7.64], 
        [18.76, 7.84], [18.72, 8.06], [18.68, 8.31], [18.62, 8.47], 
        [18.54, 8.56], [18.41, 8.61], [18.09, 8.65], [17.84, 8.60], 
        [17.67, 8.47], [17.58, 8.26], [17.57, 8.12], [17.59, 8.01], 
        [17.64, 7.93], [17.72, 7.87], [18.08, 7.57], [18.49, 7.11], 
        [18.82, 6.62], [18.96, 6.27], [18.98, 6.20], [19.03, 6.11], 
        [19.10, 6.01], [19.19, 5.91], [19.29, 5.80], [19.40, 5.66], 
        [19.50, 5.51], [19.58, 5.36], [19.65, 5.22], [19.71, 5.08], 
        [19.78, 4.96], [19.82, 4.88], [19.89, 4.77], [19.98, 4.57], 
        [20.10, 4.33], [20.23, 4.05], [20.37, 3.77], [20.52, 3.49], 
        [20.66, 3.26], [20.77, 3.10], [20.86, 2.98], [20.93, 2.87], 
        [20.98, 2.77], [21.00, 2.70], [21.01, 2.64], [21.05, 2.56], 
        [21.12, 2.48], [21.19, 2.40], [21.27, 2.33], [21.33, 2.25], 
        [21.37, 2.18], [21.39, 2.12], [21.50, 1.83], [21.80, 1.26], 
        [22.23, 0.51], [22.72, -0.30], [22.86, -0.53], [23.00, -0.78], 
        [23.14, -1.03], [23.24, -1.24], [23.33, -1.43], [23.44, -1.65], 
        [23.54, -1.85], [23.62, -2.02], [23.70, -2.17], [23.76, -2.32], 
        [23.80, -2.44], [23.81, -2.52], [23.83, -2.59], [23.87, -2.67], 
        [23.94, -2.76], [24.01, -2.85], [24.16, -3.00], [24.32, -3.24], 
        [24.51, -3.60], [24.78, -4.14], [24.87, -4.32], [24.96, -4.49], 
        [25.05, -4.63], [25.12, -4.72], [25.17, -4.80], [25.23, -4.91], 
        [25.28, -5.02], [25.32, -5.13], [25.35, -5.25], [25.42, -5.37], 
        [25.49, -5.47], [25.57, -5.56], [25.64, -5.63], [25.70, -5.71], 
        [25.74, -5.79], [25.75, -5.85], [25.77, -5.92], [25.82, -6.02], 
        [25.89, -6.14], [25.99, -6.25], [26.08, -6.38], [26.17, -6.53], 
        [26.24, -6.67], [26.29, -6.79], [26.32, -6.90], [26.37, -7.00], 
        [26.43, -7.09], [26.48, -7.16], [26.54, -7.23], [26.61, -7.34], 
        [26.67, -7.47], [26.73, -7.62], [26.78, -7.77], [26.85, -7.92], 
        [26.92, -8.04], [26.98, -8.12], [27.29, -8.55], [27.74, -9.30], 
        [28.24, -10.18], [28.66, -11.00], [28.75, -11.17], [28.83, -11.31], 
        [28.90, -11.42], [28.96, -11.47], [29.00, -11.52], [29.07, -11.60], 
        [29.13, -11.71], [29.20, -11.84], [29.41, -12.26], [29.63, -12.61], 
        [29.83, -12.86], [29.99, -12.99], [30.20, -13.05], [30.40, -13.06], 
        [30.56, -13.03], [30.66, -12.95], [30.66, -12.95] ], convexity = 10); 
	} 
	
	//        12 for PAC-3 MSE Intercepotor 
	if (iopt==12) polygon(points = [ [-32.26, -49.54], [-32.60, -49.33], [-32.87, -49.25], 
    [-33.10, -49.28], [-33.34, -49.43], [-33.82, -49.66], [-34.23, -49.61], 
    [-34.45, -49.33], [-34.36, -48.87], [-34.25, -48.56], [-34.31, -48.28], 
    [-34.57, -47.96], [-35.07, -47.55], [-36.08, -46.78], [-35.60, -45.85], 
    [-35.28, -45.30], [-34.77, -44.46], [-34.13, -43.45], [-33.43, -42.40], 
    [-32.41, -40.83], [-31.94, -39.85], [-31.93, -39.24], [-32.31, -38.78], 
    [-32.47, -38.64], [-32.56, -38.53], [-32.59, -38.45], [-32.55, -38.42], 
    [-32.52, -38.35], [-32.61, -38.18], [-32.79, -37.94], [-33.05, -37.64], 
    [-33.55, -37.06], [-33.71, -36.60], [-33.51, -36.07], [-32.97, -35.23], 
    [-32.53, -34.66], [-32.14, -34.31], [-31.74, -34.12], [-31.24, -34.07], 
    [-30.87, -34.09], [-30.54, -34.15], [-30.28, -34.24], [-30.14, -34.35], 
    [-29.99, -34.46], [-29.73, -34.55], [-29.38, -34.61], [-28.99, -34.64], 
    [-28.33, -34.49], [-27.42, -33.61], [-25.72, -31.35], [-22.70, -27.08], 
    [-17.39, -19.53], [-17.39, -17.74], [-17.39, -15.94], [-13.78, -10.87], 
    [-12.29, -8.76], [-10.88, -6.78], [-9.71, -5.13], [-8.95, -4.06], 
    [-8.12, -3.01], [-7.17, -2.10], [-5.91, -1.17], [-4.15, -0.05], 
    [-3.72, 0.32], [-3.12, 0.98], [-2.41, 1.84], [-1.70, 2.81], 
    [0.09, 5.33], [1.81, 7.68], [3.32, 9.68], [4.49, 11.16], 
    [5.15, 12.01], [6.13, 13.36], [7.32, 15.02], [8.56, 16.81], 
    [9.83, 18.64], [11.07, 20.41], [12.13, 21.92], [12.88, 22.96], 
    [13.61, 23.97], [14.63, 25.39], [15.79, 27.04], [16.96, 28.72], 
    [18.66, 31.13], [20.07, 33.04], [21.32, 34.63], [22.55, 36.09], 
    [22.89, 36.49], [23.34, 37.07], [23.85, 37.73], [24.35, 38.41], 
    [25.56, 40.02], [26.77, 41.44], [28.46, 43.21], [31.12, 45.87], 
    [32.77, 47.47], [34.18, 48.79], [35.20, 49.67], [35.69, 50.00], 
    [35.96, 49.84], [36.08, 49.45], [36.05, 49.02], [35.83, 48.72], 
    [35.72, 48.58], [35.60, 48.33], [35.48, 47.99], [35.39, 47.61], 
    [34.64, 45.69], [33.07, 42.43], [31.18, 38.81], [29.46, 35.82], 
    [28.47, 34.30], [26.89, 31.96], [24.94, 29.13], [22.84, 26.11], 
    [20.85, 23.25], [19.20, 20.83], [18.06, 19.10], [17.61, 18.33], 
    [17.54, 18.14], [17.45, 17.98], [17.35, 17.87], [17.26, 17.83], 
    [16.15, 16.44], [13.73, 13.05], [10.81, 8.83], [8.20, 4.93], 
    [7.33, 3.60], [6.36, 2.14], [5.39, 0.71], [4.55, -0.51], 
    [3.76, -1.70], [3.12, -2.82], [2.63, -3.83], [2.32, -4.71], 
    [2.12, -5.45], [1.90, -6.23], [1.70, -6.95], [1.54, -7.54], 
    [-0.02, -10.20], [-3.23, -15.08], [-6.54, -19.89], [-8.44, -22.36], 
    [-8.69, -22.50], [-9.06, -22.64], [-9.52, -22.77], [-9.99, -22.86], 
    [-10.63, -23.02], [-11.16, -23.32], [-11.70, -23.85], [-12.38, -24.71], 
    [-12.88, -25.38], [-13.35, -25.97], [-13.71, -26.42], [-13.93, -26.67], 
    [-15.22, -28.45], [-17.83, -32.20], [-20.50, -36.10], [-21.98, -38.32], 
    [-22.00, -38.88], [-21.76, -39.68], [-21.39, -40.41], [-21.02, -40.72], 
    [-20.87, -40.78], [-20.71, -40.93], [-20.54, -41.15], [-20.39, -41.42], 
    [-20.26, -41.83], [-20.29, -42.23], [-20.53, -42.74], [-20.99, -43.45], 
    [-21.63, -44.32], [-22.08, -44.70], [-22.45, -44.64], [-22.85, -44.18], 
    [-23.04, -43.95], [-23.21, -43.82], [-23.35, -43.80], [-23.46, -43.89], 
    [-23.59, -44.01], [-23.81, -44.11], [-24.08, -44.18], [-24.38, -44.20], 
    [-24.77, -44.19], [-24.93, -44.11], [-24.89, -43.92], [-24.65, -43.56], 
    [-24.47, -43.29], [-24.33, -43.02], [-24.23, -42.79], [-24.20, -42.63], 
    [-24.48, -42.70], [-25.21, -43.41], [-26.22, -44.55], [-27.32, -45.94], 
    [-28.58, -47.55], [-29.72, -48.84], [-30.63, -49.69], [-31.19, -50.00], 
    [-31.40, -49.96], [-31.68, -49.86], [-31.97, -49.72], [-32.26, -49.54], 
    [-32.26, -49.54] ], convexity = 10); 
	
	//        13 for PTDS 
	if (iopt==13) polygon(points = [ [-16.17, -39.81], [-16.53, -39.36], [-17.01, -38.77], 
    [-17.54, -38.12], [-18.06, -37.47], [-19.23, -36.01], [-20.06, -35.00], 
    [-20.66, -34.29], [-21.15, -33.75], [-21.71, -33.10], [-22.38, -32.26], 
    [-23.04, -31.37], [-23.58, -30.60], [-23.76, -30.35], [-23.99, -30.06], 
    [-24.25, -29.76], [-24.51, -29.49], [-24.78, -29.18], [-25.10, -28.78], 
    [-25.41, -28.32], [-25.69, -27.88], [-25.96, -27.44], [-26.27, -26.99], 
    [-26.56, -26.58], [-26.81, -26.27], [-27.04, -26.01], [-27.26, -25.73], 
    [-27.46, -25.47], [-27.60, -25.25], [-27.73, -25.08], [-27.88, -24.96], 
    [-28.03, -24.89], [-28.17, -24.88], [-29.06, -25.07], [-29.79, -25.11], 
    [-30.38, -24.99], [-30.90, -24.71], [-31.58, -24.20], [-33.22, -24.81], 
    [-33.91, -25.07], [-34.58, -25.33], [-35.15, -25.55], [-35.54, -25.71], 
    [-38.79, -26.97], [-43.34, -28.60], [-47.50, -30.01], [-49.58, -30.62], 
    [-49.90, -30.51], [-50.00, -30.21], [-49.89, -29.77], [-49.56, -29.25], 
    [-49.39, -29.01], [-49.24, -28.77], [-49.15, -28.56], [-49.11, -28.40], 
    [-49.08, -28.28], [-49.02, -28.16], [-48.92, -28.04], [-48.81, -27.95], 
    [-48.42, -27.58], [-48.01, -27.04], [-47.71, -26.51], [-47.66, -26.21], 
    [-47.69, -25.98], [-47.49, -25.71], [-47.16, -25.47], [-46.80, -25.37], 
    [-46.45, -25.26], [-45.80, -24.94], [-44.95, -24.47], [-43.98, -23.89], 
    [-41.68, -22.48], [-39.36, -21.08], [-37.33, -19.88], [-35.89, -19.05], 
    [-35.46, -18.80], [-35.06, -18.56], [-34.73, -18.36], [-34.52, -18.20], 
    [-34.19, -17.99], [-33.56, -17.59], [-32.70, -17.08], [-31.72, -16.50], 
    [-30.76, -15.93], [-29.96, -15.43], [-29.39, -15.06], [-29.15, -14.86], 
    [-29.04, -14.39], [-28.83, -13.23], [-28.55, -11.58], [-28.24, -9.59], 
    [-27.86, -7.29], [-27.52, -5.53], [-27.23, -4.29], [-26.96, -3.55], 
    [-26.17, -2.40], [-24.96, -1.04], [-23.67, 0.18], [-22.63, 0.91], 
    [-22.20, 1.08], [-21.84, 1.16], [-21.52, 1.16], [-21.19, 1.07], 
    [-20.97, 0.96], [-20.80, 0.85], [-20.71, 0.73], [-20.71, 0.64], 
    [-20.58, 0.46], [-20.14, 0.30], [-19.62, 0.22], [-19.26, 0.26], 
    [-19.09, 0.48], [-18.75, 0.99], [-18.29, 1.72], [-17.76, 2.60], 
    [-13.75, 9.03], [-9.92, 14.41], [-5.57, 19.61], [-0.05, 25.53], 
    [0.64, 26.25], [1.20, 26.86], [1.58, 27.30], [1.72, 27.50], 
    [2.96, 28.95], [5.92, 31.45], [9.46, 34.12], [12.43, 36.02], 
    [12.75, 36.20], [13.21, 36.44], [13.74, 36.72], [14.28, 37.01], 
    [14.92, 37.34], [15.73, 37.71], [16.60, 38.09], [17.43, 38.42], 
    [18.19, 38.72], [18.87, 39.00], [19.39, 39.22], [19.69, 39.37], 
    [21.97, 39.90], [25.91, 40.38], [29.77, 40.64], [31.84, 40.52], 
    [32.07, 40.42], [32.38, 40.34], [32.75, 40.29], [33.11, 40.26], 
    [34.00, 40.15], [35.00, 39.86], [35.77, 39.54], [35.99, 39.28], 
    [35.96, 39.22], [36.00, 39.17], [36.09, 39.14], [36.24, 39.13], 
    [37.83, 38.64], [40.28, 37.33], [43.25, 35.42], [46.35, 33.12], 
    [48.54, 31.29], [49.65, 29.80], [50.00, 27.82], [49.95, 24.54], 
    [49.87, 22.72], [49.75, 20.89], [49.61, 19.26], [49.46, 18.05], 
    [48.29, 13.30], [46.31, 8.76], [43.59, 4.52], [40.17, 0.71], 
    [37.55, -1.66], [34.95, -3.66], [31.94, -5.60], [28.05, -7.82], 
    [25.33, -9.31], [25.04, -11.16], [24.43, -13.84], [23.49, -16.18], 
    [22.19, -18.23], [20.52, -20.01], [19.11, -21.14], [17.62, -22.09], 
    [16.08, -22.86], [14.48, -23.43], [13.86, -23.63], [13.27, -23.84], 
    [12.78, -24.04], [12.45, -24.21], [12.03, -24.38], [11.30, -24.49], 
    [10.16, -24.55], [8.46, -24.56], [6.29, -24.56], [4.59, -24.33], 
    [1.93, -23.52], [-3.12, -21.80], [-4.87, -21.22], [-6.32, -20.75], 
    [-7.32, -20.45], [-7.72, -20.37], [-7.76, -21.04], [-7.82, -22.79], 
    [-7.86, -25.35], [-7.91, -28.45], [-7.96, -32.17], [-8.03, -34.73], 
    [-8.14, -36.27], [-8.27, -36.94], [-8.95, -37.77], [-10.03, -38.59], 
    [-11.41, -39.34], [-13.00, -39.95], [-13.85, -40.22], [-14.57, -40.44], 
    [-15.08, -40.59], [-15.32, -40.64], [-15.44, -40.58], [-15.64, -40.40], 
    [-15.89, -40.13], [-16.17, -39.81], [-16.17, -39.81] ], convexity = 10); 

	//        14 for SR71 
	if (iopt==14) polygon(points = [ [-19.02, -39.79], [-19.11, -39.41], [-19.35, -38.82], 
    [-19.66, -38.17], [-19.98, -37.62], [-20.46, -36.94], [-21.11, -36.12], 
    [-21.83, -35.25], [-22.55, -34.45], [-22.97, -33.94], [-23.41, -33.27], 
    [-23.95, -32.33], [-24.66, -30.98], [-25.64, -29.01], [-26.36, -27.38], 
    [-26.97, -25.77], [-27.60, -23.83], [-28.20, -21.70], [-28.57, -19.87], 
    [-28.76, -18.02], [-28.81, -15.81], [-28.78, -13.85], [-28.65, -12.39], 
    [-28.39, -11.13], [-27.95, -9.74], [-27.48, -8.53], [-26.93, -7.39], 
    [-26.26, -6.25], [-25.42, -5.00], [-24.51, -3.72], [-23.39, -2.13], 
    [-22.15, -0.36], [-20.88, 1.47], [-20.34, 2.30], [-20.21, 2.86], 
    [-20.53, 3.39], [-21.33, 4.12], [-21.82, 4.55], [-22.40, 5.08], 
    [-23.01, 5.65], [-23.57, 6.17], [-24.75, 7.28], [-25.87, 8.30], 
    [-26.80, 9.12], [-27.40, 9.61], [-27.79, 9.90], [-28.84, 9.49], 
    [-29.34, 9.27], [-29.84, 9.00], [-30.33, 8.70], [-30.78, 8.36], 
    [-31.90, 7.59], [-33.01, 7.08], [-34.16, 6.83], [-35.37, 6.81], 
    [-36.10, 6.93], [-36.86, 7.14], [-37.46, 7.38], [-37.71, 7.57], 
    [-37.72, 7.61], [-37.76, 7.65], [-37.82, 7.67], [-37.89, 7.68], 
    [-38.22, 7.85], [-38.72, 8.27], [-39.26, 8.84], [-39.72, 9.43], 
    [-40.14, 10.18], [-40.45, 10.95], [-40.64, 11.74], [-40.71, 12.55], 
    [-40.77, 13.23], [-40.91, 13.85], [-41.16, 14.43], [-41.52, 14.98], 
    [-42.00, 15.70], [-42.33, 16.41], [-42.52, 17.15], [-42.61, 18.00], 
    [-42.62, 19.01], [-42.50, 19.74], [-42.21, 20.33], [-41.70, 20.91], 
    [-41.02, 21.59], [-41.47, 21.98], [-41.73, 22.19], [-42.08, 22.45], 
    [-42.49, 22.75], [-42.90, 23.03], [-43.96, 23.78], [-45.18, 24.69], 
    [-46.30, 25.55], [-47.04, 26.17], [-47.28, 26.43], [-47.61, 26.85], 
    [-47.98, 27.37], [-48.36, 27.93], [-48.74, 28.51], [-49.11, 29.06], 
    [-49.43, 29.53], [-49.67, 29.86], [-49.87, 30.14], [-49.97, 30.35], 
    [-50.00, 30.51], [-49.95, 30.64], [-49.66, 30.82], [-49.12, 30.89], 
    [-48.36, 30.86], [-47.44, 30.71], [-45.99, 30.30], [-43.36, 29.44], 
    [-39.95, 28.28], [-36.22, 26.96], [-33.72, 26.08], [-32.23, 25.58], 
    [-31.49, 25.40], [-31.21, 25.44], [-30.38, 26.02], [-29.24, 26.70], 
    [-28.10, 27.31], [-27.26, 27.66], [-26.45, 27.82], [-25.54, 27.89], 
    [-24.64, 27.87], [-23.88, 27.75], [-23.11, 27.54], [-22.80, 27.90], 
    [-22.65, 28.09], [-22.43, 28.34], [-22.20, 28.62], [-21.96, 28.90], 
    [-21.12, 29.93], [-19.93, 31.40], [-18.70, 32.94], [-17.73, 34.18], 
    [-15.82, 36.63], [-14.48, 38.30], [-13.63, 39.28], [-13.17, 39.68], 
    [-13.02, 39.75], [-12.90, 39.80], [-12.82, 39.82], [-12.79, 39.81], 
    [-12.87, 39.64], [-13.16, 39.20], [-13.69, 38.43], [-14.51, 37.28], 
    [-15.67, 35.65], [-16.57, 34.35], [-17.40, 33.16], [-18.30, 31.82], 
    [-18.95, 30.87], [-19.62, 29.87], [-20.26, 28.95], [-20.76, 28.21], 
    [-21.77, 26.75], [-21.28, 26.28], [-21.07, 26.04], [-20.84, 25.73], 
    [-20.63, 25.40], [-20.46, 25.09], [-20.28, 24.65], [-20.18, 24.24], 
    [-20.13, 23.69], [-20.12, 22.87], [-20.13, 22.04], [-20.18, 21.49], 
    [-20.28, 21.07], [-20.48, 20.61], [-20.61, 20.31], [-20.72, 20.05], 
    [-20.78, 19.87], [-20.78, 19.79], [-20.74, 19.78], [-20.66, 19.79], 
    [-20.56, 19.83], [-20.46, 19.88], [-20.31, 19.94], [-20.18, 19.96], 
    [-20.05, 19.94], [-19.90, 19.87], [-19.63, 19.79], [-19.09, 19.67], 
    [-18.37, 19.54], [-17.54, 19.41], [-16.30, 19.20], [-15.07, 18.92], 
    [-13.49, 18.46], [-11.17, 17.72], [-9.48, 17.18], [-8.06, 16.72], 
    [-7.06, 16.39], [-6.62, 16.24], [-6.39, 16.16], [-5.97, 16.01], 
    [-5.41, 15.83], [-4.77, 15.62], [-3.19, 15.11], [-2.50, 15.56], 
    [-1.38, 16.22], [-0.48, 16.56], [0.35, 16.60], [1.26, 16.39], 
    [2.05, 16.03], [2.66, 15.47], [3.16, 14.63], [3.62, 13.41], 
    [3.89, 12.59], [4.93, 12.19], [6.79, 11.48], [9.74, 10.33], 
    [12.76, 9.16], [14.80, 8.36], [15.28, 8.16], [15.74, 7.95], 
    [16.11, 7.77], [16.36, 7.62], [16.54, 7.49], [16.76, 7.35], 
    [16.99, 7.22], [17.20, 7.11], [17.45, 6.98], [17.79, 6.79], 
    [18.17, 6.56], [18.56, 6.32], [18.94, 6.09], [19.29, 5.91], 
    [19.57, 5.78], [19.75, 5.74], [19.87, 5.71], [20.00, 5.65], 
    [20.12, 5.56], [20.21, 5.45], [20.33, 5.30], [20.41, 5.29], 
    [20.50, 5.45], [20.63, 5.83], [21.29, 7.20], [22.27, 8.38], 
    [23.47, 9.28], [24.80, 9.80], [25.57, 9.97], [25.67, 11.65], 
    [25.72, 12.48], [25.80, 13.50], [25.88, 14.59], [25.96, 15.60], 
    [26.15, 17.92], [26.38, 21.14], [26.59, 24.08], [26.68, 25.56], 
    [26.71, 25.72], [26.82, 25.70], [26.96, 25.52], [27.13, 25.21], 
    [27.25, 24.84], [27.31, 24.26], [27.32, 23.23], [27.28, 21.47], 
    [27.25, 19.89], [27.21, 17.95], [27.19, 15.91], [27.18, 14.00], 
    [27.16, 9.74], [27.99, 9.28], [28.76, 8.82], [29.35, 8.38], 
    [29.82, 7.91], [30.23, 7.36], [30.68, 6.57], [31.18, 5.51], 
    [31.64, 4.37], [31.97, 3.36], [32.11, 2.93], [32.25, 2.68], 
    [32.49, 2.51], [32.90, 2.35], [34.87, 1.61], [37.03, 0.82], 
    [39.14, 0.05], [41.02, -0.63], [44.89, -2.03], [47.32, -2.99], 
    [48.74, -3.70], [49.57, -4.35], [50.00, -4.82], [49.94, -5.14], 
    [49.19, -5.48], [47.51, -6.03], [45.56, -6.66], [43.23, -6.63], 
    [42.19, -6.61], [41.08, -6.58], [40.04, -6.54], [39.20, -6.49], 
    [38.53, -6.45], [37.96, -6.43], [37.55, -6.42], [37.36, -6.43], 
    [37.29, -6.51], [37.25, -6.69], [37.25, -7.00], [37.28, -7.44], 
    [37.31, -7.96], [37.29, -8.33], [37.21, -8.65], [37.06, -9.00], 
    [36.65, -9.64], [36.05, -10.32], [35.37, -10.94], [34.75, -11.37], 
    [34.46, -11.50], [34.12, -11.63], [33.74, -11.76], [33.39, -11.86], 
    [32.69, -12.08], [32.13, -12.32], [31.71, -12.60], [31.41, -12.92], 
    [31.01, -13.41], [30.53, -13.85], [29.95, -14.26], [29.23, -14.64], 
    [28.65, -14.91], [28.17, -15.09], [27.70, -15.19], [27.13, -15.25], 
    [24.90, -15.01], [23.03, -14.00], [21.61, -12.32], [20.77, -10.06], 
    [20.61, -9.36], [20.39, -8.74], [20.10, -8.13], [19.70, -7.45], 
    [19.38, -6.95], [16.89, -7.03], [14.77, -7.12], [12.64, -7.23], 
    [10.83, -7.35], [9.71, -7.45], [9.21, -7.56], [8.93, -7.83], 
    [8.78, -8.40], [8.70, -9.42], [8.65, -10.18], [8.58, -11.13], 
    [8.51, -12.14], [8.43, -13.09], [8.34, -14.08], [8.26, -15.18], 
    [8.17, -16.28], [8.11, -17.22], [7.76, -19.86], [7.08, -22.27], 
    [6.03, -24.55], [4.57, -26.80], [3.63, -27.91], [2.32, -29.27], 
    [0.94, -30.59], [-0.19, -31.55], [-2.21, -32.94], [-4.34, -34.23], 
    [-6.61, -35.41], [-9.02, -36.50], [-9.83, -36.84], [-10.56, -37.15], 
    [-11.11, -37.39], [-11.42, -37.53], [-11.65, -37.61], [-11.98, -37.69], 
    [-12.36, -37.76], [-12.77, -37.80], [-13.15, -37.84], [-13.51, -37.90], 
    [-13.78, -37.95], [-13.94, -38.01], [-14.15, -38.07], [-14.54, -38.17], 
    [-15.07, -38.27], [-15.67, -38.38], [-16.70, -38.59], [-17.47, -38.83], 
    [-18.07, -39.14], [-18.59, -39.55], [-18.76, -39.69], [-18.89, -39.78], 
    [-18.98, -39.82], [-19.02, -39.79], [-19.02, -39.79] ], convexity = 10); 
	
	//        15 for U2
	if (iopt==15) polygon(points = [ [47.19, -20.65], [47.16, -20.58], [47.13, -20.47], 
    [47.12, -20.33], [47.11, -20.17], [47.11, -19.77], [43.58, -18.72], 
    [40.86, -17.91], [37.63, -16.93], [34.37, -15.94], [31.56, -15.07], 
    [29.92, -14.55], [27.79, -13.88], [25.32, -13.08], [22.61, -12.21], 
    [21.01, -11.70], [19.27, -11.14], [17.60, -10.60], [16.22, -10.16], 
    [14.92, -9.74], [13.45, -9.26], [12.02, -8.79], [10.78, -8.38], 
    [8.17, -7.49], [5.83, -7.99], [4.74, -8.22], [3.48, -8.48], 
    [2.22, -8.75], [1.11, -8.99], [-0.10, -9.25], [-0.95, -9.40], 
    [-1.55, -9.46], [-2.02, -9.46], [-3.03, -9.23], [-3.76, -8.73], 
    [-4.10, -8.07], [-3.99, -7.34], [-3.77, -7.02], [-3.46, -6.68], 
    [-3.11, -6.39], [-2.78, -6.20], [-2.61, -6.12], [-2.45, -6.05], 
    [-2.32, -5.99], [-2.22, -5.94], [-2.03, -5.88], [-1.64, -5.79], 
    [-1.10, -5.67], [-0.47, -5.54], [0.14, -5.41], [0.65, -5.29], 
    [0.99, -5.20], [1.11, -5.14], [1.01, -5.08], [0.73, -4.96], 
    [0.31, -4.80], [-0.19, -4.62], [-0.89, -4.38], [-1.82, -4.06], 
    [-2.86, -3.70], [-3.89, -3.33], [-5.30, -2.85], [-6.19, -2.58], 
    [-6.65, -2.50], [-6.78, -2.59], [-6.83, -2.63], [-6.96, -2.66], 
    [-7.16, -2.68], [-7.40, -2.69], [-7.65, -2.70], [-7.87, -2.72], 
    [-8.04, -2.76], [-8.14, -2.81], [-8.24, -2.86], [-8.40, -2.90], 
    [-8.61, -2.93], [-8.85, -2.94], [-9.08, -2.94], [-9.28, -2.97], 
    [-9.43, -3.00], [-9.50, -3.05], [-9.55, -3.09], [-9.65, -3.13], 
    [-9.77, -3.15], [-9.91, -3.16], [-10.15, -3.18], [-10.57, -3.26], 
    [-11.11, -3.37], [-11.70, -3.50], [-12.34, -3.64], [-12.98, -3.76], 
    [-13.56, -3.85], [-14.00, -3.90], [-14.35, -3.94], [-14.68, -3.99], 
    [-14.95, -4.05], [-15.13, -4.12], [-15.29, -4.18], [-15.50, -4.22], 
    [-15.74, -4.26], [-15.97, -4.27], [-16.29, -4.29], [-16.78, -4.35], 
    [-17.38, -4.45], [-18.00, -4.56], [-18.80, -4.71], [-19.87, -4.90], 
    [-21.07, -5.12], [-22.27, -5.33], [-23.35, -5.53], [-24.25, -5.71], 
    [-24.87, -5.85], [-25.12, -5.94], [-25.15, -5.99], [-25.18, -6.01], 
    [-25.21, -6.00], [-25.24, -5.96], [-25.33, -5.93], [-25.57, -5.93], 
    [-25.94, -5.97], [-26.44, -6.06], [-28.92, -6.34], [-31.10, -6.29], 
    [-32.67, -5.96], [-33.31, -5.36], [-33.13, -4.84], [-32.52, -4.26], 
    [-31.55, -3.66], [-30.28, -3.10], [-30.00, -3.00], [-29.77, -2.92], 
    [-29.61, -2.88], [-29.56, -2.88], [-29.54, -2.89], [-29.48, -2.88], 
    [-29.40, -2.84], [-29.31, -2.78], [-29.01, -2.64], [-28.54, -2.46], 
    [-28.07, -2.30], [-27.78, -2.22], [-27.74, -2.21], [-27.70, -2.18], 
    [-27.64, -2.15], [-27.58, -2.12], [-27.51, -2.09], [-27.45, -2.07], 
    [-27.40, -2.07], [-27.37, -2.09], [-27.05, -2.03], [-26.42, -1.82], 
    [-25.76, -1.55], [-25.38, -1.33], [-25.29, -1.26], [-25.17, -1.19], 
    [-25.04, -1.13], [-24.91, -1.08], [-24.77, -1.03], [-24.60, -0.94], 
    [-24.43, -0.82], [-24.28, -0.69], [-23.76, -0.27], [-23.08, 0.20], 
    [-22.43, 0.59], [-21.99, 0.79], [-21.86, 0.82], [-21.76, 0.87], 
    [-21.69, 0.91], [-21.67, 0.95], [-21.64, 0.99], [-21.55, 1.03], 
    [-21.43, 1.08], [-21.28, 1.11], [-21.11, 1.16], [-20.95, 1.22], 
    [-20.80, 1.30], [-20.69, 1.38], [-20.33, 1.63], [-19.74, 1.91], 
    [-19.07, 2.17], [-18.44, 2.34], [-17.83, 2.47], [-18.68, 2.90], 
    [-19.54, 3.33], [-22.13, 2.96], [-23.27, 2.80], [-24.47, 2.63], 
    [-25.57, 2.46], [-26.44, 2.33], [-27.69, 2.15], [-28.48, 2.08], 
    [-29.03, 2.11], [-29.54, 2.25], [-30.16, 2.54], [-30.60, 2.94], 
    [-30.84, 3.41], [-30.84, 3.91], [-30.66, 4.25], [-30.34, 4.64], 
    [-29.99, 4.97], [-29.71, 5.12], [-29.61, 5.14], [-29.48, 5.18], 
    [-29.35, 5.24], [-29.22, 5.31], [-28.92, 5.44], [-28.40, 5.56], 
    [-27.60, 5.69], [-26.44, 5.84], [-26.05, 5.89], [-25.68, 5.95], 
    [-25.38, 5.99], [-25.18, 6.02], [-24.98, 6.07], [-25.32, 6.33], 
    [-26.75, 7.12], [-29.83, 8.78], [-31.33, 9.59], [-32.70, 10.33], 
    [-33.79, 10.93], [-34.44, 11.29], [-35.07, 11.64], [-36.06, 12.19], 
    [-37.29, 12.88], [-38.61, 13.62], [-39.92, 14.36], [-41.12, 15.04], 
    [-42.05, 15.57], [-42.61, 15.90], [-43.02, 16.14], [-43.55, 16.45], 
    [-44.14, 16.79], [-44.71, 17.12], [-45.32, 17.47], [-46.01, 17.88], 
    [-46.68, 18.28], [-47.26, 18.64], [-47.94, 19.04], [-48.39, 19.27], 
    [-48.72, 19.37], [-49.06, 19.40], [-49.49, 19.44], [-49.78, 19.57], 
    [-49.95, 19.81], [-50.00, 20.15], [-49.99, 20.35], [-49.91, 20.46], 
    [-49.70, 20.51], [-49.31, 20.55], [-48.03, 20.66], [-47.41, 20.69], 
    [-47.18, 20.63], [-47.10, 20.46], [-46.98, 20.32], [-46.77, 20.15], 
    [-46.44, 19.96], [-46.02, 19.75], [-45.47, 19.49], [-44.70, 19.13], 
    [-43.81, 18.70], [-42.89, 18.25], [-41.90, 17.78], [-40.80, 17.26], 
    [-39.74, 16.77], [-38.83, 16.35], [-38.02, 15.98], [-37.19, 15.60], 
    [-36.45, 15.26], [-35.89, 15.00], [-33.29, 13.82], [-31.46, 13.04], 
    [-30.26, 12.60], [-29.53, 12.43], [-29.16, 12.39], [-28.92, 12.34], 
    [-28.78, 12.26], [-28.72, 12.16], [-28.70, 12.07], [-28.69, 11.99], 
    [-28.70, 11.91], [-28.71, 11.86], [-28.72, 11.78], [-28.51, 11.65], 
    [-27.92, 11.37], [-26.78, 10.86], [-26.14, 10.58], [-25.35, 10.23], 
    [-24.51, 9.86], [-23.72, 9.50], [-22.87, 9.13], [-21.86, 8.68], 
    [-20.83, 8.23], [-19.89, 7.82], [-17.83, 6.93], [-16.17, 7.12], 
    [-15.24, 7.21], [-14.63, 7.25], [-14.17, 7.22], [-13.69, 7.13], 
    [-13.32, 7.05], [-12.93, 6.93], [-12.57, 6.81], [-12.27, 6.69], 
    [-11.97, 6.54], [-11.79, 6.41], [-11.69, 6.29], [-11.67, 6.15], 
    [-11.74, 5.92], [-11.95, 5.63], [-12.26, 5.33], [-12.65, 5.04], 
    [-12.81, 4.91], [-12.76, 4.80], [-12.38, 4.62], [-11.55, 4.29], 
    [-11.06, 4.09], [-10.59, 3.90], [-10.18, 3.73], [-9.90, 3.60], 
    [-9.42, 3.42], [-8.91, 3.31], [-8.46, 3.26], [-8.14, 3.30], 
    [-7.95, 3.34], [-7.60, 3.40], [-7.13, 3.48], [-6.60, 3.55], 
    [-4.25, 3.87], [-2.78, 4.08], [-2.01, 4.22], [-1.75, 4.32], 
    [-1.71, 4.38], [-1.69, 4.40], [-1.67, 4.38], [-1.67, 4.32], 
    [-1.61, 4.25], [-1.31, 4.25], [-0.63, 4.33], [0.61, 4.51], 
    [1.28, 4.62], [1.86, 4.75], [2.38, 4.91], [2.89, 5.12], 
    [3.27, 5.28], [3.62, 5.43], [3.89, 5.55], [4.06, 5.62], 
    [4.18, 5.67], [4.34, 5.73], [4.52, 5.79], [4.71, 5.85], 
    [5.14, 5.98], [4.26, 6.44], [3.77, 6.71], [3.06, 7.08], 
    [2.23, 7.51], [1.39, 7.95], [-0.64, 9.00], [-1.84, 9.64], 
    [-2.41, 9.96], [-2.55, 10.08], [-2.35, 10.18], [-1.85, 10.23], 
    [-1.26, 10.22], [-0.78, 10.14], [0.12, 9.83], [1.85, 9.24], 
    [4.02, 8.48], [6.27, 7.69], [6.83, 7.50], [7.29, 7.34], 
    [7.61, 7.24], [7.73, 7.21], [7.76, 7.26], [7.84, 7.38], 
    [7.96, 7.55], [8.10, 7.76], [8.37, 8.21], [8.81, 9.06], 
    [9.57, 10.61], [10.80, 13.18], [11.14, 13.90], [11.52, 14.69], 
    [11.88, 15.45], [12.18, 16.08], [12.80, 17.36], [13.48, 17.60], 
    [14.04, 17.78], [14.39, 17.84], [14.57, 17.79], [14.59, 17.63], 
    [14.56, 17.54], [14.50, 17.46], [14.44, 17.39], [14.38, 17.35], 
    [14.32, 17.32], [14.27, 17.27], [14.24, 17.21], [14.23, 17.15], 
    [14.17, 16.80], [14.00, 15.96], [13.75, 14.74], [13.45, 13.29], 
    [13.14, 11.78], [12.87, 10.43], [12.66, 9.38], [12.55, 8.79], 
    [12.49, 8.46], [12.41, 8.14], [12.34, 7.87], [12.27, 7.69], 
    [12.13, 7.31], [12.11, 7.00], [12.22, 6.78], [12.44, 6.64], 
    [12.68, 6.50], [12.77, 6.31], [12.73, 6.08], [12.54, 5.83], 
    [12.46, 5.73], [12.40, 5.63], [12.39, 5.56], [12.41, 5.50], 
    [12.58, 5.40], [12.97, 5.22], [13.53, 4.97], [14.19, 4.69], 
    [14.87, 4.39], [15.49, 4.13], [15.97, 3.92], [16.24, 3.80], 
    [17.09, 3.43], [18.69, 2.74], [20.50, 1.95], [21.99, 1.31], 
    [22.92, 0.92], [22.43, 0.77], [21.97, 0.66], [21.54, 0.65], 
    [20.97, 0.76], [20.11, 1.02], [19.46, 1.22], [18.62, 1.48], 
    [17.71, 1.76], [16.83, 2.03], [15.95, 2.30], [15.03, 2.59], 
    [14.17, 2.86], [13.49, 3.07], [12.96, 3.24], [12.52, 3.38], 
    [12.21, 3.47], [12.08, 3.51], [12.05, 3.48], [12.02, 3.41], 
    [11.98, 3.31], [11.95, 3.18], [11.72, 2.70], [11.00, 2.23], 
    [9.39, 1.59], [6.48, 0.56], [5.33, 0.17], [4.23, -0.20], 
    [3.31, -0.50], [2.68, -0.69], [1.63, -0.99], [2.53, -1.40], 
    [3.08, -1.64], [3.91, -1.99], [4.91, -2.41], [5.96, -2.83], 
    [8.48, -3.85], [9.49, -3.64], [10.42, -3.50], [11.40, -3.45], 
    [12.29, -3.47], [12.96, -3.58], [13.40, -3.75], [13.79, -3.98], 
    [14.07, -4.22], [14.20, -4.45], [14.18, -4.58], [14.09, -4.75], 
    [13.94, -4.97], [13.73, -5.21], [13.41, -5.56], [13.26, -5.74], 
    [13.25, -5.81], [13.34, -5.82], [13.63, -5.92], [14.33, -6.19], 
    [15.34, -6.58], [16.54, -7.06], [17.82, -7.57], [19.05, -8.05], 
    [20.08, -8.45], [20.78, -8.71], [21.33, -8.92], [21.98, -9.16], 
    [22.63, -9.42], [23.22, -9.65], [23.96, -9.94], [24.45, -10.09], 
    [24.86, -10.13], [25.39, -10.10], [26.08, -10.08], [26.53, -10.17], 
    [26.76, -10.36], [26.82, -10.69], [26.82, -10.83], [26.84, -10.94], 
    [26.87, -11.02], [26.91, -11.05], [27.14, -11.12], [27.69, -11.31], 
    [28.48, -11.60], [29.42, -11.94], [30.52, -12.35], [31.73, -12.80], 
    [32.90, -13.24], [33.89, -13.60], [34.84, -13.95], [35.90, -14.34], 
    [36.94, -14.71], [37.83, -15.03], [38.68, -15.33], [39.58, -15.65], 
    [40.42, -15.95], [41.11, -16.20], [44.61, -17.44], [47.21, -18.33], 
    [48.90, -18.85], [49.64, -18.99], [49.83, -18.96], [49.94, -18.98], 
    [49.99, -19.05], [50.00, -19.20], [49.97, -19.50], [49.87, -19.71], 
    [49.66, -19.86], [49.30, -20.00], [49.06, -20.09], [48.80, -20.19], 
    [48.57, -20.30], [48.40, -20.39], [48.06, -20.54], [47.69, -20.65], 
    [47.38, -20.69], [47.19, -20.65], [47.19, -20.65] ], convexity = 10); 
	
	// end of module
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Here is where the actual model gets created

// Make the selected part

if (style==1) {
	if (part2print == "Pot") print_container();
	if (part2print == "Pan") print_pan();
	if (part2print == "Both") {
		print_container();
		translate([2*max(base_diam,top_diam),0,0]) print_pan();
	}
} else {
	print_container();
}

// End of file
