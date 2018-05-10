/*
 * Motor Bracket Generator v1.0
 *
 * http://www.thingiverse.com/thing:1902768
 *
 * By: Maxstupo
 */

/* [Base Plate] */
// (The thickness of the base plate):
baseThickness = 3;

// (The bracket mounting hole diameter):
plateMountHoleDiameter = 3;

// (The distance between the mount holes on the y axis, center-to-center):
plateMountHoleWidth = 20;

// (The distance between the mount holes on the x axis, center-to-center):
plateMountHoleLength = 35;

// (The distance between the mount holes and the edge of the motor plate):
plateMountHoleFromEdge = 8;



/* [Motor Plate] */

// (The thickness of the plate that the motor attaches to):
plateThickness = 3;

// (The outer diameter of the motor):
motorDiameter = 25;

// (The motor length defines the length of the base plate):
motorLength = 50;

// (The diameter of the motorW shaft):
motorShaftDiameter = 8;

// (The motor mounting hole diameter):
motorMountHoleDiameter = 3;

// (Spacing of motor mount holes from center of motor shaft):
motorMountSpacing = 8.25;



/* [Support] */

// (The spacing between the motor and the bracket):
spacing = 2;

// (The thickness of the supports):
supportThickness = 3;

// (The length of each support from the motor plate):
supportLength = 20;


/* [Misc] */
$fn=200;


motorBracket(plateThickness, baseThickness, spacing, supportThickness, supportLength, motorDiameter, motorLength, motorShaftDiameter);


module motorBracket(plateThickness=5, baseThickness=3, spacing=2, supportThickness=3, supportLength=20, motorDiameter=25, motorLength=50, motorShaftDiameter=8){
    difference(){
        union(){
            // Base
            cube([motorLength+plateThickness, motorDiameter + (spacing + supportThickness) * 2, baseThickness]);
            
            // Motor plate
            cube([plateThickness, motorDiameter + (spacing + supportThickness) * 2, motorDiameter + baseThickness + (spacing + supportThickness) * 2]);

            //Supports
            translate([plateThickness, supportThickness, baseThickness]) rotate([90, 0, 0]) rightAngleTriangle(a=motorDiameter + (spacing + supportThickness) * 2, b=supportLength, height=supportThickness);
            translate([plateThickness, motorDiameter + (spacing + supportThickness) * 2, baseThickness]) rotate([90, 0, 0]) rightAngleTriangle(a=motorDiameter + (spacing + supportThickness) * 2, b=supportLength, height=supportThickness);
                
        }
        
        // Motor shaft hole.
        rotate([0, 90, 0]) translate([-motorDiameter / 2 - baseThickness - (spacing + supportThickness), motorDiameter / 2 + (spacing + supportThickness), -1]) cylinder(d=motorShaftDiameter, h=plateThickness + 2);
    
        // Bracket mount holes.
        translate([plateMountHoleLength/2+plateMountHoleDiameter/2+plateMountHoleFromEdge,(motorDiameter + (spacing + supportThickness) * 2)/2,0]){
            translate([plateMountHoleLength/2,plateMountHoleWidth/2,-1])  cylinder(h=baseThickness+2,d=plateMountHoleDiameter);
            translate([-plateMountHoleLength/2,-plateMountHoleWidth/2,-1])  cylinder(h=baseThickness+2,d=plateMountHoleDiameter);
            
            translate([-plateMountHoleLength/2,plateMountHoleWidth/2,-1])  cylinder(h=baseThickness+2,d=plateMountHoleDiameter);
            translate([plateMountHoleLength/2,-plateMountHoleWidth/2,-1])  cylinder(h=baseThickness+2,d=plateMountHoleDiameter);
        }
        
        // Motor mount holes.
       rotate([0, 90, 0]) translate([-motorDiameter / 2 - baseThickness - (spacing + supportThickness), motorDiameter / 2 + (spacing + supportThickness), -1]) {
           translate([0,-motorMountSpacing,0]) cylinder(h=plateThickness+2,d=motorMountHoleDiameter);
           translate([0,motorMountSpacing,0]) cylinder(h=plateThickness+2,d=motorMountHoleDiameter);
           translate([-motorMountSpacing,0,0]) cylinder(h=plateThickness+2,d=motorMountHoleDiameter);
           translate([motorMountSpacing,0,0]) cylinder(h=plateThickness+2,d=motorMountHoleDiameter);
        }
    
    }

    // Motor ghost.
    %rotate([0, 90, 0]) translate([-motorDiameter / 2 - baseThickness - (spacing + supportThickness), motorDiameter / 2 + (spacing + supportThickness), plateThickness]) cylinder(h=motorLength, d=motorDiameter);

}

module rightAngleTriangle(a, b, height=1) {
	aCos = cos(90) * a;
	aSin = sin(90) * a;
	polyhedron(
		points=[[0, 0, 0], [b, 0, 0], [aCos, aSin, 0], [0, 0, height], [b, 0, height], [aCos, aSin, height]],
        faces=[[0, 1, 2], [2, 1, 4, 5], [0, 2, 5, 3], [3, 4, 1, 0], [4, 3, 5]]
    );
}