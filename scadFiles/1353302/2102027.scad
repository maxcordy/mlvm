/* [Main] */

// Which part would you like to see?
part = "assembly"; // [shoulderBasePlate:shoulder base plate,armSection:upper arm section,forearmSection:forarm section,shoulderSpacerSet:shoulder spacers,armSpacerSet:arm spacers,assembly:all parts assembled]
// length of main arm
armLength = 100;
// length of forearm
forearmLength = 75;
// spacers: print sets or just one (need 6 arm spacers and 4 shoulder spacers)
print_spacer_sets = 1; //[1:true,0:false]

/* [shoulder base] */

shoulderBaseHeight = 3;
shoulderBaseDiameter = 55;
shaftBossDiameter = 10;
mountScrewDiameter = 3.1;
// size in mm of bearing interface step
bearingStep = 2; 

/* [joint parameters] */

hubHeight = 10;
hubRadius = 7;
shaftHeight = 6;
shaftRadius = 3.1;
setScrewRadius = 1.5;
setScrewHeight = 2.75;
spokeWidth = 3;
spokes = 6;
screwTabs = 4;
screwTabHeight = 4;

/* [Forearm manipulator] */

sharpieDiameter = 13;
laserDiodeDiameter = 2 * 3.05;
// 8 is distance from shaft center to screw center on x axis
shaftCenterToMountHoldCenterXAxis = 8;
// 35 is screw center to screw center on y axis
mountHoleCenterToMountHoleCenter = 35;
leadScrewDiameter = 8;


/* [Misc] */

baseDeckExtension = 80;
boundingBox = 8;
boundingBoxHalf = boundingBox / 2;
// interference fit adjustments for 3D printer
iFitAdjust = .4;
iFitAdjust_d = .25;
//Render quality
$fn = 64; // [24:low quality,48:development,64:production]

//////////////////////////////////////////////////////////

print_part();

module print_part() {
	if (part == "shoulderBasePlate") {
		shoulderBasePlate();
	} else if (part == "armSection") {
		armSection();
	} else if (part == "forearmSection") {
        forearmSection();
	} else if (part == "shoulderSpacerSet") {
        if (print_spacer_sets > 0) {
            shoulderSpacerSet();
        } else {
            shoulderSpacer();
        }
	} else if (part == "armSpacerSet") {
        if (print_spacer_sets > 0) {
            armSpacerSet();
        } else {
            armSpacer();
        }        
	} else if (part == "assembly") {
		assembly();
	} else {
		//nothing
	}
}


// SHOULDER
// shoulder base
module shoulderBasePlate() { // make me 
color([.7, .7, 1]) 
    shoulderBase(bearing6807_2RS_d - iFitAdjust_d, bearing6807_2RS_D + iFitAdjust, shoulderBaseHeight, shoulderBaseDiameter, shaftBossDiameter, mountScrewDiameter);
}

// shoulder spacers
module shoulderSpacerSet() { // make me
    color([.7, .6, .2])
    shoulderSpacers(bearing6807_2RS_D + iFitAdjust, 0 * shoulderBaseHeight + (4 * bearing6807_2RS_B) + (8 * bearingStep));
    color([.7, .6, .2])
    translate([baseDeckExtension / 3, 0, 0])
    shoulderSpacers(bearing6807_2RS_D + iFitAdjust, 0 * shoulderBaseHeight + (4 * bearing6807_2RS_B) + (8 * bearingStep));
}
// end shoulder

// lower arm including the shoulder - arm joint 
module armSection() { // make me
color([1, .7, .7]) 
    translate([0, 0, shoulderBaseHeight + bearing6807_2RS_B]) 
        armLower(bearing6807_2RS_D + iFitAdjust, bearingStep, bearingStep, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, screwTabs, screwTabHeight, armLength);
}

// arm spacers
module armSpacerSet() { // make me
color([.6, .6, .3])
    armSpacers(bearing6807_2RS_D + iFitAdjust, 0 * shoulderBaseHeight + (4 * bearing6807_2RS_B) + (8 * bearingStep));
}
// end arm
        
// forearm pieces
// lower
module forearmSection() { // make me
color([.1, .7, .1])
translate([-armLength, 0, shoulderBaseHeight + (bearing6807_2RS_B * 2) + (4 *bearingStep)])
//translate([-armLength, 0, shoulderBaseHeight + (bearing6807_2RS_B * 2) + (14 *bearingStep)])
    forearmLower(bearing6807_2RS_d - iFitAdjust_d, bearing6807_2RS_D + iFitAdjust, bearingStep, bearingStep, hubHeight + (bearing6807_2RS_B / 2) + (bearingStep/2), hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, forearmLength, boundingBox);
}

// forearm spacers
// none at this time

//bearingInnerStep(bearing6807_2RS_d - iFitAdjust, 2, 2);
module bearingInnerStep(bearingID, stepHeight, stepWidth) {
    difference() {
        union() {
            // this fits inside of the bearing
            cylinder(h = stepHeight * 2, d = bearingID);
            // this rests on the bearing inner lip
            cylinder(h = stepHeight, d = bearingID + stepWidth);
        }
        // remove center
        cylinder(h = stepHeight * 2, d = bearingID - (stepWidth * 2));
    }
}

//translate([0, 0, 12]) bearingOuterStep(bearing6807_2RS_D + iFitAdjust, 2, 2);
module bearingOuterStep(bearingOD, stepHeight, stepWidth) {
    //render(convexivity = 3)
    difference() {
        cylinder(h = stepHeight * 2, d = bearingOD + stepWidth);
        cylinder(h = stepHeight * 2, d = bearingOD - stepWidth);
        cylinder(h = stepHeight, d = bearingOD);
    }
}

module shoulderSpacer() {
    //     shoulderSpacers(bearing6807_2RS_D + iFitAdjust, 0 * shoulderBaseHeight + (4 * bearing6807_2RS_B) + (8 * bearingStep));
    bearOD = bearing6807_2RS_D + iFitAdjust;
    screwSpacerH = (4 * bearing6807_2RS_B) + (8 * bearingStep);
    color([.7, .6, .2])
    difference() {
        cylinder(h = (4 * bearing6807_2RS_B) + (8 * bearingStep), r = setScrewRadius * 2);
        cylinder(h = screwSpacerH / 4, r = setScrewRadius);
        translate([0, 0, screwSpacerH * .75])
            cylinder(h = screwSpacerH/4, r = setScrewRadius);
        }           
                
}

module shoulderSpacers(bearingOD, screwSpacerHeight) {
    union() {
        // screw holes for joining to arm
        rotate([0, 0, -30])
            radial_array_partial(vec = [0, 0, 1], n = 6, 2)
                translate([bearingOD / 2 + (setScrewRadius * 8), 0, shoulderBaseHeight * 1.0])
                    difference() {
                        cylinder(h = screwSpacerHeight, r = setScrewRadius * 2);
                        cylinder(h = screwSpacerHeight / 4, r = setScrewRadius);
                        translate([0, 0, screwSpacerHeight * .75])
                            cylinder(h = screwSpacerHeight/4, r = setScrewRadius);
                    }       
    }
}

module armSpacers(bearingOD, screwSpacerHeight) {
    union() {
        // screw holes for joining to arm
        radial_array(vec = [0, 0, 1], n = 4)
            translate([bearingOD / 2 + (setScrewRadius * 2), 0, shoulderBaseHeight + bearing6807_2RS_B + 2 * bearingStep])
        difference() {
            union () {
                cylinder(h = bearing6807_2RS_B * 2 + 4 * bearingStep, r = setScrewRadius * 2);
                
                }
            cylinder(h = bearing6807_2RS_B * 2 + 4 * bearingStep, r = setScrewRadius);
        }
        // TODO: put in spacers along arm, make sure holes exist in arm
        translate([- armLength, 0, 0])
        rotate([0, 0, -30])
        radial_array_partial(vec = [0, 0, 1], n = 6, 2)
            translate([bearingOD / 2 + (setScrewRadius * 8), 0, shoulderBaseHeight + bearing6807_2RS_B + 2 * bearingStep])
        difference() {
            union () {
                cylinder(h = bearing6807_2RS_B * 2 + 4 * bearingStep, r = setScrewRadius * 2);
                
                }
            cylinder(h = bearing6807_2RS_B * 2 + 4 * bearingStep, r = setScrewRadius);
        }
    }
}

module armSpacer(bearingOD, screwSpacerHeight) {
    difference() {
        union () {
            cylinder(h = bearing6807_2RS_B * 2 + 4 * bearingStep, r = setScrewRadius * 2);
            }
        cylinder(h = bearing6807_2RS_B * 2 + 4 * bearingStep, r = setScrewRadius);
    }   
}

// armJointSpacer(bearing6807_2RS_D - iFitAdjust, bearing6807_2RS_D + iFitAdjust, bearingStep, shaftBossDiameter, mountScrewDiameter);
module armJointSpacer(bearingID, bearingOD, bearingStep, shaftBossDiameter, mountScrewDiameter) {
    union() {
        difference() {
            cylinder(h = bearingStep * 2, d = bearingOD + bearingStep);
            cylinder(h = bearingStep * 2, d = bearingID);
        }
        translate([0, 0, bearingStep * 2])
                bearingInnerStep(bearingID, bearingStep, bearingStep);
        // screw holes for joining to arm
        radial_array(vec = [0, 0, 1], n = screwTabs)
                translate([bearingOD / 2 + (setScrewRadius * 2), 0, (2 * bearingStep) - screwTabHeight])
                    difference() {
                        union () {
                            cylinder(h = screwTabHeight, r = setScrewRadius * 2);
                            translate([-2 * setScrewRadius, - 2 * setScrewRadius, 0])
                                cube([setScrewRadius * 2, 4 * setScrewRadius, screwTabHeight], center = false);
                        }
                        cylinder(h = screwTabHeight, r = setScrewRadius);
                    }       
    }
}


//shoulderBase(2, 55, 9.1, 3.1);
// WARNING: has some hard-coded non-parametric values in here!
module shoulderBase(bearingID, bearingOD, shoulderBaseHeight, shoulderBaseDiameter, shaftBossDiameter, mountScrewDiameter) {
    mountHoleDepth = shoulderBaseHeight;

    //render(convexivity = 3)
    difference() {
        union () {
            cylinder(h = shoulderBaseHeight, d = shoulderBaseDiameter);
            translate([0, 0, shoulderBaseHeight])
                bearingInnerStep(bearing6807_2RS_d - iFitAdjust, bearingStep, bearingStep);
            // 40 is the length of deck extension from the baseplate in x
            translate([0, -shoulderBaseDiameter / 2, 0])
                cube([baseDeckExtension, shoulderBaseDiameter, shoulderBaseHeight], center = false);
        }
        // motor shaft hole
        cylinder(h = shoulderBaseHeight + (bearingStep * 2), d = shaftBossDiameter);
        // mounting holes
        
        translate([shaftCenterToMountHoldCenterXAxis, mountHoleCenterToMountHoleCenter/2, 0]) 
            cylinder(h = mountHoleDepth, d = mountScrewDiameter);
        translate([shaftCenterToMountHoldCenterXAxis, -mountHoleCenterToMountHoleCenter/2, 0]) 
            cylinder(h = mountHoleDepth, d = mountScrewDiameter);
        // lead screw hole
        translate([baseDeckExtension - (leadScrewDiameter * 1.5), 0, 0])
            cylinder(h = shoulderBaseHeight, d = leadScrewDiameter + (leadScrewDiameter / 2));
        // upper to lower spacer screw holes
        rotate([0, 0, -30])
            radial_array_partial(vec = [0, 0, 1], n = 6, 2)
                translate([bearingOD / 2 + (setScrewRadius * 8), 0, shoulderBaseHeight * 0])
                    cylinder(h = screwTabHeight, r = setScrewRadius);
           translate([baseDeckExtension / 3, 0, 0])
            rotate([0, 0, -30])
            radial_array_partial(vec = [0, 0, 1], n = 6, 2)
                translate([bearingOD / 2 + (setScrewRadius * 8), 0, shoulderBaseHeight * 0])
                    cylinder(h = screwTabHeight, r = setScrewRadius);
    }
    // NOTE: need to add LM8UU mounts
}




module armLower(bearingOD, stepHeight, stepWidth, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, screwTabs, screwTabHeight, armLength) {
    armWidth = bearingOD / 2;
    //render(convexivity = 3)
    difference() { 
    union() {
        armInnerJoint(bearingOD, bearingStep, bearingStep, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, screwTabs, screwTabHeight);
        translate([-armLength, 0, 0])
            armOuterJointBase(bearingOD, bearingStep, setScrewRadius, screwTabs, screwTabHeight);
        difference() {
            translate([-armLength, -armWidth / 2, 0])
                cube([armLength, armWidth, bearingStep * 2], center=false);
            cylinder(h = bearingStep * 2, d = bearingOD);
            translate([-armLength, 0, 0])
                cylinder(h = bearingStep * 2, d = bearingOD);
            translate([-armLength + (bearingOD / 2) + (boundingBox / 2), -(armWidth / 2) + boundingBoxHalf, 0])
                cube([armLength - bearingOD - (boundingBox + boundingBoxHalf), armWidth - boundingBox, bearingStep * 2], center = false);
        }
        difference() {
            intersection() {
            
                translate([-armLength + (bearingOD / 2) + (boundingBox / 2), -(armWidth / 2) + boundingBoxHalf, 0])
                    cube([armLength - bearingOD - boundingBox, armWidth - boundingBox, bearingStep * 2], center = false);
                for (i = [ bearingOD / 2 - boundingBoxHalf: armWidth : armLength]) {
                    translate([ -i, 0, bearingStep])
                        rotate([0, 0, 45])
                            cube([spokeWidth, armWidth + boundingBoxHalf, bearingStep * 2], center = true);
                    translate([ -i, 0, bearingStep])
                        rotate([0, 0, -45])
                            cube([spokeWidth, armWidth + boundingBoxHalf, bearingStep * 2], center = true);
                }
            }
        
        }
               difference() {
               hull() {
                   translate([- armLength, 0, bearingStep])
                    linear_extrude(height = 2 * bearingStep, center = true, twist = 0)
                        polygon(points=[[0, -bearingOD/2 - setScrewRadius/2], [bearingOD / 2 + (setScrewRadius * 8), -armWidth / 2], [bearingOD / 2 + (setScrewRadius * 8), armWidth / 2], [0, bearingOD/2 + setScrewRadius/2]]);
                translate([- armLength, 0, 0])
                    rotate([0, 0, -30])
                    radial_array_partial(vec = [0, 0, 1], n = 6, 2)
                        translate([bearingOD / 2 + (setScrewRadius * 8), 0, 0])
                            cylinder(h = 2 * bearingStep, r = setScrewRadius * 2);
                        
                    }
                translate([- armLength, 0, 0])
                    rotate([0, 0, -30])
                    radial_array_partial(vec = [0, 0, 1], n = 6, 2)
                        translate([bearingOD / 2 + (setScrewRadius * 8), 0, 0])
                        cylinder(h = 2 * bearingStep, r = setScrewRadius);
                   
                 translate([-armLength + (bearingOD / 2) + (boundingBox / 2), -(armWidth / 2) + boundingBoxHalf, 0])
                    cube([armLength - bearingOD - boundingBox, armWidth - boundingBox, bearingStep * 2], center = false);
             translate([-armLength, 0, 0])
                cylinder(h = bearingStep * 2, d = bearingOD);
               
        }
   }
           // screw holes for joining to upper
        radial_array(vec = [0, 0, 1], n = screwTabs)
                translate([bearingOD / 2 + (setScrewRadius * 2), 0, (2 * stepHeight) - screwTabHeight])
                       cylinder(h = screwTabHeight, r = setScrewRadius);
   
 
   }
}

module armOuterJointBase(bearingOD, bearingStep, setScrewRadius, screwTabs, screwTabHeight) {
    mountHoleDepth = bearingStep * 2;

    //render() 
    union() {
        difference() {
            union() {
                translate([0, 0, -(bearingStep * 2)]) 
                    difference() { // base w/ cutout for seeing into the joint
                    
                        cylinder(h = bearingStep * 2, d = bearingOD + bearingStep);
                    intersection() { // cutout
                        difference() {
                            cylinder(h = bearingStep * 2, d = .85 * bearingOD);
                            cylinder(h = bearingStep * 2, d = .35 * bearingOD);
                        }
                        translate([-bearingOD, -bearingOD/2, 0])
                            cube([bearingOD, bearingOD, bearingStep * 2], center = false);
                    }
                }
                translate([0, 0, bearingStep * 2])
                    rotate([0, 180, 0])
                        bearingOuterStep(bearingOD, bearingStep, bearingStep);
                // spokes
                rotate([0, 0, 150])
                radial_array_partial(vec=[0, 0, 1], n = 6, 2)
                translate([hubRadius - (bearingStep / 2), -(spokeWidth / 2), -(bearingStep * 2)]) 
                    cube([(bearingOD / 2) - hubRadius, spokeWidth, bearingStep], center = false);
            }
            // motor shaft hole
            translate([0, 0, -(bearingStep * 2)])
                cylinder(h = shoulderBaseHeight + (bearingStep * 2), d = shaftBossDiameter);
            // mounting holes
            translate([0, 0, -(bearingStep * 2)]) {
                translate([shaftCenterToMountHoldCenterXAxis, mountHoleCenterToMountHoleCenter/2, 0]) 
                cylinder(h = mountHoleDepth, d = mountScrewDiameter);
                translate([shaftCenterToMountHoldCenterXAxis, -mountHoleCenterToMountHoleCenter/2, 0]) 
                cylinder(h = mountHoleDepth, d = mountScrewDiameter);
            }
        }
        
    }
}

//armInnerJoint(bearing6807_2RS_D + iFitAdjust, bearingStep, bearingStep, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, screwTabs, screwTabHeight);
module armInnerJoint(bearingOD, stepHeight, stepWidth, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, screwTabs, screwTabHeight) {
    //translate([0, 0, hubHeight - (2 * stepHeight)])
    difference() {
        union() {
         difference() {
            cylinder(h = bearingStep * 2, d = bearingOD + (setScrewRadius * 6));
            cylinder(h = bearingStep * 2, d = bearingOD);
//            translate([0, -bearingOD, 0])
//                cube([bearingOD, bearingOD * 2, bearingStep * 2]);
        }
        bearingOuterStep(bearingOD, stepHeight, stepWidth);
        // hub
        translate([0, 0, -(hubHeight - (2 * stepHeight))])
            stepperHub(hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight);
        // spokes
        radial_array(vec=[0, 0, 1], n = spokes)
                translate([hubRadius - (stepWidth / 2), -(spokeWidth / 2), stepHeight * 1.2]) 
                    cube([(bearingOD / 2) - hubRadius, spokeWidth, stepHeight * .8], center = false);
        // screw tabs for joining to upper
        radial_array(vec = [0, 0, 1], n = screwTabs)
                translate([bearingOD / 2 + (setScrewRadius * 2), 0, (2 * stepHeight) - screwTabHeight])
                    
                        union () {
                            cylinder(h = screwTabHeight, r = setScrewRadius * 2);
                            translate([-2 * setScrewRadius, - 2 * setScrewRadius, 0])
                                cube([setScrewRadius * 2, 4 * setScrewRadius, screwTabHeight], center = false);
                        }
                        
                    }
        // screw holes for joining to upper
        radial_array(vec = [0, 0, 1], n = screwTabs)
                translate([bearingOD / 2 + (setScrewRadius * 2), 0, (2 * stepHeight) - screwTabHeight])
                       cylinder(h = screwTabHeight, r = setScrewRadius);
    }
}


module forearmLower(bearingID, bearingOD, stepHeight, stepWidth, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, forearmLength, boundingBox) {
    armWidth = bearingOD / 2;

    rotate([180, 0, 0]) union() {
        boundingBoxHalf = boundingBox / 2;
        difference() {
            cylinder(h = bearingStep * 2, d = bearingOD + bearingStep);
            cylinder(h = bearingStep * 2, d = bearingID - (2 * bearingStep));
        }
        translate([0, 0, bearingStep * 2])
            bearingInnerStep(bearingID, bearingStep, bearingStep);
        // screw holes for joining to arm
        radial_array(vec = [0, 0, 1], n = screwTabs)
                translate([bearingOD / 2 + (setScrewRadius * 2), 0, (2 * bearingStep) - screwTabHeight])
                    difference() {
                        union () {
                            cylinder(h = screwTabHeight, r = setScrewRadius * 2);
                            translate([-2 * setScrewRadius, - 2 * setScrewRadius, 0])
                                cube([setScrewRadius * 2, 4 * setScrewRadius, screwTabHeight], center = false);
                        }
                        cylinder(h = screwTabHeight, r = setScrewRadius);
                    }
        // hub
        translate([0, 0, hubHeight]) rotate([180, 0, 0]) 
            stepperHub(hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight);
        // spokes
        radial_array(vec=[0, 0, 1], n = spokes)
                translate([hubRadius - (stepWidth / 2), -(spokeWidth / 2), 0]) 
                    cube([(bearingOD / 2) - hubRadius, spokeWidth, 2 *stepHeight], center = false);   
        // forearm extension
        difference() {
            translate([-forearmLength, -armWidth / 2, 0])
                cube([forearmLength, armWidth, bearingStep * 2], center=false);
            cylinder(h = bearingStep * 2, d = bearingOD);
 /* original */
            translate([-forearmLength, 0, 0])
                 cylinder(h = bearingStep * 2, d = laserDiodeDiameter);
                 // 4 on next line comes from dividing the bearingOD on the above line
            translate([-forearmLength + laserDiodeDiameter, -(armWidth / 2) + boundingBoxHalf, 0])
                cube([forearmLength - (bearingOD/2) - (boundingBox + boundingBoxHalf), armWidth - boundingBox, bearingStep * 2], center = false);
/**/
        }

            intersection() {
            
                translate([-forearmLength + boundingBox / 2, -(armWidth / 2) + boundingBoxHalf, 0])
                    cube([forearmLength - (bearingOD / 2) - boundingBox, armWidth - boundingBox, bearingStep * 2], center = false);
                for (i = [ bearingOD / 2 - boundingBoxHalf: armWidth : forearmLength]) {
                    translate([ -i, 0, bearingStep])
                        rotate([0, 0, 45])
                            cube([spokeWidth, armWidth + boundingBoxHalf, bearingStep * 2], center = true);
                    translate([ -i, 0, bearingStep])
                        rotate([0, 0, -45])
                            cube([spokeWidth, armWidth + boundingBoxHalf, bearingStep * 2], center = true);
                }
            }
        // laser mount
        union() {
            translate([-forearmLength, 0, 0])
                difference() {
                    union() {
                        cylinder(h = bearingStep * 2, d = laserDiodeDiameter * 2);
                        translate([-laserDiodeDiameter * 1.75, -1.5, 0])
                            cube([laserDiodeDiameter + 4 * setScrewRadius, 3, bearingStep * 2]);
                    }
                    cylinder(h = bearingStep * 2, d = laserDiodeDiameter);
                    #translate([ - laserDiodeDiameter * 1.75, -.5, 0])
                        cube([laserDiodeDiameter + 4 * setScrewRadius, 1, bearingStep * 2], center = false);
                    translate([-laserDiodeDiameter - 1.5 * setScrewRadius, laserDiodeDiameter * 2, bearingStep])
                        rotate([90, 0, 0])
                            cylinder(h = laserDiodeDiameter * 4, r = setScrewRadius);
                }
            }

    }
}


module copy_mirror(vec=[0,1,0]) { 
    children(); 
    mirror(vec)
        children(); 
} 

module radial_array(vec = [0,0,1], n = 4) {
    for ( i = [0 : n - 1] )
    {
        rotate( i * 360 / n, vec)
            children();
    }   
}

module radial_array_partial(vec = [0,0,1], n = 4, j = 2) {
    for ( i = [0 : n - 1] )
    {
        if (i < j)
            rotate( i * 360 / n, vec)
                children();
    }   
}


/////////////////////////////
module assembly(){
    
    shoulderBasePlate();
    // shoulder lower stepper
    rotate([0, 180, 0]) 
        translate([-8, 0, 10]) 
            StepMotor28BYJ();
    // lower shoulder bearing
    translate([0, 0, shoulderBaseHeight + bearingStep])
        %bearing6807_2RS();
    // shoulder top
    color([.6, .6, .9]) 
        translate([0, 0, 2 * shoulderBaseHeight + (4 * bearing6807_2RS_B) + (8 * bearingStep)])
        rotate([180, 0, 0])
            shoulderBase(bearing6807_2RS_d - iFitAdjust_d, bearing6807_2RS_D + iFitAdjust, shoulderBaseHeight, shoulderBaseDiameter, shaftBossDiameter, mountScrewDiameter);
    // upper shoulder bearing
    translate([0, 0, shoulderBaseHeight + (3 * bearing6807_2RS_B) + (7 * bearingStep)])
        %bearing6807_2RS();
    // shoulder upper stepper
    rotate([0, 0, 180]) 
        translate([-8, 0, 10 + 2 * shoulderBaseHeight + (4 * bearing6807_2RS_B) + (8 * bearingStep)]) 
            StepMotor28BYJ();

    shoulderSpacerSet();
    armSection();  
    // upper arm
    color([.9, .7, .7]) 
        translate([0, 0, shoulderBaseHeight + ( 2*bearing6807_2RS_B) + (12 * bearingStep) - (.5 * bearingStep)]) 
            rotate([180, 0, 0])
                armLower(bearing6807_2RS_D + iFitAdjust, bearingStep, bearingStep, hubHeight, hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, screwTabs, screwTabHeight, armLength);
    // elbow joint pieces
    // lower bearing
    translate([-armLength, 0, shoulderBaseHeight + bearing6807_2RS_B + bearingStep])
        %bearing6807_2RS();
    // arm upper stepper
    translate([-armLength + 8, 0, shoulderBaseHeight + ( 3*bearing6807_2RS_B) + (16 * bearingStep) - (.5 * bearingStep)]) 
        rotate([0, 0, 180]) 
            StepMotor28BYJ();
    // arm lower stepper
    rotate([0, 180, 0]) 
        translate([armLength - 8, 0, bearingStep * 2]) 
            StepMotor28BYJ();            
            
    armSpacerSet();
    forearmSection();
    
    // upper
    render()
    color([.2, .8, .2])
    translate([-armLength, 0, shoulderBaseHeight + (bearing6807_2RS_B * 2) + (4 *bearingStep)])
        rotate([180, 0, 0])
            forearmLower(bearing6807_2RS_d - iFitAdjust_d, bearing6807_2RS_D + iFitAdjust, bearingStep, bearingStep, hubHeight + (bearing6807_2RS_B / 2) + (bearingStep/2), hubRadius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight, spokeWidth, spokes, forearmLength, boundingBox);
    // forearm upper bearing
    translate([-armLength, 0, shoulderBaseHeight + (2 * bearing6807_2RS_B) + (7 * bearingStep)])
        %bearing6807_2RS();    
}




/* [Hidden] */

/////////////////////////////////////////////////////////////////
// inline "includes"
//


// 28BYJ-48 from RGriffoGoes 
// at http://www.thingiverse.com/thing:204734
// named and measured dimensions, and
// added details by J.Beale 21 July 2014

MBH = 18.8;   // motor body height
MBD = 28.25;  // motor body OD
SBD = 9.1;    // shaft boss OD
SBH = 1.45;   // shaft boss height above motor body
SBO = 7.875;  // offset of shaft/boss center from motor center
SHD = 4.93;   // motor shaft OD
SHDF = 3.0;   // motor shaft diameter, across flats
SHHF = 6.0;   // motor shaft flats height, or depth in from end
SHH = 9.75;   // height of shaft above motor body 

MBFH = 0.7;   // height of body edge flange protruding above surface
MBFW = 1.0;   // width of edge flange
MBFNW = 8;    // width of notch in edge flange
MBFNW2 = 17.8;  // width of edge flange notch above wiring box

MHCC = 35.0;  // mounting hole center-to-center
MTH  = 0.8;   // mounting tab thickness
MTW  = 7.0;   // mounting tab width
WBH  = 16.7;  // plastic wiring box height
WBW  = 14.6;  // plastic wiring box width
WBD  = 31.3;  // body diameter to outer surface of wiring box

WRD = 1.0;     // diameter of electrical wires
WRL = 30;      // length of electrical wires
WRO = 2.2;		// offset of wires below top motor surface

// =========================================================
eps = 0.05;   // small number to avoid coincident faces


module wires() {
 
  color([0.9,0.9,0]) translate([0,WRD*2,0]) cylinder(h=WRL,r=WRD/2, $fn = 7);
  color([.9,.45,0]) translate([0,WRD*1,0]) cylinder(h=WRL,r=WRD/2, $fn = 7);   
  color([1,0,0]) translate([0,0,0]) cylinder(h=WRL,r=WRD/2, $fn = 7);
  color([1,.6,.6]) translate([0,-WRD*1,0]) cylinder(h=WRL,r=WRD/2, $fn = 7);
  color([.2,.2,1]) translate([0,-WRD*2,0]) cylinder(h=WRL,r=WRD/2, $fn = 7);
}

module StepMotor28BYJ()
{
  difference(){
    union(){
	   color("gray") translate([0,0,-(MBH+MBFH)/2])
		  difference() {  // flange at top rim
         cylinder(h = MBFH+eps, r = MBD/2, center = true, $fn = 50);
         cylinder(h = MBFH+2*eps, r = (MBD-MBFW)/2, center = true, $fn = 32);
			cube([MBFNW,MHCC,MBFH*2],center=true); // notches in rim
			cube([MBD+2*MBFW,SBD,MBFH*2],center=true);
		   translate([-MBD/2,0,0]) cube([MBD,MBFNW2,MBFH*2],center=true);
        }
		color("gray") // motor body
			cylinder(h = MBH, r = MBD/2, center = true, $fn = 50);
		color("gray") translate([SBO,0,-SBH])	// shaft boss
			cylinder(h = MBH, r = SBD/2, center = true, $fn = 32);

		translate([SBO,0,-SHH])	// motor shaft
        difference() {
			color("gold") cylinder(h = MBH, r = SHD/2, center = true, $fn = 32);
				// shaft flats
		   color("red") translate([(SHD+SHDF)/2,0,-(eps+MBH-SHHF)/2]) 
				cube([SHD,SHD,SHHF], center = true);
		   color("red") translate([-(SHD+SHDF)/2,0,-(eps+MBH-SHHF)/2]) 
				cube([SHD,SHD,SHHF], center = true);
        }


		color("Silver") translate([0,0,-(MBH-MTH-eps)/2]) // mounting tab 
			cube([MTW,MHCC,MTH], center = true);				
		color("Silver") translate([0,MHCC/2,-(MBH-MTH)/2]) // mt.tab rounded end
			cylinder(h = MTH, r = MTW/2, center = true, $fn = 32);
		color("Silver") translate([0,-MHCC/2,-(MBH-MTH)/2]) // mt.tab rounded end
			cylinder(h = MTH, r = MTW/2, center = true, $fn = 32);


		color("blue") translate([-(WBD-MBD),0,eps-(MBH-WBH)/2]) // plastic wire box
			cube([MBD,WBW,WBH], center = true);
	   color("blue") translate([-2,0,0])	
			cube([24.5,16,15], center = true);
		}

				// mounting holes in tabs on side
		color("red") translate([0,MHCC/2,-MBH/2])	
				cylinder(h = 2, r = 2, center = true, $fn = 32);
		color("red") translate([0,-MHCC/2,-MBH/2])	
				cylinder(h = 2, r = 2, center = true, $fn = 32);
		}
	}

// rotate([180,0,0]) {
//
//  StepMotor28BYJ();  // motor body (without wires)
//
//  // 5 colored hookup wires
//  translate([0,0,-(MBH/2 - WRO)]) rotate([0,-90,0])  
//	  wires();
// }

/////////////////////////////////////////////////////////////////

// Hub for 28BYJ-48 stepper motor w/ set screw
// Example for 3mm set screw:
//stepperHub(10, 7, 6, 3.1, 1.5, 2.75);
module stepperHub(height, radius, shaftHeight, shaftRadius, setScrewRadius, setScrewHeight) {
    //render(convexity = 3)
    difference() {
        // hub
        cylinder(h = height, r = radius, center = false);
        // shaft
        intersection() {
            cylinder(h = shaftHeight, r = shaftRadius, center = false);
            translate([-shaftRadius, -shaftRadius/2, 0])
                cube(size = [shaftRadius * 2., shaftRadius, shaftHeight], center = false);
        }
        // set screw hole
        translate([0, 0, setScrewHeight])
            rotate([90, 0, 0]) 
                cylinder(h = (radius * 2) + radius, r = setScrewRadius, center = true);
    }
}

/////////////////////////////////////////////////////////////////

// Values from http://www.astbearings.com/product.html?product=6807-2RS
bearing6807_2RS_rs = 1.2;	// lip width
bearing6807_2RS_d = 35;		// ID
bearing6807_2RS_D = 47;		// OD
bearing6807_2RS_B = 7;		// width

module bearing6807_2RS() {
    rs = bearing6807_2RS_rs;
    d = bearing6807_2RS_d;
    D = bearing6807_2RS_D;
    B = bearing6807_2RS_B;
	//render(convexity = 3)
    translate([0, 0, B / 2])
	union() {
        // outer lip
        difference() {
            cylinder(h = B, d = D, center = true);
            cylinder(h = B, d = D - rs, center = true);
        }
        // inner lip
        difference() {
            cylinder(h = B, d = d + rs, center = true);
            cylinder(h = B, d = d, center = true);
        }
        // race
            difference() {
                cylinder(h = B - (rs * 2), d = D, center = true);
                cylinder(h = B - (rs * 2), d = d, center = true);
            };
    }
}
