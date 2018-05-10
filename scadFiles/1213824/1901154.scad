//
//  SwordPenHolder.scad
//
//  EvilTeach
//
//  12/19/2015
//
//  This models a simple bookmark with a pen holder. 
//
//  ABS with no raft, no support.  Layer .25 no shells
//
//     True, This! —

//     Beneath the rule of men entirely great
//     The pen is mightier than the sword. Behold
//     The arch-enchanters wand! — itself is nothing! —
//     But taking sorcery from the master-hand
//     To paralyse the Cæsars, and to strike
//     The loud earth breathless! — Take away the sword —
//     States can be saved without it!



// This is the diameter of the pen that should fit into the holder
penDiameter         =  11.5;

// This is the length of the rectangular portion of the sword
swordBladeLength    = 100.0;

// This is the width of the rectangluar potion of the sword, which most of the hilt is based off of
swordBladeWidth     =  20.0;

// This is the thickness of the sword blade.  It is flexible.  I recommend keeping it greater than 1.
swordBladeThickness =   1.3;



// Draws just the rectangular part of the sword.
module blade()
{
    color("cyan")
        cube([swordBladeLength, swordBladeWidth, swordBladeThickness]);
}



// Draws the pointy tip of the sword.
module point()
{
    triangleLegs = sqrt(swordBladeWidth * swordBladeWidth / 2);
    color("lime")
        translate([swordBladeLength, 0, 0])
            rotate([0, 0, 45])
                cube([triangleLegs, triangleLegs, swordBladeThickness]);
}



// Draws a simple hilt, based on the sword width
module hilt()
{
    color("pink")
    {
        // Guard
        rotate([0, 0, 90])
        translate([-swordBladeWidth, 0, 0])
        cube([swordBladeWidth * 3, swordBladeWidth / 4, swordBladeThickness]);
        
        // Grip
        translate([-swordBladeWidth / 4, 
                   swordBladeWidth / 4, 
                   0])
        rotate([0, 0, 90])
        cube([swordBladeWidth / 2, swordBladeWidth, swordBladeThickness]);
        
        // Prommel
        translate([-swordBladeWidth * 3/2, swordBladeWidth / 2, 0])
            cylinder(r = swordBladeWidth / 3, swordBladeThickness);
    }
}



// This just groups the related pieces into one call.
module sword()
{
    point();
    blade();
    hilt();
}



// Reusable draw a hollow cylinder
module hollow_cylinder(outsideRadius, insideRadius, height)
{
    difference()
    {
        cylinder(r = outsideRadius, h = height);
        cylinder(r = insideRadius,  h = height);
    }
}



// This draws just the pen holder
module pen_holder()
{
    // This is the thickness of the pen holder.  Too Thin and it breaks.  To Thick and it cracks.
    thickness = 1.1;
    
    // The inside radius needs to hold the pen
    insideRadius  = penDiameter / 2;
    
    // The outside needs to be big enough to hold it, yet remain flexible.
    outsideRadius = insideRadius + thickness;
    
    color("yellow")
        // Move to the correct location relative the blade
        translate([outsideRadius / 2 + swordBladeWidth / 3, 
                   swordBladeWidth, 
                   outsideRadius + swordBladeThickness - thickness])
    
            // give the cylinder the correct orientation
            rotate([90, 0, 0])
            difference()
            {
                hollow_cylinder(outsideRadius, 
                                outsideRadius - thickness, 
                                swordBladeWidth);
                
                // Subtrace out an entrance for the pen.
                rotate([0, 0, 45])
                    cube([outsideRadius, outsideRadius, swordBladeWidth]);
            }
}


// This is the entry point
module main()
{
    // I prefer smooth where possible.
    $fn=360;

    sword();
    pen_holder();
}


// From the perspective of an old C programmer.
main();
