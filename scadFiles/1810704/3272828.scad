// http://www.openscad.org/cheatsheet/index.html

// Diameter of tangible
tangibleSize = 50;
// Diameter of inner hole
holeDiameter = 20;
// Width/height of markers
markerSize = 10;
// Distance between markers and outer circle line
markerToCircleEdgeDistance = 2.5;
// Border width of middle part. Smaller width results in bigger interior
borderWidth = 5;

// Position and label of first marker (clockwise, starts at x-axis)
marker1Angle = 0; // [0:360]
// Label is rotated by 45° - Leave empty to remove
marker1Label = "";
// ... second marker
marker2Angle = 120;	// [0:360]
marker2Label = "";
// ... third marker
marker3Angle = 240;	// [0:360]
marker3Label = "";

/* [Support Marker] */

supportMarker1 = 0; // [1:enabled, 0:disabled]
supportMarker1Angle = 80; // [0:360]
supportMarker2 = 0; // [1:enabled, 0:disabled]
supportMarker2Angle = 280; // [0:360]

module circleWithHole(diameter = tangibleSize, hole = holeDiameter) {
	difference() {
		circle(diameter / 2, $fn = 75);
		circle(hole / 2, $fn = 50);
	}
}

module markerAtAngle(angle) {
	markerXTranslation = tangibleSize / 2 - markerToCircleEdgeDistance - markerSize / 2;
	rotate([0, 0, -angle]) translate([markerXTranslation, 0, 0]) square(markerSize, true);
}

module markerTextAtAngle(text, angle) {
	markerXTranslation = tangibleSize / 2 - markerToCircleEdgeDistance - markerSize / 2;
	color("blue") rotate([0, 0, -angle]) translate([markerXTranslation, 0, 0]) rotate([0, 0, 45]) text(text, size = 4, halign = "center", valign = "center");
}

module rings() {
	difference() {
		circleWithHole();
		circleWithHole(tangibleSize - borderWidth, holeDiameter + borderWidth);
	}	
}

module bottom() {
	difference() {
		circleWithHole();

		markerAtAngle(marker1Angle);
		markerAtAngle(marker2Angle);
		markerAtAngle(marker3Angle);

		if (supportMarker1) {
			markerAtAngle(supportMarker1Angle);
		}
		if (supportMarker2) {
			markerAtAngle(supportMarker2Angle);
		}

		notchWidth = 2;
		for (i = [0:3]) {
			rotate([0, 0, i * 90]) translate([tangibleSize/2 - notchWidth/2, 0, 0]) square([notchWidth, 3], true);
		}
	}	
}

translate([tangibleSize + 1, 0, 0]) rings();
bottom();

markerTextAtAngle(str(marker1Label), marker1Angle);
markerTextAtAngle(str(marker2Label), marker2Angle);
markerTextAtAngle(str(marker3Label), marker3Angle);
