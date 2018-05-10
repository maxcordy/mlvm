//
//  SmallPlug.scad
//
//  Evilteach
//
//  07/22/2016
//
//  A model to allow construction of a small plug.
//  in my case it fills a small hole in the bottom of my lawnmower.
//  It may be of use to you.   If it is, leave me a note.
//


$fn = 90;

bottomRadius = 4;
bottomHeight = 1;

shaftRadius  = 2;
shaftHeight  = 2;

topRadius    = 2.5;
topHeight    = 3;

module bottom()
{
    color("cyan")
        cylinder(r2 = bottomRadius, r1 = bottomRadius - 1, h = bottomHeight);
}

module shaft()
{
    color("yellow")
        translate([0, 0, bottomHeight])
            cylinder(r = shaftRadius, h = shaftHeight);
}

module top()
{
    color("lime")
        translate([0, 0, bottomHeight + shaftHeight])
            cylinder(r1=topRadius, r2=topRadius - 1, h=topHeight);
}

module main()
{
    bottom();
    shaft();
    top();
}

main();