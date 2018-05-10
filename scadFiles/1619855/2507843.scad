/* [Ninja Star Generator Settings] */
// shape of blades
pointShape = "triangle"; // [triangle,asymTriangle]
// number of blades
numPoints = 4;
// diameter of ninja star
starDiameter = 40;
// how much of the star is the sharp end
bladearmRatio = 0.7; // [0:0.1:1]
// thickness of ninja star
thickness = 1.5;

// sides of in between blade cutout shapes
polygonCutoutSides = 35; // [3,4,5,6,8,50]
// length of cutout shape
cutoutSideLength = 5;

// amount of center that is a hole, set to 0 for no center cutout
centercutoutDiameterRatio = 0.6; // [0:0.1:1]
// centercutout number of sides cutout
centerPolygonSidesCount = 3;

// Calculations //
starRadius = starDiameter/2;
// finding the blade length
bladeLength = starRadius*bladearmRatio;
// finding the complementary center length end
centerRadius = starRadius*(1 - bladearmRatio);
// totals points for calculating star cutouts
numPointsTotal = numPoints*2;
// finding the size of the center cutout
centercutoutRadius = centerRadius*centercutoutDiameterRatio;


module star2() {
	linear_extrude(thickness)
	difference() {
		union() {
			for (i = [0:numPoints]) {
				if (pointShape == "triangle") {
				// actual points
					rotate([0,0,i*360/numPoints]) {
						hull() {
							translate([0,centerRadius]) 
							polygon(points=[[-centerRadius,0]
								,[centerRadius,0]
								,[0,bladeLength]]);
							circle(centerRadius,true,$fn = 30);
						}
					}
				} else if (pointShape == "asymTriangle") {
					rotate([0,0,i*360/numPoints]) {
						hull() {
							translate([0,centerRadius]) 
							polygon(points=[[-centerRadius,0]
								,[0,0]
								,[0,bladeLength]]);
							difference() {
								circle(centerRadius,true,$fn = 30);
								translate([centerRadius,0]) {
									square(centerRadius*2,true);
								}
							}
						}
					}
				}
			}
		}

		union() {
			// in between points cutout
			for (i = [0:numPointsTotal]) {
				if (i % 2 == 1) {
					rotate([0,0,i*360/numPointsTotal]) {
						translate([0,centerRadius + cutoutSideLength*bladearmRatio])
						// rotate([0,0,0])
						circle(r = cutoutSideLength, center = true, $fn = polygonCutoutSides);
					}
				}
			}
			circle(r = centercutoutRadius, center = true, $fn = centerPolygonSidesCount);
		}
	}
}

star2();
