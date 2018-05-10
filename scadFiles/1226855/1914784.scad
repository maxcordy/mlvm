//DParametric Build Plate Support for Delta Printer
//12/13/2015    By: David Bunch
//
//When slicing, I rotated -15 degrees using Slic3r to fit on my 10" Build Plate
//Onyx Heat Bed is 310mm OD & 12 Holes at 300MM Hole OD,
//1.03oz at 20% Infill & print time of 1:41:57 for 406mm 60deg Wing
//1.12oz at 40% infill & print time of 1:50:40 for 406mm 60deg Wing

//Orion Heat Bed is 220mm OD & 6 Holes at 210mm Hole OD

//CUSTOMIZER VARIABLES

//1. Outside Diameter of the 3 Wings
Wing_OD = 406;      //310mm original
                    //If using Outside Ledge, you probably want to add 10mm or more

//2. Diameter of Heat Bed Hole Mounting Pattern
HeatBd_Hole_OD = 396;   //I Rotate 1st Hole 3 degrees From Y-axis to miss side connection

//3. Initial Rotation for Heat Bed Mounting Holes
Hole_InitialRotate = 3;     //Use 3mm for 310 to 320mm Wing_OD, 5mm for 220 Wing_OD
                            //or play with the value for what looks good to you

//4. How Many Holes around Circular Heat Bed
HeatBd_Hole_Qty = 12;

//5. Wing Angle (120 or 90 usually)
Wing_Ang = 60;

//6. Inside Cutout Diameter of the 3 Wings
Wing_ID = 58;       //If not using Special Center Cut

//7. Cut Special Center Cut (1 = Yes, 0 = Use Wing_ID Cut)
C_Cut = 1;

//8. Thickness of Wing at outer edge
Wing_Out_Thk = 16;

//9. How many outer sides on each Wing
Wing_Sides = 24;    //4 would equal 12 sides around circle

//10. Outside Diameter of Center Circular Bracket
C_OD = 148;

//11. Heat Bead Holes Diameter
Heat_OD = 3.5;          //These are for the Heat Bed Mounts          

//12. Bracket Holes Diameter
Brac_OD = 3.5;          //These are for the Brackets that support the 3 wings
                        //If you change this, you need to change the Bracket parts also

//13. Height of Build Plate Support
Ht = 3.53;                 //2mm is the minimum that will work if using Ledges

//14. Resolution of Heat_OD & Brac_OD holes
Hole_iRes = 24;

//15. Y Offset from Center of Wings for Inner Mounting Holes
CO_Y_Offset = 52.0;     //Y Offset from Center of Wings

//16. Offset from Center Line of Oval Bracket Mounting Holes 
Oval_X_Offset = 10.5;

//17. Distance between holes if using 4 hole Outer Bracket
Oval_Y_Offset = 9.5;        //Set to 0, if you do not want to use 4 holes
                            //I use 4 holes just in case I decide to use double bracket

//18. 2 or 4 Hole Outer Bracket for Assembly visual
Oval_Bracket_Qty = 2;

//19. Diameter of Ledge Bumps (Only 6mm tested on printing)
L_OD = 6;

//20. Draw Inner Ledge (1 = Yes, 0 = No)
DrawInnerLedge = 1;

//21. Draw Outside Ledge (1 = Yes, 0 = No)
DrawOutLedge = 0;

//22. Draw a Middle Ledge (1 = Yes, 0 = No)
DrawMidLedge = 1;

//23. Middle Ledge Offset from Center (if used)
MidLedge_offset = 160;

//24. Draw Spoke Ledges (1 = Yes, 0 = No)
DrawSpokes = 1;

//25. How many Ledge spokes to use
Spokes = 3;         //5 will give you 1 Ledge spoke every 30 degrees

//26. Double Holes on each side of Ledge Spokes (1 or 2)
HeatBd_Hole_Dbl = 2;        //2 = hole on each side of Ledge Spoke

//27. Heat Bed Diameter
HeatBd_OD = 406;

//28. Heat Bed Thickness for Visual
HeatBd_Thk = 1.7;

//29. Heat Bed Z Height above Bottom
HeatBd_Z = 18;          //This is what I measured on  my current printer

//30. Glass Plate Diameter
Glass_OD = 406;

//31. Glass Plate Thickness
Glass_Thk = 3;

//32. Glass Plate Z Height above Bottom
Glass_Z = 20;

//33. Diameter of Brass Bar if used
BrDia=3.7;          //1/8" Brass round is 3.2mm in diameter (3.7 is nice snug fit for me)

//34. Height of Brass Bar to cut through ledg
BarHt = 4.5;

//35. Use Brass Bars (1 = Yes)
DrawBars = 0;         //0 = No, 1 = Yes (Draw Brass Bars)

//36. Draw Assembled (1 = Yes, 0 = Draw Printable Part)
Assembled = 0;

//CUSTOMIZER VARIABLES END

$fn=Hole_iRes;
L_Rad = L_OD / 2;       //Radius of Ledge Bumps
Wing_Rad = Wing_OD / 2;
Wing_OD2 = Wing_OD-(Wing_Out_Thk*2);        //This is the Outer flat surface
Wing_Rad2 = Wing_OD2 / 2;
C_Rad = C_OD / 2;
HeatBd_Hole_Rad = HeatBd_Hole_OD / 2;
HeatBd_Hole_Rot = 360 / HeatBd_Hole_Qty;
echo("HeatBd_Hole_Rot = ",HeatBd_Hole_Rot);
Cos225 = cos(22.5);
Sin225 = sin(22.5);
Tan225 = tan(22.5);
Oct_Rad = (L_OD / 2) * Cos225;    //Radius of Sides of 8 Sided polygon
echo("OCT_Rad = ",Oct_Rad);
Oct_OD = Oct_Rad * 2;           //Diameter of Sides of 8 Sided polygon
echo("Oct_OD = ",Oct_OD);
Sq_OD = sqrt((Oct_OD*Oct_OD)+(Oct_OD*Oct_OD));
Sq_Rad = Sq_OD / 2;
echo("Sq_Rad = ",Sq_Rad);
Oct_HalfRad = Tan225 * Oct_Rad;
Oct_D_HalfRad = Oct_HalfRad * 2;
echo("Oct_HalfRad = ",Oct_HalfRad);
Sq_Z =  Oct_Rad - Oct_HalfRad;
echo("Sq_Z = ",Sq_Z);
W_iRes = Wing_Sides * (360 / Wing_Ang);        //Multiple by number of wings
NumOfWings = 360 / Wing_Ang;
L_Len = Wing_Rad - C_Rad;
echo("L_Len = ",L_Len);
Spoke_Ang = Wing_Ang / (Spokes - 1);
echo("Spoke_Ang = ",Spoke_Ang);
L_Adjust = L_OD - 6;                //Adjustment of holes if Ledge is not 6mm
echo("L_Adjust = ",L_Adjust);
Y_Half = Oval_Y_Offset / 2;
module Oval_2HoleBracket()
{
    translate([0,0,0])
    rotate([0,180,0])
    color("Blue",.5)
    import("BuildPlate_2HoleOvalBracket_rev22.stl", convexity=3);
}
module Oval_4HoleBracket()
{
    translate([0,0,0])
    rotate([0,180,0])
    color("Blue",.5)
    import("BuildPlate_4HoleOvalBracket_rev22.stl", convexity=3);
}
module HeatBed()
{
    translate([0,0,HeatBd_Z])
    color("Red",.5)
    difference()
    {
        cylinder(d=HeatBd_OD,h=HeatBd_Thk,$fn=HeatBd_OD);
        for (r =[0:(HeatBd_Hole_Qty)-1])
        {
            rotate([0,0,Hole_InitialRotate+(r*HeatBd_Hole_Rot)])
            translate([0,HeatBd_Hole_Rad,-1])
            cylinder(d=Heat_OD,Ht+4,$fn=24);
        }
    }
}
module GlassPlate()
{
    translate([0,0,Glass_Z])
    color("LightCyan",.5)
    cylinder(d=Glass_OD,h=Glass_Thk,$fn=Glass_OD);
}

module HeatBd_Bolt()
{
    color("Silver",.5)
    translate([0,HeatBd_Hole_Rad,HeatBd_Z + HeatBd_Thk])
    union()
    {
        cylinder(d=Heat_OD+2,h=3);
        translate([0,0,-20])
        cylinder(d=Heat_OD,h=20);
    }
}

module BracketSupports()
{
    if (Oval_Bracket_Qty  == 2)
    {
        translate([0,CO_Y_Offset,0])
        Oval_2HoleBracket();
        translate([0,Wing_Rad2+1-6.2-Oval_Y_Offset,0])
        Oval_2HoleBracket();
    } else {
        translate([0,CO_Y_Offset+Y_Half,0])
        Oval_4HoleBracket();
        translate([0,Wing_Rad2+1-6.2-Y_Half,0])
        Oval_4HoleBracket();
    }
}
module Oval_Bracket()
{
    if (Oval_Bracket_Qty  == 2)
    {
        Oval_2HoleBracket();
    } else {
        Oval_4HoleBracket();
    }
}
module TriBracketLt()
{
    translate([0,Wing_Rad2+1,0])
    difference()
    {
        cylinder(d=66+L_Adjust*2,h=Ht,$fn=4);
        translate([-60,0,-1])
        cube([120,120,50]);
        translate([0,-60,-1])
        cube([120,120,50]);
        translate([-Oval_X_Offset-L_Adjust,-6.2,-1])
        cylinder(d=Brac_OD,h=Ht+2,$fn=24);
        translate([-Oval_X_Offset-L_Adjust,-6.2-Oval_Y_Offset,-1])
        cylinder(d=Brac_OD,h=Ht+2,$fn=24);
    }
}
module TriBracketRt()
{
    rotate([0,0,Wing_Ang])
    translate([0,Wing_Rad2+1,0])
    difference()
    {
        cylinder(d=66+L_Adjust*2,h=Ht,$fn=4);
        translate([-60,0,-1])
        cube([120,120,50]);
        translate([-120,-60,-1])
        cube([120,120,50]);
        translate([Oval_X_Offset+L_Adjust,-6.2,-1])
        cylinder(d=Brac_OD,h=Ht+2,$fn=24);
        translate([Oval_X_Offset+L_Adjust,-6.2-Oval_Y_Offset,-1])
        cylinder(d=Brac_OD,h=Ht+2,$fn=24);
    }
}
module Ledge1()
{
    translate([0,C_Rad-L_Rad,Ht])
    difference()
    {
        union()
        {
            if (DrawOutLedge == 0)
            {
                translate([0,0,0])
                rotate([-90,0,0])
                rotate([0,0,22.5])
                union()
                {
                    cylinder(d=L_OD,h=L_Len-1,$fn=8);
                    translate([0,0,L_Len-1.01])
                    cylinder(d1=L_OD,d2=0,h=3.01,$fn=8);
                }
            } else {
                translate([0,0,0])
                rotate([-90,0,0])
                rotate([0,0,22.5])
                cylinder(d=L_OD,h=L_Len,$fn=8);
            }
            translate([-Oct_Rad,0,-Ht-1])
            cube([Oct_OD,L_Len,Ht+1]);

        }
        translate([-Oct_OD,-1,-Ht-Ht])
        cube([Oct_OD*2,L_Len+2,Ht]);
    }
}
module Wing_Center()
{
    difference()
    {
        cylinder(d=C_OD,h=Ht,$fn=W_iRes);
        rotate([0,0,-(180-Wing_Ang)])
        translate([0,-Wing_OD,-5])
        cube([Wing_OD*2,Wing_OD*2,50]);     //Cut out Bottom Left side to create Wing

        translate([0,-Wing_OD,-5])
        cube([Wing_OD*2,Wing_OD*2,50]);     //Cut off the Complete Right side to create Wing
    }
}
module Wing_OuterEdge()
{
    difference()
    {
        cylinder(d=Wing_OD,h=Ht,$fn=W_iRes);    //Outer Diameter

        translate([0,0,-1])
        cylinder(d=Wing_OD2,h=Ht+4,$fn=W_iRes); //Create Outside Edge

        rotate([0,0,-(180-Wing_Ang)])
        translate([0,-Wing_OD,-5])
        cube([Wing_OD*2,Wing_OD*2,50]);         //Cut out Bottom Left side to create Wing

        translate([0,-Wing_OD,-5])
        cube([Wing_OD*2,Wing_OD*2,50]);         //Cut off the Complete Right side to create Wing
        HeatBd_Holes();

    }
}
module HeatBd_Holes()
{
    for (r =[0:(HeatBd_Hole_Qty)-1])
    {
        rotate([0,0,Hole_InitialRotate+(r*HeatBd_Hole_Rot)])
        translate([0,HeatBd_Hole_Rad,-1])
        cylinder(d=Heat_OD,Ht+4,$fn=24);
        if (HeatBd_Hole_Dbl == 2)
        {
            rotate([0,0,-Hole_InitialRotate+(r*HeatBd_Hole_Rot)])
            translate([0,HeatBd_Hole_Rad,-1])
            cylinder(d=Heat_OD,Ht+4,$fn=24);            
        }
    }
}
module DrawUnion()
{
    union()
    {
        Wing_Center();
        Wing_OuterEdge();
        if (DrawOutLedge == 1)
        {
            RimLedgeOct();                     //Draw the Outside Ledge
        }
        if (DrawMidLedge == 1)
        {
            MidRimLedgeOct();
        }
        if (DrawInnerLedge == 1)
        {
            InRimLedgeOct();                   //Draw the Inside Ledge
        }
        translate([0,0,0])
        Ledge1();
        rotate([0,0,Wing_Ang])
        translate([0,0,0])
        Ledge1();
        if (DrawSpokes == 1)
        {
            if (Spokes > 2)
            {
                for (r = [1: (Spokes - 2)])
                {
                    //echo("**Ang = ",r*Spoke_Ang);
                    rotate([0,0,r*Spoke_Ang])
                    Ledge1();
                }
            }
        }
        if (DrawBars == 0)
        {
            TriBracketLt();
            TriBracketRt();
        }
    }
}
//Holes for Inner Bracket on One End
module Holes_2()
{
    translate([-Oval_X_Offset,CO_Y_Offset ,-1])
    cylinder(d=Brac_OD,h=Ht+2);

    translate([-Oval_X_Offset,CO_Y_Offset+Oval_Y_Offset ,-1])
    cylinder(d=Brac_OD,h=Ht+2);
}
//Holes for Inner Bracket on Both Sides
module Holes_4()
{
    Holes_2();
    rotate([0,0,Wing_Ang])
    translate([Oval_X_Offset*2,0,0])
    Holes_2();
}
module RimLedgeOct()
{
    translate([0,0,Ht])
    difference()
    {
        translate([0,0,0])
        rotate_extrude(convexity = 10, $fn = W_iRes)
        translate([Wing_Rad - Oct_Rad,0,0])
        rotate([0,0,22.5])
        circle(r = L_Rad, $fn = 8);
        translate([0,0,-Ht-1])
        cylinder(d=Wing_OD+3,h=Ht,$fn=300);

        rotate([0,0,-(180-Wing_Ang)])
        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);             //Cut out Bottom Left side to create Wing

        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);             //Cut off the Complete Right side to create Wing
//        translate([Oct_Rad,Wing_Rad-L_OD,-(Sq_Z)])
//        rotate([0,-45,0])
//        cube([L_OD*2,L_OD*2,L_OD*2]);           //Chamfer the Right End of Inner Ledge
//
//        rotate([0,0,120])
//        translate([-Oct_Rad,Wing_Rad-L_OD,-(Sq_Z)])
//        rotate([0,45,0])
//        translate([-(L_OD*2),0,0])
//        cube([L_OD*2,L_OD*2,L_OD*2]);           //Chamfer the Left End of Inner Ledge
    }
}
module MidRimLedgeOct()
{
    difference()
    {
        union()
        {
            translate([0,0,Ht])
            rotate_extrude(convexity = 10, $fn = W_iRes)
            translate([MidLedge_offset,0,0])
            rotate([0,0,22.5])
            circle(r = L_Rad, $fn = 8);
            translate([0,0,0])
            difference()
            {
                cylinder(r=MidLedge_offset+Oct_Rad,h=Ht+1,$fn=W_iRes);
                translate([0,0,-1])
                cylinder(r=MidLedge_offset-Oct_Rad,h=Ht+3,$fn=W_iRes);
            }
        }
        translate([0,0,-Ht-1])
        cylinder(d=Wing_OD+3,h=Ht,$fn=300);

        rotate([0,0,-(180-Wing_Ang)])
        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);     //Cut out Bottom Left side to create Wing

        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);     //Cut off the Complete Right side to create Wing
    }
}
module InRimLedgeOct()
{
    translate([0,0,Ht])
    difference()
    {
        rotate_extrude(convexity = 10, $fn = W_iRes)
        translate([C_Rad - Oct_Rad,0,0])
        rotate([0,0,22.5])
        circle(r = L_Rad, $fn = 8);

        translate([0,0,-Ht-1])
        cylinder(d=C_OD+3,h=Ht);
        rotate([0,0,-(180-Wing_Ang)])
        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);             //Cut out Bottom Left side to create Wing

        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);             //Cut off the Complete Right side to create Wing
//        translate([Oct_Rad,C_Rad-L_OD,-(Sq_Z)])
//        rotate([0,-45,0])
//        cube([L_OD*2,L_OD*2,L_OD*2]);           //Chamfer the Right End of Inner Ledge
//
//        rotate([0,0,120])
//        translate([-Oct_Rad,C_Rad-L_OD,-(Sq_Z)])
//        rotate([0,45,0])
//        translate([-(L_OD*2),0,0])
//        cube([L_OD*2,L_OD*2,L_OD*2]);           //Chamfer the Left End of Inner Ledge
    }
}
module BrassBarCuts()
{
    translate([0,100,BarHt])
    rotate([0,90,0])
    cylinder(d=BrDia,h=125,center=true);
  
    translate([0,134,BarHt])
    rotate([0,90,0])
    cylinder(d=BrDia,h=14,center=true);
}
//Use this for cutting out center part of 120 degree Wings
module CenterCut120()
{
    translate([0,0,-1])
    linear_extrude(height = Ht+2, center = false, convexity = 10)polygon(points = 
    [[-46.96,-27.11],[5,-27.11],[0,54.23],[-2.85,36.75],[-2.99,36.09],
    [-3.18,35.44],[-3.43,34.81],[-3.74,34.21],[-4.1,33.64],[-4.5,33.09],
    [-4.95,32.59],[-5.44,32.13],[-5.97,31.71],[-6.54,31.34],[-7.14,31.02],
    [-7.76,30.75],[-8.4,30.54],[-9.06,30.39],[-9.73,30.29],[-10.4,30.25],
    [-11.08,30.27],[-11.8,30.36],[-21.62,32.03],[-22.31,32.14],[-23.01,32.22],
    [-23.7,32.27],[-24.4,32.31],[-25.1,32.31],[-25.8,32.3],[-26.49,32.26],
    [-27.19,32.19],[-27.88,32.1],[-28.57,31.99],[-29.25,31.85],[-29.93,31.69],
    [-30.61,31.51],[-31.27,31.3],[-31.93,31.07],[-32.58,30.81],[-33.22,30.54],
    [-33.85,30.24],[-34.47,29.92],[-35.08,29.57],[-35.68,29.21],[-36.26,28.83],
    [-36.83,28.42],[-37.39,28],[-37.93,27.56],[-38.45,27.1],[-38.96,26.62],
    [-39.45,26.12],[-39.92,25.61],[-40.38,25.08],[-40.81,24.53],[-41.31,23.85],
    [-41.65,23.08],[-41.91,22.43],[-42.14,21.77],[-42.35,21.1],[-42.53,20.43],
    [-42.69,19.75],[-42.83,19.07],[-42.94,18.38],[-43.03,17.68],[-43.1,16.99],
    [-43.14,16.29],[-43.15,15.59],[-43.15,14.9],[-43.11,14.2],[-43.06,13.5],
    [-42.98,12.81],[-42.87,12.12],[-42.74,11.43],[-42.59,10.75],[-42.41,10.08],
    [-42.21,9.41],[-41.99,8.75],[-41.74,8.09],[-41.47,7.45],[-41.18,6.81],
    [-40.87,6.19],[-40.53,5.58],[-40.18,4.98],[-39.8,4.39],[-39.4,3.82],
    [-38.99,3.26],[-38.55,2.71],[-32.19,-4.96],[-31.75,-5.54],[-31.4,-6.12],
    [-31.09,-6.72],[-30.84,-7.35],[-30.65,-8],[-30.51,-8.66],[-30.43,-9.33],
    [-30.41,-10.01],[-30.45,-10.68],[-30.54,-11.35],[-30.7,-12.01],[-30.91,-12.65],
    [-31.18,-13.27],[-31.5,-13.87],[-31.87,-14.43],[-32.29,-14.96],[-32.75,-15.46],
    [-33.25,-15.91],[-46.96,-27.11]]);
}
//Use this for cutting out center part of 90 degree Wings
module CenterCut90()
{
    translate([0,0,-1])
    linear_extrude(height = Ht+2, center = false, convexity = 10)polygon(points = 
    [[0,54.23],[5,-5],[-54.23,0],[-43.33,1.78],[-42.66,1.92],
    [-42.02,2.11],[-41.39,2.36],[-40.78,2.67],[-40.21,3.03],[-39.66,3.43],
    [-39.16,3.88],[-38.7,4.38],[-38.28,4.91],[-37.91,5.48],[-37.59,6.08],
    [-37.32,6.7],[-37.11,7.34],[-36.96,8],[-36.86,8.67],[-36.83,9.35],
    [-36.85,10.03],[-36.93,10.7],[-38.09,17.66],[-38.19,18.37],[-38.27,19.08],
    [-38.33,19.79],[-38.36,20.51],[-38.36,21.22],[-38.33,21.94],[-38.29,22.65],
    [-38.21,23.36],[-38.11,24.07],[-37.99,24.78],[-37.84,25.48],[-37.66,26.17],
    [-37.46,26.86],[-37.24,27.54],[-36.99,28.21],[-36.72,28.87],[-36.42,29.52],
    [-36.11,30.16],[-35.76,30.79],[-35.4,31.41],[-35.02,32.01],[-34.61,32.6],
    [-34.18,33.17],[-33.73,33.73],[-33.17,34.18],[-32.6,34.61],[-32.01,35.02],
    [-31.41,35.4],[-30.79,35.76],[-30.16,36.11],[-29.52,36.42],[-28.87,36.72],
    [-28.21,36.99],[-27.54,37.24],[-26.86,37.46],[-26.17,37.66],[-25.48,37.84],
    [-24.78,37.99],[-24.07,38.11],[-23.36,38.21],[-22.65,38.29],[-21.94,38.33],
    [-21.22,38.36],[-20.51,38.36],[-19.79,38.33],[-19.08,38.27],[-18.37,38.19],
    [-17.66,38.09],[-10.7,36.93],[-10.03,36.85],[-9.35,36.83],[-8.67,36.86],
    [-8,36.96],[-7.34,37.11],[-6.7,37.32],[-6.08,37.59],[-5.48,37.91],
    [-4.91,38.28],[-4.38,38.7],[-3.88,39.16],[-3.43,39.66],[-3.03,40.21],
    [-2.67,40.78],[-2.36,41.39],[-2.11,42.02],[-1.92,42.66],[-1.78,43.33]]);
}
//Use this for cutting out center part of 60 degree Wings
module CenterCut60()
{
    translate([0,0,-1])
    linear_extrude(height = Ht+2, center = false, convexity = 10)polygon(points = 
    [[0,155],[3,-5],[-46.96,27.11],[-42.79,25.54],[-42.14,25.32],
    [-41.48,25.17],[-40.8,25.07],[-40.12,25.03],[-39.44,25.06],[-38.76,25.14],
    [-38.1,25.28],[-37.44,25.48],[-36.81,25.74],[-36.2,26.05],[-35.63,26.42],
    [-35.08,26.83],[-34.58,27.29],[-34.12,27.79],[-33.7,28.33],[-33.34,28.91],
    [-29.34,35.82],[-29,36.38],[-28.64,36.93],[-28.25,37.46],[-27.84,37.97],
    [-27.41,38.46],[-26.96,38.93],[-26.49,39.38],[-25.99,39.81],[-25.48,40.22],
    [-24.96,40.61],[-24.41,40.97],[-23.85,41.31],[-23.28,41.63],[-22.69,41.92],
    [-22.09,42.18],[-21.48,42.42],[-20.86,42.63],[-20.23,42.81],[-19.6,42.97],
    [-18.96,43.1],[-18.31,43.2],[-17.66,43.27],[-17.01,43.31],[-16.35,43.32],
    [-8.37,43.32],[-7.69,43.35],[-7.01,43.44],[-6.34,43.59],[-5.69,43.8],
    [-5.06,44.06],[-4.46,44.38],[-3.89,44.75],[-3.35,45.17],[-2.85,45.63],
    [-2.39,46.14],[-1.98,46.68],[-1.62,47.26],[-1.31,47.87],[-1.06,48.5],
    [-0.86,49.16],[-0.72,49.83],[0,54.23]]);
}
module DrawWing()
{
    difference()
    {
        DrawUnion();
        rotate([0,0,-(180-Wing_Ang)])
        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);     //Cut out Bottom Left side to create Wing

        translate([0,-Wing_OD,-20])
        cube([Wing_OD*2,Wing_OD*2,50]);     //Cut off the Complete Right side to create Wing
        if (DrawOutLedge == 0)
        {
            translate([0,Wing_Rad,-1])
            cylinder(d=6,h=Ht*2,$fn=4);
            rotate([0,0,Wing_Ang])
            translate([0,Wing_Rad,-1])
            cylinder(d=6,h=Ht*2,$fn=4);
        }
        if (C_Cut == 1)
        {
            if (Wing_Ang == 120)
            {
                CenterCut120();
            } else if (Wing_Ang == 60)
            {
                CenterCut60();
            } else {
                CenterCut90();
            }
        } else {
            translate([0,0,-1])
            cylinder(d=Wing_ID,h=Ht+2);
        }
        Holes_4();
        rotate([0,0,Wing_Ang])
        Holes_4();
        if (DrawBars == 1)
        {
            BrassBarCuts();
            rotate([0,0,120])
            BrassBarCuts();
        }
    }
}

if (Assembled == 0)
{
    if (DrawBars == 0)
    {
        %BracketSupports();
        rotate([0,0,Wing_Ang])
        %BracketSupports();
    }
    DrawWing();
}
if (Assembled == 1)
{
    %HeatBed();
    %GlassPlate();
    for (r =[0:(HeatBd_Hole_Qty)-1])
    {
        rotate([0,0,Hole_InitialRotate+(r*HeatBd_Hole_Rot)])
        %HeatBd_Bolt();
    }
    for (r =[0:NumOfWings-1])
    {
        rotate([0,0,r*Wing_Ang])
        DrawWing();
    }
    for (r =[0:NumOfWings-1])
    {
        rotate([0,0,r*Wing_Ang])

        %BracketSupports();
        rotate([0,0,r*Wing_Ang])

        %BracketSupports();
    }
    if (DrawBars == 1)
    {
        %BrassBarCuts();
        rotate([0,0,120])
        %BrassBarCuts();
        rotate([0,0,-120])
        %BrassBarCuts();
    }
}