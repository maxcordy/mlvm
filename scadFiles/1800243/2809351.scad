{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 use <write/Write.scad>\
use <Write.scad>\
 \
// preview[view:south, tilt:top]\
\
/* [global] */\
//Approx width of the heart. Small: 15mm / Medium: 30mm / Large: 50mm\
heart_size = 30; // [10:Small,20:Medium,30:Large]\
\
\
\
//For initials, this is meant for one letter only. \
left_initial = \'93A\'94; \
right_initial = \'93S\'94; \
w=heart_size;\
//l=20;\
\
//Select font. \
your_font = "write/Letters.dxf"; // ["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/knewave.dxf":Knewave,"write/BlackRose.dxf":Blackrose, "write/braille.dxf":Braille]\
\
\
/* [hidden] */\
thickness = 2.5; \
h=0;\
\
lx = (sqrt((w*w)/2));\
ly = 1.5*(sqrt((w*w)/2));\
diag = sqrt(2*w*w); \
c2x=.85*lx;\
c2y=.80*ly;\
c3x=1.15*lx; \
c3y=.60*ly; \
\
\
$fn=150; \
\
module heart() \{\
translate([.5*(sqrt((w*w)/2)),1.5*(sqrt((w*w)/2)),h]) circle(w/2); \
translate([1.5*(sqrt((w*w)/2)),1.5*(sqrt((w*w)/2)),h]) circle(w/2); \
translate([sqrt((w*w)/2),0,0]) rotate([0,0,45]) square([w,w]);\
\}\
\
module rightSquare() \{\
polygon( [ [(lx),(1.2*diag)],[(lx),(.75*diag)],[c2x,c2y],[c3x,c3y],[(lx),(.30*diag)],[(lx),(-2)],[(2.5*lx),(-2)],[(2.5*lx),(1.2*diag)] ] , [ [0,1,2,3,4,5,6,7,8] ]); \
\}\
\
module leftSquare() \{\
polygon( [ [(lx),(1.2*diag)],[(lx),(.75*diag)],[c2x,c2y],[c3x,c3y],[(lx),(.30*diag)],[(lx),(-2)],[(-20),(-2)],[(-20),(1.2*diag)] ] , [ [0,1,2,3,4,5,6,7,8] ]); \
\}\
\
\
module leftSection() \{\
difference() \{\
heart();\
rightSquare(); \
\}\
\
\}\
\
module rightSection() \{\
difference() \{\
heart();\
leftSquare(); \
\}\
\
\}\
\
linear_extrude(height = thickness) leftSection(); \
translate([5,0,0]) linear_extrude(height = thickness) rightSection(); \
\
//difference() \{\
\
//linear_extrude(height = thickness) heart(); \
//jaggedLine(); \
\
//\}\
\
if (heart_size == 10) \{\
\
translate([(.2*lx),(.6*diag),thickness-.01]) write(left_initial,t=.75,h=5,center=false, font=your_font); \
translate([((1.35*lx)+5),(.6*diag),thickness-.01]) write(right_initial,t=.75,h=5,center=false, font=your_font); \
\
\} else if (heart_size == 20) \{\
\
translate([(.2*lx),(.6*diag),thickness-.01]) write(left_initial,t=1,h=10,center=false, font=your_font); \
translate([((1.35*lx)+5),(.6*diag),thickness-.01]) write(right_initial,t=1,h=10,center=false, font=your_font); \
\
\} else if (heart_size == 30) \{\
\
translate([(.2*lx),(.6*diag),thickness-.01]) write(left_initial,t=1,h=13,center=false, font=your_font); \
translate([(1.35*lx)+5,(.6*diag),thickness-.01]) write(right_initial,t=1,h=13,center=false, font=your_font); \
\
\}\
\
difference() \{\
translate([(.4*lx),(1.15*diag),0]) cylinder((.5*thickness),3,3); \
translate([(.4*lx),(1.15*diag),-1]) cylinder((thickness),1.5,1.5); \
\
\}\
\
difference() \{\
translate([(1.6*lx)+5,(1.15*diag),0]) cylinder((.5*thickness),3,3); \
translate([(1.6*lx)+5,(1.15*diag),-1]) cylinder((thickness),1.5,1.5); \
\
\}\
\
\
\
 \
\
\
\
\
\
}