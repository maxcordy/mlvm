//Select the view
part = "Print"; // [Print,OnSilvia,OnSilviaSolidRender,OnSilviaCutOpen]

//write "Boilertemperatur" on the front
do_writing="true"; // [true,false]

//Thickness of the walls in Millimeters
wallthick=2;

/* [Hidden] */

/*
Housing for a PID control for the Rancilio Silvia espresso machine
Version E, May 2014
Written by MC Geisler (mcgenki at gmail dot com)

Stop the print at 104mm to change filament and have the writing on top in another color.

Sorry for the use of German for variable names.
Have fun!

License: Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
Under the following terms:
    Attribution - You must give appropriate credit, provide a link to the license, and indicate if changes were made. 
    You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial - You may not use the material for commercial purposes.
    ShareAlike - If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. 
*/

$fn=60;
//$fs=.5;

//PID
PIDwidth=45;
PIDheight=21.5+.5;
PIDthick=70;//70
//contacts at the back
PIDwidth_contacts=38;
PIDheight_contacts=18;
PIDthick_without_contacts=60;
//front panel
frontthick=5;
frontheight=23.1;
frontwidth=47.5;

debug=1;
//padding
PID_pad_up=8*debug;
PID_pad_down=2*debug;
shiftbox=(PID_pad_up+PID_pad_down)/2;
shifthole=PID_pad_up - shiftbox;

//PID housing
width=PIDwidth;
height=PIDheight+PID_pad_up+PID_pad_down;
thick=PIDthick+30;//70
//chamfers
upper_chamfer=(PID_pad_up+wallthick)*sqrt(2);
lower_chamfer=(PID_pad_down+wallthick)*sqrt(2);

//hole
holeradius=23/2;//23.1//16/2

//latch 
latch_sq_width=1;

holderwidth=thick+2*wallthick; //thick/2;
holderlength=2.7*PIDheight;
holderthick=wallthick;
holdertriangle=wallthick*10;

holderangle=33;
holderlengthlongerangle=holderlength+holderwidth/2*tan(holderangle);
holderwidthlongerangle=holderwidth/cos(holderangle);

holderWallthick=2+0.5;
holderWalldepth=8-1;
 
ranfronttiefe=105;
ranfronthoehe=135;
ranfrontmetallumbieg=10;
ranfrontbreite=235;

cutsize=20;

module PID()
{
	translate([0,0,thick/2])
	union()
	{
		//main body - contacts
		translate([0,0,-PIDthick/2-PIDthick_without_contacts/2+.1])
			cube([PIDheight_contacts,PIDwidth_contacts,PIDthick-PIDthick_without_contacts],center=true);

		//main body - without contacts
		translate([0,0,-PIDthick_without_contacts/2+.05])
			cube([PIDheight,PIDwidth,PIDthick_without_contacts],center=true);

		//front panel
		translate([0,0,+frontthick/2])
			cube([frontheight,frontwidth,frontthick],center=true);
	}
}



module air_hole(length,radius,thickness)
{
	translate([-radius,0,0])
		cube([radius*2,length,thickness]);
	cylinder(r=radius,h=thickness);
	translate([0,length,0])
		cylinder(r=radius,h=thickness);
}

air_hole_r=2;
air_hole_length=5;
module air_holes_top()
{
		//air holes
		for (zz=[-PIDthick_without_contacts/2+air_hole_r:air_hole_r*4:PIDthick_without_contacts/2-upper_chamfer])
		{
			translate([-height/2-1,-width*.45,zz+air_hole_r+(thick/2-PIDthick_without_contacts/2)])
				rotate([0,90-0,0])
					air_hole(air_hole_length,air_hole_r,height/3);
		}
}



module air_holes_side()
{
	translate([shiftbox,width/2,-wallthick+thick/2-airside_thick/2-(PIDthick_without_contacts-airside_thick)/2])
		for (zz=[-1:1])
			translate([0,0,zz*airside_thick/3])
				cube([airside_height,width/2,airside_thick/3-1.5*wallthick],center=true); 
}

airside_height=height*.8;
airside_thick=PIDthick_without_contacts*.85;
flap_radius=wallthick/2;
module ventflap(angle)
{
	rotate([0,0,angle])
	scale([1,3,1])
	{
		cylinder(r=flap_radius, h=airside_thick,center=true);
		translate([0,0,airside_thick/2])
			sphere(r=flap_radius);
		translate([0,0,-airside_thick/2])
			sphere(r=flap_radius);
	}
}
module ventcover()
{
	translate([shiftbox+wallthick/2,width/2+wallthick*2,-wallthick+thick/2-airside_thick/2-(PIDthick_without_contacts-airside_thick)/2])
		for (zz=[-airside_height/2:flap_radius*4.5:airside_height/2])
		{
			translate([zz,0,0])
				ventflap(-50);
		}

	//%cube([airside_height,width/2,airside_thick],center=true);
}


module housing()
{
	union()
	{
		difference()
		{
			//main box
			translate([shiftbox,0,-wallthick])
				cube([height+wallthick*2*2,width+wallthick*2*2,thick+wallthick*2],center=true);

			//air holes
			air_holes_top();
			//mirror([0,1,0])
			//	translate([height,0,0])
 			//		air_holes();
			
			//holes on the side, add vents later!
			air_holes_side();

			//bigger inner cutout (inner volume)
			translate([shiftbox,0,-wallthick])
				difference()
				{
					cube([height+wallthick*2,width+wallthick*2,thick],center=true);
					
					translate([(height+wallthick*2)/2,0,thick/2])
						rotate([0,45,0])
							cube([lower_chamfer,width*2,lower_chamfer],center=true);

					translate([-(height+wallthick*2)/2,0,thick/2])
						rotate([0,45,0])
							cube([upper_chamfer,width*2,upper_chamfer],center=true);
				}

			//PID cutout (front hole)
			translate([shiftbox+shifthole,0,0.01])
				PID();

			//cable out
			translate([shiftbox+height/2-holeradius,-width/2+holeradius,-thick/2])
				cylinder(r=holeradius,h=20,center=true);
		}
		
		//ventilation cover on side
		ventcover();

		//Temperatur
		if (do_writing=="true")
		{
			color("indigo") 
				translate([-7.5,-24,(thick)/2])
					rotate([0,0,90])
						scale(.48)
							linear_extrude(height = 2) 
								import("boilertemperatur.dxf");		
		}

		//holder
		translate([-PIDheight/2-wallthick*2+.5,-width/2-wallthick*2,-holderthick])
		{
			//main holder
			difference()
			{
				translate([-holderlengthlongerangle/2,holderthick/2,0])
					cube([holderlengthlongerangle,holderthick,holderwidth],center=true);
				//cutoff holder in an angle
				translate([-holderlength,holderthick/2,0])
				{
					rotate([0,holderangle,0])
					{
						translate([-holderlengthlongerangle/2,-(wallthick+holderWallthick)/2,0])
							cube([holderlengthlongerangle,(wallthick*2+holderWallthick)*2,holderwidthlongerangle],center=true);
					}
				}
			}

			//latch to fix the holder
			difference()
			{
				rotate([0,holderangle,0])
				{
					translate([10,0,-43+5])
						rotate([45,0,0])
							cube([holderlengthlongerangle,latch_sq_width,latch_sq_width],center=true);
				}
				translate([height/2+wallthick*2-.5+height+wallthick*2*2,+width/2+wallthick*2,+holderthick-wallthick])
					cube([height+wallthick*2*2,width*2,thick+wallthick*2],center=true);

				translate([holderlength,-holderthick/2,0])
					translate([-holderlengthlongerangle/2,holderthick/2,-holderwidth/2-cutsize/2])
						cube([holderwidth,holderwidth,cutsize],center=true);
			}

			//triangle
			translate([-holdertriangle/2,holdertriangle/2,0])
				difference()
				{
					cube([holdertriangle,holdertriangle,holderwidth],center=true);
					translate([-holdertriangle/sqrt(2),holdertriangle/sqrt(2),0])
						rotate([0,0,45]) 
							cube([holdertriangle*2,holdertriangle*2,holderwidth*2],center=true);
					translate([(holdertriangle+wallthick)/sqrt(2),-(holdertriangle+wallthick)/sqrt(2),0])
						rotate([0,0,45]) 
							cube([holdertriangle*2,holdertriangle*2,holderwidth*2],center=true);
				}
			//holder top
			translate([-holderlength,holderthick/2,0])
			{
				difference()
				{
					rotate([0,holderangle,0])
					{
						translate([holderWalldepth/2,-holderWallthick-wallthick,0])
							cube([holderWalldepth,holderthick,holderwidthlongerangle],center=true);
						translate([wallthick/2,-(wallthick+holderWallthick)/2,0])
							cube([wallthick,wallthick*2+holderWallthick,holderwidthlongerangle],center=true);
					}
					translate([-holderlengthlongerangle/2,holderthick/2,-holderwidth/2-cutsize/2])
						cube([holderwidth,holderwidth,cutsize],center=true);



				}
			} 
		}
			
	}
}

//--------------------------------------------

module rancilio()
{
	translate([0,-width/2-ranfrontbreite/2-2*wallthick,0])
		rotate([0,holderangle,0])	
			translate([10,0,5])
			{
				difference()
				{
					cube([ranfronthoehe,ranfrontbreite,ranfronttiefe],center=true);
					translate([-ranfronthoehe/2,0,0])
					cube([holderWalldepth*2,ranfrontbreite-holderWallthick*2,ranfronttiefe-holderWallthick*2],center=true);
	
				}
				translate([-ranfronthoehe/2+345/2,0,-ranfronttiefe/2-160/2]) 
					cube([345,ranfrontbreite,160],center=true);
	
				translate([-ranfronthoehe/2,ranfrontbreite/2,ranfronttiefe/2])
				{
					translate([23+18/2,-16-70/2,0+3/2])
						cube([18,70,3],center=true);	
					translate([100,-35,0+35/2])
						cylinder(r=23,h=35,center=true);	
				}
			}
}

//--------------------------------------------

if (part=="Print")
{
	//for printing
	rotate([0,0,0])
	{
		%translate([shiftbox+shifthole,0,0])
			PID();
		housing();
	
		//%rancilio();	
	}
}


if (part=="OnSilvia")
{	
	//for viewing
	rotate([0,90-holderangle,-90])
	{
		%translate([shiftbox+shifthole,0,0])
			PID();
		housing();
	
		%rancilio();	
	}
}

if (part=="OnSilviaSolidRender")
{	
	//for viewing
	rotate([0,90-holderangle,-90])
	{
		translate([shiftbox+shifthole,0,0])
			PID();
		housing();
	
		rancilio();	
	}
}


if (part=="OnSilviaCutOpen")
{	
	//for viewing
	rotate([0,90-holderangle,-90])
	{
	*	%translate([shiftbox+shifthole,0,0])
			PID();
	*	housing();
	
		difference()
		{
			housing();
			translate([-70,-15*0,-70])
				cube(140,140,140);
		}
	
	
		%rancilio();	
	}
}
