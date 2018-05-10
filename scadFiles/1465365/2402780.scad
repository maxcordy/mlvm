//BY DOWNLOADING, OPENING AND/OR USING THIS WORK YOU AGREE TO THE TERMS AND CONDITIONS CONTAINED AT THE END OF THIS FILE.

$fn=90;

//Outer contours and clasps.
size=6.7;

//1=4 turns, 2=6 turns.
turns=2;

thickness=1.5;

//Y axis width.
width=12;

//Z axis height.
height=6;

//Force spring clasp rafts for all sizes.
raft=true;

//Raft size. Only make this bigger.
raftsize=2;

//This guide places a marker starting from the center point of the first clasp. You can then use 'size' and 'turns' to match the marker at the far end of the spring.
measure=38;

//Generate spring clip. 0=Spring, 1=Clip. Print these clips to prevent springs from moving.
clip=0;


echo();
echo("Current Length");
echo((size*2-thickness*2)+(size*2-thickness*2)*turns+size);
echo();
echo("Inner Diameter");
echo(size-thickness);
echo();

%color("red",0.5) translate([-size+measure,0,0]) cylinder(height*2,1/2,1/2);

if (clip==0 || clip==1) {
translate([-size+thickness,0,0]) {
difference() {
union() {
cylinder(height,size/2,size/2,true);
if (raft==true) {
translate([0,0,-height/2+0.1]) cylinder(0.2,size/2+raftsize,size/2+raftsize,true);
}
if (size<10) {
translate([0,0,-height/2+0.1]) cylinder(0.2,size/2+raftsize,size/2+raftsize,true);
}
}
    
cylinder(height,size/2-thickness,size/2-thickness,true);
translate([size/4-thickness,size/2,0]) cube([size/2,size,height],true);
}
}
}

if (clip==0) {
translate([(size*2-thickness*2)+(size*2-thickness*2)*turns,0,0]) {
%color("blue",0.5) cylinder(height*2,1/2,1/2,true);
difference() {
union() {
cylinder(height,size/2,size/2,true);
if (raft==true) {
translate([0,0,-height/2+0.1]) cylinder(0.2,size/2+raftsize,size/2+raftsize,true);
}
if (size<10) {
translate([0,0,-height/2+0.1]) cylinder(0.2,size/2+raftsize,size/2+raftsize,true);
}
}
cylinder(height,size/2-thickness,size/2-thickness,true);
translate([-size/4+thickness,-size/2,0]) cube([size/2,size,height],true);
}
}


for (i = [0:size*2-thickness*2:(size*2-thickness*2)*turns]) {

difference() {
hull() {
translate([i,width-size/2,0]) cylinder(height,size/2,size/2,true);
translate([i,-width+size/2,0]) cylinder(height,size/2,size/2,true);
}

hull() {
translate([i,width-size/2,0]) cylinder(height,size/2-thickness,size/2-thickness,true);
translate([i,-width+size/2,0]) cylinder(height,size/2-thickness,size/2-thickness,true);
}
translate([i,-width/2,0]) cube([size,width,height],true);
}

difference() {
hull() {
translate([size-thickness+i,width-size/2,0]) cylinder(height,size/2,size/2,true);
translate([size-thickness+i,-width+size/2,0]) cylinder(height,size/2,size/2,true);
}

hull() {
translate([size-thickness+i,width-size/2,0]) cylinder(height,size/2-thickness,size/2-thickness,true);
translate([size-thickness+i,-width+size/2,0]) cylinder(height,size/2-thickness,size/2-thickness,true);
}
translate([size-thickness+i,width/2,0]) cube([size,width,height],true);
}
}
}

//License Conditions 

//Rights: 
//Save and privately distribute modified copies for the sole purpose of convenience, provided the license remains included and unmodified. 
//Use this design in a commercial setting provided it is on a single case basis. 
//Review the code and values for learning purposes. 
//Display this design in a public setting provided the appropriate attributions are included and clearly visible. 

//Conditions (without prior written permission): 
//Sell, gain profit from or relicense this design in any format or by any means, commercially or otherwise. 
//Directly copy sections of code for any other project or design. 
//Publicly redistribute or host this file. 
//The design owner can revoke all rights at any time, including all use, for any reason. Sorry.