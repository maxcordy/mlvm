//Parametric L Bracket
//You can make this any length, Width, Height & Thickness you want
//You can also have 1, 2 or 4 screws on each leg of the L
//8/19/2015 By: David Bunch
//
//CUSTOMIZER VARIABLES

//1. Length of Part along 1st L
Len = 38.1;

//2. Width of L along 2nd L
Wid = 38.1;

//3. Height of L Bracket
Ht = 25.4;

//4. Thickness of Leg along X-Axis
Thk_X = 8;

//5. Thickness of Leg along Y-axis
Thk_Y = 8;

//6. Weld Diameter at L junction
WeldDia = 8;

//7. Chamfer Diameter at ends of L
ChamfDia = 10;

//8. Hole Diameter for Screws (#8 screw default)
HoleSize = 4.2;            //#10 Screws are 4.5 measured
                            //#8 Screws are 4.2 measured
                            //#6 Screws are 3.4 measured

//9. Dia. of Taper Head of Screw (#8 used for default)
TaperDia = 7.9;             //#10 Screws are a measured 9.0mm dia
                            //#8 Screws are a measured 7.95mm dia
                            //#6 Screws are a measured 6.45mm dia
//10. Taper Length Head of Screw (#8 used for default)
TaperLen = 3.5;            //#10 Screws are a measured 3.9mm taper
                            //#8 Screws are a measured 3.5mm taper
                            //#6 Screws are a measured 2.66mm taper
//11. Multiplication factor for Drill Holes
Tolerance = 1.03;  

//12. # of Screws on each side of L (1 or 2)
Screws_X = 1;                 //I split the distance by 3 for 2 screws

//13. # of Screws on each side of L (1 or 2)
Screws_Y = 1;                 //I split the distance by 3 for 2 screws

//14. # of Scres along Height of L (1 or 2)
Screws_Z = 1;

//15. Screw Height (I use 3/4" screws for default)
ScrewHt = 19.02;

//16. # of parts to make (1,2,3 or 4)
Parts = 1;

//CUSTOMIZER VARIABLES END

HoleOD = HoleSize * Tolerance;      //Calculated Hole Diameter
TapOD = TaperDia * Tolerance;       //Calculated Tapered Head Diameter
WeldRad = WeldDia / 2;              //Radius of Weld
Ht2 = Ht / (Screws_Z + 1);          //Half Height or 1/3 height if 2 screws are used
echo("Ht2 = ", Ht2);
//Calcs for Hole(s) along X axis
H_X = (Len - Thk_Y - WeldRad) / (Screws_X + 1);
echo("H_X = ",H_X);
Hole_X =  H_X + Thk_Y + WeldRad;
echo("Hole_X = ",Hole_X);
Hole_X2 = Hole_X + H_X;
echo("Hole_X2 = ",Hole_X2);
//
//Calcs for Hole(s) along Y axis
H_Y = (Wid - Thk_X - WeldRad) / (Screws_Y + 1);
echo("H_Y = ",H_Y);
Hole_Y = H_Y + Thk_X + WeldRad;
echo("Hole_Y = ",Hole_Y);
Hole_Y2 = Hole_Y + H_Y;
echo("Hole_Y2 = ",Hole_Y2);
//
ScrewThreadHt = ScrewHt - TaperLen;
module DrawSrewCut()
{
//This combines the head to the screw
	union()
	{
		cylinder(d1=TapOD,d2=HoleOD,h=TaperLen,$fn=24);
		cylinder(d=HoleOD,h=ScrewThreadHt,$fn=24);
	}
}
module LBracket()
{
    union()
    {
        cube([Len,Thk_X,Ht]);         //Draw the X axis side
        cube([Thk_Y,Wid,Ht]);         //Draw the Y axis side
        translate([Thk_Y,Thk_X,0])
        cylinder(d=WeldDia,h=Ht,$fn=4);     //Add the Weld
    }
}
module ChamCorners()
{
//Chamfer at end of X Length
    translate([Len,-1,0])
    rotate([-90,0,0])
    cylinder(d=ChamfDia,h=Thk_X+2,$fn=4);
    translate([Len,-1,Ht])
    rotate([-90,0,0])
    cylinder(d=ChamfDia,h=Thk_X+2,$fn=4);
//Chamfer at end of Y Length
    translate([-1,Wid,0])
    rotate([0,90,0])
    cylinder(d=ChamfDia,h=Thk_Y+2,$fn=4);
    translate([-1,Wid,Ht])
    rotate([0,90,0])
    cylinder(d=ChamfDia,h=Thk_Y+2,$fn=4);
}
module Screws_XY()
{
//Drill holes for Screws along the X & Y axis
    translate([Hole_X,Thk_X+.02,Ht2])
    rotate([90,0,0])
    DrawSrewCut();
    if (Screws_X == 2)
    {
        translate([Hole_X2,Thk_X+.02,Ht2])
        rotate([90,0,0])
        DrawSrewCut();
    }
    translate([Thk_Y+.02,Hole_Y,Ht2])
    rotate([0,-90,0])
    DrawSrewCut();
    if (Screws_Y == 2)
    {
        translate([Thk_Y+.02,Hole_Y2,Ht2])
        rotate([0,-90,0])
        DrawSrewCut();
    }
}
module DrawL()
{
    rotate([90,0,0])
    difference()
    {
        LBracket();
        Screws_XY();
        if (Screws_Z == 2)
        {
            translate([0,0,Ht2])
            Screws_XY();
        }
        ChamCorners();
//The following section is only for visual checks of how far screws go into wood
//These will not draw on final render
        translate([0,-12.7,0])
        %cube([Hole_X,12.7,38.1]);          //Check how far screw goes into 1/2" wood
        translate([-19.02,0,0])
        %cube([19.02,Hole_Y,38.1]);         //Check how far screw goes into 3/4" wood
        translate([Hole_X,Thk_X+.02,Ht2])
        rotate([90,0,0])
        color("red")
        %DrawSrewCut();
        translate([Thk_Y+.02,Hole_Y,Ht2])
        rotate([0,-90,0])
        color("red")
        %DrawSrewCut();
    }
}
DrawL();                                //Always draw 1 Part
if (Parts > 1)
{
    translate([0,Ht+6,0])
    DrawL();
}
if (Parts > 2)
{
    translate([0,Ht+Ht+6+6,0])
    DrawL();
}
if (Parts > 3)
{
    translate([0,Ht+Ht+Ht+6+6+6,0])
    DrawL();
}
