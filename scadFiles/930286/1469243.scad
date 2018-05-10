//Remix of http://www.thingiverse.com/thing:918871
//to make it parametric
//CUSTOMIZER VARIABLES

//1. Length of Square check (originals were 97.5mm & 140mm)
Len = 97.5;             //Original Short Length

//Len=140;              //Original Long Length

//2. Width of Square check
Wid = 25;               //Width of Part

//3. Thickness Between inside cut & pipe cut (original was 17.19mm)
LenCutThk = 6;

//4. Thickness on edges of inside cut
WidCutThk = 3;
//WidCut = 16;          //Width of Inside Cut

//5. Height of Square Check
Ht = 10;                //Height of part

//6. Pipe Dia. to use (Probably use 23.5 Standard or 25 Metric)
PipeDia = 25;         //Original Dia of Pipe was 25;

//6. Center of Pipe from end of Square Check
CylOffset = 4.7;        //Offset of pipe cut on top & bottom

//7. Resolution of Pipe cut (original was 32)
ires = 32;

//8. Print 1 or 2 Square Checks
Qty = 1;

//CUSTOMIZER VARIABLES END

$fn = ires;                 //Resolution of Pipe Cylinder cut
L2 = Len / 2;
echo("L2 = ", L2);
W2 = Wid / 2;
Y_org = (PipeDia / 2) - CylOffset;
echo("Y_org = ", Y_org);
L3 = L2 - Y_org - LenCutThk;
echo("L3 = ", L3);
LenCut2 = L3;
LenCut = LenCut2 * 2;
WidCut = Wid - (WidCutThk *2);
WidCut2 = WidCut / 2;
Cyl_Y = L2 + CylOffset;

//Draw the Main base for this part
//The main length is along the Y-axis as originally drawn
module Base()
{
    translate([-W2,-L2,0])
    cube([Wid,Len,Ht]);
}
module SquareCheck()
{
    difference()
    {
        Base();
        translate([-WidCut2,-LenCut2,-1])
        cube([WidCut,LenCut,Ht+2]);         //Cut inside cube out of part
        translate([0,-Cyl_Y,-1])
        cylinder(d=PipeDia,h=Ht+2);         //Cut bottom end for pipe
        translate([0,Cyl_Y,-1])
        cylinder(d=PipeDia,h=Ht+2);         //Cut Top end for pipe
    }
}
SquareCheck();                  //Draw 1st part
if (Qty == 2)
{
    translate([Wid+6,0,0])      //Seperate parts by 6mm
    SquareCheck();              //Maybe draw a 2nd part
}