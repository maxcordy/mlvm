// Wheel parameters
diameter = 36.0;
spikeHeight = 9.0;
thickness = 22.0;
rimThickness = 2.0;
numberOfSpokes = 5;
rowsOfSpikes = 3;
spaceBetweenSpikes = 1.0;

LEGOFitFudgeFactor = 1.04;

// LEGO parameters
xCrossMainWidth = 5.0;
xCrossBeamWidth = 1.2 * 1.8;
xCrossMainWidthAddition = 3.0;

$fn=90;

module wheel () {
    difference () {
        cylinder (d=diameter,
                  h=thickness);
        translate([0,0,-1]) 
            cylinder (d=diameter-2*rimThickness,
                      h=thickness+2);
    }
    
    cylinder (d=xCrossMainWidth+2*xCrossMainWidthAddition,
              h=thickness);
    
    angleBetweenSpokes = 360.0/numberOfSpokes;
    
    for (spoke = [1 : numberOfSpokes]) {
        rotate (spoke*angleBetweenSpokes) {
            translate ([-rimThickness/2,0,0])
            cube([rimThickness, 0.5*(diameter-rimThickness),thickness]);
        }
    }
}

module shaft () {
    scale (LEGOFitFudgeFactor) {
        translate ([-0.5*xCrossMainWidth,
                    -0.5*xCrossBeamWidth,-1]) {
            cube ([xCrossMainWidth,xCrossBeamWidth,thickness+2]);
        }
        translate ([-0.5*xCrossBeamWidth,
                    -0.5*xCrossMainWidth,-1]) {
            cube ([xCrossBeamWidth,xCrossMainWidth,thickness+2]);
        }
    }
}

module spikes () {
    padding = (rowsOfSpikes+1)*spaceBetweenSpikes;
    spikeDiameter1 = (thickness-padding)/rowsOfSpikes;
    
    numberOfSpikesAround = floor((PI*diameter) / (spikeDiameter1+spaceBetweenSpikes));
    
    for (radRow = [1:numberOfSpikesAround]) {
        rotate (radRow * 360/numberOfSpikesAround) {
            for (row = [1 : rowsOfSpikes]) {
                translate ([diameter/2-(rimThickness/2),0,spikeDiameter1/2 + spaceBetweenSpikes]) {
                    translate ([0,0,(row-1)*(spikeDiameter1+spaceBetweenSpikes)]) {
                        rotate ([0,90,0]) {
                            cylinder (d1 = spikeDiameter1, d2=0, h=spikeHeight+(rimThickness/2));
                        }
                    }
                }
            }
        }
    }
}

module LEGOPart () {
    difference () {
        wheel();
        shaft();
    }
    spikes();
}

module testArticle () {
    thickness = 3;
    difference () {
        cylinder (d=xCrossMainWidth+2*xCrossMainWidthAddition,
                  h=thickness);
        shaft();
    }
}

//testArticle();
LEGOPart();