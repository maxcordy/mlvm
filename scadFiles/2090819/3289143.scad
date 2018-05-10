// Just for presentation purposes
showClosed = 1; // [0:Open, 1:Closed]

// Show parts
showParts = 0; // [0:All, 1:Base, 2:Lid]

// Outer box width
boxWidth = 50;

// Outer box depth
boxDepth = 30;

// Outer total box height
boxHeight = 40;

// Lid height
lidHeight = 15;

// Number of vertical spaces
numSeparatorsX = 2; // [1:20]

// Number of horizontal spaces
numSeparatorsY = 2; // [1:20]

// Outer wall thickness
wallThickness = 1.4;

// Tolerance
tolerance = 0.2;

// Text on base (empty to remove)
textBase = "Text";

// Base text size
textBaseSize = 7; // [3:50]

// Text on lid (empty to remove)
textLid = "Your";

// Lid text size
textLidSize = 8; // [3:50]


/* [Hidden] */
wt = wallThickness;

corner = 2;

$fn=60;

il=9;
iw=wt/2-tolerance;
internalWall = 1;

box();

module box() {
    if( showParts != 2 || showClosed ==1) {
        boxBase();
        separators(numSeparatorsX, numSeparatorsY, boxWidth, boxDepth, boxHeight-wt);
    }
    if (showClosed == 1 ) {
        %translate([0, 0, boxHeight]) rotate(a=[180, 0, 0]) boxLid();
    }
    else {
        if (showParts != 1) translate([boxWidth + 5, 0, 0]) boxLid();
    }
}


module separators (nx, ny, sizeX, sizeY, height) {
    xS = sizeX / nx;
    yS = sizeY / ny;
    union(){
        if ( nx > 1) {
            for ( a = [0 : nx-2] ) {
                translate([-sizeX/2+xS*(a+1), 0, 0])
                    linear_extrude(height=height)
                    square([internalWall, sizeY-2*wt], center = true);
            }
        }
        if ( ny > 1) {
            for ( b = [0 : ny-2] ) {
                translate([0, -sizeY/2+yS*(b+1), 0])
                    linear_extrude(height=height)
                    square([sizeX-2*wt, internalWall], center = true);
            }
        }
    }

}


module boxLid() {
    difference() {
        
        roundedCube(boxWidth, boxDepth, lidHeight, corner);
            
        translate([0, 0, lidHeight-il]) roundedCube(boxWidth-2*iw, boxDepth-2*iw, il+1, corner);
        translate([0, 0, wt]) roundedCube(boxWidth-2*wt, boxDepth-2*wt, lidHeight, corner);
        translate([0, 0, 0.5]) rotate(a=[180, 0, 0]) linear_extrude(height=2) text(textLid, valign="center", halign="center", font="Arial", size=textLidSize);
    }    
}

module boxBase() {
    difference(){
        union(){
            
            roundedCube(boxWidth, boxDepth, boxHeight-lidHeight, corner);
            translate([0, 0, boxHeight-lidHeight]) roundedCube(boxWidth-2*(wt-iw), boxDepth-2*(wt-iw), il, corner);
        }

        translate([0, 0, wt]) roundedCube(boxWidth-2*wt, boxDepth-2*wt, boxHeight, corner);
        translate([0, -boxDepth/2+0.5, (boxHeight-lidHeight)/2]) rotate(a=[90, 0, 0]) linear_extrude(height=2) text(textBase, valign="center", halign="center", font="Arial", size=textBaseSize);
        }
}


module roundedCube (w, d, h, r) {
    hull() {
        translate([-w/2+r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([-w/2+r, d/2-r, 0]) cylinder(r=r, h=h);    
        translate([w/2-r, -d/2+r, 0]) cylinder(r=r, h=h);
        translate([w/2-r, d/2-r, 0]) cylinder(r=r, h=h);
    }
}