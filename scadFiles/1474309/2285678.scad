/* Render the pin? (true/false) */
Pin = false;

/* Render the clamp? (true/false) */
Clamp = true;

/* Render an integrated tripod nut? (true/false) */
Nut = false;

$fn=80;
module clamp(x,y,z) {
	xlength = 22;
	ylength = 60;
	height = .1;	
	translate([x,y,z]) {
		minkowski() {
			cube([xlength, ylength, height], center=true);
			sphere(d=4.9);
		}		
	}
}

if(Pin) {
	union() {
		translate([-40, 0, 2.47]) {
			cube([5, 40, 15], center=true);
		}
		translate([-40, 0, 9.97]) {
			rotate(90, v=[1,0,0]) cylinder(d=5, h=40, center=true);
		}
		translate([-40, 0, -6.53]) {
			cube([9, 44, 3], center=true);
		}
	}
}

if(Clamp) {
	rotate(15.95, [0,1,0]) {
		difference() {
			union() {
				clamp(-11, 0, -5.75);
				clamp(-11, 0, 5.75);
			
/*Arm*/			ArmPoints = [
				  [  105,  7.5,  24.2 ],  	// 0 Front Bottom Left
				  [ 0,  30,  -5.8 ],  		// 1 Front Bottom Right
				  [ 0,  -30,  -5.8 ],  		// 2 Back Bottom Right
				  [  105,  -7.6,  24.2 ],  	// 3 Back Bottom Left
				  [  105,  7.5,  35.8 ],  	// 4 Front Top Left
				  [ 0,  30,  5.8 ],  		// 5 Front Top Right
				  [ 0,  -30,  5.8 ],  		// 6 Back Top Right
				  [  105,  -7.6,  35.8 ]]; 	// 7 Back Top Left
				ArmFaces = [
				  [0,1,2,3], // bottom
				  [4,5,1,0], // front
				  [7,6,5,4], // top
				  [5,6,2,1], // right
				  [6,7,3,2], // back
				  [7,4,0,3]];// left
				minkowski() {
					polyhedron( ArmPoints, ArmFaces );
					sphere(d=4.9);
				}
				
/*Stem*/		minkowski() {
					difference() {
						translate([105, 0, 12.65]) { 
							cylinder(d=15.1, h=35);
						}
						translate([100,0,12.374]) {
							rotate(74.075, [0,1,0]) cube([20,40,70], center=true);
						}
					}
					sphere(d=4.9);
				}
				
/*Tripod*/		translate([105, 0, 47.74]) { 
					rotate(-90, v=[0,0,1]) import("tripod.stl");
					rotate(-90, v=[0,0,1]) import("padding.stl");
				}
				translate([105, -.15, 47.74]) { 
					rotate(-90, v=[0,0,1]) import("padding.stl");
				}
				
				if(Nut) {	
/*Nut*/				translate([105, -9.85, 73.25]) {
						difference() {
							rotate(-90, v=[1,0,0]) cylinder(d=10, h=4.136);
							rotate(-90, v=[1,0,0]) cylinder(d=7, h=15, center=true);
						}
						 rotate(-90, v=[1,0,0]) import("m5_fixed.stl");
						difference() {
							scale([1,.25,1]) sphere(d=10);
							rotate(-90, v=[1,0,0]) cylinder(d=10, h=4.136);
						}
					}
				}
			}
/*Pin Gap*/	translate([-15.05, 0, 0]) {
				cube([5.5, 41.5, 18.5], center=true);
			}
		}
	}
}