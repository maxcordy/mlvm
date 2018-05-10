//Parametric V-SLot Limit Switch Holder
//11/27/2015    By: David Bunch
//
//The 1st 3 variables you should not need to change if using V-Slot
//CUSTOMIZER VARIABLES

//1. Width of Trapezoid base connection at V-Slot
Trap_Base = 5.78;

//2. Angle of Trapezoid connection (45.0 for V-Slot)
Trap_Ang = 45.0;

//3. Thickness of Trapezoid connection
Trap_Thk = 1.69;

//4. M5 Hole diameter for connecting to V-Slot
M5 = 5.5;

//5. Width of Holder away from V-Slot
Wid = 6;

//6. Height of Limit Switch Holder
Trap_Ht = 15;

//7. Offset between Trap Connections (20 for V-Slot)
Trap_X_Offset = 20;         //Only used when Trap_Qty = 2

//8. Offset from Holder to Center of V-slot
V_Slot_Offset = 10;         //Only used when displaying Assembled

//9. 1 or 2 Trapezoid Connections to V-Slot
Trap_Qty = 1;

//10. Length to Left of Center of Trapezoid Base
Lt_Len = 8;

//11. Length to Right of Center of Trapezoid Base
Rt_Len = 13.34;

//12. Round Corner Diameter for Base Connection
TrapRnd_Dia = 12;

//--- Variables for the Leg that Holds the Limit Switch ---

//13. Length of Leg of Limit Switch
LS_Leg_Len = 30;

//14. Angle rotation of Leg of Limit Switch
LS_Leg_Ang = 75;

//15. Width of Leg of Limit Switch
LS_Leg_Wid = 6;

//16. Height of Leg of Limit Switch
LS_Leg_Ht = 15;

//17. Diameter of Holes to connect Limit Switch
LS_Hole_Dia = 2.5;

//18. Offset to 1st Limit Switch Mounting Hole
LS_Hole_Offset = 12.8;

//19. Spacing between Limit Switch Mounting Holes
LS_Hole_Spacing = 9.6;

//20. Height of Holes for Limit Switch
LS_Z_Height = 7.5;      //This is usually Half the total Height LS_Leg_Ht

//21. Diameter of Weld to place between Leg & Main Base (0 = No Weld)
LS_Weld_Dia = 5;        //Only allowed if LS_Leg_Ang >= 90   

//22. Limit Switch Side to show for reference (0 or 1)
LS_Side = 0;            //This variable tells which side of Leg to place switch

//23. Round Corner Diameter on Limit Switch Leg
LS_Rnd_Dia = 8;

//24. Resolution of Cylinder Cuts
iRes = 24;

//25. Draw Part Assembled with Switch & V-Slot
Assembly = 1;

//CUSTOMIZER VARIABLES END

TotTrap_Offset = Trap_X_Offset * (Trap_Qty - 1);
TotLt_Len = TotTrap_Offset + Lt_Len;

Trap_Leg_X_Len = Trap_Thk / tan(Trap_Ang);

Trap_Len = Trap_Base + (Trap_Leg_X_Len * 2);

Trap_Len_Half = Trap_Len / 2;

Leg_Len = sqrt((Trap_Thk * Trap_Thk) + (Trap_Leg_X_Len * Trap_Leg_X_Len));

Lt_Rt_Len = TotLt_Len + Rt_Len;

TrapRnd_Rad = TrapRnd_Dia / 2;

LS_Rnd_Rad = LS_Rnd_Dia / 2;

$fn = iRes;         //Resolution of Cylinders
module LimitSwitch()
{
    color("red")
    import("LimitSwitch.stl", convexity=3);
}
module V_Slot_2060()
{
    translate([0,0,50])
    rotate([180,0,0])
    import("V_Slot_2060_50mm.stl", convexity=3);
}
module Trap()
{
    translate([-Trap_Len_Half,0,0])
    difference()
    {
        cube([Trap_Len,Trap_Thk,Trap_Ht]);

        rotate([0,0,Trap_Ang])
        translate([0,0,-1])
        cube([Leg_Len,Leg_Len,Trap_Ht+2]);      //Cut off Left side of Trapezoid

        translate([Trap_Len,0,-1])
        mirror([1,0,0])
        rotate([0,0,Trap_Ang])
        cube([Leg_Len,Leg_Len,Trap_Ht+2]);      //Cut off Right side of Trapezoid
    }
}
module TrapConnect()
{
    union()
    {
        Trap();
        translate([-TotLt_Len,-Wid,0])
        cube([Lt_Rt_Len,Wid,Trap_Ht]);  //Add the part Fits against the V-Slot
        if (LS_Leg_Ang >= 90)
        {
            if (LS_Weld_Dia > 0)
            {
                translate([Rt_Len,0,0])
                rotate([0,0,-LS_Leg_Ang])
                translate([Wid,-LS_Leg_Wid,0])
                color("green")
                cylinder(d=LS_Weld_Dia,h=Trap_Ht,$fn=4);
            }
        }
    }
}
module LimitSwitchLeg()
{
    translate([Rt_Len,0,0])
    rotate([0,0,-LS_Leg_Ang])
    translate([0,-LS_Leg_Wid,0])
    color("cyan")
    difference()
    {
        cube([LS_Leg_Len,LS_Leg_Wid,LS_Leg_Ht]);
        translate([LS_Hole_Offset,-1,LS_Z_Height])
        rotate([-90,0,0])
        cylinder(d=LS_Hole_Dia,h=LS_Leg_Wid + 2);
        translate([LS_Hole_Offset+LS_Hole_Spacing,-1,LS_Z_Height])
        rotate([-90,0,0])
        cylinder(d=LS_Hole_Dia,h=LS_Leg_Wid + 2);
        translate([LS_Leg_Len-LS_Rnd_Rad,-1,Trap_Ht])
        rotate([-90,0,0])
        rotate([0,0,90])
        translate([LS_Rnd_Rad,0,0])
        RndCorner(LS_Rnd_Dia);
        translate([LS_Leg_Len,-1,LS_Rnd_Rad])
        rotate([-90,0,0])
        rotate([0,0,180])
        translate([LS_Rnd_Rad,0,0])
        RndCorner(LS_Rnd_Dia);
    }
    if (Assembly > 0)
    {
//Hole on Switch I drew starts at 5.3mm from end of switch
        if (LS_Side == 0)
        {
            translate([Rt_Len,0,0])
            rotate([0,0,-LS_Leg_Ang])
            translate([LS_Hole_Offset-5.3,6.5,0])
            translate([20,-6.5,0])      //Orient Switch
            rotate([0,0,180])           //to our scheme
            rotate([90,0,0])            //before translating & rotating
            %LimitSwitch();
        } else {
            translate([Rt_Len,0,0])
            rotate([0,0,-LS_Leg_Ang])
            translate([LS_Hole_Offset-5.3,-LS_Leg_Wid,0])
            translate([20,-6.5,0])      //Orient Switch
            rotate([0,0,180])           //to our scheme
            rotate([90,0,0])            //before translating & rotating
            %LimitSwitch();
         
        }
    }
}
module DrawLimitSwitchHolder()
{
    difference()
    {
        union()
        {
            if (LS_Leg_Ang > 90)
            {
            difference()
            {
                TrapConnect();
                translate([Rt_Len,0,0])
                rotate([0,0,-LS_Leg_Ang])
                translate([0-1,-LS_Leg_Wid,-1])
                cube([LS_Leg_Len,Wid*2,Trap_Ht+2]);
            }
            } else {
                TrapConnect();
            }
            difference()
            {
                LimitSwitchLeg();
                translate([0,0,-1])
                cube([LS_Leg_Len,LS_Leg_Wid*2,LS_Leg_Ht+2]);
            }
            if (Trap_Qty == 2)
            {
                translate([-TotTrap_Offset,0,0])
                Trap();
            }
        }
        translate([-TotLt_Len + TrapRnd_Rad,-Wid-1,Trap_Ht-TrapRnd_Rad])
        rotate([-90,0,0])
        RndCorner();
        translate([-TotLt_Len+TrapRnd_Rad,-Wid-1,TrapRnd_Rad])
        rotate([-90,0,0])
        rotate([0,0,-90])
        RndCorner();        
        translate([0,-(Wid+1),Trap_Ht/2])
        rotate([-90,0,0])
        cylinder(d=M5,h=Wid+Trap_Thk+2);
        if (Trap_Qty == 2)
        {
            translate([-TotTrap_Offset,-(Wid+1),Trap_Ht/2])
            rotate([-90,0,0])
            cylinder(d=M5,h=Wid+Trap_Thk+2);
        }
    }
}
module RndCorner(R_Dia = TrapRnd_Dia)
{
    difference()
    {
        translate([-((R_Dia+2)/2),-((R_Dia+2)/2),0])
        cube([R_Dia+2,R_Dia+2,Trap_Ht+2]);  //Draw Basic cube

        translate([0,0,-1])                 //Cut Cylinder
        cylinder(d=R_Dia,h=Trap_Ht+4);      //out of Midle of Cube

        translate([-((R_Dia*3)/2),0,-1])
        cube([R_Dia*3,R_Dia*3,Trap_Ht+4]);  //Slice off Half

        translate([0,-((R_Dia*3)/2),-1])
        cube([R_Dia*3,R_Dia*3,Trap_Ht+4]);  //Slice off other quarter
    }
}
if (Assembly == 1)
{
    %V_Slot_2060();
 
    translate([0,V_Slot_Offset,0])
    rotate([0,0,180])
    DrawLimitSwitchHolder();
} else {
    if (LS_Leg_Ang == 0 && Wid == LS_Leg_Wid)
    {
        translate([0,0,Wid])        //Orient Flat for better print
        rotate([90,0,0])
        DrawLimitSwitchHolder();
    } else {
        DrawLimitSwitchHolder();
    }
}