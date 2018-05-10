// model: Prusa i3 MK2 Y Chassis Bearing Straps
//        This replaces the zip ties that tend to stretch and can reduce accuracy over time.
// author: fiveangle@gmail.com
// date: 2016oct11
// ver: 1.0.0
// notes: Print 2x "left" and 1x "right". Use 6x M3x10mm button-head or socket-head screws to secure.
// history:
//     -1.0.0 - 2016oct11 - Released
//
$fn = 300;

bearingDiameter = 15.05; // [15.00:Tight - 15.00mm, 15.05:default - 15.05mm, 15.1:Loose - 15.10mm, 15.2:Lucy Goosey - 15.20mm]
bearingLength = 15.1; // [15.0:Tight - 15.00mm, 15.1:default (to ridge) - 15.05mm, 15.2:Loose - 15.20mm, 24.2:Full bearing length - 24.20mm]
bearingType = "left"; // [left:Left, right:right]
nozzleWidth = 0.4; // used to calculate strap thickness
shellsForStrap = 4; // adjust with nozzleWidth to get desired strap thickness
bearingRidgeDiameter = 14.6;
bearingRidgeWidth = 0.8;
mountLength = bearingLength + 2 * bearingRidgeWidth;
screwDiameter = 2.9; // [2.8:Tight - 2.8mm, 2.9:default - 2.9mm, 3.0:Loose 3.0mm]
mountHoleSeparation = 22.9 - (22.9 - 17.2) / 2;
strapThickness = shellsForStrap * nozzleWidth;
mountWidth = mountHoleSeparation + 3 * screwDiameter;
prusaYChassisThickness = 6.2; // Measurement of your Y Chassis thickness
prusaYChassisBearingSlotWidth = bearingDiameter - 2;
prusaYChassisbearingSinkage = 4.3; // Measure Y chassis to bearing distance using depth guage in bearing slot minus about 0.2 mm for pretension
mountTabThickness = (prusaYChassisThickness - prusaYChassisbearingSinkage) + 5;
mountDiameter = bearingDiameter + (2 * strapThickness);
mountHeight = mountDiameter;

// polyhole cylinder fitment method: http://hydraraptor.blogspot.com/2011/02/polyholes.html
module polyhole(d, h) {
    n = max(round(2 * d), 3);
    rotate([0, 0, 180])
        cylinder(h = h, r = (d / 2) / cos(180 / n), $fn = n);
}


module bearing() {
        difference() {
            // mount body
            union() {
                cube([mountWidth, mountLength, mountTabThickness]);

                translate([mountWidth / 2, 0, (bearingDiameter / 2) + strapThickness])
                    rotate([-90, 0, 0])
                        cylinder(r = (bearingDiameter / 2) + strapThickness, h = mountLength);

            }

            // bearing core
            union() {
                    translate([mountWidth / 2, 0, (bearingDiameter / 2) + strapThickness])
                        rotate([-90, 0, 0])
                            cylinder(r = ((bearingRidgeDiameter / 2)), h = mountLength);

                    translate([mountWidth / 2, (mountLength - bearingLength) / 2, (bearingDiameter / 2) + strapThickness])
                        rotate([-90, 0, 0])
                            polyhole(bearingDiameter, bearingLength);

                }
                
            // prusa bearing sink
            cube([mountWidth + 10, mountLength, prusaYChassisThickness - prusaYChassisbearingSinkage + strapThickness]);

            if (bearingType == "left")
                cube([mountWidth, mountLength - (mountLength / 2 + screwDiameter / 2 + strapThickness), bearingDiameter + 2 * strapThickness]);

            translate([mountWidth / 2 - prusaYChassisBearingSlotWidth / 2, 0, 0])
                cube([prusaYChassisBearingSlotWidth, mountLength, (bearingDiameter + 2 * strapThickness) / 2]);



            translate([screwDiameter + screwDiameter / 2, mountLength / 2, 0])
                rotate([0, 0, 0])
                    cylinder(r = screwDiameter / 2, h = mountTabThickness);

            translate([mountWidth - screwDiameter - screwDiameter / 2, mountLength / 2, 0])
                rotate([0, 0, 0])
                    cylinder(r = screwDiameter / 2, h = mountTabThickness);
        }

    }


// doit
translate([0, -(prusaYChassisThickness - prusaYChassisbearingSinkage) - strapThickness, mountLength])
    rotate([-90, 0, 0])
        bearing();
