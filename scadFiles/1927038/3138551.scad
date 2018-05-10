$fs=0.4;
$fa=0.5;

/* [Global] */
// Reed Name (short text string)
txt="Alto";
// Reed Overall Length (mm)
length=70;
// Reed Cylinder Radius (mm)
reed_cyl_rad=14;
// Reed Back Thickness (mm)
back_thickness=3.1;
// Reed Back Width (in mm)
back_width=13;
// Reed Tip Crosscut Сurvature (mm)
work_rad=200;
// Reed Tip Cut Angle (degrees)
cut_angle=14.0;
// Reed Tip End Width (mm)
width=17;
// Reed Tip End Round (mm)
tip_round=4;
// Reed Tip Initial Thickness (mm)
tip_thickness=0.6;
// Reed Tip Crosscut Increment Element 0 (mm)
reed_tip_incr0=0;
// Reed Tip Crosscut Increment Element 1 (mm)
reed_tip_incr1=-1;
// Reed Tip Crosscut Increment Element 2 (mm)
reed_tip_incr2=-2;
// Reed Tip Crosscut Increment Element 3 (mm)
reed_tip_incr3=-3;
// Reed Tip Crosscut Increment Element 4 (mm)
reed_tip_incr4=-4;
// Reed Tip Crosscut Increment Element 5 (mm)
reed_tip_incr5=-5;
// Reed Tip Crosscut Increment Element 6 (mm)
reed_tip_incr6=-6;
// Reed Tip Crosscut Increment Element 7 (mm)
reed_tip_incr7=-7;
// Reed Tip Crosscut Increment Element 8 (mm)
reed_tip_incr8=-7.5;


/* [Hidden] */
work_rad_incr=[reed_tip_incr0,reed_tip_incr1,reed_tip_incr2,reed_tip_incr3,reed_tip_incr4,reed_tip_incr5,reed_tip_incr6,reed_tip_incr7,reed_tip_incr8];

module reed_base()
{
	difference()
	{
		union()
		{
			translate([0,0,back_thickness-reed_cyl_rad]) rotate([0,90,0]) color([0.4,0.75,0.4])
				cylinder(r=reed_cyl_rad,h=length-tip_round);
 			translate([length-tip_round,0,-0.01]) scale([2 * tip_round / width,1,1])
				cylinder(d=width,h=back_thickness);
		}
		translate([-1,-reed_cyl_rad-1,-reed_cyl_rad*2])
			cube([length+2,reed_cyl_rad*2+2,reed_cyl_rad*2]);
		translate([-0.2,back_width*0.5,-1]) rotate([0,0,atan2((width-back_width)*0.5,length)])
			cube([length+1,width,back_thickness+2]);
		translate([-0.2,-back_width*0.5,-1]) rotate([0,0,-atan2((width-back_width)*0.5,length)]) translate([0,-width,0])
			cube([length+1,width,back_thickness+2]);
	}
}
 
module reed()
{
	intersection()
	{
		reed_base();
		for_end=len(work_rad_incr)-2;
		color([0.85,0.85,0.35]) translate([length,0,tip_thickness]) rotate([0,cut_angle,0])
		{
			for(i=[0:1:for_end])
			{
				translate([-(i+1)*length*0.5/(len(work_rad_incr)-1),0,-work_rad]) rotate([0,90,0])
					cylinder(r1=work_rad+work_rad_incr[i+1],
						 r2=work_rad+work_rad_incr[i],
						 h=length*0.5/(for_end+1));
			}
			translate([-length,0,-work_rad]) rotate([0,90,0])
				cylinder(r=work_rad+work_rad_incr[for_end+1],h=length*0.5);
		}
	}
}

module reed_with_text()
{
	difference()
	{
		reed();
		translate([5,-2.5,back_thickness-1.0]) linear_extrude(1.1) text(text=txt,size=6);
	}
}

reed_with_text();

