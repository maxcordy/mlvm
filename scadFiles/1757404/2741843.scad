//Handle Replacement for Nalgene Wide Mouth
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"nalgene_wide_mouth_handle" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//7/9/2016 - Released
//8/9/2016
//-Added a wedge to reduce gap between clip and cap
//-Added an option for a clip cover 
//-Customizable version

/* [Options] */
// preview[view:north east, tilt:side]
// Gap between clip and cap.   
Gap=1.0; // [0:4]
// Mount plate thickness
Mount_thickness=5; // [5:10]
// Generate cover for the handle clip? Advisable for permanent replacement
Cover=0; // [0:No,1:Yes]

/* [Hidden] */
$fn=60;
epsilon=0.1;
//cap
capD=57-1;//exclude ridges
capR=capD/2;
capH=16.7;
capD1=6.6+2.3*2;
capR1=capD1/2;
capH1=2;
capD2=19;
capR2=capD2/2;
capH2=2;
capD3=capD1;
capR3=capD3/2;
capH3=1;
//clip
tight=0;
clipgap=Gap;
clipcover=Cover;
cliptotalH=capH1+capH2+capH3;
clipH=cliptotalH+2;
clipL=capD-5;
clipW=capD2+4;
clipCH1=capH1;
clipCL1=capD1-tight;
clipCW1=capD2;
clipCZ1=clipCH1/2;
clipCH2=capH2;
clipCL2=capD2-tight;
clipCW2=capD2;
clipCZ2=clipCH1/2+clipCH2;
clipCH3=capH3;
clipCL3=capD3-tight;
clipCW3=capD2;
clipCZ3=clipCH1+clipCH2+clipCH3/2;

module cap(e=0,bottom=1) {
    if (bottom) {
        translate([0,0,-capH]) cylinder(r=capR,h=capH);
    }
    translate([0,0,-e/2]) cylinder(r=capR1+e,h=capH1+e);
    translate([0,0,capH1-e/2]) cylinder(r=capR2+e,h=capH2+e);
    translate([0,0,capH1+capH2-e/2]) cylinder(r=capR3+e,h=capH3+e);
}

module clip(L=clipL,e=epsilon) {
    difference() {
        translate([0,0,clipH/2]) union() {
            cube([L,clipW,clipH],center=true);
            translate([0,0,clipH/2]) rotate([90,0,0]) hgap(L=clipL-4);
        }
        cap(bottom=0);
        translate([0,0,-2]) cylinder(r=capR1,h=capH1+2);
        translate([0,clipCW1/2,clipCZ1]) cube([clipCL1,clipCW1,clipCH1+2+e],center=true);
        translate([0,clipCW2/2,clipCZ2]) cube([clipCL2,clipCW2,clipCH2+e],center=true);
        translate([0,clipCW3/2,clipCZ3]) cube([clipCL3,clipCW3,clipCH3+e],center=true);
        if (clipcover) {
            translate([0,clipcoverW/2+capD2/2,-(clipH-cliptotalH)/2-2/2]) clipcover(e=epsilon,H=cliptotalH+2);
        }
    }
}

module clipcover2() {
    difference() {
        translate([0,0,clipH/2]) cube([clipL-epsilon,clipW-epsilon,clipH-epsilon],center=true);
        union() {
            clip(e=0);
            cap(e=epsilon);
        }
    }
}
clipcoverW=(clipW-capD2)/2;
module clipcover(e=0,H=cliptotalH) {
    translate([0,epsilon/2,clipH/2]) cube([clipCW2,clipcoverW+epsilon,H],center=true);
}

handleD=clipL;
handleR=handleD/2;
handleH=clipW;
handleT=4;
module h1(gap=clipgap) {
difference() {
        cylinder(r=handleR,h=handleH,center=true);
        cylinder(r=handleR-handleT,h=handleH+epsilon,center=true);
        translate([0,-handleR-clipH-gap,0]) cube([handleD,handleD,handleH+epsilon],center=true);
    }
}

module hgap(L=clipL){
    rotate([0,0,atan(-clipgap*2/L)]) translate([0,-clipH,-clipW/2]) cube([L/2,clipgap,clipW]);
    mirror([1,0,0]) rotate([0,0,atan(-clipgap*2/L)]) translate([0,-clipH,-clipW/2]) cube([L/2,clipgap,clipW]);
}
module hgap1(intersect=1){
    difference() {
        intersection() {
            h1();   
            hgap();
        }
        hdull();
    }
}
module hdull() {
//dull the edge
     translate([0,0,handleH/2]) cylinder(r2=handleR-handleT+2,r1=handleR-handleT,h=2,center=true);
        mirror([0,0,1]) translate([0,0,handleH/2]) cylinder(r2=handleR-handleT+2,r1=handleR-handleT,h=2,center=true);
        translate([0,0,-handleH/2]) difference() {
            cylinder(r=handleR+epsilon,h=2,center=true);
            cylinder(r2=handleR,r1=handleR-2,h=2,center=true);
        }
        mirror([0,0,1]) translate([0,0,-handleH/2]) difference() {
            cylinder(r=handleR+epsilon,h=2,center=true);
            cylinder(r2=handleR,r1=handleR-2,h=2,center=true);
        }
}
module h2() {
    difference() { 
        h1(gap=clipgap/2);
        hdull();   
    }   
    hgap1();
    //difference() {
        //hgap(L=clipL-4);
        //rotate([]) cap(bottom=0);
    //}
    
}
module handle() {
    translate([0,0,clipH]) rotate([90,0,0]) h2();
    clip(L=clipL-4);
}

handle();
%cap();
if (clipcover) {
    translate([0,capD,0]) clipcover();
}