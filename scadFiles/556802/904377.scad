// Which one would you like to see?
part="scribe"; // [body: The box,cover: the cover of the box,scribe: the scibe (dualstruder)]

/* [Global] */

// height of one hive figure
oh=12; // [3:30]

// outer diameter of hive figure
ow=42.95; // [10:50]

// extra space to keep in addition to figures
zapas=2; // [0:3]

// size of the wall between figures
stenka=2; // [1:10]

// number of figures in stack
num_height=4; // [1:10]

// size of the hole on the bottom (to fit a finger)
finger=20; // [0:30]

/* [Cover] */

// text size (adjust to feed into the cover)
tsize=35; // [5:50]

// Height of the cover
cover_height=5; // [5:50]

/* [Hidden] */

dt=0.01;
r_mink=3;

use <write/Write.scad>

module hex(size, height)
{
	minkowski() {
		cylinder (h=height-dt,r=size/2-r_mink,$fn=6);
		cylinder (h=dt,r=r_mink,$fn=60);
	}
}

module socket (height, finger)
{
	difference() {
		hex (ow+zapas+stenka*2, height);
		translate([0,0,stenka])
			hex (ow+zapas, height);
		if ( finger>0 )
			translate([0,0,-1])
				cylinder (h=stenka+2,r=finger/2,$fn=60);
	}
}

module socket_cover ()
{
	union() {
		hex (ow+zapas+stenka*2, stenka);
		translate([0,0,stenka-dt])
			difference(){
				hex (ow+zapas/2, cover_height+dt);
				hex (ow+zapas/2-stenka*2, cover_height+dt+dt);
			}
	}
}

sqrt3=1.732050808;

module body (height)
{
	size = ow+zapas;
	distance=2*r_mink+(size/2-r_mink)*sqrt3;
	socket(height, finger);
	for ( i = [0 : 5] )
	{
   	 rotate( i * 360 / 6, [0, 0, 1])
		   translate([0, stenka+distance, 0])
	   		 socket( height, finger);
	}
}

module cover ()
{
	size=ow+zapas;
	socket_cover();
	for ( i = [0 : 5] )
	{
   	 rotate( i * 360 / 6, [0, 0, 1])
	    translate([0, stenka+2*r_mink+(size/2-r_mink)*sqrt3, 0])
   	 socket_cover();
	}
}

module scribe(height=stenka/2)
{
	rotate([180,0,30])
	translate([0,tsize/7,-height/2+dt])
	write("HIVE",t=height,h=tsize,center=true,font="write/knewave.dxf");
}

if ( part=="body" ) {
	// body
	body (stenka+zapas+oh*num_height+cover_height);
} else if ( part=="cover" ) {
	// cover
	difference() {
		cover();
		scribe();
	}
} else if ( part=="scribe")
{
	scribe();
} else if ( part=="test")
{
	// framework to test any parts
	scribe();
}