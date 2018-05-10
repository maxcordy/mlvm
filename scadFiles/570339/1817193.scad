// mathgrrl customizable snowflake cutter

// thanks atartanian for suggesting how to speed up the code
// thanks anoved for commenting your lathe code so well for me to learn

// preview[view:south, tilt:top]

/* [Cut] */

// Sketch the design that will be mirrored and rotated to make the snowflake. Only the parts of your design that end up inside the green triangular region will be used; anything outside of that will be truncated. 
cuts = [[[0,0],[.124,0],[.075,.2],[.25,.35],[.225,.375],[.06,.235],[.03,.35],[.1,.4],[.075,.425],[.025,.39],[.02,.5],[0,.5],[0,.275],[.05,.125],[0,.05]],[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]]]; // [draw_polygon]

/* [Parameters] */

// (print height, in mm)
thickness = 1.2; 

// (diameter of enclosing circle, in mm)
size = 40;

// (for hanging)
loop = 0; //[0:No,1:Yes]

/////////////////////////////////////////////////////////////////////////
// renders

// guide triangle
color("lime")
%linear_extrude(height=2)
union(){
    hull(){
        circle(.1);
        translate([19.9/sqrt(3),19.9,0]) circle(.1);
    }
    hull(){
        translate([19.9/sqrt(3),19.9,0]) circle(.1);
        translate([0,19.9,0]) circle(.1);
    }
    hull(){
        translate([0,19.9,0]) circle(.1);
        circle(.1);
    }
}

// guide box
color([.8,.8,.8]) 
translate([0,0,-1]) %cube([40,40,1],center=true);

// tiny dot to avoid errors
cylinder(r=.1,h=.1);

// make the flake!
color("white")
difference(){
	union(){
		// draw the snowflake
		snowflake();
		// also draw outer loop, if desired
		if (loop==1){
			translate([0,size/2-.1*size,0])
			linear_extrude(height=thickness)
			circle(.1*size,$fn=24);
		}
	}
	// take away inner loop, if desired
	if (loop==1){
		translate([0,size/2-.1*size,-1])
		linear_extrude(height=thickness+2)
		circle(.05*size,$fn=24);
	}
}

/////////////////////////////////////////////////////////////////////////
// make snowflake out of cut piece

module snowflake(){
	scale(size)
		for (i=[0:5]){
			rotate(60*i,[0,0,1])
				union(){
					piece();
					mirror([1,0,0]) piece();
				}
		}
}

/////////////////////////////////////////////////////////////////////////
// make the cut piece from the sketch

module piece(){
	intersection(){
		linear_extrude(height=thickness/size)
		polygon(
			points=cuts[0], 
			paths=cuts[1]
		); 
		linear_extrude(height=thickness/size)
		polygon(
			points=[[0,0],[.5*cos(60),.5*sin(60)],[0,.5]],
			paths=[[0,1,2]]
		);
	}
}

