// Diameter of tangible
tangibleDiameter = 50;
// Diameter of inner hole
holeDiameter = 20;

module circleWithHole(diameter, holeDiameter) {
	difference() {
		res = 75;
		circle(d = diameter, $fn = res);
		circle(d = holeDiameter, $fn = res);
	}
}

circleWithHole(tangibleDiameter, holeDiameter);
translate([tangibleDiameter + 1, 0, 0]) circleWithHole(tangibleDiameter, holeDiameter);
