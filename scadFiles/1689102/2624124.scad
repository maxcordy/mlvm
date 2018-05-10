//Super8 film reel generator
//By Bram Vaessen
//E-mail: bram.vaessen@gmail.com


////////////// What to render ////////////////////////
////////////////////////////////////////////////////////////////


/* [Which part to generate] */

// Which one would you like to see?
part = "bottom"; // [bottom:Bottom,top:Top]

//pick which half you want to generate
//Bottom();
//Top();

//uncomment this to see the two halves together
//not printable as 1 piece width FDM printers
//translate([0,0,height*2+filmSize]) rotate([180,0,0]) Top();

////////////// Configuration Parameters ////////////////////////
////////////////////////////////////////////////////////////////


/* [Type of Spool] */
//the width of the film: 8mm or 16mm
filmWidth=8; //[8:8mm,16:16mm]

//the center hole
//for super8: innerDiameter=13, insertLength=5, insertNum=3, insertWidth=2.5
//for normal8, I used: innerDiameter=8, insertLength=5, insertNum=1, insertWidth=2
//I don' have normal8, so I can't test this, and can't find the exact specs online,
//so let me know when it is not correct and I'll fix it
//the diameter of the inner hole
innerDiameter = 13; //[8:8 (8mm),13:13 (Super8)]
//the length of the insert(s) for the spool
insertLength = 5; //[3:3 (8mm),5:5 (Super8)]
//the number of inserts for the spool
insertNum = 3; //[1: 1 (8mm),3:3 (Super8)]
//the width of the insert(s) for the spool
insertWidth = 2.5; //[2:2 (8mm),2.5:2.5 (Super8)]

//if you want a square hole (for 16mm), please set useSquareHole = 1
//size of the square hole is adjustable with second parameter
//I don' have 16mm reels so I'm not sure this is correct, I found size in another STL
//whether to use the square hole (for 16mm film)
useSquareHole=0; //[0:No (8mm and Super8),1:Yes (16mm)]


/* [Size of the Spool] */

//the outer and core diameter of the reel, some standard size:
//(core diameter is what I measured on the reels I own, not sure how standard those are)
//3inch: outerDiameter=76, coreDiameter=32
//4inch: outerDiameter=101, coreDiameter=?? (I don' have these and can' find the info)
//5inch: outerDiameter=127, corediameter=45
//6inch: outerDiameter=152, coreDiameter=?? (I don' have these and can' find the info)
//7inch: outerDiameter=178, coreDiameter=61
//the outer diameter of the reel in mm (3 to 7 inch)
outerDiameter = 178; //[67:3inch,101:4inch,127:5inch,152:6inch,178:7inch]
//the diameter of the core of the reel (on which the film rolls)
coreDiameter = 61; //[32:32 (3 inch),38:38 (4 inch),45:45 (5 inch),52:52 (6 inch),61:61 (7 inch)]

//Wheter to create a wheel with spokes or solid
useSpokes=1; //[0:No (3 inch),1:Yes]

//the width of the fitting between the two halfs, set this to 1 for the 3 inch reel
fittingWidth = 2; //[1:1 (3 inch),1.5 ,2]


/* [Fitting parameters] */


//the tightness of the center hole for the spool, increase this if the reel too lose on the spool, decrease this if the reel does not fit on the spool, or is very tight, can be negative as well if a value of 0 is still too tight
coreTightness = 0.0; //[-1:0.05:1]

//the extra space in the fitting between the two halfs
fittingSpacer = 0.4; //[-1:0.05:1]

/* [Other Specifications] */

//how many spokes in the wheel
spokes = 6; //[2,3,4,5,6,7,8]

//some parameters for the sizes of the ring and the spokes
//for 3 inch: use the same as 7 inch, but set spokes to 12 to close the reel
//for 5 inch: outerRingWidth=10, innerRingWidth=6, spokeWidth=19
//for 7 inch: outerRingWidth=12, innerRingWidth=10, spokeWidth=21
//for the other sizes I have no example reels, so just pick something in between
//for spoked wheel, the width of the outer ring
outerRingWidth=12; //[2:20]
//the thickess of the extra ring around the core in the center
innerRingWidth=10; //[0:25]
//the width of the spokes
spokeWidth=21; //[2:30] 


//the size of the square hole
squareHoleSize=9;

// the height of the plates, makes smaller to save print time, or wider to make the reel stronger
height=2; //[0.1:0.1:4]

//the width of the inserts for the film
//increase if hole is too narrow for film
//decrease if film gets out too easy
//the width of the inserts for the film
filmInsertWidth = 1; //[0.1:0.1:2]


////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////







//calculate some stuff 
filmSize = filmWidth+1;
fittingCenter = (coreDiameter/2 + (innerDiameter/2 + insertLength)) / 2;
fittingDepth = filmSize/2;




//basic plate with bevelled edges and spokes
module Plate()
{
    difference()
    {
        cylinder(r=outerDiameter/2, h=height, $fn=256); //plate
        //The big cutouts in the middle
        if (useSpokes) translate([0,0,-1]) difference()
        {
            cylinder (r=outerDiameter/2 - outerRingWidth, h=height+2, $fn=256);
            translate([0,0,-1]) 
                cylinder (r=coreDiameter/2 + innerRingWidth, h=height+4, $fn=128);
            
            for (r=[0:spokes-1]) rotate([0,0,r*360/spokes])
                translate([coreDiameter/2, -spokeWidth/2,0]) 
                    cube([outerDiameter/2 - outerRingWidth/2 - coreDiameter/2, spokeWidth, height+2]);  
                
        }
        
        //make the edge of the plate bevelled
        for (r=[0,360/64/2]) rotate([0,0,r])
            rotate_extrude(convexity=10, $fn=64)
            translate([outerDiameter/2,0,0]) 
                polygon(points=[[0.1,-0.1], [-0.1, -0.1], [-height*2,height*2], [0.1,height*2]]); 
    }
}

//this is the cutout for the spool
module CoreCutout(height)
{
    translate([0,0,-1])
    {
        //either a square hole or the standard hole
        if (useSquareHole==1)
        {
            translate([-squareHoleSize/2, -squareHoleSize/2,0])
                cube([squareHoleSize, squareHoleSize, height+2]);
        }
        else
        {
            //the core cutout
            cylinder(r=innerDiameter/2 - coreTightness/2, h=height+2, $fn=64);
            
            //the inserts
            for (r=[0:insertNum-1])
                rotate([0,0,r*120])
                    translate([0,-insertWidth/2 + coreTightness/2,0])
                        cube([innerDiameter/2 + insertLength, insertWidth - coreTightness , height+2]);
        }
        
        //the film inserts
        for (r=[0:2])
            rotate([0,0,r*120 + 60])
                translate([innerDiameter/2+2,-filmInsertWidth/2,0])
                    cube([coreDiameter/2 - innerDiameter/2 -2+0.1, filmInsertWidth, height+2]);
    }
    
    
}

//The bottom half of the reel, print this
module Bottom()
{
    difference()
    {
        //the main plate and core
        union()
        {
            Plate();
            cylinder(r=coreDiameter/2, h=height+filmSize, $fn=256); //core
        }
        //the middle cutout
        CoreCutout(height=height+filmSize);
                
        //the coutout for fitting
        translate([0,0,height+filmSize/2-fittingSpacer])
        {
            difference() //the coutout ring for fitting the top half
            {
                cylinder (r=fittingCenter+fittingWidth/2+fittingSpacer/2, 
                            h=fittingDepth+fittingSpacer+1, $fn=128);
                translate([0,0,-1])
                    cylinder(r=fittingCenter-fittingWidth/2-fittingSpacer/2, 
                            h=fittingDepth+fittingSpacer+3, $fn=128);
            }
            //one extra cutout to make it easy to orient the halves correctly
            translate([fittingCenter+fittingWidth/2,0,0])
                cylinder(r=fittingWidth + fittingSpacer/2, h=fittingDepth+1, $fn=32);
        }
    }
    

}


//The top half of the reel, print this
module Top()
{
    difference()
    {
        //the main plate and the fitting
        union()
        {
            Plate();
            translate([0,0,height])
            {
                difference() //fitting
                {
                    cylinder (r=fittingCenter+fittingWidth/2, h=fittingDepth-1, $fn=128);
                    translate([0,0,-1])
                        cylinder(r=fittingCenter-fittingWidth/2, h=fittingDepth+2, $fn=128);
                }
                //extra part to make orientation of the two halves easy
                translate([fittingCenter+fittingWidth/2,0,0])
                    cylinder(r=fittingWidth, h=fittingDepth-1, $fn=32);
            }
            
        }
        //the cutout for the core
        CoreCutout(height=height+fittingDepth);
    }
}

//uncomment this to see the two halves together
//translate([0,0,height*2+filmSize]) rotate([180,0,0]) Top();


//for the curstomizer on thingiverse
module print_part() 
{
	if (part == "bottom") 
    {
		Bottom();
	} 
    else if (part == "top")
    {
		Top();
    }
}

print_part();
