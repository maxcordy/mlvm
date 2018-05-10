
// CUSTOMIZER VARIABLES

// Precision of the model from 10 (low definition) to 180 (high definition)
PRECISION = 10; // [ 10:180 ]

// Rod thickness
ROD_Z = 3;

// Rod width
ROD_Y = 12;

// Radius of the screw hole
HOLE_R = 2;

// Height of the rod from the socle
HOOK_DZ = 10;

// Thickness of the socle
SOC_Z = 2.5;

//CUSTOMIZER VARIABLES END

$fn=PRECISION;

SOC_R = 1*2;
SOC_X = 2*ROD_Y;
SOC_Y = 1*12.5;

HOOK_R = ROD_Z/2+1.5;
HOOK_X = ROD_Y;
HOOK_Y = ROD_Y+2*HOLE_R;
HOOK_Z = 2*HOOK_R;

PASS_X  = HOOK_X+1;
PASS_Y  = ROD_Y-ROD_Z;
PASS_Z  = HOOK_DZ+HOOK_Z;
PASS_DZ = PASS_Z/2+SOC_Z;

module hook( h=HOOK_Z, w=HOOK_Y, l=HOOK_X ) {
    rotate ( [ 0, 0, 90 ] )
    union() {
        cube ( [w-h,l,h], center=true );
        translate( [ +(w/2-h/2), 0, 0 ] )
        rotate ( [ 90, 0, 0 ] )
        cylinder( r=h/2, h=l, center=true );
        translate( [ -(w/2-h/2), 0, 0 ] )
        rotate ( [ 90, 0, 0 ] )
        cylinder( r=h/2, h=l, center=true );
    }
}

difference() {

    union() {
        translate( [ SOC_R,SOC_R,0 ] )
        minkowski() {
            cube ( [SOC_X-2*SOC_R,SOC_Y-2*SOC_R,SOC_Z] );
            cylinder( r=SOC_R, h=0.0001 );
        }

        hull() {
            translate( [ SOC_X/2, SOC_Y/2, HOOK_DZ ] )
            hook();
            translate( [ SOC_X/2, SOC_Y/2, HOOK_Z/2 ] )
            hook();
        }
    }

    translate( [ SOC_X/2, SOC_Y/2, -0.01 ] )
    cylinder( r=HOLE_R, h=SOC_Z+0.1 );

    translate( [ SOC_X/2, SOC_Y/2, HOOK_DZ ] )
    hook( h=ROD_Z, w=ROD_Y, l=HOOK_X+4 );

    translate( [ SOC_X/2, SOC_Y/2, PASS_DZ ] )
    cube( [PASS_X,PASS_Y,PASS_Z], center=true );
}

