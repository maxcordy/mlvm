// Resolution of radius 
$fn=80;
// Variables
iNoOfHolders=4;
// Ratio: 2mm from side, 20mm in total (split in: 5 (free), 3 (material), 4 (free), 3 (material), 5 (free) = Total: 20mm)
lHolderLengthX=21.5;
lHolderWidthY=3;
lHolderHeightZ=lHolderWidthY;
lGapY=4;
lHolderMaxWidth=20;
lHolderSpacingY=(lHolderMaxWidth - lGapY - 2*lHolderWidthY) / 2;
lHolderRotationz=3;

lPlateMarginY=2;
lPlateHeightZ=10;
lPlateWidthY=iNoOfHolders*lHolderMaxWidth + 2*lPlateMarginY;
lPlateLengthX=4;
lPlateRotationY=4;
    
// Base Plate
rotate([0,lPlateRotationY,0]) translate([-lPlateLengthX+0.5,0,0]) cube([lPlateLengthX,lPlateWidthY,lPlateHeightZ]);

// Set # 1
	for (i = [0:iNoOfHolders-1]) {
    translate([0,lPlateMarginY + lHolderSpacingY +i*lHolderMaxWidth,0]) 
        rotate([0,0,lHolderRotationz]) cube([lHolderLengthX,lHolderWidthY,lHolderHeightZ]);
    translate([lHolderLengthX,lPlateMarginY + lHolderSpacingY +i*(lHolderMaxWidth)+ tan(lHolderRotationz)*lHolderLengthX + lHolderWidthY/2,0]) 
        cylinder(r=lHolderWidthY/2,h=lHolderWidthY);                           
    difference() {
        translate([lHolderLengthX,lPlateMarginY + lHolderSpacingY +i*lHolderMaxWidth + tan(lHolderRotationz)*lHolderLengthX + lHolderWidthY/2,lHolderHeightZ]) 
            sphere(lHolderWidthY/2);
        translate([lHolderLengthX-lHolderWidthY/2,lPlateMarginY + lHolderSpacingY +i*lHolderMaxWidth + tan(lHolderRotationz)*lHolderLengthX + lHolderWidthY/2,lHolderHeightZ])      
            cube([lHolderWidthY,lHolderWidthY,lHolderWidthY], center = true);
    }
      }

// Set # 2
	for (i = [0:iNoOfHolders-1]) {
    translate([0,lPlateMarginY + lHolderSpacingY + lHolderWidthY + lGapY + i*lHolderMaxWidth,0]) 
        rotate([0,0,-lHolderRotationz]) cube([lHolderLengthX,lHolderWidthY,lHolderHeightZ]);
    translate([lHolderLengthX,lPlateMarginY + lHolderSpacingY + lHolderWidthY + lGapY + i*lHolderMaxWidth + -tan(lHolderRotationz)*lHolderLengthX + lHolderWidthY/2,0]) 
        cylinder(r=lHolderWidthY/2,h=lHolderWidthY);                           
    difference() {
        translate([lHolderLengthX, lPlateMarginY + lHolderSpacingY + lHolderWidthY + lGapY + i*lHolderMaxWidth -tan(lHolderRotationz)*lHolderLengthX + lHolderWidthY/2,lHolderHeightZ]) 
            sphere(lHolderWidthY/2);
        translate([lHolderLengthX-lHolderWidthY/2, lPlateMarginY + lHolderSpacingY + lHolderWidthY + lGapY + i*lHolderMaxWidth -tan(lHolderRotationz)*lHolderLengthX + lHolderWidthY/2,lHolderHeightZ])      
            cube([lHolderWidthY,lHolderWidthY,lHolderWidthY], center = true);
    }
      }
