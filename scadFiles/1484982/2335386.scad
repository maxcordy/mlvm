/***********************************************************************
Name ......... : HobbingTooSupport.scad
Content ...... : Generates pieces to hold drill tight in order to hobb a bolt
Author ....... : Jean-Etienne BOUVET (Jeet)
Version ...... : V1.0 du 20/04/2016
Licence ...... : GPL
***********************************************************************/
part = 0; // [0:All, 1:Wheel, 2:DrillHolder, 3:Support, 4:Clic]

/* [Bolt] */
BoltDiameter = 8;
BoltLength = 40;

/* [Wheel] */
TeethNumber = 22;
WheelDiameter = 40;
WheelThickness = 4;
WheelAxisThickness = 6;
WheelThickness = 4;

/* [Support] */
SupportThickness = 5;
DrillXOffset = 27;
DrillYOffset = 50;
AxisHeight = 10;

/* [Drill] */
DrillDiameter = 19;
DrillHolderHeight = 10;
DrillHolderThickness = 3;
DrillHolderOpening = 3;

/* [Clic] */
ClicSpringThickness = 1.6;
ElasticHookDistance = 20;

/* [Other] */
ScrewDiameter = 3.1;
MinThickness = 2;
Spacing = 0.2;
DrillToolThickness = 0.9;

/* [Hidden] */
DrillZOffset = BoltDiameter;
ClicThickness = 2;
WheelArmNumber = 3;
ToothHeight = 2;
ToothWidth = 3.3;
ToothScale = ToothHeight/(cos(30)*ToothWidth/2);
BoltNutRatio = 0.9;
BoltHeadRatio = 1.25;
ClicOffset = WheelDiameter/2+1.5*SupportThickness;

/**********************************************************************/
/************************** POSITIONNING ******************************/
/**********************************************************************/
module clicFromScrewPosition() {
  translate([0, ClicOffset, 0])
    rotate([0, 0, -45])
      translate([WheelDiameter/2, 0, 0])
        children();
}

/**********************************************************************/
/***************************** ELEMENTS *******************************/
/**********************************************************************/
module clic() {
  d = 2*SupportThickness+ScrewDiameter;
  difference() {
    union() {
      difference() {
        hull() {
          cylinder(d=d, h=WheelThickness);
          clicFromScrewPosition()
            scale([ToothScale, 1, 1])
              rotate([0, 0, 90])
                cylinder(d=ToothWidth, h=WheelThickness, $fn=6);
        }
        translate([0, 0, -0.5]) {
          difference() {
            translate([0, ClicOffset, 0])
              cylinder(d=2*ClicOffset-d, h=WheelThickness+1);
            clicFromScrewPosition()
              translate([-ToothHeight, 0, 0])
                rotate([0, 0, -45])
                  cube([3*ToothHeight, 3*ToothHeight, WheelThickness+2]);
          }
          rotate([0, 0, 90])
            cube([d, d, WheelThickness+1]);
        }
      }
      hull() {
        cylinder(d=d, h=WheelThickness);
        translate([-d, 0, 0])
          cylinder(d=SupportThickness, h=WheelThickness);
      }
      translate([-d, 0, -SupportThickness]) {
        cylinder(d=SupportThickness, h=WheelThickness+SupportThickness);
        cylinder(d1=3*SupportThickness/2, d2=SupportThickness, h=SupportThickness/2);
      }
      clicFromScrewPosition() {
        scale([ToothScale, 1, 1])
          rotate([0, 0, 90])
            cylinder(d=ToothWidth, h=WheelThickness, $fn=6);
      }
    }
    translate([0, 0, -0.5])
      cylinder(d=ScrewDiameter, h=WheelThickness+1);
  }
}

module drillHolder() {
  d = 2*SupportThickness+ScrewDiameter;
  difference()
  {
    union() {
      rotate([0, 0, 90])
        holder(d=DrillDiameter, h=DrillHolderHeight, thick=DrillHolderThickness, screwDiameter=ScrewDiameter, holdingDistance=DrillHolderOpening, center=false);
        difference() {
          hull() {
            translate([ScrewDiameter-DrillXOffset, 0, 0])
              cylinder(d=d, h=DrillHolderHeight);
            cylinder(d=DrillDiameter-1, h=DrillHolderHeight);
          }
          translate([0, 0, -0.5])
          cylinder(d=DrillDiameter+1, h=DrillHolderHeight+1);
        }
    }
    translate([ScrewDiameter-DrillXOffset, 0, -0.5])
      cylinder(d=ScrewDiameter, h=DrillHolderHeight+1);
  }
}

module support() {
  d = 2*SupportThickness+ScrewDiameter;
  union() {
    rotate([0, -90, 0]) {
      translate([0, 0, -SupportThickness]) {
        tube(d=BoltDiameter, thick=SupportThickness, h=AxisHeight, center=false);
      }
      translate([0, -ClicOffset, 0]) {
        tube(d=ScrewDiameter, thick=SupportThickness, h=SupportThickness, center=false);
        translate([0, -ElasticHookDistance, 0]) {
          hull() {
            translate([-d/3, 0, 0])
              cube([SupportThickness/4, SupportThickness, SupportThickness]);
            translate([-d, 0, 0])
              cylinder(d=SupportThickness, h=SupportThickness);
          }
          translate([-d, 0, 0])
            hull() {
              cylinder(d=SupportThickness, h=SupportThickness);
              translate([0, -SupportThickness, 0])
                cylinder(d=SupportThickness/2, h=SupportThickness);
            }
        }
      }
    }
    translate([0, DrillYOffset-DrillHolderHeight, DrillZOffset]) {
      difference() {
        hull() {
          translate([-SupportThickness, -d, -d/2])
            cube([SupportThickness, d, d]);
          translate([ScrewDiameter, 0, 0])
            rotate([90, 0, 0])
              cylinder(d=d, h=d);
        }
        translate([ScrewDiameter, 0, 0])
          rotate([-90, 0, 0])
            screwHole(screwDiameter=ScrewDiameter, screwLength=15, headThroatDepth=0, nutDistance=d-ScrewDiameter+0.1, nutThroatDepth=0, conicHead=false, seal=false);
      }
    }
    difference() {
      hull() {
        translate([-SupportThickness, DrillYOffset-DrillHolderHeight-d, DrillZOffset-d/2])
          cube([SupportThickness, 1, d]);
        rotate([0, -90, 0])
          cylinder(d=BoltDiameter+2*SupportThickness, h=SupportThickness);
      }
      hull() {
        translate([-0.5-SupportThickness, DrillYOffset-DrillHolderHeight-d, DrillZOffset-ScrewDiameter/2])
          cube([SupportThickness+1, 1, ScrewDiameter]);
        translate([0.5, 0, 0])
          rotate([0, -90, 0])
            cylinder(d=BoltDiameter, h=SupportThickness+1);
      }
    }
    rotate([90, 0, -90])
      belt(d1=BoltDiameter, d2=ScrewDiameter, offset=ClicOffset+ElasticHookDistance-ScrewDiameter, thick=SupportThickness, h=SupportThickness, center=false);
  }
}

module wheel() {
  difference() {
    union() {
      difference() {
        cylinder(d=WheelDiameter, h=WheelThickness);
        translate([0, 0, -0.5])
          cylinder(d=WheelDiameter-2*WheelThickness, h=WheelThickness+1);
      }
      cylinder(d=WheelDiameter/2, h=WheelAxisThickness);
      circularMatrix(number=WheelArmNumber) {
        hull() {
          cylinder(d=2*BoltDiameter, h=WheelThickness);
          translate([WheelDiameter/2-WheelThickness, 0, WheelThickness/2])
            cube([WheelThickness, 0.5*BoltDiameter, WheelThickness], center=true);
        }
      }
    }
    translate([0, 0, MinThickness])
      cylinder(d=2*BoltNutRatio*BoltDiameter, h=BoltNutRatio*BoltDiameter, $fn=6);
    translate([0, 0, -0.5]) {
      cylinder(d=BoltDiameter, h=WheelAxisThickness+1);

      circularMatrix(number=TeethNumber, diameter=WheelDiameter)
        scale([ToothScale, 1, 1])
          rotate([0, 0, 90])
            cylinder(d=ToothWidth, h=WheelThickness+1, $fn=6);
      translate([5*WheelDiameter/16, 0, 0])
        cylinder(d=2, h=WheelThickness+1);
    }
  }
}

module holder(d=5, h=10, thick=3, screwDiameter=3, holdingDistance=2, center=false) {
  difference() {
    hull() {
      cylinder(d=d+2*thick, h=h, center=center);
      translate(center ? [0, -thick-holdingDistance/2, -h/2] : [0, -thick-holdingDistance/2, 0])
        cube([d/2+thick+2*screwDiameter+Spacing, 2*thick+holdingDistance, h]);
    }
    translate(center ? [] : [0, 0, -0.5])
      cylinder(d=d, h=h+1, center=center);
    translate(center ? [0, -holdingDistance/2, -h/2-0.5] : [0, -holdingDistance/2, -0.5])
      cube([d/2+thick+1+3*screwDiameter+Spacing, holdingDistance, h+1]);
    rotate([-90, 0, 180])
      translate([-(d/2+thick+screwDiameter+Spacing), center ? 0 : -h/2, holdingDistance/2+thick])
        screwHole(screwDiameter=ScrewDiameter, screwLength=d, headThroatDepth=d/2, nutDistance=holdingDistance+2*thick, nutThroatDepth=2*thick);
  }
}

/**********************************************************************/
/**************************** TOOL BOX ********************************/
/**********************************************************************/

module circularMatrix(radius=0, diameter=0, number=4, stepAngle=0, startAngle=0, endAngle=360) {
  r = diameter > 0 ? diameter/2 : radius;
  proceedingAngle = endAngle-startAngle;
  step = stepAngle > 0 ? stepAngle : proceedingAngle/(proceedingAngle%360 == 0 ? number : (number-1));
	for(i=[0:number-1]) {
		rotate([0, 0, startAngle+step*i]) {
			translate([r, 0, 0]) {
				children();
			}
		}
	}
}

/**
 * Provides a volume corresponding a screw hole with differents throats for screw and/or nut insertion
 */
module screwHole(screwDiameter=3, screwLength=15, headThroatDepth=10, nutDistance=0, nutThroatDepth=0, conicHead=false, seal=false) {
	union() {
		if(headThroatDepth > 0)
		  cylinder(d=2*screwDiameter, h=headThroatDepth);
    if(conicHead) {
      translate([0, 0, 0.01-screwDiameter/2])
        cylinder(d1=screwDiameter, d2=2*screwDiameter, h=screwDiameter/2);
    }
    if(seal && nutDistance>0) {
      translate([0, 0, 0.2-nutDistance])
        cylinder(d=screwDiameter, h=nutDistance-0.4);
      translate([0, 0, -screwLength])
        cylinder(d=screwDiameter, h=screwLength-nutDistance-screwDiameter-0.2);
    } else {
      translate([0, 0, 0.01-screwLength])
        cylinder(d=screwDiameter, h=screwLength+0.01-(seal ? 0.2 : 0));
    }
		if(nutDistance>0) {
		  translate([0, 0, -screwDiameter/2-nutDistance]) {
        cylinder(d=2*screwDiameter, h=screwDiameter, center=true, $fn=6);
        if(nutThroatDepth>0) {
          translate([-nutThroatDepth/2, 0, 0])
          cube([nutThroatDepth, 1.8*screwDiameter, screwDiameter], center=true);
        }
		  }
		}
	}
}

module tube(d=8, thick=5, h=10, center=false) {
  difference() {
    cylinder(d=d+2*thick, h=h, center=center);
    translate([0, 0, (center ? 0 : -0.5)])
      cylinder(d=d, h=h+1, center=center);
  }
}


module belt(d1=5, d2=20, offset=15, thick=2, h=10, center=false) {
  translate(center ? [-offset/2, 0, -h/2] : [])
    difference() {
      hull() {
        cylinder(d=d1+2*thick, h=h);
        translate([offset, 0, 0])
          cylinder(d=d2+2*thick, h=h);
      }
      translate([0, 0, -0.5])
        hull() {
          cylinder(d=d1, h=h+1);
          translate([offset, 0, 0])
            cylinder(d=d2, h=h+1);
        }
    }
}

module hobbedBolt() {
  // Hobbed Head
  translate([0, 0, -1.25*BoltDiameter]) {
    linear_extrude(height=BoltHeadRatio*BoltDiameter) {
      difference() {
        circle(d=1.5*BoltDiameter);
        circularMatrix(radius=2.5*BoltDiameter/2-1.5, number=TeethNumber)
          square([BoltDiameter, DrillToolThickness], center=true);
      }
    }
  }
  // Core
  cylinder(d=BoltDiameter, h=BoltLength);
}

module nut() {
  linear_extrude(height=BoltNutRatio*BoltDiameter) {
    difference() {
      circle(d=2*BoltNutRatio*BoltDiameter, $fn=6);
      circle(d=BoltDiameter);
    }
  }
}
/**********************************************************************/
/**************************** RENDERING *******************************/
/**********************************************************************/

$fn=60;
if(part == 0) {
  rotate([0, 0, -90]) {
    rotate([0, -90, 0]) {
      translate([0, 0, SupportThickness]) {
        rotate([0, 0, -45])
          wheel();
        translate([0, 0, MinThickness]) {
          %nut();
          translate([0, 0, BoltNutRatio*BoltDiameter])
            rotate([0, 0, 10])
              %nut();
        }
      }
    }
    translate([DrillXOffset, 0, 0]) {
      rotate([0, -90, 0])
        translate([0, 0, BoltHeadRatio*BoltDiameter/2])
          %hobbedBolt();
    }
    translate([DrillXOffset, DrillYOffset, DrillZOffset])
      rotate([90, 0, 0])
        drillHolder();
    support();
    translate([-SupportThickness, -ClicOffset, 0])
      rotate([0, -90, 0])
        clic();
  }
} else {
  if(part == 1) {
    wheel();
  }
  if(part == 2) {
    drillHolder();
  }
  if(part == 3) {
    translate([0, 0, SupportThickness])
      rotate([0, -90, 0])
        support();
  }
  if(part == 4) {
    translate([0, 0, WheelThickness])
      rotate([0, 180, 0])
        clic();
  }
}
