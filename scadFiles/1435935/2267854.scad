/***********************************************************************
Name ......... : ToolMagneticHolder.scad
Content ...... : Generates a row of magnet holders to hang long tools
                 with handle like screwdrivers
Author ....... : Jean-Etienne BOUVET (Jeet)
Version ...... : V1.0 du 22/03/2016
Licence ...... : GPL
***********************************************************************/
/* [Display] */
Part = 0; // [0:All, 1:Holder]

/* [Tool] */
ToolNumber = 5;
ToolBodyLength = 130;
ToolBodyDiameter = 3;
ToolHandleLength = 100;
ToolHandleBaseDiameter = 15;
ToolHandleHeadDiameter = 20;

/* [Magnet] */
MagnetDiameter = 7;
MagnetThickness = 3;

/* [Block] */
HolderWidth = 20;
HolderDepth = 5;
ScrewDiameter = 4;

/* [Hidden] */
HolderOffset = 10+ToolHandleHeadDiameter;
MinThickness = (ToolHandleBaseDiameter-ToolBodyDiameter)/2;

$fn=60;

Angle = asin(ToolHandleHeadDiameter/2/(ToolBodyLength+ToolHandleLength));

translate([0, 0, MinThickness+ToolBodyDiameter/2]) {
  if(Part == 0) {
    %rotate([Angle, 0, 0]) {
      translate([0, HolderWidth-ToolBodyLength, 0])
        linearMatrix(numberX=ToolNumber, offsetX=HolderOffset)
          rotate([90, 0, 0])
            screwdriver();
    }
  }
  holder();
}

module holder() {
  side = sqrt(2*(HolderDepth+ToolBodyDiameter)*(HolderDepth+ToolBodyDiameter));
  height = MinThickness+HolderDepth+ToolBodyDiameter/2;
  difference() {
    rotate([90, 0, 0]) {
      difference() {
        translate([-HolderOffset/2, height/2-MinThickness-ToolBodyDiameter/2, -3*HolderWidth/4]) {
          minkowski() {
            cube([HolderOffset*ToolNumber, height/2, HolderWidth/2]);
            rotate([90, 0, 0])
              cylinder(d=HolderWidth/2, h=height/2);
          }
        }
        rotate([Angle, 0, 0])
          translate([0, 0, -HolderWidth/2])
            linearMatrix(numberX=ToolNumber, offsetX=HolderOffset) {
              linear_extrude(height=2*HolderWidth, center=true) {
                rotate([0,0,45])
                  minkowski() {
                    square([side, side]);
                    circle(d=ToolBodyDiameter);
                  }
              }
              rotate([-90, 0, 0]) {
                translate([0, 0, -MagnetThickness/2])
                  magnet();
              }
            }
      }
    }
    linearMatrix(numberX=2, offsetX=HolderOffset*ToolNumber)
      translate([-HolderOffset/2, HolderWidth/2, height-MinThickness-ToolBodyDiameter/2])
        screwHole(screwDiameter=ScrewDiameter, screwLength=height+1, headThroatDepth=10, conicHead=true);
  }
}

module magnet() {
  translate([0, 0, -MagnetThickness])
    cylinder(d=MagnetDiameter, h=10*MagnetThickness);
}

module screwdriver() {
  translate([0, 0, -ToolBodyLength]) {
    translate([0, 0, -ToolHandleLength])
      cylinder(d1=ToolHandleHeadDiameter, d2=ToolHandleBaseDiameter, h=ToolHandleLength);
    cylinder(d=ToolBodyDiameter, h=ToolBodyLength);
  }
}

/**
 * Duplicates childrens as many as specify and on specified axis
 */
module linearMatrix(offsetX=1, offsetY=1, offsetZ=1, numberX=1, numberY=1, numberZ=1, center=false) {
  translate(center ? [-(offsetX*(numberX-1))/2, -(offsetY*(numberY-1))/2, -(offsetZ*(numberZ-1))/2, ] : [0, 0, 0]) {
    for(nx=[0:numberX-1]) {
      translate([nx*offsetX, 0, 0])
        for(ny=[0:numberY-1]) {
          translate([0, ny*offsetY, 0])
            for(nz=[0:numberZ-1]) {
              translate([0, 0, nz*offsetZ])
                children();
            }
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
