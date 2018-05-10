// model of math cubes for learning counting and volume and stuff for kids

//************************************************************
//PARAMETERS
//************************************************************
// Size of individual cube faces
cubeSize = 10; //[5:15]
// Number of cubes in the x direction
lengthNum = 10; //[1:25]
// Number of cubes in the y direction
widthNum = 10; //[1:19]
// Number of cubes in the z direction
heightNum = 1; //[1:15]
// Resolution
res = 60; //[30:Low,60:Med,90:High,120:Unnecessary]
// Radius on outer edges of entire solid
cubeRad = cubeSize/10;
// Radius of grooves cut between cubes
groove = cubeSize/10;

//************************************************************
//MATH
//************************************************************
// variables for overall dimensions
Length = cubeSize * lengthNum;
Width = cubeSize * widthNum;
Height = cubeSize * heightNum;

// values with radius subtracted so desired end product is created
length = Length - 2*cubeRad;
width = Width - 2*cubeRad;
height = Height - 2*cubeRad;

// cube will be centered on origin so halv values for these
// will make things look nicer
Hlength = length/2;
Hwidth = width/2;
Hheight = height/2;

//************************************************************
//RENDERS
//************************************************************
$fn = res;

// translate cube up to x-y plane to make printers happy
translate([0,0,Height/2]){
	mathCubes();
}

//************************************************************
//MODULES
//************************************************************
module mathCubes(){
	
	// put spheres in the bottom four corners
	module bottom(cubeRad,Hlength,Hwidth,Hheight){
		translate([-Hlength,-Hwidth,-Hheight]){
			sphere(cubeRad);
		}
		translate([Hlength,-Hwidth,-Hheight]){
			sphere(cubeRad);
		}
		translate([Hlength,Hwidth,-Hheight]){
			sphere(cubeRad);
		}
		translate([-Hlength,Hwidth,-Hheight]){
			sphere(cubeRad);
		}
	}
	
	// make a copy of all 4 spheres at the desired height
	module top(height){
		translate([0,0,height]){
			bottom(cubeRad,Hlength,Hwidth,Hheight);
		}
	}
	
	// use 'hull' to make a solid cube from the 8 spheres
	// do it this way to get the nice rounded edges
	module fullSolid(){
		hull(){
			bottom(cubeRad,Hlength,Hwidth,Hheight);
			top(height);
		}
	}
	
	// make cylinders to cut the required grooves in the front face;
	// multiply the heights of all the cylinders by 1.1 so they aren't 
	// quite flush with the faces of the cube;
	// OpenSCAD doesn't like sharing faces
	module frontGrooves(){
		if(lengthNum > 1){
			for(i = [1:lengthNum-1]){
				translate([(-Length/2) + cubeSize*i,-Width/2,0]){
					cylinder(Height*1.1,groove,groove,true);
				}
			}
		}
		
		if(heightNum > 1){
			for(i = [1:heightNum-1]){
				translate([0,-Width/2,(-Height/2) + cubeSize*i]){
					rotate([0,90,0]){
						cylinder(Length*1.1,groove,groove,true);
					}
				}
			}
		}
	}
	
	// make cylinders to cut the required grooves in the side face
	module sideGrooves(){
		if(widthNum > 1){
			for(i = [1:widthNum-1]){
				translate([Length/2,(-Width/2) + cubeSize*i,0]){
					cylinder(Height*1.1,groove,groove,true);
				}
			}
		}
		
		if(heightNum > 1){
			for(i = [1:heightNum-1]){
				translate([Length/2,0,(-Height/2) + cubeSize*i]){
					rotate([90,0,0]){
						cylinder(Width*1.1,groove,groove,true);
					}
				}
			}
		}
	}
	
	// make cylinders to cut the required grooves in the top face
	module topGrooves(){
		if(widthNum > 1){
			for(i = [1:widthNum-1]){
				translate([0,(-Width/2) + cubeSize*i,Height/2]){
					rotate([0,90,0]){
						cylinder(Length*1.1,groove,groove,true);
					}
				}
			}
		}
		
		if(lengthNum > 1){
			for(i = [1:lengthNum-1]){
				translate([(-Length/2) + cubeSize*i,0,Height/2]){
					rotate([90,0,0]){
						cylinder(Width*1.1,groove,groove,true);
					}
				}
			}
		}
	}
	
	// combine grooves for all sides in one module
	// including the the back sides
	module allGrooves(){
		frontGrooves();
		sideGrooves();
		topGrooves();
		translate([0,Width,0]){
			frontGrooves();
		}
		translate([-Length,0,0]){
			sideGrooves();
		}
		translate([0,0,-Height]){
			topGrooves();
		}
	}
	
	// cut the grooves in the solid cube
	module complete(){
		difference(){
			fullSolid();
			allGrooves();
		}
	}
	
	// render the final product
	complete();
}