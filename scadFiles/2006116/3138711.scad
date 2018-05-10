/* [Basic] */
// Reed Name (short text string)
txt="iAlto";
// Reed Overall Length (mm)
length=73;
// Reed Cylinder Radius (mm)
reed_cyl_rad=14;
// Reed Butt Thickness (mm)
butt_thickness=3.1;
// Reed Butt Width (in mm)
butt_width=13;
// Reed Tip Width (mm)
width=17;
// Reed Tip Round (mm)
tip_round=4;
// Reed Tip Initial Thickness (mm)
tip_thickness=0.4;
// Reed Vamp Coverage (percent)
reed_vamp_cov=50; // [33:66]
/* [Vamp Element 0] */
// Reed Vamp Crosscut Rise Element 0 (percent)
reed_vamp_rise0=0; // [100]
// Reed Vamp Crosscut Curvature Element 0 (mm)
reed_vamp_radius0=200;
/* [Vamp Element 1] */
// Reed Vamp Crosscut Rise Element 1 (percent)
reed_vamp_rise1=5; // [100]
// Reed Vamp Crosscut Curvature Element 1 (mm)
reed_vamp_radius1=170;
/* [Vamp Element 2] */
// Reed Vamp Crosscut Rise Element 2 (percent)
reed_vamp_rise2=7; // [100]
// Reed Vamp Crosscut Curvature Element 2 (mm)
reed_vamp_radius2=155;
/* [Vamp Element 3] */
// Reed Vamp Crosscut Rise Element 3 (percent)
reed_vamp_rise3=11; // [100]
// Reed Vamp Crosscut Curvature Element 3 (mm)
reed_vamp_radius3=140;
/* [Vamp Element 4] */
// Reed Vamp Crosscut Rise Element 4 (percent)
reed_vamp_rise4=17; // [100]
// Reed Vamp Crosscut Curvature Element 4 (mm)
reed_vamp_radius4=125;
/* [Vamp Element 5] */
// Reed Vamp Crosscut Rise Element 5 (percent)
reed_vamp_rise5=25; // [100]
// Reed Vamp Crosscut Curvature Element 5 (mm)
reed_vamp_radius5=110;
/* [Vamp Element 6] */
// Reed Vamp Crosscut Rise Element 6 (percent)
reed_vamp_rise6=38; // [100]
// Reed Vamp Crosscut Curvature Element 6 (mm)
reed_vamp_radius6=95;
/* [Vamp Element 7] */
// Reed Vamp Crosscut Rise Element 7 (percent)
reed_vamp_rise7=56; // [100]
// Reed Vamp Crosscut Curvature Element 7 (mm)
reed_vamp_radius7=70;
/* [Vamp Element 8] */
// Reed Vamp Crosscut Rise Element 8 (percent)
reed_vamp_rise8=85; // [100]
// Reed Vamp Crosscut Curvature Element 8 (mm)
reed_vamp_radius8=55;

/* [Hidden] */
$fs=0.4;
$fa=0.5;
vamp_rise=[reed_vamp_rise0,reed_vamp_rise1,reed_vamp_rise2,reed_vamp_rise3,reed_vamp_rise4,reed_vamp_rise5,reed_vamp_rise6,reed_vamp_rise7,reed_vamp_rise8];
vamp_radius=[reed_vamp_radius0,reed_vamp_radius1,reed_vamp_radius2,reed_vamp_radius3,reed_vamp_radius4,reed_vamp_radius5,reed_vamp_radius6,reed_vamp_radius7,reed_vamp_radius8];

module reed_base()
{
	color([0.8314,0.686,0.215]) difference()
	{
		union()
		{
			translate([0,0,butt_thickness-reed_cyl_rad]) rotate([0,90,0])
				cylinder(r=reed_cyl_rad,h=length-tip_round);
 			translate([length-tip_round,0,-0.01]) scale([2 * tip_round / width,1,1])
				cylinder(d=width,h=butt_thickness);
		}
		translate([-1,-reed_cyl_rad-1,-reed_cyl_rad*2])
			cube([length+2,reed_cyl_rad*2+2,reed_cyl_rad*2]);
		translate([-0.2,butt_width*0.5,-1]) rotate([0,0,atan2((width-butt_width)*0.5,length)])
			cube([length+1,width,butt_thickness+2]);
		translate([-0.2,-butt_width*0.5,-1]) rotate([0,0,-atan2((width-butt_width)*0.5,length)]) translate([0,-width,0])
			cube([length+1,width,butt_thickness+2]);
	}
}

module cone_section(rad1,shift1,rad2,shift2,h)
{
	if (abs(rad2-rad1) >= 0.1)
	{
		shift_corr=-rad1+rad1*(shift2-shift1)/(rad2-rad1);
		translate([-rad1+shift1-shift_corr,0,0]) linear_extrude(height=h,convexity=10,scale=rad2/rad1)
			translate([shift_corr,0]) circle(r=rad1);
	}
	else
	{
		hull()
		{
			translate([-rad1+shift1,0,0]) cylinder(r=rad1,h=0.01);
			translate([-rad2+shift2,0,h-0.01]) cylinder(r=rad2,h=0.01);
		}
	}
}

module reed()
{
	intersection()
	{
		z_interval=butt_thickness-tip_thickness;
		reed_base();
		for_end=len(vamp_rise)-2;
		color([1.0,0.843,0]) union()
		{
			for(i=[0:1:for_end])
			{
				translate([length-0.01*i*length*reed_vamp_cov/(for_end+1),0,tip_thickness]) rotate([0,-90,0]) cone_section(vamp_radius[i],vamp_rise[i]*(z_interval*0.01),vamp_radius[i+1],vamp_rise[i+1]*(z_interval*0.01),0.01*length*reed_vamp_cov/(for_end+1));
			}
			translate([length*(100-reed_vamp_cov)*0.01,0,tip_thickness]) rotate([0,-90,0])
				cone_section(vamp_radius[for_end+1],vamp_rise[for_end+1]*(z_interval*0.01),vamp_radius[for_end+1]+reed_cyl_rad,butt_thickness*3,length*(100-reed_vamp_cov)*0.01);
		}
	}
}

module reed_with_text()
{
	difference()
	{
		reed();
		color([1.0,0.843,0]) translate([5,-2.5,butt_thickness-1.0]) linear_extrude(1.1) text(text=txt,size=6);
	}
}

reed_with_text();

