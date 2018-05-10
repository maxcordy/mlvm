//Watch Strap Buckle
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"watch_strap_buckle" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//4/10/2016 - Updates
//-Relax the printer tolerance requirement
//-Add strengthening fillet 
//23/9/2016 - Updates
//-Code cleanup
//-Added different frame shapes
//-Added print position option
//22/9/2016 - Released

/* [Options] */
// preview[view:south east, tilt:top diagonal]
// Watch strap thickness. Be sure to increase the thickness if the strap make several pass through the keeper. i.e. Nato or Zulu strap.   
Strap_thickness=1.2; // [1:10]
// Width of the strap.
Strap_width=24; // [5:30]
// Thickness of the buckle.
Buckle_thickness=3; // [3:6]
// Height of the buckle. The tip of the prong would be half of the buckle height
Buckle_height=4; // [4:6]
//Strap entry slit.
Slit = 1; //[0:No, 1:Yes]
//Frame shapes
Frame = 6; //[0:Square, 1:Round, 2:Square wide, 3:Round wide, 4:Trapezoid Square, 5:Trapezoid Round, 6: Custom 1, 7: Custom 2]
//Open the prong
Prong_open = 0; //[0:No, 1:Yes]
// Position for printing.
Print=0; // [0:No, 1:Yes]

/* [Hidden] */
strapW=Strap_width;
strapT=Strap_thickness;
buckleH=Buckle_height;
buckleT=Buckle_thickness;
buckleW=strapW+buckleT*2;
buckleL=15;
pinD=2;
pinR=pinD/2;
prongR=buckleH/2;
prongW=2;
prongRot=Prong_open;
slit=Slit;
slitAngle=0;
shape=Frame;
print=Print;
epsilon=0.1;
$fn=40;
frameL=buckleT+strapT*1.5+buckleL+buckleT;
strapX=-strapW/2-frameL/2+buckleT+strapT;
pinX=-buckleT/2+frameL/2-buckleT-strapT*1.5;

module strap() {
    cube([strapW,strapW,buckleH],center=true);
}

module fshape() {
    //%cube([frameL,buckleW,buckleH],center=true); 
    posX=(shape==0 || shape==1) ? frameL/2-buckleT/2 : frameL/2 ;
    posY=(shape==0 || shape==1 || shape==2 || shape==3) ? buckleW/2-buckleT/2 : buckleW/2;
    if (shape==0 || shape==2 || shape==4) { //square
        hull() {
            translate([0.5-frameL/2,0,0]) cube([1,buckleW,buckleH],center=true);
            translate([posX,posY,0]) cube([buckleT,buckleT,buckleH],center=true);
            translate([posX,-posY,0]) cube([buckleT,buckleT,buckleH],center=true);
        }
    } else if (shape==1 || shape==3 || shape==5) { //round
        hull() {
            translate([-frameL/2+buckleT/2,buckleW/2-buckleT/2,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([-frameL/2+buckleT/2,-(buckleW/2-buckleT/2),0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([posX,posY,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([posX,-posY,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
        }
    } else if (shape==6) {
        hull() {
            translate([-frameL/2+buckleT/2,buckleW/2-buckleT/2,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([-frameL/2+buckleT/2,-(buckleW/2-buckleT/2),0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([posX-buckleT,posY,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([posX-buckleT,-posY,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([posX,posY-buckleT/2,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
            translate([posX,-posY+buckleT/2,0]) cylinder(r=buckleT/2,h=buckleH,center=true);
        }
    } else if (shape==7) {
        hull() {
            translate([0.5-frameL/2,0,0]) cube([1,buckleW,buckleH],center=true);
            factor=4;
            translate([posX,0,0]) scale([1,factor,1]) cylinder(r=buckleW/(factor*2),h=buckleH,center=true);
        }
    }
}
module frame() {
    difference() {
        fshape();
        translate([0,0,0]) hull() { 
            //cube([frameL-buckleT*2,strapW,buckleH+epsilon],center=true);
            coL=frameL-buckleT*2;
            coD=4;
            coR=coD/2;
            translate([0.5-coL/2,0,0]) cube([1,strapW,buckleH+epsilon],center=true);
            translate([-coR+coL/2,strapW/2-coR,0]) cylinder(r=coR,h=buckleH+epsilon,center=true);
            translate([-coR+coL/2,-strapW/2+coR,0]) cylinder(r=coR,h=buckleH+epsilon,center=true);
    }
        translate([-pinX,0,0]) pin(R=pinR+0.4,gap=0.3);
        translate([-pinX,0,0]) prong(gap=0.6,e=epsilon);
        if (slit) {
            rotate([0,0,slitAngle]) translate([-frameL/2+buckleT/2,0,0]) cube([buckleT+epsilon,buckleW/6,buckleH+epsilon],center=true);
        }
    }
}
module pin(R=pinR,gap=0) {
    rotate([90,0,0]) cylinder(r=R,h=buckleW-buckleT+gap,center=true);
}

module prong(gap=0,e=0) {
    hull() {
            cube([buckleT,prongW+gap,buckleH+gap],center=true);
            translate([pinX+buckleT/2/2+frameL/2-buckleT,0,buckleH/2/2]) cube([buckleT/2+gap,prongW+gap+e,buckleH/2+gap+e],center=true);
    }
      
    cube([buckleT,strapW-1.0,buckleH],center=true);
    pin();
}

rotX = print?180:0;
rotate([rotX,0,0]) union() {
    %translate([strapX,0,0]) strap();
    frame();
    rotY=prongRot?30:0;
    translate([-pinX,0,0]) rotate([0,-rotY,0]) prong();
}