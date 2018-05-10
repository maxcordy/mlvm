/* [General Blade Controls] */
// type of blade
bladeType = "rudder"; // [smooth,rudder,impeller,helicopter]
// diameter of the entire propeller
bladeOD = 65;
// how many blades
numBlades = 3;
// pitch angle of the blades, set to negative to change direction
bladePitch = 10; // [0:1:90]
// width of the blades
bladeWidth = 6;
// thickness of the propeller blades
bladeThickness = 1.2;
// ratio of rudder expansion
rudderEndWidthMod = 2;

/* [Helicopter Blade Controls] */
// how flat are the helicopter blades
heliBladeZScale = .4; // [0:0.1:1]
// position of blade loft division
heliPortionRatio = 0.1; // [0:0.1:1]
// amount of tapering
heliEndScale = 2.2; // [2:0.2:10]
// style of helicopter blade tips (WIP No Function)
// heliBladeTip = "none"; // [none,pointed,rounded]

/* [Shaft Controls] */
// choose either a cross or a peg connector fitting
fittingType = "cross"; // [peg,cross,maleCrossTop,maleCrossBottom]
// type of shaft topper. Note: not all combinations of toppers will work with the shafts
shaftTopper = "none"; // [none,rounded,flat,stud,female,cross,peg]
// shaft wall thickness
propellerShaftOffset = 3;
// distance from propellers to the top of the shaft
bladeHeightOffset = 0.5;
// height of the propeller shaft
shaftHeight = 6;
// thickness of the topper thickness, set to 0 for no separator
shaftTopSeparator = 1;



/* [Peg Fitting Controls] */ 
// ID of the peg connector, don't change these settings unless you're trying to adjust the peg connector fitting
pegID = 5.25;
// wall thickness of peg connector offset
pegShaftWall = 1;
// don't change this unless you're adjusting the connector, this is the depth of the connector
pegHeight = 5;
// height of the connector fitting's rim
pegRimHeight = 1;
// wall thickness of the rim
pegRimIDOffset = 0.7;

/* [Cross Fitting Controls] */
// Overall cross fitting diameter: increase this number to loosen and lower to tighten the cross beam fittings. Adjust these 2 numbers accordingly, each printer will have different settings for a good fit just tinker til you get it
xFitDiameter = 5.65;
// Cross beam thickness cutting profile: increase this number to tighten and lower to loosen the cross beam fittings
xFitAxleBeams = 1.95;

/* [Male Cross Beam Controls] */
// can be a number
// roundedAdjust = xFitDiameter/2;
roundedAdjust = xFitDiameter/3.1;
// modifier for making cross beam males, the sizing difference from females, a negative number will make the males smaller and a positive number will makes the males larger
xFitAdjust = 0.1;
// length of male 
maleLength = 7;

// male Cross beam calculations
xFitAxleBeams2 = 3.4 + xFitAdjust;
xFitDiameter2 = 5.0 + xFitAdjust;

// calculations
propShaftOD = xFitDiameter + propellerShaftOffset;
propShaftOr = propShaftOD/2;
bladeOr = bladeOD/2 - propShaftOr;

// peg calculations
pegOr = pegID/2 + pegShaftWall;
pegIr = pegID/2;


module pegMale() {

}

module propeller2() {
	$fn = 30;
	align = 2.234;	
	// shaft build
	difference() {
		// shaft OD
		union() {
			cylinder(h = shaftHeight, r = propShaftOr,center = true);
			for (i = [0:numBlades]) {
				rotate([0,0,i*360/numBlades]) {
					// translate([0,0,-(bladeWidth*sin(bladePitch)/2)])
					if (bladeType == "smooth") {
						translate([0,0,-(bladeWidth*sin(bladePitch)/2)])
						roundedProp2();
					} else if (bladeType == "rudder") {
						translate([0,0,-(bladeWidth*sin(bladePitch)/2)])
						rudder();
					} else if (bladeType == "impeller") {
						// translate([0,0,(bladeWidth*sin(bladePitch)/2)])
						impellerBlades();
					} else if (bladeType =="helicopter") {
						translate([0,propShaftOr + bladeOr/2 - 0.5,0])
						helicopterBlades();
					}
				}
			}

			// male cross union add-on
			if (fittingType == "maleCrossTop") {
				rotate([180,0,0])
				translate([0,0,-maleLength/2])
				crossProfileMale(shaftHeight + maleLength);
			} else if (fittingType == "maleCrossBottom") {
				rotate([0,0,0])
				translate([0,0,-maleLength/2])
				crossProfileMale(shaftHeight + maleLength);
			}

			// shaft topper
			translate([0,0,(shaftHeight + shaftTopSeparator)/2])
			shaftTopper();
		}
		// shaft cross cutout
		if (fittingType == "cross") {
			difference() {
				cylinder(h = shaftHeight*1.01, r = xFitDiameter/2,center = true);
				crossProfile(shaftHeight*1.00);
			}
		} else if (fittingType == "peg") {
			union() {
				$fn = 90;
				cylinder(h = shaftHeight*2, r = pegIr, center = true);

				translate([0,0,(shaftHeight + pegHeight)/2])
				cylinder(h = shaftHeight, r = pegOr, center = true);
			}
		} 
	}
}

module shaftTopper() {
	if (shaftTopper == "flat") {
		cylinder(h = shaftTopSeparator, r = propShaftOr, center = true);
	} else if (shaftTopper == "rounded") {
		cylinder(h = shaftTopSeparator, r = propShaftOr, center = true);
		translate([0,0,shaftTopSeparator/2]) {
			difference() {
				sphere(propShaftOr,true);
				translate([0,0,-propShaftOr])
				cube(propShaftOD,true);
			}
		}
	} else if (shaftTopper == "cross") {
		cylinder(h = shaftTopSeparator, r = propShaftOr, center = true);
		translate([0,0,shaftTopSeparator/2]) {
			crossProfile(shaftHeight);
		}
	}
}

module crossProfile(height) {
	align = 2.234;	
	// shaft build
	difference() {
	// shaft OD
		union() {
	
			cylinder(h = height, r = propShaftOr,center = true);
		}
		// shaft cross cutout
		difference() {
			// actual x Profile that'll act as the cutting tool
			cylinder(h = height + 0.01, r = xFitDiameter/2,center = true);
			union() {
				translate([align,align,0])
				cube([xFitAxleBeams, xFitAxleBeams, height+0.02],true);

				translate([-align,align,0])
				cube([xFitAxleBeams, xFitAxleBeams, height+0.02],true);

				translate([align,-align,0])
				cube([xFitAxleBeams, xFitAxleBeams, height+0.02],true);

				translate([-align,-align,0])
				cube([xFitAxleBeams, xFitAxleBeams, height+0.02],true);
			}
		}	
	}
}



module crossProfileMale(height) {
	align = 2.234;	
	$fn = 30;
	// rotate([180,0,0])
	difference() {
	// cross beam
		difference() {
		// actual x Profile that'll act as the cutting tool
			cylinder(h = height + 0.01, r = xFitDiameter2/2,center = true);
			union() {
				translate([align,align,0])
				cube([xFitAxleBeams2, xFitAxleBeams2, height+0.02],true);
	
				translate([-align,align,0])
				cube([xFitAxleBeams2, xFitAxleBeams2, height+0.02],true);
	
				translate([align,-align,0])
				cube([xFitAxleBeams2, xFitAxleBeams2, height+0.02],true);
	
				translate([-align,-align,0])
				cube([xFitAxleBeams2, xFitAxleBeams2, height+0.02],true);
			}
		}

		// rounded ends
		translate([0,0,-height/2 + roundedAdjust])
		difference() {
			$fn = 50;
			// building cutting tool
			translate([0,0,-xFitDiameter2/2])
			cube(xFitDiameter2,true);
			sphere(xFitDiameter2/2,true);

		}	
	}
}

module roundedProp2() {
	zMove = shaftHeight/2 - bladeHeightOffset - bladeThickness/2;
	translate([bladeOr/2,0,zMove])
	rotate([bladePitch,0,0])
	union() {
		translate([bladeOr/2,0])
		cylinder(h = bladeThickness, r = bladeWidth/2, center = true);
		cube([bladeOr,bladeWidth,bladeThickness],true);
	}
}

module rudder() {
	zMove = shaftHeight/2 - bladeHeightOffset - bladeThickness/2;
	translate([propShaftOD/2,0,zMove])
	rotate([bladePitch,0,0])
	hull() {
		translate([bladeOr/2 + propShaftOr,-bladeWidth*rudderEndWidthMod/2,0])
		cylinder(h = bladeThickness, r = bladeWidth/2, center = true);
		translate([bladeOr/2 + propShaftOr,bladeWidth*rudderEndWidthMod/2,0])
		cylinder(h = bladeThickness, r = bladeWidth/2, center = true);

		cube([bladeWidth,bladeWidth,bladeThickness],true);
	}
}

module impellerBlades() {
	linear_extrude(height = shaftHeight, center = true, twist = bladePitch, slices = 10)
	translate([(propShaftOr + bladeOr/2) - 0.1,0])
	square([bladeOr,bladeThickness],true);
	// circle(propShaftOr,true);
}

module helicopterBlades() {
	$fn = 15;
	upperPortion = 1 - heliPortionRatio; // 0.7
	lowerPortion = heliPortionRatio; // 0.3
	translate([0,bladeOr*lowerPortion/2,0])
	rotate([90,bladePitch,0])
	resize([bladeWidth,bladeWidth*heliBladeZScale,bladeOr + 0.5])
	union() {
		cylinder(h = bladeOr*upperPortion, r1 = bladeThickness/heliEndScale, r2 = bladeThickness, center = true);
		translate([0,0,bladeOr/2])
		cylinder(h = bladeOr*lowerPortion, r2 = bladeThickness/heliEndScale, r1 = bladeThickness, center = true);
	}
}


propeller2();