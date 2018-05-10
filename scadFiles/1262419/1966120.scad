// Modified Carriage for Emmett-Delta
// By David Bunch
//
// Which is based on Delta-Six 3D Printer carriage
// which was Created by Sage Merrill
// Released on Openbuilds.com
// which in turn was Based on orginal design by Johann C. Rocholl (Kossel Printer)
// License = Attribution Share Alike - CC BY SA
//
//Variables for Carriage
Car_Ht = 11.71;
M3 = 3.4;
M3Ht = 14.5;
//M3Nut = 2.066*M3;
M3Nut = 7.0;
M3NutHt = .9*M3;
//echo("M3Nut = ", M3Nut);
//echo("M3NutHt = ", M3NutHt);
M3_ires = 24;
module Carriage()
{
//Draw Basic Outline of Carriage
    linear_extrude(height = Car_Ht, center = false, convexity = 10)polygon(points = 
    [[-19.16,-15.95],[19.16,-15.95],[27.5,-7.61],[27.5,-0.39],[21.41,5.71],
    [-21.41,5.71],[-27.5,-0.39],[-27.5,-7.61]]);
}
module BeltGroove()
{
    union()
    {
        translate([0,0,4])
        linear_extrude(height = Car_Ht, center = false, convexity = 10)polygon(points = 
        [[9.14,-14.78],[8.85,-14.78],[8.59,-14.66],[8.4,-14.46],[8.3,-14.19],
        [8.3,-13.91],[8.42,-13.65],[8.62,-13.46],[8.88,-13.36],[8.79,-12.81],
        [8.51,-12.81],[8.25,-12.69],[8.05,-12.49],[7.95,-12.22],[7.96,-11.94],
        [8.07,-11.68],[8.27,-11.49],[8.54,-11.39],[8.44,-10.84],[8.16,-10.84],
        [7.9,-10.72],[7.7,-10.52],[7.6,-10.26],[7.61,-9.97],[7.72,-9.71],
        [7.93,-9.52],[8.19,-9.42],[8.09,-8.87],[7.81,-8.87],[7.55,-8.75],
        [7.36,-8.55],[7.25,-8.29],[7.26,-8],[7.37,-7.74],[7.58,-7.55],
        [7.84,-7.45],[7.75,-6.9],[7.46,-6.9],[7.21,-6.78],[7.01,-6.58],
        [6.91,-6.32],[6.91,-6.03],[7.03,-5.77],[7.23,-5.58],[7.49,-5.48],
        [7.4,-4.93],[7.12,-4.93],[6.86,-4.81],[6.66,-4.61],[6.56,-4.35],
        [6.57,-4.06],[6.68,-3.81],[6.88,-3.61],[7.15,-3.51],[7.05,-2.96],
        [6.77,-2.96],[6.51,-2.84],[6.32,-2.64],[6.21,-2.38],[6.22,-2.09],
        [6.33,-1.84],[6.54,-1.64],[6.8,-1.54],[6.7,-0.99],[6.42,-0.99],
        [6.16,-0.87],[5.97,-0.67],[5.87,-0.41],[5.87,-0.12],[5.99,0.13],
        [6.19,0.33],[6.45,0.43],[6.36,0.97],[6.07,0.98],[5.82,1.09],
        [5.62,1.3],[5.52,1.56],[5.52,1.84],[5.64,2.1],[5.84,2.3],
        [6.11,2.4],[6.01,2.94],[5.73,2.95],[5.47,3.06],[5.27,3.27],
        [5.17,3.53],[5.18,3.81],[5.29,4.07],[5.5,4.27],[5.76,4.37],
        [5.66,4.91],[5.38,4.92],[5.12,5.03],[4.93,5.24],[4.69,5.61],
        [4.47,6.2],[6.55,6.2],[10.54,-16.45],[8.55,-16.45],[8.65,-15.88],
        [8.76,-15.62],[8.97,-15.43],[9.23,-15.32]]);
        translate([6.55,6.2,11.7])
        rotate([0,0,10])
        rotate([90,0,0])
        cylinder(d=2.2,h=23,$fn=4);
    }
}

module DrawCarriage()
{
    translate([0,4,0])      //Put traxxas connections on centerline
    difference()
    {
        Carriage();
        translate([-12,-16.95,1])
        cube([10,23.65,20]);
        BeltGroove();
        translate([-3.85,0,0])
        BeltGroove();
    
        translate([-28.5,-4,7])
        rotate([0,90,0])
        cylinder(d=M3,h=M3Ht,$fn=M3_ires);  //Cut for M3 bolt on Left Side
        translate([14,-4,7])
        rotate([0,90,0])
        cylinder(d=M3,h=M3Ht,$fn=M3_ires);  //Cut for M3 bolt on Left Side
    
        translate([-20,-4,7])
        rotate([0,90,0])
        cylinder(d=M3Nut,h=M3NutHt,$fn=6);  //Cut opening for Left Jam Nut
        translate([-20,-4,10])
        rotate([0,90,0])
        cylinder(d=M3Nut,h=M3NutHt,$fn=6);  //Make sure nut is open to top
    
        translate([17.2,-4,7])
        rotate([0,90,0])
        cylinder(d=M3Nut,h=M3NutHt,$fn=6);  //Cut opening for Left Jam Nut
        translate([17.2,-4,10])
        rotate([0,90,0])
        cylinder(d=M3Nut,h=M3NutHt,$fn=6);  //Make sure nut is open to top
    
        translate([-28,5.71,Car_Ht])
        rotate([0,90,0])
        cylinder(d=16,h=17,$fn=4);           //Chamfer the bottom Left side a little more
    //Originally 11.5,-3.49,11.71, but changed to give more plastic at new belt clamp
        translate([11.2,5.71,Car_Ht])
        rotate([0,90,0])
        cylinder(d1=0,d2=16,h=6,$fn=4);           //Chamfer the bottom Left side a little more
        translate([11.2+6,5.71,Car_Ht])
        rotate([0,90,0])
        cylinder(d=16,h=17,$fn=4);           //Chamfer the bottom Left side a little more
    
        translate([-27.5,-15.95,Car_Ht])
        rotate([0,90,0])
        cylinder(d=6,h=55,$fn=4);           //Chamfer the bottom side Edge

        translate([-27.5,-15.95,Car_Ht])
        rotate([0,90,0])
        cylinder(d=16,h=16,$fn=4);           //Chamfer the bottom Left side a little more
        translate([-27.5,5.71,Car_Ht])
        rotate([0,90,0])
        cylinder(d=6,h=55,$fn=4);           //Chamfer the bottom side Edge
//slice off top & bottom sides a sliver to make an even dimension
        translate([-30,-25.3,-1])
        cube([60,10,20]);
        translate([-30,4.9,-1])
        cube([60,10,20]);
    }
}
//DrawCarriage();