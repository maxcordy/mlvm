$fn=100;
//Total heigth of trickler.
height=70;
//Outer diameter of the upper part.
diameter=40;
//Diameter of the base
basediameter=55;
//Thickness of the base
basethickness=2;
//Diameter of your tube
tubediameter=8;
//Length of your tube
tubelength=100;
//Angle of the tube
tubeangle=3;
//Diameter of the knob
knobdiameter=20;
//Length of the knob
knoblength=20;
//number of knurles on the knob
noofknurles=30;
//Depth of knurles in the knob
knurledepth=1;
//Depth of the container
depth=30;

hh=knobdiameter*sin(tubeangle)+diameter/cos(tubeangle);
holecenter=depth-tubediameter/2-2;
echo("Sin:");
echo(sin(tubeangle));
echo("Cos:");
echo(cos(tubeangle));

module knurledcyl(d,h,noofknurles,knurledepth){
	angle=360/noofknurles;
	difference(){
		cylinder(d=d,h=h);
		for(i=[1:noofknurles]){
			rotate([0,0,angle*i])
				translate([d/2,0,h/2])
					rotate([0,0,45])
						cube(size=[knurledepth/1.4142,knurledepth/1.4142,h+2],center=true);
		}
	}
}

difference(){
	union(){
		cylinder(d=basediameter,h=basethickness);
		cylinder(d=diameter,h=height);

		translate([0,0,height-holecenter])
			rotate([0,90-tubeangle,0])
				cylinder(d=knobdiameter,h=hh/2);
	}

	translate([0,0,height-holecenter])
		rotate([0,90-tubeangle],0)
			translate([0,0,hh/2-tubelength+knoblength])
				cylinder(d=tubediameter,h=tubelength);
	translate([0,0,height-depth])
	rotate_extrude()
	polygon(points=[[0,0],[5,0],[diameter/2-2,depth-5],[diameter/2-2,depth+2],[0,depth+2]]);
}

%translate([0,0,height-holecenter])
	rotate([0,90-tubeangle],0)
		translate([0,0,hh/2-tubelength+knoblength-1]){
			translate([0,0,tubelength+2])
				rotate([180,0,0]){
					knurledcyl(d=knobdiameter,h=knoblength,noofknurles=noofknurles,knurledepth=knurledepth);
					cylinder(d=knobdiameter-2,h=knoblength+1);
				}
			cylinder(d=tubediameter,h=tubelength);
		}


translate([(basediameter+knobdiameter)/2+10,0,0]){
	difference(){
		union(){
			knurledcyl(d=knobdiameter,h=knoblength,noofknurles=noofknurles,knurledepth=knurledepth);

			cylinder(d=knobdiameter-2,h=knoblength+1);
		}
		translate([0,0,2])
			cylinder(d=tubediameter,h=knoblength);
	}
}

	