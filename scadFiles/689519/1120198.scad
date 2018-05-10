squobe_size = 20; // [5:100]
//if squobe is not visible, lower hole size
hole_size = 15; // [5:100]

build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 100; //[100:400]
build_plate_manual_y = 100; //[100:400]
//
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
//



module build_plate(bp,manX,manY){

		translate([0,0,-.52]){
			if(bp == 0){
				%cube([285,153,1],center = true);
			}
			if(bp == 1){
				%cube([225,145,1],center = true);
			}
			if(bp == 2){
				%cube([120,120,1],center = true);
			}
			if(bp == 3){
				%cube([manX,manY,1],center = true);
			}
		
		}
		translate([0,0,-.5]){
			if(bp == 0){
				for(i = [-14:14]){
					translate([i*10,0,0])
					%cube([.5,153,1.01],center = true);
				}
				for(i = [-7:7]){
					translate([0,i*10,0])
					%cube([285,.5,1.01],center = true);
				}	
			}
			if(bp == 1){
				for(i = [-11:11]){
					translate([i*10,0,0])
						%cube([.5,145,1.01],center = true);
				}
				for(i = [-7:7]){
					translate([0,i*10,0])
						%cube([225,.5,1.01],center = true);
				}
			}
			if(bp == 2){
				for(i = [-6:6]){
					translate([i*10,0,0])
						%cube([.5,120,1.01],center = true);
				}
				for(i = [-6:6]){
					translate([0,i*10,0])
						%cube([120,.5,1.01],center = true);
				}
			}
			if(bp == 3){
				for(i = [-(floor(manX/20)):floor(manX/20)]){
					translate([i*10,0,0])
						%cube([.5,manY,1.01],center = true);
				}
				for(i = [-(floor(manY/20)):floor(manY/20)]){
					translate([0,i*10,0])
						%cube([manX,.5,1.01],center = true);
				}
			}
		}
}


cSize = squobe_size * 2;
sSize =(2/3)* cSize;
cyLength = cSize + 20;
x = hole_size;

translate([0,0,squobe_size])
{
difference()
{
intersection()
{
color([0,0,1,]) sphere(r=sSize);
color ([.909,.439,.368]) cube([cSize,cSize,cSize],center=true);
}


color ([0,1,0]) cylinder(cyLength,x,x,center=true);


rotate([90,0,0])
color ([0,1,0]) cylinder(cyLength,x,x,center=true);


rotate([0,90,0])
color ([0,1,0]) cylinder(cyLength,x,x,center=true);
}
}
