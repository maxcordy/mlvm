use <write/Write.scad>

facetas=144;

/*

This file had been created by Tim Chandler a.k.a. 2n2r5 and is
being shared under the creative commons - attribution license.
Any and all icons, references to 2n2r5.com, 2n2r5.net, Tim
Chandler ,2n2r5 or Trademarks must remain in the the end product.
This script is free to use for any and all purposes, both
commercial and non-commercial provided that the above conditions
are met.


Please refer to http://creativecommons.org/licenses/by/3.0/
for more information on this license.
*/

/*

Script by: Tim Chandler (2n2r5)

Filename: threadless_ball_screw.scad
Date of Creation: 7/26/13
True Revision Number: V1.121
Date of Revision: 7/30/13

Description:
This will create a customizable version of thing:112718, the "Threadless Ball Screw", for mounting on the solidoodle bed.


Todo:

 - make prettier bases that fit the platform better
 - add mounting solutions to fit more applications
 - make an adjustable tension system to combat fatigue
 - create a selectable library to choose from standard bearings


*/

/* [Global] */
//Show Text Summary
text = "true" ; //[true,false]

/* [Base Shape and Size] */

// Circle or Rectangle base (more options coming)
Base_Shape= "fitting"; // ["round":Round,"box":Box] 
//"fitting" fits the number of bearings in a rounded polygon around the bearings incremented by a factor (below)

//Height of Base (OEM M3 screws will stick out around 14-15mm)
Base_Height = 22;

// -------------- "Box" Base Shape Options ---------- 

//Y width of Base
Box_Y_Width = 38;

//X width of Base
Box_X_Width = 38;

// -------------- "Round" Base Shape Option ---------

//Round Base width 
Round_Base_Width = 27;



/* [Bearing & Smooth Rod Options] */

bearing=[5,10,4]; //(Inner diameter, Outer diameter, Width)

//	PN	ID	OD	Width
//	MR105-ZZ/2RS -> (5,10,4) *my "choice" (couldn't find any other model)
//	603	3	9	3
//	604	4	12	4
//	605	5	14	5
//	606	6	17	6
//	623	3	10	4
//	624	4	13	5
//	625	5	16	5
//	626	6	19	6
//	633	3	13	5
//	634	4	16	5
//	635	5	19	6
//	636	6	22	7
//	673	3	6	2
//	674	4	7	2
//	675	5	8	2
//	676	6	10	2.5
//	684	4	9	2.5
//	685	5	11	3
//	686	6	13	3.5
//	693	3	8	3
//	694	4	11	4
//	695	5	13	4
//	696	6	15	5 

//Total Number of Bearings (use 4 bearings works best with wood bed)
Number_of_Bearings = 3; //[2,3,4,5]
//Smooth Rod Diameter
Smooth_Rod_Diameter = 8 ; //[9.525:3/8,7.9375:5/16,6.35:1/4,3:3MM,5:5MM,6:6MM,8:8MM,10:10MM,12:12MM]
//How many MM per rotation? This is like thread pitch on threaded rod.
Bearing_Pitch = 5; 

Base_increment_factor=0.7;

Smooth_rod_clearance=0.25;


//Bearing Outer Diameter
Bearing_Outer_Diameter = bearing[1] ;//

//Bearing Inner Diameter and Screw hole size
Bearing_Inner_Diameter = bearing[0] ; //[3,4,5,6]

//Bearing Width ;
Bearing_Width = bearing[2]; //[2,2.5,3,4,5,6]


//Nut Size for screws that hold bearings (this should be the same as the Bearing ID)
Bearing_Nut_Size = lookup(Bearing_Inner_Diameter,[
	[3,6.5],
	[4,8.2],
	[5,9.2],
	[6,11.4]
]); //[9:M5, 8:M4,6.3:M3]

//Screw Length
Screw_Length = 30;


//Use this to rotate the bearings if they are not in a friendly place
Bearing_Rotation_Adjustment = lookup(Number_of_Bearings, [
 		[ 2, 90 ],
 		[ 3, 120 ],
 		[ 4, 45 ],
 		[ 5, 72 ]
 	]);



//Use this to move the bearing in to create a tight fit
snug = 0.4; // [.05,.1,.15,.2,.25,.3,.35,.4]


//Tilt (Makes bearing tilt by X degrees inward or outward)
Bearing_Tilt = 0 ; //[-5:5]


//Reverse "Thread"?
Reverse_Thread = "no" ;//["yes":yes,"no":no]

/* ------------------- Rookie Line (Do not cross unless you know what you are doing) --------------------- */

/* [hidden] */

/* Variable Clean-up (makes pretty variables usable) */

BaseShape = Base_Shape	;
bif=Base_increment_factor;
mss = Mount_Screw_Size	;
sdbt = Solidoodle_Bed_Type;
mhd = Bed_Mounting_Hole_Depth;
bh = Base_Height		;
bhs = Bed_Hole_Size		;
byw = Box_Y_Width		;
bxw = Box_X_Width		;
bwr = Round_Base_Width	;
bod = Bearing_Outer_Diameter;
bid = Bearing_Inner_Diameter;
bw = Bearing_Width		;
nob = Number_of_Bearings;
bnd = Bearing_Nut_Size	;
srd = Smooth_Rod_Diameter;
rotAdj = Bearing_Rotation_Adjustment;
pitch = Bearing_Pitch	;
obmx = Other_Bed_Mounting_X/2 ;
obmy = Other_Bed_Mounting_Y/2;
rt = Reverse_Thread;
bt = Bearing_Tilt		;
sl = Screw_Length		;
pres=(200*16)/pitch; // resolution per step
//Mounting holes 
mhfc = [[ -13.5,8.5,-(bh-mhd)/2 ],[ -13.5,-8.5,-(bh-mhd)/2 ],[ 13.5,8.5,-(bh-mhd)/2],[13.5,-8.5,-(bh-mhd)/2 ]] ; 						

// [[ -12.5,7.5,-(bh-mhd)/2 ],[ -12.5,-7.5,-(bh-mhd)/2 ],[ 12.5,7.5,-(bh-mhd)/2 ],[12.5,-7.5,-(bh-mhd)/2 ]]   <--Use this for Aluminum Bed
mhfcw = [[ -8,8,-(bh-mhd)/2 ],[ -8,-8,-(bh-mhd)/2 ],[ 8,8,-(bh-mhd)/2 ],[8,-8,-(bh-mhd)/2 ]]; // <-- Use this for Wood Bed 

//Mounting holes for bed type not Solidoodle
mhfco = [[ -obmx,obmy,-(bh-mhd)/2 ],[ -obmx,-obmy,-(bh-mhd)/2 ],[ obmx,obmy,-(bh-mhd)/2 ],[obmx,-obmy,-(bh-mhd)/2 ]]; // This defines the "other" bed type option

//simplify base size
base = [bxw,byw,bh];

//simplify bearing
bsize = [bod/2,bid/2,bw];

//bearing mounting angle to get desired pitch
bma = round(atan(pitch / (srd * 3.141592 ))*10)/10; //Use round(var*10)/10 to round the angle down to the nearest 10th

//X distance from center of bearing
bdfc = cos(bma)*(bod/2);

$fn=30;



echo (str("The bearing angle will be set to ", bma ," degrees."));
angleNotify = str("Bearing Angle = ", bma ," degrees");
pitchNotify = str("Pitch = ", pitch ," MM Per Rotation");
bearingSize = str("Bearing Dimensions = ",bid,":",bod,":",bw);
rtNotify = str("Reverse Thread?  ", rt );
steps = str("Steps per mm (using 200 steps * 16 microsteps): ", pres );
resolution=str("Resolution per microstep: ", 1/pres,"mm" );
fullstep=str("Resolution per full step: ", (1/pres)*16,"mm"  );
pitchengraving=str("p=",pitch,"mm");
echo ("Bearing is " , bdfc , "Horizontally from edge.");
echo (snug);





	/* ------------- End Variables and Start Shapes Below ---------------*/

/*

			In the interest of making this script easily adaptable,
			all main shapes will be separate modules will be put
			together at the bottom of this script.

*/
/* --- This is the on-screen info Graphic since there is no option for Echo output in customizer --- */
if (text=="true"){
%color("yellow")
rotate([30,0,-180]){
translate([0,10,-30])
rotate ([90,0,180]){
write(angleNotify,h=2,t=0.1,font="write/orbitron.dxf",center=true);
translate([0,3,0])
write(pitchNotify,h=2,t=0.1,font="write/orbitron.dxf",center=true);
translate([0,6,0])
write(bearingSize,h=2,t=0.1,font="write/orbitron.dxf",center=true);
translate([0,-3,0])
write(rtNotify,h=2,t=0.1,font="write/orbitron.dxf",center=true);
translate([0,-6,0])
write(steps,h=2,t=0.1,font="write/orbitron.dxf",center=true);
translate([0,-9,0])
write(resolution,h=2,t=0.1,font="write/orbitron.dxf",center=true);
translate([0,-12,0])
write(fullstep,h=2,t=0.1,font="write/orbitron.dxf",center=true);
}
} } else {

}


// This builds the basic shape of the bearing For refrence and cutouts
module Bearing (bigd,smalld,bbwidth) {
	difference(){
		cylinder(r=bigd,h=bbwidth,$fn=facetas);
		%cylinder(r=smalld,h=bbwidth,$fn=facetas);
	}
}

//Main body of the nut.This acts as the Adapter between the bearing mounts and the bed mounts
module Base(){
	difference(){

		union(){
			if(BaseShape=="round"){
					cylinder(r=bwr/2,h=bh,center=true,$fn=facetas);
			} else if (BaseShape=="box"){
				cube(base,center=true);
			} else if (BaseShape=="fitting"){
				difference(){
					union(){
						translate([-bod-srd-(-bod/nob),0,-0.5]) rotate([0,0,0]) cube([bod+(bod/nob)+srd/2,srd*1.5,bh],center=true);
						hull(){
							for (j= [0:nob]) {
								rotate([0,0,j*360/nob+rotAdj]) translate([(srd/2)+bdfc-snug,0,bh/2-1]) translate([0,0,-(bh)/2+0.5])cylinder(r=bod*bif,h=bh,center=true,$fn=facetas); // the base
								}
						}
					}
					cylinder(r=(srd/(2-Smooth_rod_clearance))*1.0,h=100,center=true,$fn=facetas); //This shows the smooth rod that the bearings will be spaced for.
					translate([-bod-srd,0,-0.7]) cube([bod/2*nob+(bod/nob)+srd*3,srd/2,bh+0.5],center=true);
				}
			}
		}
				rotate([90,0,lookup(Number_of_Bearings, [
		 		[ 2, 90 ],
		 		[ 3, 60 ],
		 		[ 4, 45 ],
		 		[ 5, 36]	])])translate([(-srd/2)-bdfc+snug,0,bh/2-1]) translate([0,0,-(bh)/2+0.5]) translate([-bod*bif+lookup(Number_of_Bearings, [
		 		[ 2, 0.4],
		 		[ 3, 0.4],
		 		[ 4, 0.4],
		 		[ 5, 0.4]]),0,0]) rotate([270,180,90]) write(pitchengraving,h=4,t=1,font="write/orbitron.dxf",center=true);
				translate([-bod-srd-(-bod/nob)/3.3,0,-bh/3.3]) rotate([90,0,0]) cylinder(r=1.55,h=srd+bod,center=true,$fn=facetas);
				translate([-bod-srd-(-bod/nob)/3.3,0,bh/3.3]) rotate([90,0,0]) cylinder(r=1.55,h=srd+bod,center=true,$fn=facetas);
			%cylinder(r=(srd/2)*1.0,h=100,center=true,$fn=facetas); //This shows the smooth rod that the bearings will be spaced for.

	}
}


/* Bearing mounts are all made positive and will be subtracted from base */
module bearingMounts(){
	
// --------------- ***** For anything that will be used in a rotational translate loop (I.E. bearing cut out, mounting screw, mounting nut) ****** ----------- //
	for (j= [0:nob]) {
		if (rt=="yes") { //"Reverse Thread" option
			rotate([-bma,bt,j*360/nob+rotAdj]) translate([(srd/2)+bdfc-snug,0,bh/2-1]){  //snug is used to apply force between the bearing and the smooth rod
					#Bearing(bod/2*(1.05),bid/2,bw*(1.05)); //Main Bearings as defined in bearing module plus 5% to keep slack around the bearing
					#translate([0,0,-bh/2])cylinder(r=bid/2,h=sl,center=true,$fn=facetas); //Shaft for bolt/screw to hold the bearing
					#translate([0,0,-bh+0.9])rotate([0,0,lookup(Number_of_Bearings, [
 		[ 2, 94 ],
 		[ 3, 37 ],
 		[ 4, 37 ],
 		[ 5, 37 ]
 	])]) cylinder(r=bnd/2,h=bnd/2.75,$fn=6,center=true); //Retainer for nut bearing bolt
		}
		}  else if (rt=="no") { //"Regular Thread" option
			rotate([bma,bt,j*360/nob+rotAdj]) translate([(srd/2)+bdfc-snug,0,bh/2-1]){ 
					#Bearing(bod/2*(1.05),bid/2,bw*(1.05)); //Main Bearings as defined in bearing module plus 5% to keep slack around the bearing
					#translate([0,0,-bh/2])cylinder(r=bid/2,h=sl,center=true,$fn=facetas); //Shaft for bolt/screw to hold the bearing
					#translate([0,0,-bh+0.9])rotate([0,0,lookup(Number_of_Bearings, [
 		[ 2, 94 ],
 		[ 3, 37 ],
 		[ 4, 37 ],
 		[ 5, 37 ]
 	])]) cylinder(r=bnd/2,h=bnd/2.75,$fn=6,center=true); //Retainer for nut bearing bolt
			}
		}
	}

}

// Part assembly starts here
difference(){
Base();
bearingMounts();
}

