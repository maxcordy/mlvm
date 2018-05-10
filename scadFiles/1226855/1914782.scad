//Center Cirucular Bracket for Build Plate Support
//12/24/15      By: David Bunch
//
OD = 90;
ID = 52;
Wing_Ang = 120;
NumOfWings = 360 / Wing_Ang;
CO_Y_Offset = 38.0;     //Y Offset from Center of Wings
Oval_X_Offset = 10.5;
Hole_iRes = 24;
M3 = 3.5;
Ht=4;
$fn=372;

module RimLedge()
{
    translate([0,0,Ht])
    difference()
    {
        rotate_extrude(convexity = 10, $fn = 372)
        translate([ID / 2 + 4.15,0,0])
        scale([.75,.75,1])
        rotate([0,0,22.5])
        circle(r = 6, $fn = 8);
        translate([0,0,-10])
        cylinder(d=OD,h=10);
    }
}

module DrawFinal()
{
    difference()
    {
        union()
        {
            cylinder(d=OD,h=Ht-2);
            translate([0,0,Ht-2])
            cylinder(d1=OD,d2=OD-4,h=2);


        }
    //    cylinder(d=OD,h=Ht);
        translate([0,0,-1])
        cylinder(d=ID,h=Ht+2);
        translate([0,0,-.1])
        cylinder(d1=ID+4,d2=ID,h=2.1);
        for (r =[0:NumOfWings-1])
        {
            rotate([0,0,r*Wing_Ang])
            translate([-Oval_X_Offset,CO_Y_Offset,-1])
            cylinder(d=M3,h=Ht+2,$fn=Hole_iRes);
            rotate([0,0,r*Wing_Ang])
            translate([Oval_X_Offset,CO_Y_Offset,-1])
            cylinder(d=M3,h=Ht+2,$fn=Hole_iRes);
            rotate([0,0,r*Wing_Ang])
            translate([-Oval_X_Offset,CO_Y_Offset,Ht])
            %cylinder(d=8,h=4,$fn=6);
        }
    }
    RimLedge();
}
DrawFinal();