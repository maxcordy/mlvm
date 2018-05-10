//Watch Strap keeper
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"watch_strap_keeper" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//22/9/2016 - Released

/* [Options] */
// preview[view:south east, tilt:top diagonal]
// Watch strap thickness. Be sure to increase the thickness if the strap make several pass through the keeper. i.e. Nato or Zulu strap.   
Strap_thickness=1.2*3.5; // [1:10]
// Width of the strap.
Strap_width=24; // [5:30]
// Thickness of the keeper.
Keeper_thickness=2; // [1:5]
// Width of the keeper.
Keeper_width=3; // [1:5]
//Shape of keeper edge.
Edge = 1; //[0:Square, 1:Round]
//Strap entry slit.
Slit = 0; //[0:No, 1:Yes]
// Position for printing.
Print=0; // [0:No, 1:Yes]

/* [Hidden] */

strapT=Strap_thickness;
strapW=Strap_width;
keeperT=Keeper_thickness;
keeperW=strapW+keeperT*2;
keeperL=Keeper_width;
keeperH=strapT+keeperT*2;
edge=Edge;
slit=Slit; //entry slit
slitAngle=0;
print=Print;
epsilon=0.1;
$fn=40;

module strap() {
    cube([strapW*3,strapW,strapT],center=true);
}

module kround(T=keeperT,e=0) {
    kR=strapT/2;
    hull() {
        translate([0,keeperW/2-kR*2,0]) rotate([0,90,0]) cylinder(r=kR+T,h=keeperL+e,center=true);
        translate([0,-keeperW/2+kR*2,0]) rotate([0,90,0]) cylinder(r=kR+T,h=keeperL+e,center=true);
    }
}

module keeper() {
    if (edge) {
        difference() {
            kround();
            kround(T=0,e=epsilon);
        }
    } else {
        difference() {
            cube([keeperL,keeperW,keeperH],center=true);
            cube([keeperL+epsilon,strapW,strapT],center=true);
        }
    }
}

rotY = print?90:0;
 rotate([0,rotY,0]) union() {
    %strap();
    difference() {
        keeper();
        if (slit) {
            rotate([0,0,slitAngle]) translate([0,0,-keeperH/2]) cube([keeperL*4,keeperW/6,keeperH],center=true);
        }
    }
}