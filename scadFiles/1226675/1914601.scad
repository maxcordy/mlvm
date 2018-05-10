PI = 3.14 * 1;

//  Amount of segments in a circle
$fn = 40;

//  Amount of different angles at which the blades can be put, put at least 6, else the rings can't be put onto the ax
axEdges = 8;

//  Clearances on the axes are determined by your nozzleradius
nozzleRadius = 0.35 / 2;

//  The radius of the ax through the rings, don't make this smaller than 4 for stability
axRadius = 4;

//  Base radius of the rings
ringRadius = 6;

//  Cutting length of each blade
cuttingLength = 30;
outerRadius = 2 * cuttingLength / (2 * PI);

//  Thickness of the cutting part of the ring, smaller values make the blades sharper
ringThickness = 2;

//  Axial distance between cutting edges
ringSpacer = 4;

//  Amount of cutting rings in the devices
amountRings = 24;

//  Total length of the handle to hold the device
handleLength = 150;

//  Thickness of the handle in z direction
handleHeight = ringRadius * 2;

//  Thickness of the handle in x direction
handleThickness = 7.5;

//  The radius of the hole in the handle to hang it on
handleHoleRadius = 5;

assembly();

module assembly()
{
    handle();
    rotate([0, 0, 90])
    {
        ax();
    }
    translate([amountRings * ringSpacer, 0, 0])
    {
        array(amountRings);
    }
}

module array(x){
    dimension = ceil(sqrt(x));
    spacing = 2 * outerRadius + 5;
    
    for(i = [0:dimension - 1]){
        for(j = [0:dimension - 1]){
            if(dimension * i + j < x){
                translate([i * spacing, j * spacing, 0]){
                    ring();
                }
            }
        }
    }
}

module handle()
{
    difference()
    {
        union()
        {
            handleHalf();
            mirror()
            {
                handleHalf();
            }
        }
        translate([0, ringRadius, handleHeight / 2])
        {
            for(i = [-1:2:1])
            {
                rotate([0, i * 90, 0])
                {
                    cylinder(r = axRadius + nozzleRadius, h = amountRings * ringSpacer);
                }
                translate([-amountRings * ringSpacer / 2 - handleThickness - 0.1, -ringRadius - 0.1, -handleHeight / 2 - 0.1])
                {
                    difference()
                    {
                        cube([amountRings * ringSpacer + 2 * handleThickness + 0.2, ringRadius + 0.2, handleHeight + 0.2]);
                        translate([0.1, ringRadius + 0.1, handleHeight / 2 + 0.1])
                        {
                            rotate([0, 90, 0])
                            {
                                cylinder(r = ringRadius, h = amountRings * ringSpacer + 2 * handleThickness);
                            }
                        }
                    }
                }
            }
        }
        translate([0, handleLength - handleThickness - handleHoleRadius, -0.1])
        {
            cylinder(r = handleHoleRadius, h = handleThickness * 2 + 0.2);
        }
    }
}

module handleHalf()
{
    width1 = amountRings / 2 * ringSpacer;
    width2 = width1 + handleThickness;
    width3 = handleThickness;
    
    height1 = 3 * handleThickness + outerRadius;
    height2 = height1 + width2 - width3;
    height3 = handleLength;
    height4 = height2 - width3;
    height5 = height1 - handleThickness;
    
    linear_extrude(height = handleHeight)
    {
        polygon(    points  =   [   [width1, 0],
                                    [width2, 0],
                                    [width2, height1],
                                    [width3, height2],
                                    [width3, height3],
                                    [0, height3],
                                    [0, height4],
                                    [width1, height5]
                                ]);
    }
}

module ax()
{
    height = amountRings * ringSpacer + 2 * handleThickness + 4 * ringThickness;
    union()
    {
        cylinder(r = axRadius, h = 2 * ringThickness, $fn = axEdges);
        translate([0, 0, 2 * ringThickness])
        {
            cylinder(r = axRadius * cos(30), h = handleThickness);
            translate([0, 0, handleThickness])
            {
                cylinder(r = axRadius, h = amountRings * ringSpacer, $fn = axEdges);
                translate([0, 0, amountRings * ringSpacer])
                {
                    cylinder(r = axRadius * cos(30), h = handleThickness);
                    translate([0, 0, handleThickness])
                    {
                        cylinder(r = axRadius, h = 2 * ringThickness, $fn = axEdges);
                    }
                }
            }
        }
    }
    for(i = [-1:2:1])
    {
        translate([i * (axRadius + 2 * ringRadius), 0, 0])
        {
            difference()
            {
                cylinder(r = ringRadius, h = ringThickness);
                translate([0, 0, -0.1])
                {
                    cylinder(r1 = axRadius, r2 = axRadius + nozzleRadius, h = ringThickness + 0.2, $fn = axEdges);
                }
            }
        }
    }
}

module ring()
{
    difference()
    {
        union()
        {
            difference()
            {
                cylinder(r1 = outerRadius, r2 = ringRadius, h = ringThickness);
                translate([-outerRadius, 0, -0.1])
                {
                    cube(2 * outerRadius + 0.2);
                }
            }
            cylinder(r = ringRadius, h = ringSpacer);
        }
        translate([0, 0, -0.1])
        {
            cylinder(r = axRadius + nozzleRadius, h = ringSpacer + 0.2, $fn = axEdges);
        }
    }
}