/* [Plate Dimensions] */

// how many studs in the X-direction
studCountX = 2;
// how many studs in the Y-direction
studCountY = 4;
// thickness of plate
plateThickness = 3.7;

/* [Hidden] */
centerCircleOD = 6.134;
centerCircleID = 4.314;
offsetThickness = 1.05;
$fn = 30;

// calculations // 
plateWidth = studCountX*7.95;
plateHeight = studCountY*7.95;
CCOr = centerCircleOD/2;
CCIr = centerCircleID/2;

module doubleFemalePlate4() {
	linear_extrude(plateThickness)
	union() {
		// border of piece
		difference() {
			union() {
				square([plateWidth,plateHeight],true);
			}
			union() {
				square([plateWidth - 2*offsetThickness,plateHeight - 2*offsetThickness],true);
			}
		}

		union() {
			// center circle
			difference() {
				// base shape
				union() {
					for (i = [0:studCountX - 2]) {
						for (j = [0:studCountY - 2]) {
							// base circle
							translate([-4*(studCountX-2) + 8*i,-4*(studCountY-2) + 8*j])
							circle(CCOr,true);
							translate([-4*(studCountX-2) + 8*i,0])
							square([1.15,plateHeight - 2*offsetThickness],true);

							translate([0,-4*(studCountY-2) + 8*j])
							square([plateWidth - 2*offsetThickness,1.15],true);
						}
					}

					// tessellated poles, spokes and crossed reinforcing beams
					for (i = [0:studCountX - 1]) {
						for (j = [0:studCountY - 1]) {
							// place stud spokes here
							// translate([8*(i - studCountX),0])
							translate([-4*(studCountX - 1) + 8*i,(plateHeight/2 - offsetThickness - 0.2)])
							square([0.6,0.4],true);

							translate([(plateWidth/2 - offsetThickness - 0.2),-4*(studCountY - 1) + 8*j])
							square([0.4,0.6],true);

							// mirrored spokes
							mirror([0,1,0])
							translate([-4*(studCountX - 1) + 8*i,(plateHeight/2 - offsetThickness - 0.2)])
							square([0.6,0.4],true);

							mirror([1,0,0])
							translate([(plateWidth/2 - offsetThickness - 0.2),-4*(studCountY - 1) + 8*j])
							square([0.4,0.6],true);
						}
					}
				}

				// cutting tool
				for (i = [0:studCountX - 2]) {
					for (j = [0:studCountY - 2]) {
						// tool body cut
						translate([-4*(studCountX-2) + 8*i,-4*(studCountY-2) + 8*j])
						circle(CCIr,true);
					}
				}
			}
		}
	}
}

module doubleFemalePlateThin1() {
	linear_extrude(plateThickness)
	union() {
		// border of piece
		difference() {
			union() {
				square([plateWidth,plateHeight],true);
			}
			union() {
				square([plateWidth - 2*offsetThickness,plateHeight - 2*offsetThickness],true);
			}
		}

		union() {
			// tessellated spokes
			for (i = [0:studCountX - 1]) {
				for (j = [0:studCountY - 1]) {
					// place stud spokes here
					// translate([8*(i - studCountX),0])
					translate([-4*(studCountX - 1) + 8*i,(plateHeight/2 - offsetThickness - 0.2)])
					square([0.6,0.4],true);
					translate([(plateWidth/2 - offsetThickness - 0.2),-4*(studCountY - 1) + 8*j])
					square([0.4,0.6],true);
					// mirrored spokes
					mirror([0,1,0])
					translate([-4*(studCountX - 1) + 8*i,(plateHeight/2 - offsetThickness - 0.2)])
					square([0.6,0.4],true);
					mirror([1,0,0])
					translate([(plateWidth/2 - offsetThickness - 0.2),-4*(studCountY - 1) + 8*j])
					square([0.4,0.6],true);
				}
			}
		}
	}
}

if (studCountY < 2 || studCountX < 2) {
	doubleFemalePlateThin1();
} else {
	doubleFemalePlate4();
}
