/* [Dimensions to Measure] */
// Outer dimension of the fan (assumed square)
fanSize = 80.0;

// Diameter of the bolt holes in the fan (The clips will fit into here)
fanHoleDiameter = 4.4;

// Distance between the outer edge of the fan, and the edge of the hole
fanHoleToEdgeThickness = 2.4;

// Inner separation between top and bottom fan walls
fanEdgeSeparation = 16.5;

// Separation between the inner surfaces of the M6 rods for the Huxley Frame Triangles
rodInnerSeparation = 154.8;

/* [Fan holder customization] */
// How far out from the crossbars will the fan sit?
outwardsOffset = 50.0;

// Height of the pins that clip into the fan holes
fanPinHeight = 1.5;

/* [Display on Huxley] */
// Set to true to see four holders with representative Huxley Frame Triangles
displayOnHuxley = "yes"; // [yes,no]

/* [Hidden] */
$fn=30;

// How far up the crossbar will the fan sit (just for showing in context)
verticalOffset = 50.0;

// Measured diameter of the M6 threaded rod
rodDiameter = 5.8;

// How long whould the rods be when displaying in context
rodLength = 207;

// Working calculations
rodCenterSeparation = rodInnerSeparation + rodDiameter;
fanEdgeToHoleCenter = fanHoleToEdgeThickness + fanHoleDiameter / 2;

// Horizontal offset is from center of rod to center of holes in fan
horizontalOffset = (rodCenterSeparation - fanSize) / 2 + fanEdgeToHoleCenter;

// Outer depth of the fan
fanDepth = 25.0;

// Thickness of top and bottom fan walls
fanWallThickness = 3.0;

// Thickness of the clip fingers
clipWidth = 3;

// Entry to the clip hole is this fraction of the hole diameter
clipInsetRatio = 0.7;

// How thick the overall structure will be
armThickness = 6.2;

// Width of the arm sections 
armWidth = 7.0;

// Offset used to avoid infinitely thin walls when doing differences
aBit = 0.1;

// Generic tolerance for matching parts to reality
tolerance = 0.1;

module showInContext() {
	rotate([30,0,0]) {
	% HuxleyCrossbars();
	% fan();

	mirror([1,0,0]) {
		twoHolderArms();
	}
	twoHolderArms();
	}
}

module twoHolderArms() {
	for(z=[-1,1]) {
		translate([rodCenterSeparation / 2,0, (verticalOffset + fanSize / 2) + z*(fanSize / 2 - fanEdgeToHoleCenter)]) {
			rotate([0,0,-90]) {
				holderArm();
			}
		}
	}
}

module HuxleyCrossbars() {
	for(x=[-1,1]) {
		translate([x*rodCenterSeparation/2,0,0]) cylinder(h=rodLength, r=rodDiameter/2.0);
	}
}

module fan() {
	translate([0, outwardsOffset, verticalOffset + fanSize / 2]) {
		difference() {
			union() {
				difference() {
					// Cutout center of cube to leave space for fan cylinder
					cube([fanSize, fanDepth, fanSize], center = true);
					cube([fanSize + aBit, fanEdgeSeparation, fanSize + aBit], center=true);
				}
				// Add fan outer cylinder
				rotate([90,0,0]) cylinder(h=fanEdgeSeparation, r=fanSize / 2, center=true);
			}

			// Cutout main fan hole
			rotate([90,0,0]) cylinder(h=fanDepth + aBit * 2, r=fanSize / 2 - fanWallThickness, center=true);

			// Cutout attachment holes
			for(z=[-1,1]) {
				for(x=[-1,1]) {
					translate([x*(fanSize / 2 - fanEdgeToHoleCenter), 0, z * (fanSize / 2 - fanEdgeToHoleCenter)]) {
						rotate([90,0,0]) cylinder(h=fanDepth + aBit, r=fanHoleDiameter / 2, center=true);
					}
				}
			}
		}
	}
}

module holderArm() {
	difference() {
		union() {
			 holderClipEnd();
			 holderElbow();
			 holderFanClip();
		}
		clipCutout();
		fanClipCutout();
	}
}

module holderClipEnd() {
	hull() {
		// Outer cylinder
		cylinder(h=armThickness, r=(rodDiameter/2) + clipWidth, center = true);
		wristCylinder();
		}
}

module clipCutout() {
	union(){
		// Inner cutout
		cylinder(h=armThickness + aBit, r=(rodDiameter/2), center = true);
		// Entry slot
		translate([rodDiameter / 2, 0, 0]) {
			cube([(rodDiameter/2 + clipWidth + aBit), (rodDiameter * clipInsetRatio), armThickness + aBit], center=true);
		}
	}
}

module wristCylinder() {
		// Cylinder closest to clip end
		translate([-(rodDiameter / 2 + clipWidth), 0, 0]) {
			cylinder(r=armWidth/2, h=armThickness, center=true);
		}
}

module elbow1Cylinder() {
		// Cylinder for elbow closest to wrist
		translate([-(outwardsOffset / 2), 0, 0]) {
			cylinder(r=armWidth/2, h=armThickness, center=true);
		}
}

module elbow2Cylinder() {
		// Cylinder for elbow closest to fan clip
		translate([-(outwardsOffset), -(horizontalOffset / 2), 0]) {
			cylinder(r=armWidth/2, h=armThickness, center=true);
		}
}

module shoulderCylinder() {
		// Cylinder closest to fan clip
		translate([-(outwardsOffset), -horizontalOffset, 0]) {
			cylinder(r=armWidth/2, h=armThickness, center=true);
		}
}

module holderElbow()
{
	union() {
		hull() { wristCylinder(); elbow1Cylinder(); }
		hull() { elbow1Cylinder(); elbow2Cylinder(); }
	}
}

module holderFanClip(){
	difference() {
		union() {
			// Fan clip pins
			translate([-(outwardsOffset), -horizontalOffset, 0]) {
				rotate([0,90,0]) {
					cylinder(h=fanEdgeSeparation + fanPinHeight *  2, r = fanHoleDiameter / 2 - tolerance, center=true);
				}
			}

			hull() {
				// Main connection cylinder
				translate([-(outwardsOffset), -horizontalOffset, 0]) {
					rotate([0,90,0]) {
						cylinder(h=fanEdgeSeparation - tolerance, r = armThickness / 2, center=true);
					}
				}

				// Far end of shoulder muscle
				translate([-(outwardsOffset), -(horizontalOffset * 3/4), 0]) {
					rotate([0,90,0]) {
						cylinder(h=fanEdgeSeparation - tolerance, r = armThickness / 2, center=true);
					}
				}

				elbow2Cylinder();
			}
		}
		// Bevel Cutout to help with installation
		translate([-(outwardsOffset + (fanEdgeSeparation + fanPinHeight * 3) / 2), -horizontalOffset, 0]) {
			rotate([0,0,30]) {
				cube([fanPinHeight, fanHoleDiameter * 2, fanHoleDiameter * 2], center=true);
			}
		}
	}
}

module fanClipCutout() {
	fanClipCutoutRadius = fanEdgeSeparation / 3;
	hull() {
		translate([-(outwardsOffset), -(horizontalOffset + fanClipCutoutRadius), 0]) {
			cylinder(h=armThickness + aBit, r = fanClipCutoutRadius, center=true);
		}

		translate([-(outwardsOffset), -(horizontalOffset - fanClipCutoutRadius), 0]) {
			cylinder(h=armThickness + aBit, r = fanClipCutoutRadius, center=true);
		}
	}
}

if(displayOnHuxley == "yes") {
	showInContext();
}
else {
	holderArm();
}

