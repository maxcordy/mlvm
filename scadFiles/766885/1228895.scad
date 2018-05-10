// -------------------------------------------------------------------------------------------------

// Parametric Atomium Model v1
// © anton@cking.be
//   https://www.youmagine.com/users/ant0ni0
//   https://www.thingiverse.com/ant0ni0

// scale (using default parameters): 1/1000 (1mm := 1m)

// GLOBAL PARAMETERS -------------------------------------------------------------------------------

/* [Atomium] */

// what do you want to make?
make = "atomium"; // [atom:Atom, atomium:Atomium]

// axial distance between balls
cubeSize = 47;

ball_diameter = 18;

tube_diameter = 4; 

// elevation of the lowest ball
bottom_elevation = 3; 

/* [Base] */

// base is only printed for Atomium model, not for Atom

// number of corners of the base polygon at the bottom (zero = circle)
baseCorners = 3;

// thickness of base polygon
baseThickness = 2; // (zero = no base)

/* [Hidden] */

$fa = 0.5; // default minimum facet angle
$fs = 0.5; // default minimum facet size in mm
fnt = 0; // override number of faces for the tubes (overriding global $fn; use zero for no override)

// CALCULATED VALUES -------------------------------------------------------------------------------

// shorter variable names for my own convenience
dBall = ball_diameter;
dTube = tube_diameter;
eBottom = bottom_elevation;

lDiagonal = cubeSize / sin(35); // length of a diagonal tube // (81.942 m)
eMiddle = (lDiagonal + dBall) / 2 + eBottom; // elevation of middle of center ball

// BUILD -------------------------------------------------------------------------------------------

// uncomment one of the following and hit Preview (F5):

// atom or atomium (according to Customizer values)
build();

// just one of the supporting bipodes, not rotated
// bipode(rotV=0);     

// MODULES -----------------------------------------------------------------------------------------

module build()
{
    if (make == "atom")
        atom(false);
    else // (make == "atomium")
        atomium();
}

module atom(zCentered=true) // the iron atom, slightly enlarged
{
    halfSize = cubeSize / 2;

    translate(zCentered ? [0,0,0] : [0,0,(cubeSize+dBall)/2])
    {
        union()
        {
            %cube(cubeSize,center=true); // transparent, not included in output
            
            // 1 center sphere
            sphere(d=dBall);
            
            // 8 corner spheres
            for (x=[-halfSize,halfSize])
                for (y=[-halfSize,halfSize])
                    for (z=[-halfSize,halfSize])
                        translate([x,y,z]) sphere(d=dBall);
                    
            // 4 horizontal tubes, x direction
            for (y=[-halfSize,halfSize])
                for (z=[-halfSize,halfSize])
                    translate([0,y,z]) rotate([0,90,0]) cylinder(d=dTube, h=cubeSize, center=true, $fn=fnt);
                
            // 4 horizontal tubes, y direction
            for (x=[-halfSize,halfSize])
                for (z=[-halfSize,halfSize])
                    translate([x,0,z]) rotate([90,0,0]) cylinder(d=dTube, h=cubeSize, center=true, $fn=fnt);
                
            // 4 vertical tubes
            for (x=[-halfSize,halfSize])
                for (y=[-halfSize,halfSize])
                    translate([x,y,0]) cylinder(d=dTube, h=cubeSize, center=true, $fn=fnt);
                
            // 4 diagonal tubes
            for (x=[-55,55])
                for (z=[-45,45])
                    rotate([x,0,z]) cylinder(d=dTube, h=lDiagonal, center=true, $fn=fnt);
        }
     
        if (rotated)
        {
            *union() // (alternative)
            {
                // 4 diagonal tubes, readily rotated:
                for (a=[0,70])
                    rotate([0,a,0]) cylinder(d=dTube, h=lDiagonal, center=true, $fn=fnt);
                for (f=[1,-1])
                    rotate([70*f,0,-30*f]) cylinder(d=dTube, h=lDiagonal, center=true, $fn=fnt);
            }
        }
    }
}

module atomium()
{
    // the translated (lifted up in the sky) and rotated atom
    translate([0,0,eMiddle]) rotate([45,-35,0]) atom();
    
    base();
    
    pavillion();

    for (a=[0,120,240])
        bipode(rotH=a);
}

module base(thickness=baseThickness)
{
    $fn = baseCorners;
    baseRadius = cubeSize + 1.5 * dBall;
    color([0,0.5,0]) translate([0,0,-thickness]) cylinder(r=baseRadius, h=thickness);
}

module pavillion()
{
    // central pavillion, main entrance of the Atomium
    
    dp = cubeSize - dBall;
    h1 = eBottom;
    h2 = dBall / 5;
    
    cylinder(d=dp, h=h1);
    translate([0,0,h1]) cylinder(d1=dp, d2=0, h=h2); // roof
}

module bipode(rotH=0, rotV=12)
{
    // structure supporting the first level, with stairs
    
    dx = cubeSize * cos(35) + 1;
    hb = (eBottom + cubeSize * sin(35) + cubeSize / 12) / cos(rotV);

    difference()
    {
        rotate([0,0,rotH])
        translate([dx+hb*sin(rotV),0,0])
        rotate([0,-rotV,0])
        {
            difference()
            {
                hull() // positive
                {
                    translate([-1,-8,-1]) cube([2,16,1]);
                    translate([-3,-4,hb]) cube([6,8,1]);
                }
                // (TODO draw stairs)
                hull() // negative
                {
                    translate([-2,-6,-4]) cube([4,12,4]);
                    translate([-4,-2,hb-6]) cube([8,4,1]);
                }
            }
        }
        base(10);
    }
}

// -------------------------------------------------------------------------------------------------
