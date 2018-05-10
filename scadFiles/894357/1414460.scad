
width=40;

width=40;
depth=30;
height=3;

plugHeight=17;
plugWall=4;
plugRound=4;
tolerance=0.4;
wall=2;
round=3;
plugDistance=3;
plugDistanceHeight=1;

plugWallSpacer=1;
minWallBlock=15;

/* [Hidden] */

plugWidth=width-(2*(wall+tolerance));
plugDepth=depth-(2*(wall+tolerance));

plugWidthReal=width-(2*(wall));
plugDepthReal=depth-(2*(wall));

module cap(){	
	translate([width/2,depth/2,height/2]){
		roundedBox([width,depth,height], round, true);		
	}
	
	translate([(wall+tolerance),(wall+tolerance),height]){
		difference(){
			translate([plugWidth/2,plugDepth/2,plugHeight/2]){
				roundedBox([plugWidth,plugDepth,plugHeight], plugRound, true);
				
				for(move= [1:plugHeight/plugDistance]){
					translate([0,0,move*plugDistance-plugHeight/2]){
						roundedBox([plugWidthReal,plugDepthReal,plugDistanceHeight], plugRound, true);
					}
				}
			}
			
			translate([plugWall,plugWall,0])cube([plugWidth-(2*plugWall),plugDepth-2*plugWall,plugHeight], center=false);
			translate([plugWall,-tolerance-5,0])cube([plugWallSpacer,plugDepth+10,plugHeight], center=false);	
			translate([plugWidth-plugWall-plugWallSpacer,-tolerance-5,0])cube([plugWallSpacer,plugDepth+10,plugHeight], center=false);
			
			if((plugWidthReal/2)>minWallBlock){
				translate([plugWidthReal/2-plugWallSpacer,-tolerance-5,0])cube([plugWallSpacer,plugDepthReal+10,plugHeight], center=false);
			}
			
			translate([-tolerance-5,plugWall,0])cube([plugWidth+10,plugWallSpacer,plugHeight], center=false);	
			translate([-tolerance-5,plugDepth-plugWall-plugWallSpacer,0])cube([plugWidth+10,plugWallSpacer,plugHeight], center=false);	
			
			if((plugDepthReal/2)>minWallBlock){
				translate([-tolerance-5,plugDepthReal/2-plugWallSpacer,0])cube([plugWidthReal+10,plugWallSpacer,plugHeight], center=false);	
			}
			
		}
				
	}

}

/*
 * roundedBox([width, height, depth], float radius, bool sidesonly);
 * EXAMPLE USAGE:
 * roundedBox([20, 30, 40], 5, true);
 * */
module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly){
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2], y = [radius-size[1]/2, -radius+size[1]/2]){
			translate([x,y,0]){
				cylinder(r=radius, h=size[2], center=true);
			}
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);
		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2], y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]){
				rotate(rot[axis]){
					translate([x,y,0]){
						cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
					}
				}
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2], y = [radius-size[1]/2, -radius+size[1]/2], z = [radius-size[2]/2, -radius+size[2]/2]){
			translate([x,y,z]) sphere(radius);
		}
	}
}

cap();