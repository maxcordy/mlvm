// goals
//  hold spool in place on the bearings
//  use minimum plastic necessary for strength and stability
//    doesn't achieve this, but consideration given to easy printing
//
// inspiration
//  http://www.thingiverse.com/thing:283656
//  http://www.thingiverse.com/thing:971275

// bearing holding idea seen on 
//  http://micro3dfans.com/download/file.php?id=100&t=1&sid=dd6a0187c45290eb48d930511e0b8567
//  appears to simply be a larger washer holding things in place

// concerns
//  large frame on M3D likely to peel away unless I can get Cura to lay down a 0.1 mm base layer for great adhesion

// must have
//  funtional

// nice to have
//  elegant

// variables
reelWidth = 55; // ideally everything should be driven from this single value
reelOuter = 200; // used for positioning
bearingSeparation = 55; // this is up for tweaking
flangeWidth = 5;

groundClearanceBelowOuterWasher = 2; // tweaking

boxThickness = 4;

// ; printer specific
tolerance = .4;

module reel () {
    rotate([0,90,0])
    difference() {
        cylinder (h=reelWidth, d=reelOuter,center=true);
        difference() {
            cylinder (h=reelWidth-flangeWidth*2, d=reelOuter+1,center=true);
            cylinder (h=reelWidth-flangeWidth*2+1, d=reelOuter-10,center=true);
        }
    }
}

module bearing () {
    rotate([0,90,0])
    difference() {
        cylinder (h=bearingWidth,d=bearingOuter,center=true);
        cylinder (h=bearingWidth+1,d=bearingInner,center=true);
    }
}

module washer(height,inner,outer) {
    rotate([0,90,0])
    difference() {
        cylinder (h=height,d=outer,center=true);
        cylinder (h=height+1,d=inner,center=true);
    }
    
}

module bearingAndWashers () {
    bearing();
    translate([-(bearingWidth/2+1),0,0])
    washer(2,8,12);
    translate([-(bearingWidth/2+1+2),0,0])
    washer(2,8,supportingWasherOuter);
    translate([-(bearingWidth/2+1-0.25),0,0])
    washer(2.5,supportingWasherOuter-2,supportingWasherOuter);
    translate([(bearingWidth/2+1),0,0])
    washer(2,8,12);
}

module produceBearingsAndWasherGroups() {
    translate([reelWidth/2-bearingWidth/2+1,bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    rotate([0,0,180])
    bearingAndWashers();
    translate([-(reelWidth/2-bearingWidth/2+1),bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    bearingAndWashers();
    translate([-(reelWidth/2-bearingWidth/2+1),-bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    bearingAndWashers();
    translate([(reelWidth/2-bearingWidth/2+1),-bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
        rotate([0,0,180])
        bearingAndWashers();
}
$fn = 100;

bearingWidth = 7;
bearingInner = 8;
bearingOuter = 22;
supportingWasherOuter = bearingOuter+5; // also up for tweaking

%translate([0,0,sqrt(pow(reelOuter/2+bearingOuter/2,2)-pow(bearingSeparation/2,2))+supportingWasherOuter/2+groundClearanceBelowOuterWasher])
%reel();
%produceBearingsAndWasherGroups();

/*
%translate([-reelOuter/4-reelWidth/2-(bearingWidth/2+2),-bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
rotate([90,0,0])
difference() {
    cylinder(d=reelOuter/2, h=supportingWasherOuter, center=true);
    cylinder(d=reelOuter/2-8, h=supportingWasherOuter+1, center=true);
}
*/
difference() {
    union() {
        translate([0,0,(bearingOuter+groundClearanceBelowOuterWasher)/2])
        difference() {
            cube([reelWidth+bearingWidth/2-1.5+8+boxThickness*2,bearingSeparation+supportingWasherOuter+2+boxThickness*2,bearingOuter+groundClearanceBelowOuterWasher],center=true);
            cube([reelWidth+bearingWidth/2-1.5+8+tolerance,bearingSeparation+supportingWasherOuter+tolerance+2,bearingOuter+groundClearanceBelowOuterWasher+1],center=true);
        }
        translate([(reelWidth/2-2-flangeWidth-(boxThickness/2+1)-tolerance/2),-(bearingSeparation/2+2+1),(bearingOuter+groundClearanceBelowOuterWasher)/2])
        cube([boxThickness,bearingOuter+groundClearanceBelowOuterWasher,bearingOuter+groundClearanceBelowOuterWasher],center=true);
        translate([-(reelWidth/2-2-flangeWidth-(boxThickness/2+1)-tolerance/2),-(bearingSeparation/2+2+1),(bearingOuter+groundClearanceBelowOuterWasher)/2])
        cube([boxThickness,bearingOuter+groundClearanceBelowOuterWasher,bearingOuter+groundClearanceBelowOuterWasher],center=true);
        translate([-(reelWidth/2-2-flangeWidth-(boxThickness/2+1)-tolerance/2),(bearingSeparation/2+2+1),(bearingOuter+groundClearanceBelowOuterWasher)/2])
        cube([boxThickness,bearingOuter+groundClearanceBelowOuterWasher,bearingOuter+groundClearanceBelowOuterWasher],center=true);
        translate([(reelWidth/2-2-flangeWidth-(boxThickness/2+1)-tolerance/2),(bearingSeparation/2+2+1),(bearingOuter+groundClearanceBelowOuterWasher)/2])
        cube([boxThickness,bearingOuter+groundClearanceBelowOuterWasher,bearingOuter+groundClearanceBelowOuterWasher],center=true);
    };
    translate([-(reelWidth/2-bearingWidth/2+1),-bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    rotate([0,90,0])
    cylinder(d=8,h=bearingWidth+boxThickness*2+6+4,center=true);
    translate([-(reelWidth/2-bearingWidth/2+1),bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    rotate([0,90,0])
    cylinder(d=8,h=bearingWidth+boxThickness*2+6+4,center=true);
    translate([(reelWidth/2-bearingWidth/2+1),bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    rotate([0,90,0])
    cylinder(d=8,h=bearingWidth+boxThickness*2+6+4,center=true);
    translate([(reelWidth/2-bearingWidth/2+1),-bearingSeparation/2,supportingWasherOuter/2+groundClearanceBelowOuterWasher])
    rotate([0,90,0])
    cylinder(d=8,h=bearingWidth+boxThickness*2+6+4,center=true);
}