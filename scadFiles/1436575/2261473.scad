/***********************************************************************
Name ......... : J-HeadSupport.scad
Content ...... : Generates pieces to assembly a support for JHead on
                 a Prusa Mendel i3
Author ....... : Jean-Etienne BOUVET (Jeet)
Version ...... : V2.0 du 01/04/2016
Licence ...... : GPL
***********************************************************************/
part = 0; // [1:PrintableParts, 0:All, 1:Support, 2:JHeadHolder-part#1, 3:JHeadHolder-part#2, 4:SensorBracket, 5:ExtrusionCooler-part#1, 6:ExtrusionCooler-part#2, 7:ExtrusionCooler-Bracket]

ScrewDiameter = 3;

/* [X Carriage Support] */
CarriageScrewDistance = 32;
CarriageHeight = 30;

/* [Sensor] */
SensorDiameter = 12;
SensorHeight = 43;
SensorDetectionDistance = 4;
//  /!\ WARNING /!\ : Take into account Y end stop (minY et maxY) of the bed carriage
SensorCarriageOffset = 45;

/* [Fan Cooler] */
FanSize=40;
FanHeight=10;
FanScrewDistance=32;

/* [J-Head] */
JHeadDiameters = 16;
JHeadCoolerDiameters = 25;
JHeadDimensions = [3.7, 9.3, 12.3, 18.3, 50.1, 80]; //Last value corresponds to global JHead height (from top to nozzle)

/* [Distances] */
ExtruderSupportOffset = 45;
ExtruderSensorDistance = 27.5;

/* [Hidden] */
Position = 0; // [0:Mounted, 1:Exploded]
ExplosionOffset = 25;
FilamentTubeDiameter = 4;

DefaultThickness = 5;
MinThickness = 2;
AirFlowBackThickness = 3;
HoldingSpace = 1;

FanRadiatorDistance = 1;
ExtrusionCoolerMouth = [20, 5];
ExtrusionCoolerNozzleDistance = 19;
ExtrusionCoolerBedDistance = 3;
ExtrusionCoolerIntDiameter = 5;
ExtrusionCoolerExtDiameter = 10;

AirFlowBackDepth = JHeadCoolerDiameters/2+4;
JHeadOffsetZ = JHeadDimensions[3]+(JHeadDimensions[4]-JHeadDimensions[3])/2;
SensorBracketWidth = SensorDiameter+2*DefaultThickness;
SensorBracketThickness = 1.5*DefaultThickness;
ExtruderBracketWidth = 0.8*FanSize;
CarriageWidth = ExtruderSensorDistance + ExtruderBracketWidth/2 + SensorBracketWidth/2;
CarriageHeight = CarriageScrewDistance;

/**********************************************************************/
/************************** POSITIONNING ******************************/
/**********************************************************************/
module extruderAxisPosition() {
  translate([-ExtruderSensorDistance/2, -ExtruderSupportOffset, JHeadOffsetZ]) {
    children();
  }
}

module coreFanAxisPositionFromExtruderCore() {
  rotate([-90, 0, 0]) {
    translate([0, (JHeadDimensions[3]+(JHeadDimensions[4]-JHeadDimensions[3])/2), 0]) {
      children();
    }
  }
}

module nozzleFanAxisPositionFromExtruderCore() {
  translate([0, 0, FanSize/2]) {
    rotate([-45, 0, 0]) {
      translate([0, FanSize/2, 0]) {
        children();
      }
    }
  }
}

module sensorAxisPosition() {
  translate([ExtruderSensorDistance/2, -SensorCarriageOffset, JHeadOffsetZ+SensorDetectionDistance/2-JHeadDimensions[5]]) {
    children();
  }
}

module carriageSurfacePosition() {
  translate([(FanSize-ExtruderSensorDistance)/4+CarriageWidth/2-ExtruderBracketWidth/2, -DefaultThickness-SensorBracketThickness/2, 2*ScrewDiameter-CarriageHeight/2-CarriageHeight/4]) {
    children();
  }
}

module extractionCoolerFanPosition() {
  extractionCoolerMainAirFlowPosition(d=ExtrusionCoolerExtDiameter, offset=(ExtrusionCoolerExtDiameter-ExtrusionCoolerIntDiameter)/2)
    rotate([0, 90, 0])
      translate([JHeadDimensions[4]-JHeadDimensions[5], 0, 0])
        children();
}

module extractionCoolerMainAirFlowPosition(d=5, offset=0) {
  rotate([0, 0, 180])
    moveFromNozzleToCoolerAirFlow()
      translate([-d/2, 0, ExtruderSupportOffset/2])
        straightenFromCoolerAirFlow()
          translate([offset-d*(1-cos(45)), 0, d*sin(20)])
            children();
}

module extrusionCoolerBracketPosition() {
  extruderAxisPosition()
    translate([10, 0, -JHeadDimensions[5]])
      extractionCoolerFanPosition()
        translate([0, -FanSize/2-2*ScrewDiameter, (MinThickness-ExtrusionCoolerExtDiameter)/2])
          children();
}

module moveFromNozzleToCoolerAirFlow() {
  translate([7, 0, 0])
    rotate([0, -20, 0])
      rotate([0, 90, 0])
        children();
}

module straightenFromCoolerAirFlow() {
  rotate([0, -90, 0])
    rotate([0, 20, 0])
      children();
}
/**********************************************************************/
/************************ PRINTABLE ELEMENTS **************************/
/**********************************************************************/
module extruderHolderPart1() {
  if((part==0) || (part==2)) {
    // JHead Bracket + Fan Air Way
    jHeadBracket();
    difference() {
      coreFanAxisPositionFromExtruderCore() {
        fanAirWay();
      }
      translate([-ExtruderBracketWidth/4, AirFlowBackDepth-AirFlowBackThickness, -JHeadDimensions[3]-DefaultThickness-2*ScrewDiameter]) {
        linearMatrix(numberX=2, offsetX=ExtruderBracketWidth/2)
          rotate([90, 0, 0])
            screwHole(screwDiameter=ScrewDiameter, screwLength=SensorBracketThickness+DefaultThickness, headThroatDepth=JHeadCoolerDiameters/2, boltDistance=AirFlowBackThickness+DefaultThickness-ScrewDiameter+0.1);
      }
    }
  }
}

module extruderHolderPart2() {
  if((part==0) || (part==3))
    union() {
      jHeadBracket(false);
      coreFanAxisPositionFromExtruderCore() {
        fanAirWay(false);
      }
    }
}

module sensorBracket() {
  anchorWidth = CarriageWidth - ExtruderBracketWidth;
  offsetX = (CarriageWidth - ExtruderSensorDistance - SensorBracketWidth)/2;
  offsetY = SensorCarriageOffset-DefaultThickness-SensorBracketThickness/2;
  offsetZ = JHeadOffsetZ-CarriageHeight/2;
  if((part==0) || (part==4))
    difference() {
      union() {
          hull() {
            sensorAxisPosition()
              translate([0, 0, SensorHeight/4])
                rotate([0, 0, 22.5])
                  cylinder(d=SensorBracketWidth, h=SensorBracketThickness, center=true);
            carriageSurfacePosition() {
              translate([0, -offsetY/2, -2*offsetZ/3])
                rotate([0, 90, 0])
                  cylinder(d=SensorBracketThickness, h=anchorWidth, center=true);
              }
          }
        sensorAxisPosition()
          translate([1.2*DefaultThickness+SensorDiameter/2, 0, SensorHeight/4])
            rotate([0, 90, 0])
              cylinder(d=SensorBracketThickness, h=DefaultThickness, center=true);
        hull() {
          carriageSurfacePosition() {
            translate([0, -offsetY/2, -2*offsetZ/3]) {
              rotate([0, 90, 0])
                cylinder(d=SensorBracketThickness, h=anchorWidth, center=true);
            }
            rotate([0, 90, 0])
              cylinder(d=SensorBracketThickness, h=anchorWidth, center=true);
          }
        }
        carriageSurfacePosition() {
          translate([0, 0, CarriageHeight/5])
            rotate([90, 0, 90])
              elongateCylinder(r=SensorBracketThickness/2, elongation=2*CarriageHeight/5, h=anchorWidth, center=true);
        }
      }
      carriageSurfacePosition() {
        translate([3*anchorWidth/8, SensorBracketThickness/4, CarriageHeight/5]) {
          linear_extrude(height=CarriageHeight, center=true)
            polygon([
              [-anchorWidth/8, SensorBracketThickness/4+0.1],
              [anchorWidth/8+0.1, SensorBracketThickness/4+0.1],
              [anchorWidth/8+0.1, -SensorBracketThickness/4],
            ]);
        }
        translate([0, SensorBracketThickness/2+DefaultThickness, CarriageHeight/5])
          rotate([-90, 0, 0])
            screwHole(screwDiameter=ScrewDiameter, screwLength=SensorBracketThickness+2*DefaultThickness, headThroatDepth=0, boltDistance=SensorBracketThickness+DefaultThickness-ScrewDiameter+0.1);
      }
      sensorAxisPosition() {
        translate([0, 0, SensorHeight/4])
          cylinder(d=SensorDiameter+0.2, h=SensorHeight, center=true);
         translate([1.8*DefaultThickness+SensorDiameter/2, 0, SensorHeight/4]) {
          rotate([0, 90, 0])
            screwHole(screwDiameter=ScrewDiameter, screwLength=2.5*DefaultThickness, headThroatDepth=10, boltDistance=DefaultThickness, boltThroatDepth=10, seal=true);
        }
      }
    }
}

module carriageBracket() {
  offsetY = JHeadOffsetZ-JHeadDimensions[3]-2*ScrewDiameter-DefaultThickness/2;
  offsetX = ExtruderSupportOffset-AirFlowBackDepth-DefaultThickness;
  devY = DefaultThickness*offsetY/offsetX;
  if((part==0) || (part==1))
    union() {
      difference() {
        rotate([90, 0, -90]) {
          translate([DefaultThickness/2, 0, ExtruderBracketWidth/2-(FanSize-ExtruderSensorDistance)/4]) {
            translate([0, 2*ScrewDiameter+DefaultThickness-CarriageHeight/2, 0]) {
              translate([0, 0, -CarriageWidth/2])
                elongateCylinder(r=DefaultThickness/2, elongation=CarriageHeight, h=CarriageWidth-ExtruderBracketWidth, center=true);
              difference() {
                hull() {
                  elongateCylinder(r=DefaultThickness/2, elongation=CarriageHeight, h=ExtruderBracketWidth, center=true);
                  translate([offsetX, offsetY, 0])
                    elongateCylinder(r=DefaultThickness/2, elongation=CarriageHeight, h=ExtruderBracketWidth, center=true);
                }
                translate([0, 0, -MinThickness])
                  hull() {
                    translate([DefaultThickness, devY, 0])
                      elongateCylinder(r=DefaultThickness/2, elongation=CarriageHeight-2*DefaultThickness, h=ExtruderBracketWidth, center=true);
                    translate([offsetX-DefaultThickness, offsetY-devY, 0])
                      elongateCylinder(r=DefaultThickness/2, elongation=CarriageHeight-2*DefaultThickness, h=ExtruderBracketWidth, center=true);
                  }
              }
            }
          }
        }
        translate([-CarriageScrewDistance/2, 0, 0]) {
          rotate([-90, 0, 0])
            linearMatrix(numberX=2, offsetX=CarriageScrewDistance)
              screwHole(screwDiameter=ScrewDiameter, screwLength=2*DefaultThickness, headThroatDepth=0, boltDistance=3*DefaultThickness/4);
        }
        carriageSurfacePosition() {
          translate([0, SensorBracketThickness/2+DefaultThickness-ScrewDiameter, CarriageHeight/5])
            rotate([-90, 0, 0])
              screwHole(screwDiameter=ScrewDiameter, screwLength=SensorBracketThickness+DefaultThickness, headThroatDepth=ScrewDiameter+0.1, boltDistance=SensorBracketThickness+DefaultThickness-2*ScrewDiameter);
        }
        extruderAxisPosition() {
          translate([-ExtruderBracketWidth/4, AirFlowBackDepth-AirFlowBackThickness, -JHeadDimensions[3]-DefaultThickness-2*ScrewDiameter]) {
            linearMatrix(numberX=2, offsetX=ExtruderBracketWidth/2)
              rotate([90, 0, 0])
                screwHole(screwDiameter=ScrewDiameter, screwLength=SensorBracketThickness+DefaultThickness, headThroatDepth=JHeadCoolerDiameters/2, boltDistance=AirFlowBackThickness+DefaultThickness-ScrewDiameter+0.1);
          }
        }
        extrusionCoolerBracketPosition()
          translate([-FanSize/6, 0, MinThickness])
            linearMatrix(numberX=2, offsetX=FanSize/3)
              cylinder(d=ScrewDiameter, h=2*MinThickness, center=true);
      }
      carriageSurfacePosition() {
        translate([3*(CarriageWidth - ExtruderBracketWidth)/8, SensorBracketThickness/4, CarriageHeight/5])
          linear_extrude(height=2*CarriageHeight/5, center=true)
            polygon([
              [-(CarriageWidth - ExtruderBracketWidth)/8, SensorBracketThickness/4+0.1],
              [(CarriageWidth - ExtruderBracketWidth)/8+0.1, SensorBracketThickness/4+0.1],
              [(CarriageWidth - ExtruderBracketWidth)/8+0.1, -SensorBracketThickness/4],
            ]);
      }
    }
}

module extrusionCooler(bottomPart=false) {
  if((part==0) || (part==5 && !bottomPart) || (part==6 && bottomPart)) {
    extruderAxisPosition() {
      translate([0, 0, -JHeadDimensions[5]]) {
        intersection() {
          if(bottomPart) {
            extractionCoolerSelectionVolume();
          } else {
            difference() {
              extractionCoolerFanPosition() {
                translate([0, 0, -0.02])
                  cube([ExtrusionCoolerExtDiameter+FanSize, 3*FanSize, ExtrusionCoolerExtDiameter], center=true);
              }
              extractionCoolerSelectionVolume();
            }
          }
          difference() {
            union() {
              extractionCoolerAirFlow(d=ExtrusionCoolerExtDiameter, offset=(ExtrusionCoolerExtDiameter-ExtrusionCoolerIntDiameter)/2);
              extractionCoolerFanPosition()
                linear_extrude(height=ExtrusionCoolerExtDiameter, center=true)
                  hull()
                    translate([-FanScrewDistance/2, -FanScrewDistance/2, 0])
                      linearMatrix(numberX=2, numberY=2, offsetX=FanScrewDistance, offsetY=FanScrewDistance)
                        circle(r=ScrewDiameter+1);
              extractionCoolerFanPosition()
                translate([0, 0, (MinThickness-ExtrusionCoolerExtDiameter)/2]) {
                  difference() {
                    hull() {
                      translate([0, -FanSize/2-2*ScrewDiameter, 0])
                        rotate([0, 0, 90])
                          elongateCylinder(r=1.5*ScrewDiameter, elongation=FanSize/3, h=MinThickness, center=true);
                      translate([-FanScrewDistance/2, -FanScrewDistance/2, 0])
                        linearMatrix(numberX=2, offsetX=FanScrewDistance)
                          cylinder(r=ScrewDiameter+1, h=MinThickness, center=true);
                    }
                    translate([-FanSize/6, -FanSize/2-2*ScrewDiameter, 0])
                      linearMatrix(numberX=2, offsetX=FanSize/3)
                        cylinder(d=ScrewDiameter, h=MinThickness+1, center=true);
                  }
                }
            }
            extractionCoolerAirFlow(d=ExtrusionCoolerIntDiameter, offset=0);
            extractionCoolerFanPosition()
              translate([0, 0, MinThickness])
                cylinder(d=FanSize-2*MinThickness, h=ExtrusionCoolerExtDiameter, center=true);
            extractionCoolerFanPosition()
              translate([0, 0, FanHeight+ExtrusionCoolerExtDiameter/2])
                circularMatrix(diameter=sqrt(2*FanScrewDistance*FanScrewDistance), number=4, startAngle=-45, endAngle=315)
                  rotate([0, 0, 180])
                    screwHole(screwDiameter=ScrewDiameter, screwLength=JHeadDimensions[2]+FanHeight, headThroatDepth=0, boltDistance=FanHeight+ExtrusionCoolerExtDiameter-ScrewDiameter+0.1, boltThroatDepth=2*ScrewDiameter, seal=true);
          }
        }
      }
    }
  }
}

module extrusionCoolerBracket(height=6) {
  if((part==0) || (part==7)) {
    extrusionCoolerBracketPosition()
      translate([-FanSize/6, 0, height/2])
        difference() {
          rotate([0, 0, -90])
            elongateCylinder(r=1.5*ScrewDiameter, elongation=FanSize/3, h=height);
          translate([0, 0, height/2])
            linearMatrix(numberX=2, offsetX=FanSize/3)
              cylinder(d=ScrewDiameter, h=height+0.1, center=true);
        }
  }
}

/**********************************************************************/
/***************************** ELEMENTS *******************************/
/**********************************************************************/
module extractionCoolerSelectionVolume() {
  extractionCoolerFanPosition() {
    union() {
      translate([FanSize/2-1.5*ScrewDiameter+0.05, 0, ExtrusionCoolerExtDiameter/3])
        cube([3*ScrewDiameter+0.1, 2*FanSize, ExtrusionCoolerExtDiameter/3], center=true);
      translate([FanSize/2+1.5*ScrewDiameter, 0, ExtrusionCoolerExtDiameter/4])
        cube([3*ScrewDiameter, 2*FanSize, ExtrusionCoolerExtDiameter/2], center=true);
      translate([FanSize/2+ExtrusionCoolerExtDiameter/4+20, 0, ExtrusionCoolerExtDiameter/2-JHeadCoolerDiameters])
        cube([40, 3*FanSize, 2*JHeadCoolerDiameters], center=true);
    }
  }
}

module extractionCoolerAirFlow(d=5, offset=0) {
  elongationFactor = 4;
  union() {
    difference() {
      circularMatrix(number=2, stepAngle=90, startAngle=135)
        moveFromNozzleToCoolerAirFlow()
          translate([0, 0, 0.5])  // Avoid non-manifold vertex
            cylinder(d=d, h=ExtruderSupportOffset/2);
      if(offset > 0) {
        translate([0, 0, ExtrusionCoolerBedDistance-5.1])
          cube([100, 100, 10], center=true);
        cylinder(r=ExtrusionCoolerNozzleDistance, h=10);
      }
    }
    hull() {
      extractionCoolerAirFlowConnection(d=d, offset=offset);
      extractionCoolerMainAirFlowPosition(d=d, offset=offset)
        elongateCylinder(r=d/2, elongation=elongationFactor*(d-2*offset), h=d, center=true);
    }
    extractionCoolerMainAirFlowPosition(d=d, offset=offset)
      translate([0, elongationFactor*(2*offset-d)/2, 0])
        elongateCylinder(r=d/2, elongation=elongationFactor*(d-2*offset), h=FanSize-2*offset);
  }
}

module extractionCoolerAirFlowConnection(d=5, offset=0) {
  hull()
    circularMatrix(number=2, stepAngle=90, startAngle=135)
      moveFromNozzleToCoolerAirFlow()
          translate([0, 0, ExtruderSupportOffset/2]) {
            cylinder(d=d, h=ExtruderSupportOffset/4);
            if(offset>0)
              cylinder(d=d-offset, h=offset+ExtruderSupportOffset/4);
          }
}

module jHeadBracket(part=true) {
  dim = [JHeadDiameters+4*ScrewDiameter, FanRadiatorDistance+JHeadCoolerDiameters/2+AirFlowBackDepth, JHeadDimensions[2]];
  majorationY = (JHeadDimensions[3]-JHeadDimensions[2])-(FanSize-(JHeadDimensions[4]-JHeadDimensions[3]))/2;
  maskHeight = part ? AirFlowBackDepth : FanRadiatorDistance+JHeadCoolerDiameters/2;
  intersection() {
    difference() {
      translate([0, AirFlowBackThickness/2, -(majorationY+dim[2])/2])
        rotate([90, 0, 180])
        linear_extrude(height=dim[1], scale=[0.8, 1], center=true)
          hull() {
            translate([-JHeadDiameters/2, 0])
              linearMatrix(numberX=2, offsetX=JHeadDiameters)
                circle(d=dim[0]-JHeadDiameters);
            translate([0, 0.5-dim[1]/2])
              square([dim[0], 1], center=true);
          }
        //cube([dim[0], dim[1], majorationY+dim[2]], center=true);
      translate([0,0,-JHeadDimensions[3]-1])
        cylinder(d=JHeadDiameters+0.1, h=JHeadDimensions[3]+1.1);
      translate([-JHeadDiameters/2, -JHeadDiameters/2, -JHeadDimensions[0]-(JHeadDimensions[1]-JHeadDimensions[0])/2])
        rotate([90, 0, 0])
          linearMatrix(numberX=2, offsetX=JHeadDiameters)
            rotate([0, 0, -90])
              screwHole(screwDiameter=ScrewDiameter, screwLength=JHeadDiameters+2*ScrewDiameter, headThroatDepth=10, boltDistance=JHeadDiameters, boltThroatDepth=dim[2], seal=true);
    }
    translate([0, (part ? 1 : -1)*(maskHeight/2+HoldingSpace/4), -(majorationY+dim[2])/2])
      cube([dim[0], maskHeight-HoldingSpace/2, majorationY+dim[2]], center=true);
  }
}

module fanAirWay(part=true) {
  dim = [FanSize, FanSize, (part ? AirFlowBackDepth : FanRadiatorDistance+JHeadCoolerDiameters/2)];
  radiatorHeight = (JHeadDimensions[1]-JHeadDimensions[0]-ScrewDiameter)+(JHeadDimensions[4]-JHeadDimensions[3])+1;
  radiatorDiameter = JHeadCoolerDiameters+1;
  wallDistance = AirFlowBackDepth-AirFlowBackThickness;
  exitThroatWidth = radiatorDiameter/4;
  exitThroatDepth = FanSize/2+0.1;
  intersection() {
    difference() {
      translate([0, 0, -FanRadiatorDistance/2+AirFlowBackDepth/2-JHeadCoolerDiameters/4])
        linear_extrude(height=FanRadiatorDistance+JHeadCoolerDiameters/2+AirFlowBackDepth, scale=[0.8, 1], center=true)
          hull()
            translate([-FanScrewDistance/2, -FanScrewDistance/2, 0])
              linearMatrix(numberX=2, numberY=2, offsetX=FanScrewDistance, offsetY=FanScrewDistance)
                circle(r=ScrewDiameter+1);
      difference() {
        hull() {
          translate([0, 0, -FanRadiatorDistance-radiatorDiameter/2]) {
            intersection() {
              cylinder(d=FanSize-2*MinThickness, h=1, center=true);
              cube([FanSize, radiatorHeight, 1], center=true);
            }
          }
          cube([radiatorDiameter, radiatorHeight, 1], center=true);
        }
        translate([0, 0, -FanRadiatorDistance-radiatorDiameter/2-1])
          circularMatrix(radius=sqrt(FanScrewDistance*FanScrewDistance+FanScrewDistance*FanScrewDistance)/2, number=4, startAngle=45, endAngle=405)
            cylinder(d=2*ScrewDiameter+2, h=FanRadiatorDistance+radiatorDiameter/2+2, $fn=6);
      }
      rotate([90, 0, 0]) {
        linear_extrude(height=radiatorHeight, center=true) {
          union() {
            scale([1, 2*wallDistance/radiatorDiameter])
              circle(d=radiatorDiameter);
            difference() {
              translate([exitThroatDepth/2, wallDistance/2])
                square([exitThroatDepth, wallDistance], center=true);
              translate([exitThroatDepth, 0])
                scale([(exitThroatDepth-radiatorDiameter/2)/(wallDistance-exitThroatWidth), 1])
                  circle(r=wallDistance-exitThroatWidth);
            }
          }
        }
        cylinder(d=JHeadDiameters, h=FanSize+0.1, center=true);
      }
      if(!part)
        translate([0, 0, -FanHeight-HoldingSpace/4-FanRadiatorDistance-JHeadCoolerDiameters/2])
          circularMatrix(radius=sqrt(FanScrewDistance*FanScrewDistance+FanScrewDistance*FanScrewDistance)/2, number=4, startAngle=45, endAngle=405)
            rotate([0, 180, 0])
              screwHole(screwDiameter=ScrewDiameter, screwLength=dim[2]+FanHeight, headThroatDepth=10, boltDistance=FanHeight+1.5*ScrewDiameter, boltThroatDepth=dim[2], seal=true);
    }
    if(part) {
      translate([0, 0, HoldingSpace/8+dim[2]/2])
        cube([dim[0], dim[1], dim[2]-HoldingSpace/4], center=true);
    } else {
      translate([0, 0, -HoldingSpace/8-dim[2]/2])
        cube([dim[0], dim[1], dim[2]-HoldingSpace/4], center=true);
    }
  }
}

module fan() {
  roundRadius = ScrewDiameter+1;
  linear_extrude(height=FanHeight, center=true) {
    difference() {
      translate([roundRadius-FanSize/2, roundRadius-FanSize/2, 0]) {
        hull() {
          linearMatrix(numberX=2, numberY=2, offsetX=FanSize-2*roundRadius, offsetY=FanSize-2*roundRadius) {
            circle(r=roundRadius);
          }
        }
      }
      circle(d=FanSize-1);
      translate([-FanScrewDistance/2, -FanScrewDistance/2, 0]) {
        linearMatrix(numberX=2, numberY=2, offsetX=FanScrewDistance, offsetY=FanScrewDistance) {
          circle(d=ScrewDiameter);
        }
      }
    }
  }
  cylinder(d=FanSize/2, h=FanHeight, center=true);
  linear_extrude(height=FanHeight, twist=30, center=true) {
    union() {
      circularMatrix(number=8)
        translate([3*FanSize/8-0.5, 0, 0])
          square([FanSize/4-1, 1], center=true);
    }
  }
}

module jHead() {
  // Top of JHead
  translate([0,0,-JHeadDimensions[0]])
    cylinder(d=JHeadDiameters, h=JHeadDimensions[0]);
  translate([0,0,-JHeadDimensions[1]])
    cylinder(d=JHeadDiameters[0], h=JHeadDimensions[1]-JHeadDimensions[0]);
  translate([0,0,-JHeadDimensions[2]])
    cylinder(d=JHeadDiameters, h=JHeadDimensions[2]-JHeadDimensions[1]);
  translate([0,0,-JHeadDimensions[3]])
    cylinder(d=9, h=JHeadDimensions[3]-JHeadDimensions[2]);
  translate([0,0,-JHeadDimensions[4]])
    // Radiator Volume
    cylinder(d=JHeadCoolerDiameters, h=JHeadDimensions[4]-JHeadDimensions[3]);
  translate([0,0,-JHeadDimensions[5]]) {
    // Throat
    translate([0,0,18])
      cylinder(d=6, h=JHeadDimensions[5]-18);
    // Heating Block
    translate([0,5,13])
      cube([20,20,10], center=true);
    // Nozzle
    translate([0,0,3])
      cylinder(d=10, h=5, $fn=6);
    cylinder(d1=1, d2=5, h=3);
  }
  // Pneumatic connector
  cylinder(d=3*FilamentTubeDiameter, h=10, $fn=6);
  // FilamentTube
  cylinder(d=FilamentTubeDiameter, h=100);
}

module sensor() {
  cylinder(d=SensorDiameter, h=SensorHeight);
  translate([0, SensorDiameter/3, SensorHeight])
    cylinder(d=SensorDiameter/3, h=2*SensorHeight);
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

module elongateCylinder(r=3, elongation=10, h=10, faceNumber=30, center=false) {
  hull() {
    translate([0, (center ? -elongation/2 : 0), 0])
      cylinder(r=r, h=h, $fn=faceNumber*2, center=center);
    translate([0, (center ? elongation/2 : elongation), 0])
      cylinder(r=r, h=h, $fn=faceNumber*2, center=center);
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

/**********************************************************************/
/**************************** RENDERING *******************************/
/**********************************************************************/
$fn=60;
if(part==0) {
  extruderAxisPosition() {
    %jHead(diameters=JHeadDiameters, dimensions=JHeadDimensions);
    %coreFanAxisPositionFromExtruderCore() {
      translate([0, 0, -FanRadiatorDistance-(FanHeight+JHeadCoolerDiameters)/2]) {
        fan();
      }
    }
    translate([0, 0, -JHeadDimensions[5]])
      extractionCoolerFanPosition()
        translate([0, 0, FanHeight/2+ExtrusionCoolerExtDiameter/2])
          %fan();
    *translate([0, 0, -JHeadDimensions[5]])
      cube([200, 200, 0.1], center=true); // Bed
  }
  sensorAxisPosition() {
    %sensor();
  }
}

if(Position==0) {
  if(part==0) {
    carriageBracket();
    extruderAxisPosition() {
      extruderHolderPart1();
      extruderHolderPart2();
    }
    sensorBracket();
    extrusionCooler(bottomPart=true);
    extrusionCooler(bottomPart=false);
    extrusionCoolerBracket();
  } else {
    translate([0, 0, DefaultThickness/4+CarriageWidth/2])
      rotate([0, -90, 0])
        carriageBracket();
    translate([0, 0, AirFlowBackDepth])
      rotate([-90, 0, 0])
        extruderHolderPart1();
    translate([0, 0, JHeadCoolerDiameters/2+FanRadiatorDistance])
      rotate([90, 0, 0])
        extruderHolderPart2();
    translate([0, 0, (FanSize-ExtruderSensorDistance)/4+CarriageWidth/4-ExtruderBracketWidth/4])
      rotate([0, -90, 0])
        sensorBracket();
    rotate([0, -90, 0])
      extrusionCooler(bottomPart=true);
    rotate([0, 90, 0]) {
      extrusionCooler(bottomPart=false);
      extrusionCoolerBracket();
    }
  }
} else {
  carriageBracket();
  translate([0, -ExplosionOffset, 0])
    extruderAxisPosition() {
      extruderHolderPart1();
      translate([0, -ExplosionOffset, 0])
        extruderHolderPart2();
    }
  translate([ExplosionOffset, -ExplosionOffset, 0])
    sensorBracket();
  translate([-ExplosionOffset/2, 0, ExplosionOffset])
    extrusionCoolerBracket();
  translate([-ExplosionOffset, 0, 0]) {
    extrusionCooler(bottomPart=false);
    translate([0, 0, -ExplosionOffset])
      extrusionCooler(bottomPart=true);
  }
}
