//Customizable Rock Climbing Hold v2.5
//2.4 had 400 downloads
//Improved over http://www.thingiverse.com/thing:487090
//Created by Ari M. Diacou, November 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

//Instructions at Bottom of file

// preview[view:north west, tilt:top diagonal]

/* [Hold Options] */
//Maximum(ish) size of hold in mm
Dmax=120;
//Changes hold thickness based on climb difficulty
difficulty=5.7;//[5.4,5.5,5.6,5.7,5.8,5.9,"5.10"]
//A way to save your random arrangement
seed=20;
//Diameter of the socket wrench you will tighten your bolt with in mm
head_diameter=26;
//Diameter of the hole that the bolt will fit into in mm
bore_diameter=10;
//Number of spheres
n=12;
//Parameter for scaling of element sizes (smaller makes spikier rocks)
a=7;//[1:10]
//Changes curviness of rocks (computation time goes up like O(Number_of_units_in_x*Number_of_units_in_y*$fn*n*log(n*$fn))
$fn=4;//[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]


/* [Array Options] */
Number_of_units_in_x = 3;//[1,2,3]
Number_of_units_in_y = 1;//[1,2,3]
print_type="molds";//[molds, tray, holds]
//How thick shold the walls of the mold be as a percentage of Rmax? Increase if you see any holes in your molds.
mold_thickness_ratio=0.15;

//A way to make a filename, just copy the output from the console before exporting. 
echo(str("filename suggestion:   Dmax=",Dmax,"_diff=",difficulty,"_seed=",seed,"_n=",n,"_",Number_of_units_in_x,"x",Number_of_units_in_y,"_",print_type));

                 /*[Hidden]*/
///////////////// Variables ///////////////////////
num_x=Number_of_units_in_x;
num_y=Number_of_units_in_y;
ep=.001+0;//A small amount, sometimes needed to remove shearing


array_num=num_x*num_y;
Rmax=Dmax/2;
vector=rands(0,1,3*array_num*n,seed);
//Figures how thin to make the hold based on the desired difficulty of the route
z_adjustment = (difficulty=="5.10" || difficulty-5.1<.04) ? 
	-0.4 :
	(difficulty-5.7)*(-4/3);
//Use lower resolution in testing mode for speed
//$fn= testing_mode ? 4 : 12;

///////////////////Main()/////////////////////////
for(i=[1:num_x]){
	for(j=[1:num_y]){
		if(print_type=="molds"){ 
//The (i-.5-num_x/2) term centers the array at x=0,y=0. The 1.1 ensures that the molds dont touch.
			translate([	(i-.5-num_x/2)*(1+1.1*mold_thickness_ratio)*Dmax,
							(j-.5-num_y/2)*(1+1.1*mold_thickness_ratio)*Dmax,
							Rmax])
				mold(i,j);
			}
		else if(print_type=="tray"){ 
//The (i-.5-num_x/2) term centers the array at x=0,y=0. The 0.95 ensures that the molds touch.
			rotate([180,0,0])
            translate([	(i-.5-num_x/2)*(1+0.95*mold_thickness_ratio)*Dmax,
							(j-.5-num_y/2)*(1+0.95*mold_thickness_ratio)*Dmax,
							-Dmax/2])
				difference(){
					union(){
//A cube and a cylinder are unioned so that a tray is formed when arrayed, the +ep in cube()ensures overlap, while the +ep in translate() ensures that shearing does not occur.
						translate([0,0,+Rmax/2+ep]) 
							cylinder(Rmax,r=(1+mold_thickness_ratio)*Rmax,center=true, $fn=40);
						translate([0,0,.5*mold_thickness_ratio*Rmax+ep]) 
							cube([	(1+mold_thickness_ratio)*Dmax+ep,
										(1+mold_thickness_ratio)*Dmax+ep,
										mold_thickness_ratio*Rmax], center=true);
						}

					translate([0,0,-ep]) rock((i-1)*(num_y)+j);
					};
			}
		else
			translate([(i-.5-num_x/2)*2*(1+mold_thickness_ratio)*Rmax,(j-.5-num_y/2)*2.1*Rmax,0])
				hold(i,j);
		}
	}

/////////////////Functions///////////////////////
module hold(x,y){
	difference(){
		translate([0,0,Rmax*z_adjustment])
			rock((x-1)*(num_y)+y);
//		if(testing_mode){echo(str("x=",x," ,y=",y));}
		//Remove the bottom to give a flat base
		translate([0,0,-Rmax*1.5]) 
			cube(Rmax*3,center=true);
		//Drill a hole for the bolt
		cylinder(r=bore_diameter/2,h=4*Rmax,center=true,$fn=20);
		//Counter-sink for the bolt head
		translate([0,0,Rmax*(0.5+z_adjustment)]) 
			cylinder(r=head_diameter/2,h=Rmax,$fn=20);
		}
	}

module rock(rock_number){
	/*Makes a rock by taking a hull around n elements, because OpenSCAD does not have runtime variables, I had to make a long vector with all possible random numbers, and then use the call of "rock_number" to specify a starting position in the vector*/
	v=vector;
	starting_position=3*(rock_number-1)*n;
//	if(testing_mode){echo(str("For rock #",rock_number,", starting position= ",starting_position," of ",len(v)));}
	hull(){
		for(i=[0:n-1]){ //For each i, pass a triplet to module element()
			element([v[starting_position+3*i+0],
						v[starting_position+3*i+1],
						v[starting_position+3*i+2]]);
			}
		}
	}

module element(v){
	//Sets up a sphere of radius R randomly placed in a cylinder
	//a triplet of random [0,1] numbers are converted to a cylindrical triplet
	//the cylinder has a radius of Rmax, and a height of 2*Rmax

	//Coordinates of a sphere in cylindrical coordinates
	r=Rmax*v[0]; 
	theta=360*v[1]; 
	z=(v[2]-0.5)*Rmax;
	//But OpenSCAD thinks in cartesian
	y=r*sin(theta);
	x=r*cos(theta);
	/*We have to wrap/hull() all of these spheres to make a rock. To make it aesthetically convincing, spheres at the edges of the allowed range should be smaller than those placed towards the center. I chose a gaussian distribution of sphere radius as a function of r/Rmax, which is simply v[0]. */
	R=.5*Rmax*exp(-v[0]*v[0]/(a/10));
	translate([x,y,z]) sphere(R);
	}


module mold(x,y){
	//Subtracts an upside-down hold from a cylinder to make a mold for pourable resin
	difference(){
		translate([0,0,-Rmax/2-ep]) cylinder(Rmax,r=(1+mold_thickness_ratio)*Rmax,center=true, $fn=40);
		rotate([0,180,0]) hold(x,y);
		}
	}


/*Instructions:

This program creates an array of rock-climbing holds to be 3D printed. The resulting holds are designed to be secured with a bolt and washer into a (presumably wood) rock-climbing wall. Since the holds need to never move, I imagine they will be secured with an impact-driver and socket-wrench. This requires hex bolts, which can be sharp when falling off of a wall. Therefore the holds are made already-countersunk.

There are 3 types of output: holds, molds, and tray. Holds are designed to be 3D printed at 100% infill. The molds are designed to be 3D printed in silicone (or other flexible material), filled with a resin, cured, and then removed from the mold. The tray is desinged to be printed with low infill of PLA/ABS, poured with a light coating of silicone or latex to make a flexible mold. The mold is then removed from the tray, coated with release agent, filled with resin, cured, and then removed from the tray. The holds will then need to be drilled and counter-sunk to make space for the bolt and socket wrench.

When using this program in OpenSCAD, a suggested filename is provided in the console, which reflects the most important parameters used when creating the STL files. To copy it, highlight the output, right-click, and then select “copy”. Ctrl-C will not work in Windows. Nor can you interact with the console when the “save file” window is up.

Theory:

The “rocks” are made by using the hull() function around n spheres, whose centers are randomly placed inside of a cylinder of Dmax width and  Dmax/4 height. Each sphere is made from a triplet of random numbers between 0 and 1. These numbers are then converted into a triplet of r, theta and z, which define the sphere's position in a cylinder. The radius of the sphere is a Gaussian function of the distance from the center of the sphere. The “a” parameter is related to the width of the Gaussian. Smaller “a” will mean smaller radii of the spheres at the edge, which will result in rocks that have sharper points. Aesthetically, I like a=7. Because the program doesn't “know” if the spheres will poke through the cylinder they were put in, a fudge-factor of mold_thickness_ratio is used. Adjust this higher is you find that some molds have holes in them, adjust lower if your molds are too thick, or to speed up printing. 

Once the “rock” is created, the bottom is sliced off to have the rock lie flush on the wall, and then a counter-bore cylinder and bolt hole are “drilled” into the hold so that the holds can be placed without drilling. The "difficulty" changes what percentage of the rock is sliced away. 5.7 slices the rock in half, 5.10 slices a lot away, leaving those annoying little nubs you find on 5.10s, and 5.4 makes orblike easysauce holds that you could climb with 2 limbs.

Hull() has a time of order n*log(n). Where n is the number of points being hull()ed. The number of points in a sphere is proprtional to $fn. Therefore the runtime of a single hold is O($fn*n*log(n*$fn)) and the total runtime is then O(Number_of_units_in_x *Number_of_units_in_y*$fn*n*log(n*$fn)). Therefore it is very important that these numbers not be set too high, or you will crash OpenSCAD.

OpenSCAD has 2 rendering modes, F5=Compile, and F6=Compile and Render. For most things, F5 is faster, for this project, F6 is faster for higher n, $fn. For 3 elements, n=12 and $fn=12 the rendering time on my computer using F5 was about 1 minute. F6 reported 3 seconds to render 3 elements, n=12 and $fn=20. I think because of some differnece in processing the elements inside hull(). As a result, if you are experimenting, and just rapidly want to see different holds (playing with “a” and “seed”), just turn on “testing mode=true” in the “Hold Options” section.

Because OpenSCAD does not have runtime variables, I had to make a long vector with all possible random numbers, and then use the call of "rock_number" to specify a starting position in the vector. The easy way, would be to pass a new random vector to each call of “rock” but you cant do that. The slightly more complicated way would be to be to make a vector of 3*n* Number_of_units_in_x *Number_of_units_in_y random numbers, and then break up the vector into pieces, and then pass those sub-vectors to “rock”. But OpenSCAD can't split vectors either. So I made a big long vector as a global variable, and then in various ways, effectively passed the position in the vector that rock() was supposed to read from. This is hackish bullshit and hard to parse, but it works. Also because of the lack of runtime variables, and the lack of string manipulation, it is impossible to figure out the actual height of a rock. Therefore the position of the counter-bore is just a guess (the 0.5 in hold()) and can be adjusted if you feel adventurous I didn't make a variable for it because I figured it's just easier to change the seed than explain what that parameter is. Also, for the same reason, the center of mass of the rock cant be obtained, and many bores will be off-center.
*/