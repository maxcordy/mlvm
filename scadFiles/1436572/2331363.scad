/***********************************************************************
Name ......... : BowdenExtruder.scad
Content ...... : Generates pieces to assemble a BowdenExtruder
Author ....... : Jean-Etienne BOUVET (Jeet)
Version ...... : V2.2 du 19/04/2016
Licence ...... : GPL
***********************************************************************/
part = 0; // [0:All, 1:Base, 2:Arm, 3:Lever, 4:Puller, 5:Clamp, 6:Cone, 7:Cap]

PieceThickness = 5; // [2:0.1:10]
SupportScrewOffset = 31;  // [10:0.1:100]
PreventWarping = true; // [true:Yes,false:No]
ScrewDiameter = 3; // [2.5:0.1:10]

/* [Step Motor] */
NemaScrewOffset = 31;  // [10:0.1:100]
NemaSlidingSize = 5;  // [2:0.1:10]

/* [Gear] */
GearEntraxis = 42.5;  // [10:0.1:100]
SmallGearTeethNumber = 8; // [5:100]
LargeGearTeethNumber = 49; // [10:100]

/* [Traction Spring] */
TractionSpringDiameter = 7;  // [5:0.1:10]
TractionSpringLength = 27;  // [25:0.1:50]

/* [Tube Holder] */
FilamentTubeDiameter = 4;  // [2:0.1:8]

/* [Vibration Absorber] */
AbsorberWidth = 15;  // [10:0.1:30]
AbsorberThickness = 1.6;  // [1:0.1:3]
AbsorberLevelNumber = 2;  // [1:3]

/* [Hidden] */
Position = 0; // [0:Mounted, 1:Exploded]
ExplosionOffset = (Position==1 ? 25 : 0);

Spacing = 0.2;
DesignRadius = 3;
SolidityThickness = 2;

Bearing = [22, 8, 7]; // ExtDiameter, IntDiameter, Width
BearingSeparator = 5;
BearingEdge = 1;
CompressingScrewLength = 60;
CompressingAxisDistance = 20;
CompressingAngle = 25;
LockingAngle = 20;
CompressorScrewLength = 30;
CompressingArmWidth = 2*Bearing[2]+BearingSeparator;
ArmAxisLayers = 5;
HobbedScrewLength = 40;
HobbedScrewDiameter = Bearing[1];
HobbedScrewHeadDiameter = 1.5*HobbedScrewDiameter;
HobbedScrewHeadLength = 1.25*HobbedScrewDiameter;
GearRatio = SmallGearTeethNumber/LargeGearTeethNumber;
SmallGearDiameter = 2*GearEntraxis*GearRatio+2*DesignRadius;
GearHeigth = 10;

FilamentDiameter = 2;
HolderSpacing = FilamentTubeDiameter/3;

ClampingScrewHolderLength = 2*PieceThickness;

baseLength = (NemaSlidingSize+NemaScrewOffset+ScrewDiameter+2*PieceThickness)/2+GearEntraxis;
baseWidth = NemaScrewOffset+2*PieceThickness;
axisOffsetY = (Bearing[0]/2+PieceThickness-BearingEdge)-(baseWidth)/2;
axisRotationAngle = -asin(axisOffsetY/GearEntraxis);
axisOffsetX = -GearEntraxis*cos(axisRotationAngle);
filamentPositionX = axisOffsetX-HobbedScrewHeadDiameter/2-FilamentDiameter/4;
filamentPositionZ = 2*Bearing[2]+BearingSeparator+HobbedScrewHeadLength/2;
compressorPositionX = filamentPositionX-Bearing[0]/2+FilamentDiameter/4;
springDim=[1.5*baseWidth, AbsorberWidth, 2*PieceThickness, AbsorberThickness, AbsorberLevelNumber]; // Length, Width, Heigth, Thickness, LevelNumber

TractionSpringThickness = 1;
TractionSpringExtendedLength = 1.5*TractionSpringLength;
ArmGapWidth = TractionSpringDiameter+2*Spacing;
LeverGapWidth = TractionSpringDiameter+PieceThickness;
TractionSpringScrewOffset = 1.5*ScrewDiameter+TractionSpringDiameter/2;

ThightenConeHeight = 20;
ThightenConeMinThickness = 1.6;
ThightenConeMaxThickness = 2.5;

TubeHolderFootWidth = 15;
TubeHolderFootHeight = 5;
ThigtheningGap = 1;

ClampThickness = 1.5;
ClampHeight = 24;

ToothHeight = 1.5;
ClampScrewDiameter = FilamentTubeDiameter+2*(ThightenConeMaxThickness+ClampThickness+ToothHeight);

CapThickness = 2.5;
CapHeight = 7*ThightenConeHeight/8+CapThickness;
CapDiameter = FilamentTubeDiameter+2*(ThightenConeMaxThickness+ClampThickness+ToothHeight+CapThickness);
CapEdgeRadius = CapDiameter/6;
CapEdgeHeight = 2;
CapGripRadius = CapDiameter/6;
CapGripNumber = 10;
CapGripRatio = 1/3;

/**********************************************************************/
/************************** POSITIONNING ******************************/
/**********************************************************************/
/* Note:PositionHierarchy
{
  wheelAxisPosition
  {
    compressionAxisPosition
    {
      leverGripPosition {
        pullerToePosition
      }
      leverPosition
      pullerPosition
    }
  }
  compressorAxisPosition
  {
    compressorArmAxisPosition
  }
  filamentAxisPosition
  stepMotorSupportScrew
  clampingScrewAxisPosition
}
*/

module wheelAxisPosition() {
  translate([axisOffsetX, axisOffsetY, 0]) {
    children();
  }
}

module compressionAxisPosition() {
  wheelAxisPosition() {
    translate([0, -CompressingAxisDistance, Bearing[2]+BearingSeparator/2]) {
      rotate([-CompressingAngle, -90, 0]) {
        children();
      }
    }
  }
}

module leverGripPosition() {
  compressionAxisPosition() {
    rotate([LockingAngle, 0, 0])
      translate([0, 0, ArmGapWidth/2+PieceThickness+Bearing[0]])
        children();
  }
}

module pullerToePosition() {
  leverGripPosition() {
    rotate([0, 90, 0])
      translate([0, 15, 0])
        children();
  }
}

module leverPosition() {
  compressionAxisPosition() {
    translate([0, 0, LeverGapWidth/2+TractionSpringExtendedLength+2*PieceThickness-ScrewDiameter])
      children();
  }
}

module pullerPosition() {
  compressionAxisPosition() {
    translate([0, -TractionSpringScrewOffset, 2*LeverGapWidth+TractionSpringLength-ScrewDiameter + (TractionSpringDiameter+PieceThickness)/2])
      children();
  }
}

module compressorAxisPosition() {
  translate([compressorPositionX, axisOffsetY, 0]) {
    children();
  }
}

module compressorArmAxisPosition() {
  compressorAxisPosition() {
    translate([2*ScrewDiameter, ScrewDiameter+Bearing[0]/2, 0]) {
      children();
    }
  }
}

module filamentAxisPosition() {
  translate([filamentPositionX, 7*baseWidth/16, filamentPositionZ]) {
    rotate([-90, 0, 0]) {
      children();
    }
  }
}

module stepMotorSupportScrew() {
  translate([-(NemaSlidingSize+NemaScrewOffset)/2, -NemaScrewOffset/2, 0]) {
    children();
  }
}

module clampingScrewAxisPosition() {
  angle = acos(ScrewDiameter/NemaSlidingSize)+20;
  circularMatrix(radius=0, number=2, stepAngle=180) {
    stepMotorSupportScrew() {
      translate([NemaSlidingSize/2, 0, ScrewDiameter]) {
        rotate([90, 0, angle]) {
          children();
        }
      }
    }
  }
}

/**********************************************************************/
/***************************** ELEMENTS *******************************/
/**********************************************************************/
module puller() {
  width = LeverGapWidth-Spacing;
  difference() {
    intersection() {
      pullerPosition()
        translate([0, TractionSpringScrewOffset, -TractionSpringLength-width/2])
          rotate([-90, 0, 0])
            elongateCylinder(r=width/2, elongation=TractionSpringLength, h=50, center=true);
      leverCore();
    }
    pullerPosition()
      translate([0, 0, -TractionSpringLength/2])
        screwHole(screwDiameter=ScrewDiameter, screwLength=TractionSpringLength, headThroatDepth=0, nutDistance=width/2, nutThroatDepth=width/2+0.1);
    compressionAxisPosition() {
      translate([0, 0, 3*ScrewDiameter/2+PieceThickness+Bearing[0]+0.1]) {
        rotate([0, 90, 0])
          cylinder(d=ScrewDiameter-Spacing, h=CompressingArmWidth+0.1, center=true);
        translate([0, 0, TractionSpringDiameter/2-TractionSpringLength/2])
          cylinder(r=TractionSpringDiameter/2+Spacing, h=TractionSpringLength, center=true);
      }
    }
  }
}

module leverCore() {
  hull() {
    leverPosition() {
      translate([0, -TractionSpringScrewOffset, 0])
        rotate([0, 90, 0]) {
          cylinder(d=3*ScrewDiameter, h=CompressingArmWidth, center=true);
        }
    }
    leverGripPosition() {
      rotate([0, 90, 0])
        cylinder(d=ArmGapWidth, h=CompressingArmWidth, center=true);
    }
    pullerToePosition() {
      cylinder(d=3*ScrewDiameter, h=CompressingArmWidth, center=true);
    }
  }
}

module lever() {
  difference() {
    leverCore();
    leverPosition() {
      translate([0, 0, -TractionSpringLength/2-3*LeverGapWidth/4])
        rotate([-90, 0, 0])
          elongateCylinder(r=LeverGapWidth/2, elongation=TractionSpringLength, h=50, center=true);
      translate([0, -TractionSpringScrewOffset, ArmGapWidth/2])
        screwHole(screwDiameter=ScrewDiameter, screwLength=CompressingArmWidth, headThroatDepth=5);
    }
  }
}

module supportBracket(thickness=2*springDim[3]) {
  translate([baseLength-GearEntraxis, 0, 0]) {
    if((part==1) && PreventWarping) {
      translate([springDim[1]/2, springDim[0]/12-springDim[0]/2, 0])
        cylinder(d=max(2*springDim[1], 2*springDim[0]/6), h=0.2);
      translate([springDim[1]/2, -springDim[0]/12+springDim[0]/2, 0])
        cylinder(d=max(2*springDim[1], 2*springDim[0]/6), h=0.2);
    }
    translate([0, 0, springDim[2]/2]) {
    rotate([0, 0, -90])
      spring(width=springDim[0], height=springDim[1], thickness=springDim[3], level=springDim[4], levelLength=springDim[0]/6, extrude=springDim[2]);
    translate([springDim[1], 0, 0]) {
      rotate([0, -90, 0]) {
        difference() {
          hull() {
            cube([springDim[2], 3*springDim[0]/4, thickness], center=true);
            translate([springDim[2]+ScrewDiameter, SupportScrewOffset/2, 0])
              cylinder(d=2*PieceThickness+ScrewDiameter, h=thickness, center=true);
            translate([springDim[2]+ScrewDiameter, -SupportScrewOffset/2, 0])
              cylinder(d=2*PieceThickness+ScrewDiameter, h=thickness, center=true);
          }
          translate([springDim[2]+ScrewDiameter, SupportScrewOffset/2, 0])
            cylinder(d=ScrewDiameter, h=thickness+0.2, center=true);
          translate([springDim[2]+ScrewDiameter, -SupportScrewOffset/2, 0])
            cylinder(d=ScrewDiameter, h=thickness+0.2, center=true);
          }
        }
      }
    }
  }
}

module compressorArm(offset=0) {
  height = 2*Bearing[2]+BearingSeparator;
  difference() {
    union() {
      compressorAxisPosition() {
        translate([0, 0, height]) {
          cylinder(d=HobbedScrewDiameter+2*BearingEdge, h=(HobbedScrewHeadLength-Bearing[2])/2);
        }
      }
      hull() {
        compressorAxisPosition() {
          cylinder(d=HobbedScrewDiameter+2*PieceThickness, h=height);
        }
        leverGripPosition() {
          intersection() {
            rotate([0, 90, 0])
              cylinder(r=ArmGapWidth+PieceThickness/2, h=height, center=true);
            translate([-height/2, -(ArmGapWidth+PieceThickness/2), -1.5*(ArmGapWidth+PieceThickness/2)])
              cube([height, ArmGapWidth+PieceThickness/2, 2*(ArmGapWidth+PieceThickness/2)]);
          }
        }
        compressorArmAxisPosition() {
          cylinder(d=3*ScrewDiameter, h=height);
        }
      }
    }
    compressionAxisPosition() {
      translate([0, -15, 25])
        rotate([0, 0, 180])
          elongateCylinder(r=ArmGapWidth/2, elongation=30, h=50, center=true);
    }
    leverGripPosition() {
      rotate([0, 90, 0])
        translate([0, 0, -0.5-height/2])
          elongateCylinder(r=ArmGapWidth/2, elongation=1.5*CompressingArmWidth, h=height+1);
      translate([-0.5-height/2, -ArmGapWidth/2, 0])
        cube([height+1, CompressingArmWidth, ArmGapWidth]);
    }
    compressorArmAxisPosition() {
      joint(d1=ScrewDiameter, d2=3*ScrewDiameter+2*Spacing, h=height, layer=ArmAxisLayers, spacing=Spacing, part=false);
      difference() {
        rotate([0, 0, -50])
          cube([Bearing[0], Bearing[0], height+0.2]);
        cylinder(d=3*ScrewDiameter, height);
      }
    }
    translate([0,0,-0.1]) {
      compressorAxisPosition() {
        cylinder(d=HobbedScrewDiameter, h=height+Bearing[2]);
        rotate([0, 0, CompressingAngle])
          cylinder(d=2*HobbedScrewDiameter, h=HobbedScrewDiameter+0.2, $fn=6);
      }
      wheelAxisPosition() {
        cylinder(d=Bearing[0]+BearingEdge, h=Bearing[2]+BearingEdge);
        translate([0, 0, Bearing[2]+BearingSeparator-BearingEdge])
          cylinder(d=Bearing[0]+BearingEdge, h=Bearing[2]+2*BearingEdge);
      }
    }
  }
}

module base() {
  height = 2*Bearing[2]+BearingSeparator;
  difference() {
    // Positive
    union() {
      translate([baseLength/2-GearEntraxis, 0, PieceThickness/2]) {
        cube([baseLength, baseWidth, PieceThickness], center=true);
        translate([0, NemaScrewOffset/2, PieceThickness])
          cube([baseLength, ScrewDiameter+2*SolidityThickness, PieceThickness], center=true);
        translate([0, -NemaScrewOffset/2, PieceThickness])
          cube([baseLength, ScrewDiameter+2*SolidityThickness, PieceThickness], center=true);
      }
      hull() {
        wheelAxisPosition() {
          rotate_extrude() {
            hull() {
              square([SolidityThickness, height]);
              translate([Bearing[0]/2+PieceThickness-BearingEdge-DesignRadius, DesignRadius]) {
                square([2*DesignRadius, 2*DesignRadius], center=true);
                translate([0, height-2*DesignRadius]) {
                  circle(r=DesignRadius);
                }
              }
            }
          }
        }
        compressionAxisPosition() {
          rotate([0, 90, 0])
            cylinder(d=3*ScrewDiameter, h=height, center=true);
        }
        compressorArmAxisPosition() {
          cylinder(d=3*ScrewDiameter, h=height);
        }
      }
      clampingScrewAxisPosition() {
        difference() {
          translate([0, 0, 3*ScrewDiameter]) {
            hull() {
              sphere(d=2*PieceThickness);
              rotate([0, 0, 22.5])
                cylinder(d=3*ScrewDiameter, h=ClampingScrewHolderLength, $fn=8);
            }
          }
          translate([0, -PieceThickness/2-ScrewDiameter, ClampingScrewHolderLength])
            cube([3*ScrewDiameter, PieceThickness, 2*ClampingScrewHolderLength], center=true);
        }
      }
      supportBracket();
      translate([filamentPositionX, 0, height/2]) {
        hull() {
          translate([0, TubeHolderFootHeight/4+7*baseWidth/16])
            roundCube([TubeHolderFootWidth+TubeHolderFootHeight, 5*TubeHolderFootHeight/2], h=height, r=2, center=true);
          translate([GearEntraxis-baseLength/2, axisOffsetY, -height/4])
            cylinder(d=Bearing[0], h=height/2, center=true);
        }
      }
      filamentAxisPosition() {
        translate([0, 0, TubeHolderFootHeight/4]) {
          rotate([90, 0, 0]) {
            roundCube([TubeHolderFootWidth+TubeHolderFootHeight, 5*TubeHolderFootHeight/2], h=height, r=2, center=true);
          }
          translate([0, 0, -3*TubeHolderFootHeight/2])
            cube([FilamentTubeDiameter+TubeHolderFootHeight, height, TubeHolderFootHeight], center=true);
          translate([-(TubeHolderFootWidth+TubeHolderFootHeight)/2, 0, 0])
            rotate([0, -90, 0])
              rotate([0, 0, 22.5])
                cylinder(d1=ScrewDiameter+1.5*TubeHolderFootHeight, d2=ScrewDiameter+TubeHolderFootHeight, h=TubeHolderFootHeight/2, $fn=8);
        }
      }
    }
    // Negative
    hobbedScrew(offset=0.1);
    wheelBearing(offset=0.1);
    stepMotorSupportScrew() {
      translate([0, 0, -0.1]) {
      linearMatrix(numberX=2, numberY=2, offsetX=NemaScrewOffset, offsetY=NemaScrewOffset) {
        rotate([0, 0, -90]) {
          // Nema screw holes support
          translate([0, 0, ScrewDiameter])
            elongateCylinder(r=ScrewDiameter/2, elongation=NemaSlidingSize, h=2*PieceThickness+0.2);
          elongateCylinder(r=ScrewDiameter, elongation=NemaSlidingSize, h=ScrewDiameter+0.1);
          }
        }
      }
    }
    hull() {
      translate([0,0,-0.1]) {
        scale([(NemaScrewOffset/2-DesignRadius)/(NemaScrewOffset/2-PieceThickness-DesignRadius), 1, 1]) {
          circularMatrix(radius=max(SmallGearDiameter/2-DesignRadius/2, NemaScrewOffset/2-PieceThickness-DesignRadius), number=8, startAngle=22.5, endAngle=382.5) {
            cylinder(r=DesignRadius, h=PieceThickness+0.2);
          }
        }
      }
    }
    compressionAxisPosition() {
      translate([CompressingArmWidth/2, 0, 0]) {
        rotate([0, 90, 0])
          screwHole(screwDiameter=ScrewDiameter, screwLength=CompressingArmWidth, headThroatDepth=5, nutDistance=CompressingArmWidth-ScrewDiameter/2);
      }
      translate([0, 0, -2*ScrewDiameter])
        rotate([0, 0, 180])
          elongateCylinder(r=TractionSpringDiameter/2+Spacing, elongation=3*ScrewDiameter, h=TractionSpringLength);
    }
    compressorArmAxisPosition() {
      joint(d1=ScrewDiameter, d2=3*ScrewDiameter+2*Spacing, h=height, layer=ArmAxisLayers, spacing=Spacing, part=true);
      difference() {
        translate([0,0,-0.1])
          linear_extrude(height=height+0.2) {
            polygon([
              [0, 0],
              [Bearing[0]/3, -Bearing[0]/3],
              [-PieceThickness, -1.5*Bearing[0]],
              [-2*PieceThickness, -1.5*Bearing[0]],
              [-2*ScrewDiameter, 0]
            ]);
          }
        translate([0,0,-0.2])
          cylinder(d=3*ScrewDiameter+2*Spacing-0.1, h=height+0.4);
      }
      translate([0, 0, -0.1])
        cylinder(d=2*ScrewDiameter, h=ScrewDiameter+0.2, $fn=6);
      translate([0, 0, height])
        cylinder(d=2*ScrewDiameter, h=height);
    }
    clampingScrewAxisPosition() {
      translate([0, 0, 3*ScrewDiameter+ClampingScrewHolderLength])
        rotate([0, 0, 90])
          screwHole(screwDiameter=ScrewDiameter, screwLength=1.5*ScrewDiameter+ClampingScrewHolderLength, headThroatDepth=PieceThickness,
            nutDistance=2.5*ScrewDiameter, nutThroatDepth=2*PieceThickness);
    }
    filamentAxisPosition() {
      translate([-TubeHolderFootWidth/2, -TubeHolderFootWidth, -TubeHolderFootHeight/2])
        cube([TubeHolderFootWidth+Spacing, 2*TubeHolderFootWidth+Spacing, TubeHolderFootHeight+Spacing], center=false);
      rotate([0, 0, 180]) {
        elongateCylinder(r=FilamentTubeDiameter/2+ThightenConeMaxThickness+ClampThickness+Spacing, elongation=TubeHolderFootWidth, h=2*TubeHolderFootHeight);
        translate([0, 0, -2*TubeHolderFootHeight])
          elongateCylinder(r=FilamentTubeDiameter/2+Spacing, elongation=TubeHolderFootWidth, h=2*TubeHolderFootHeight);
      }
      translate([-(TubeHolderFootWidth+TubeHolderFootHeight)/2-ScrewDiameter, 0, TubeHolderFootHeight/4])
        rotate([0, -90, 0])
          rotate([0, 0, 30])
            screwHole(screwDiameter=ScrewDiameter+Spacing, screwLength=1.5*ScrewDiameter+ClampingScrewHolderLength, headThroatDepth=PieceThickness,
                nutDistance=TubeHolderFootHeight/2);
    }
  }
}


module baseScrew() {
  difference() {
    union() {
      translate([0, 0, TubeHolderFootHeight/2]) {
        cube([TubeHolderFootWidth, TubeHolderFootWidth, TubeHolderFootHeight], center=true);
        translate([0, 0, TubeHolderFootHeight/2]) {
          cylinder(d=FilamentTubeDiameter+2*(ThightenConeMaxThickness+ClampThickness), h=ClampHeight);
          translate([0, 0, ClampHeight/4])
            screw_thread(od=ClampScrewDiameter-Spacing,st=4,lf0=55,lt=3*ClampHeight/4,rs=PI/2,cs=2);
        }
      }
    }
    translate([0, 0, -0.5])
      cylinder(d=FilamentTubeDiameter, h=ClampHeight+TubeHolderFootHeight+1);
    translate([0, 0, ClampHeight-ThightenConeHeight+TubeHolderFootHeight+0.05]) {
      cylinder(d1=FilamentTubeDiameter+2*(ThightenConeMinThickness-Spacing), d2=FilamentTubeDiameter+2*(ThightenConeMaxThickness-Spacing), h=ThightenConeHeight);
      translate([0, 0, Spacing-ThightenConeMinThickness+0.05])
        cylinder(d1=FilamentTubeDiameter, d2=FilamentTubeDiameter+2*(ThightenConeMinThickness-Spacing), h=ThightenConeMinThickness-Spacing);
    }
  }
}

module thightenCone() {
  difference() {
    cylinder(d1=FilamentTubeDiameter+2*ThightenConeMinThickness, d2=FilamentTubeDiameter+2*ThightenConeMaxThickness, h=ThightenConeHeight);
    translate([0, 0, -0.5]) {
      cylinder(d=FilamentTubeDiameter, h=ThightenConeHeight+1);
      translate([0, -ThigtheningGap/2, 0])
        cube([FilamentTubeDiameter+2*ThightenConeMaxThickness, ThigtheningGap, ThightenConeHeight+1]);
    }
  }
}

module cap() {
  difference() {
    handle(diameter=CapDiameter, height=CapHeight, edgeHeight=CapEdgeHeight, edgeRadius=CapEdgeRadius, gripRadius=CapGripRadius, gripNumber=CapGripNumber, gripRatio=CapGripRatio, offset=0);
    cylinder(d=FilamentTubeDiameter+Spacing, h=CapHeight+1);
    translate([0, 0, -0.05])
      screw_thread(od=ClampScrewDiameter+Spacing,st=4,lf0=55,lt=CapHeight-CapThickness,rs=PI/2,cs=0);
  }
}

module wheelBearing(offset=0) {
  wheelAxisPosition() {
    translate([0, 0, -offset]) {
      // Bearing #1
      if(offset > 0) {
        hull() {
          cylinder(d=Bearing[0]+2*offset, h=Bearing[2]);
          cylinder(d=Bearing[0]-2*BearingEdge, h=Bearing[2]+BearingEdge+2*offset);
        }
      } else {
          cylinder(d=Bearing[0], h=Bearing[2]);
      }
      translate([0, 0, Bearing[2]+BearingSeparator]) {
        // Bearing #2
        cylinder(d=Bearing[0]+2*offset, h=Bearing[2]+2*offset);
      }
    }
  }
}

module compressorBearing(offset=0) {
  compressorAxisPosition() {
    translate([0, 0, 2*Bearing[2]+BearingSeparator+(HobbedScrewHeadLength-Bearing[2])/2-offset]) {
      // Bearing #3
      cylinder(d=Bearing[0]+2*offset, h=Bearing[2]+2*offset);
    }
  }
}

module compressorBolt(offset=0) {
  compressorAxisPosition() {
    translate([0, 0, 3*Bearing[2]+BearingSeparator+(HobbedScrewHeadLength-Bearing[2])/2-offset]) {
      // Screw Round Head
      cylinder(d=HobbedScrewHeadDiameter, h=HobbedScrewHeadLength);
      translate([0, 0, -CompressorScrewLength]) {
        // Screw Body
        cylinder(d=HobbedScrewDiameter, h=CompressorScrewLength);
        // Nut
        cylinder(d=2*HobbedScrewDiameter, h=HobbedScrewDiameter, $fn=6);
      }
    }
  }
}

module hobbedScrew(offset=0) {
  wheelAxisPosition() {
    translate([0, 0, 2*Bearing[2]+BearingSeparator-offset]) {
      // Screw Round Head
      cylinder(d=HobbedScrewHeadDiameter, h=HobbedScrewHeadLength);
      translate([0, 0, -HobbedScrewLength]) {
        // Screw Body
        cylinder(d=(offset>0 ? Bearing[0]-2*BearingEdge : HobbedScrewDiameter), h=HobbedScrewLength);
      }
    }
    translate([0, 0, -GearHeigth-HobbedScrewDiameter]) {
      cylinder(d=2*HobbedScrewDiameter, h=HobbedScrewDiameter, $fn=6);
    }
  }
}

module filament() {
  filamentAxisPosition() {
    cylinder(d=FilamentDiameter, h=100, center=true);
    translate([0, 0, Bearing[0]/3-baseWidth/2+axisOffsetY])
      cylinder(d=FilamentTubeDiameter, h=100);
  }
}

module gears() {
  cylinder(d=SmallGearDiameter, h=10);
  translate([0, 0, -GearHeigth]) {
    cylinder(r=GearRatio*GearEntraxis, h=GearHeigth);
    wheelAxisPosition() {
      cylinder(r=(1-GearRatio)*GearEntraxis, h=GearHeigth);
    }
  }
}

module stepMotor() {
  hull() {
    translate([-NemaScrewOffset/2, -NemaScrewOffset/2, 2*PieceThickness]) {
      linearMatrix(numberX=2, numberY=2, offsetX=NemaScrewOffset, offsetY=NemaScrewOffset) {
        cylinder(r=5, h=40, $fn=4);
      }
    }
  }
  cylinder(d=6, h=2*PieceThickness, center=true);
}

module tractionScrew() {
  leverPosition() {
    translate([0, -TractionSpringScrewOffset, ArmGapWidth/2]) {
      screw(screwDiameter=ScrewDiameter, screwLength=TractionSpringLength);
    }
  }
  compressionAxisPosition() {
    translate([CompressingArmWidth/2, 0, 0]) {
      rotate([0, 90, 0])
        screw(screwDiameter=ScrewDiameter, screwLength=CompressingArmWidth, nutDistance=CompressingArmWidth-ScrewDiameter/2);
    }
  }
}

module compressingSpring() {
  compressionAxisPosition() {
    translate([0, 0, (TractionSpringLength-ScrewDiameter)/2])
      tractionSpring(diameter=TractionSpringDiameter, length=TractionSpringLength, thick=TractionSpringThickness);
  }
}

module joint(d1=3, d2=10, h=30, layer=3, spacing=0.1, part=false, center=false) {
  step = h/layer;
  translate([0, 0, (center ? -h/2 : 0)]) {
    cylinder(d=d1, h=h+spacing, center=center);
    for(i=[(part ? 1 : 0) : 2 : layer-1]) {
      translate([0, 0, (i+0.5)*step])
        cylinder(d=d2, h=step+spacing, center=true);
    }
  }
}

module spring(width=50, height=20, thickness=2, level=2, levelLength=5, extrude=15) {
  linear_extrude(height=extrude, center=true) {
    springShape(width=width, height=height, thickness=thickness, level=level, levelLength=levelLength);
  }
}

module springShape(width=50, height=20, thickness=2, level=2, levelLength=0) {
	if(height/(2*level) < thickness) {
		echo("Too many level defined regarding to height and thickness");
	} else {
    translate([0, thickness/2])
      difference() {
        springForm(width=width-thickness, step=(height-thickness)/(2*level-1), level=level, levelLength=levelLength, offset=thickness/2);
        springForm(width=width-thickness, step=(height-thickness)/(2*level-1), level=level, levelLength=levelLength, offset=-thickness/2);
      }
	}
}

module springForm(width=50, step=3, level=1, levelLength=0, offset=1) {
  union() {
    for(l=[0:level-1]) {
      translate([0, (2*l+0.5)*step]) {
        if(l>0) {
          translate([0, -step])
            concave(width=width, height=step, levelLength=levelLength, offset=offset);
        }
        convex(width=width, height=step, offset=offset);
      }
    }
  }
}

module convex(width=30, height=10, offset=0) {
  size = width-height;
  h = height+2*offset;
  hull() {
    translate([size/2, 0])
      circle(d=h);
    translate([-size/2, 0])
      circle(d=h);
  }
}

module concave(width=30, height=10, levelLength=0, offset=0) {
  size = width-height-2*levelLength;
  h = height-2*offset;
  difference() {
    square([size, h+0.1], center=true);
    translate([size/2, 0])
      circle(d=h);
    translate([-size/2, 0])
      circle(d=h);
  }
}

module tube(intDiameter=8, extDiameter=25, height=10, center=false) {
  difference() {
    cylinder(d=extDiameter, h=height, center=center);
    translate([0, 0, (center ? 0 : -0.5)])
      cylinder(d=intDiameter, h=height+1, center=center);
  }
}

module elongateCylinder(r=3, elongation=10, h=10, faceNumber=30, center=false) {
  hull() {
    translate([0, (center ? -elongation/2 : 0), 0])
      cylinder(r=r, h=h, $fn=faceNumber*2, center=center);
    translate([0, (center ? elongation/2 : elongation), 0])
      cylinder(r=r, h=h, $fn=faceNumber*2, center=center);
  }
}

module roundCube(dim=[10, 10], h=5, r=2, center=false) {
  translate(center ? [r-dim[0]/2, r-dim[1]/2, 0] : [r, r, 0]) {
    hull() {
      linearMatrix(numberX=2, offsetX=dim[0]-2*r, numberY=2, offsetY=dim[1]-2*r) {
        cylinder(r=r, h=h, center=center);
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

module screw(screwDiameter=3, screwLength=15, nutDistance=0, hexaHead=false, conicHead=false) {
	union() {
    if(conicHead) {
      translate([0, 0, 0.01])
        cylinder(d1=screwDiameter, d2=2*screwDiameter, h=screwDiameter/2);
      translate([0, 0, screwDiameter/2]) {
        cylinder(d=2*screwDiameter, h=screwDiameter/2);
      }
    } else {
      cylinder(d=2*screwDiameter, h=screwDiameter, $fn=(hexaHead ? 6 : 30));
    }
    translate([0, 0, 0.01-screwLength])
      cylinder(d=screwDiameter, h=screwLength+0.01);
		if(nutDistance>0) {
		  translate([0, 0, -screwDiameter/2-nutDistance]) {
        cylinder(d=2*screwDiameter, h=screwDiameter, center=true, $fn=6);
		  }
		}
	}
}

module tractionSpring(diameter=5, length=20, thick=0.8) {
  tube(intDiameter=diameter-2*thick, extDiameter=diameter, height=length-diameter-thick, center=true);
  translate([0, 0, (length-diameter)/2+thick])
    rotate([0, 90, 0])
      tube(intDiameter=diameter-2*thick, extDiameter=diameter, height=thick, center=true);
  translate([0, 0, -(length-diameter)/2-thick])
    rotate([0, 90, 0])
      tube(intDiameter=diameter-2*thick, extDiameter=diameter, height=thick, center=true);
}

module handle(diameter=30, height=50, edgeHeight=5, edgeRadius=6, gripRadius=5, gripNumber=10, gripRatio=0.3, offset=0) {
  difference() {
    translate([0, 0, offset]) {
      rotate_extrude()
        handleShape(diameter=diameter, height=height, edgeRadius=edgeRadius, offset=offset);
    }
    difference() {
      circularMatrix(radius=diameter/2+(1-gripRatio)*gripRadius, number=gripNumber) {
        translate(edgeHeight>0 ? [] : [0, 0, -0.05])
          cylinder(r=gripRadius-offset, h=height+1);
      }
      if(edgeHeight>0)
        cylinder(d1=diameter+edgeHeight, d2=diameter-edgeHeight, h=2*edgeHeight);
    }
  }
}

module handleShape(diameter=30, height=50, edgeRadius=6, offset=0) {
  hull() {
    square([1, height]);
    square([diameter/2+offset, 1]);
    translate([diameter/2-edgeRadius+offset, height-edgeRadius])
      circle(r=edgeRadius);
  }
}

/**********************************************************************/
/**************************** TOOL BOX ********************************/
/**********************************************************************/
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
 * Duplicates childrens around Z axis at distance specified by radius (translated on X axis)
 */
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

module sectionView(normal=[0,0,-1], size=1000) {
  difference() {
    children();
    color("RED")
    translate([-normal[0]*size/2, -normal[1]*size/2, -normal[2]*size/2])
      cube([size, size, size], center=true);
  }
}

/**********************************************************************/
/**** External code (source http://www.thingiverse.com/thing:8796) ****/
/**********************************************************************/
/**
 * screw_thread( od,   // Outer diameter of the thread
 *               st,   // Step, traveling length per turn, also, tooth height, whatever...
 *              lf0,   // Degrees for the shape of the tooth 
 *                       (XY plane = 0, Z = 90, btw, 0 and 90 will/should not work...)
 *               lt,   // Length (Z) of the tread
 *               rs,   // Resolution, one face each "PI/2" mm of the perimeter, 
 *               cs);  // Countersink style:
 *                         -2 - Not even flat ends
 *                         -1 - Bottom (countersink'd and top flat)
 *                          0 - None (top and bottom flat)
 *                          1 - Top (bottom flat)
 *                          2 - Both (countersink'd)
 */
module screw_thread(od,st,lf0,lt,rs,cs) {
    or=od/2;
    ir=or-st/2*cos(lf0)/sin(lf0);
    pf=2*PI*or;
    sn=floor(pf/rs);
    lfxy=360/sn;
    ttn=round(lt/st+1);
    zt=st/sn;

    intersection()
    {
        if (cs >= -1)
        {
           thread_shape(cs,lt,or,ir,sn,st);
        }

        full_thread(ttn,st,sn,zt,lfxy,or,ir);
    }
}

module thread_shape(cs,lt,or,ir,sn,st) {
    if ( cs == 0 )
    {
        cylinder(h=lt, r=or, $fn=sn, center=false);
    }
    else
    {
        union()
        {
            translate([0,0,st/2])
              cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

            if ( cs == -1 || cs == 2 )
            {
                cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }

            translate([0,0,lt-st/2])
            if ( cs == 1 || cs == 2 )
            {
                  cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
            }
            else
            {
                cylinder(h=st/2, r=or, $fn=sn, center=false);
            }
        }
    }
}

module full_thread(ttn,st,sn,zt,lfxy,or,ir) {
  if(ir >= 0.2)
  {
    for(i=[0:ttn-1])
    {
        for(j=[0:sn-1])
			assign( pt = [	[0,                  0,                  i*st-st            ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt-st       ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,0,i*st],
                        [or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
                        [or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
                        [ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
                        [ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
                        [0,                  0,                  i*st+st            ]	])
        {
            polyhedron(points=pt,
              		  faces=[	[1,0,3],[1,3,6],[6,3,8],[1,6,4],
											[0,1,2],[1,4,2],[2,4,5],[5,4,6],[5,6,7],[7,6,8],
											[7,8,3],[0,2,3],[3,2,7],[7,2,5]	]);
        }
    }
  }
  else
  {
    echo("Step Degrees too agresive, the thread will not be made!!");
    echo("Try to increase de value for the degrees and/or...");
    echo(" decrease the pitch value and/or...");
    echo(" increase the outer diameter value.");
  }
}

/**********************************************************************/
/**************************** RENDERING *******************************/
/**********************************************************************/

$fn=30;
if(part == 0) {
  %if(Position==0) {
    gears();
    wheelBearing();
    hobbedScrew();
    compressorBearing();
    compressorBolt();
    compressingSpring();
    filament();
    stepMotor();
    tractionScrew();
  }
  base();
  translate([-ExplosionOffset, 0, 0])
    compressorArm();
  translate([-3*ExplosionOffset, 0, 0])
    lever();
  translate([-2*ExplosionOffset, 0, 0])
    puller();
  filamentAxisPosition() {
    //sectionView(normal=[1,1,0])
    {
      translate([0, -ExplosionOffset, -TubeHolderFootHeight/2]) {
        baseScrew();
        translate([0, 0, ExplosionOffset+ClampHeight-ThightenConeHeight+TubeHolderFootHeight+0.05])
          thightenCone();
        translate([0, 0, 2*ExplosionOffset+CapThickness+ClampHeight-ThightenConeHeight+TubeHolderFootHeight+0.05])
          cap();
      }
    }
  }
} else if(part == 1) {
  base();
} else if(part == 2) {
  translate([-ExplosionOffset, 0, 0])
    compressorArm();
} else if (part == 3) {
  rotate([0, -11, 0])
    rotate([-90, 0, 0])
  lever();
} else if(part == 4) {
  translate([-2*ExplosionOffset, 0, 0])
    puller();
} else if(part == 5) {
  baseScrew();
} else if(part == 6) {
  translate([0, 0, ThightenConeHeight])
    rotate([180,0,0])
      thightenCone();
} else if(part == 7) {
  translate([0, 0, CapHeight])
    rotate([180, 0, 0])
      cap();
}
