length = 2; // [1:32]

width = 2; // [1:32]

//In multiples of tile heights; one standard brick is 3 tiles high
height = 3; // [1:96]

flat = 0; // [0:No, 1.9:Yes]

/* [Hidden] */
l = 8.0;
w = 8.0;
h = height*3.2;

module brick(){				//brick() module
	difference() {
		union() {
		cube([l,w,h]);			//inner invisible cube
			{
				translate([4,4,1.8])
				cylinder(r=2.4,h=h-flat);
			}
		}
		translate([1.2,1.2,-0.1]) cube([l-2.4,w-2.4,h-0.9]);
	}
}


for (i = [0 : width-1])		//lay down a cube for each value of width
{
	for (x = [0 : length-1])	//lay down a cube for each value of length
	{
		translate([i*6.8,x*6.8,0])  //move along space of one brick - wall
		brick();				//place 1x1 brick() module
	}
}