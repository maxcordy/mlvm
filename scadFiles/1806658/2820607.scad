//Gluing Jig for Folger Tech Carbon Fiber Arms
//10/1/2016     By: David Bunch
//
//This is customizable

//1. Width of Rod Ends across Flat side of Hex
RodEnd_Wid = 5.7;       //[4:0.1:10]

//2. Width of Front support
Fr_Wid = 3.5;           //[2:0.5:5]

//3. Width of Front Rod End Support
Fr_Len = 5.0;           //[2:0.5:10]

//4. Length to hold Rod Ends
Len = 21.5;             //[10:0.1:30]

//5. Height of Front & Back Support
Ht = 7;                 //[4:0.5:20]

//6. Height of Base
Base_Ht = 3.0;          //[2:0.1:6]

//7. Width of Back
Back_Wid = 3.0;         //[2:0.5:10]

//8. How Many rods are we Gluing
Rod_Qty = 6;            //[1:1:6]

//9. Rod End Hole size for Rod Ends Visual Display
Hole_OD = 3.7;          //[3:0.1:5]

//10. Rod End Diameter
End_OD = 10.5;          //[6:0.5:20]

/* [Hidden] */

Spacing = Fr_Wid + RodEnd_Wid;

End_Rad = End_OD / 2;
R_Wid2 = RodEnd_Wid / 2;
Rod_Rad = R_Wid2 / cos(30);
Rod_OD = Rod_Rad * 2;
//Wid = (Rod_Qty * RodEnd_Wid) + ((Rod_Qty + 1) * Fr_Wid);
Wid = Fr_Wid + (Rod_Qty * Spacing);
Tot_Ht = Base_Ht + Ht;

echo(Spacing = Spacing);
echo(R_Wid2 = R_Wid2);
echo(Rod_Rad = Rod_Rad);
echo(Rod_OD = Rod_OD);
echo(Wid = Wid);

$fn=16;             //Not much resolutions needed since it is just for display

module RodEnd()
{
    translate([Fr_Wid+R_Wid2,-End_Rad+Fr_Len+Len,Base_Ht+Rod_Rad])
    rotate([0,0,-90])
    rotate([90,0,0])
    {
        difference()
            {
            union()
            {
                translate([7+5.25,0,0])
                rotate([0,90,0])
                rotate([0,0,30])
                cylinder(d=Rod_OD,h=12.5,$fn=6);
                hull()
                {
                    translate([7+5.25,0,0])
                    rotate([0,90,0])
                    rotate([0,0,30])
                    cylinder(d=Rod_OD,h=.1,$fn=6);
                    translate([7,-Rod_Rad,-1.5])
                    cube([.1,Rod_OD,3]);
                }
                hull()
                {
                    translate([0,0,-1.5])
                    cylinder(d=End_OD,h=3);
                    translate([7,-Rod_Rad,-1.5])
                    cube([.1,Rod_OD,3]);
                }
            }
            cylinder(d=Hole_OD,h=10,center=true);
        }
        translate([7+5.25+12.5,0,0])
        rotate([0,90,0])
        cylinder(d=5,h=40);
    }
}
module Rods()
{
    for (a =[0:Rod_Qty-1])
    {
        translate([(a*Spacing),0,0])
        RodEnd();
    }
}
module DrawFinal()
{
    difference()
    {
        union()
        {
            cube([Wid,Fr_Len,Tot_Ht]);      //Front Cube
            //cube([58.55,15,3]);
            translate([0,Fr_Len + Len,0])
            cube([Wid,Back_Wid,Tot_Ht]);    //Back Cube
            cube([4,Fr_Len + Len,Base_Ht]);
            translate([Wid-4,0,0])
            cube([4,Fr_Len + Len,Base_Ht]);
        }
        for (a =[0:5])
        {
            translate([Fr_Wid+(a*Spacing),-1,Base_Ht])
            cube([RodEnd_Wid,Fr_Len + 2,Tot_Ht]);   //Cut out for Rod Arms to pass thru
        }
    }
}
DrawFinal();
%Rods();