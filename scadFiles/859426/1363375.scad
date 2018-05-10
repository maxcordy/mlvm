// -------------------------------------------------------------------------------------------------

// Filament Storage, Quick Change - with two 8mm steel rods in Ikea Samla box
// © anton@cking.be
//   https://www.youmagine.com/users/ant0ni0
//   https://www.thingiverse.com/ant0ni0

// GLOBAL PARAMETERS -------------------------------------------------------------------------------

/* [Dimensions] */

rd = 8.0;  // rod diameter
ss = 0.6;  // support slack
rs = 1.2;  // roller slack
gd = 2.2;  // groove depth
sw = 1.3;  // side width
gw = 4.0;  // groove width

od = 22.0; // overall diameter

/* [Hidden] */

$fa = 0.5; // minimum facet angle
$fs = 0.5; // minimum facet size

// BUILD -------------------------------------------------------------------------------------------

display();
//roller();
//2rollers();
//4rollers();
//support();

// MODULES -----------------------------------------------------------------------------------------

module display()
{
    for (f=[0,1])
        translate([f*290,0,0]) rotate([0,-90,f*180]) support();
    
    for (y=[-52,52])
        translate([-5,y,30]) rotate([0,90,0]) %cylinder(d=rd,h=300);
    
    // TODO add some rollers
}

module roller()
{
    difference()
    {
        union()
        {
            cylinder(d=od,h=sw);
            translate([0,0,sw]) cylinder(d1=od,d2=od-2*gd,h=gd);
            translate([0,0,sw+gd]) cylinder(d=od-2*gd,h=gw);
            translate([0,0,sw+gd+gw]) cylinder(d1=od-2*gd,d2=od,h=gd);
            translate([0,0,sw+2*gd+gw]) cylinder(d=od,h=sw);
        }
        
        translate([0,0,-1]) cylinder(d=rd+rs,h=99);
    }
}

module 2rollers()
{
    for (x=[0,od+2])
        translate([x,0,0]) roller();
}

module 4rollers()
{
    for (x=[0,od+2])
        for (y=[0,od+2])
            translate([x,y,0]) roller();
}

module support()
{
    difference()
    {
        translate([0,-64,0]) cube([40,128,40]);

        for (m=[0,1])
        {
            mirror([0,m,0])
            {
                translate([0,0,20]) rotate([4,86,0]) translate([4,0,-10])
                union()
                {
                    translate([0,49,0]) cylinder(d=24,h=80);
                    translate([-12,-10,0]) cube([24,59,80]);
                    translate([-12,49]) cube([12,12,80]);
                    translate([-24,0,0]) cube([20,80,80]);
                    //translate([-4,61,0]) rotate([0,0,45]) translate([-0.6,-0.6,0]) cube([1.2,1.2,80]);
                }
            }
        }
        
        for (f=[-1,1])
        {
            translate([30,f*52,-1]) cylinder(d=rd+ss,h=6);
            translate([0,f*74-10,0]) rotate([0,0,-f*4]) translate([-10,0,-1]) cube([60,20,30]);
        }

        hull()
        {
            for (y=[-32,32])
                translate([12,y,-1]) cylinder(d=18,h=10);
            translate([-2,-44,-1]) cube([1,88,10]);
        }
    }
}

// -------------------------------------------------------------------------------------------------
