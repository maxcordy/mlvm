//just call build_plate(); with the following arguments (also, you have to have a real object in your scene for this to render)

//putting 0 as the first argument will give you a manually adjustable build plate (note: if you use this option, you need to specify your build plates X length (in mm) as the second argument and the Y length (in mm) as the third argument. eg. build_plate(0,150,120);)
//putting 1 as the first argument will give you a Replicator 1 build plate, 2 gives rep 2, see read me for list (or look down)
/*

to give your user control of which build plate they see in Customizer, include the following code:

use <utils/build_plate.scad>//this would work if makerbot overrides theirs with mine.
*/

/*[build_plate]*/

//to see how this works, uncomment (or use) the following code

//build plate numbers subject to change, will have figured out soonish... Probably will change around a fair amount anyway...      for display only, doesn't contribute to final object
build_plate_selector = 1; //[0: Manual, 1: Replicator, 2: Replicator 2, 3: Replicator 2X, 4: Replicator (5th Generation), 5: Replicator Mini, 6: Replicator Z18, 7: Thing-O-Matic, 8: Cupcake CNC, 9: Afinia H480, 10: Afinia H800, 11: AW3D HD, 12: B9Creator, 13: Robox, 14: Bukito, 15: Bukobot V2, 16: Form 1, 17: Form 2, 18: hyrel, 19: Creatr, 20: Xeed, 21: TAZ, 22: TAZ Mini, 23: Makergear M2, 24: Printrbot Plus, 25: Printrbot Simple Kit, 26: Printrbot Go small, 27: Printrbot Go medium, 28: Printrbot Go large,29:Diamond Age Moa,]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
/*[extra_feature_to_control_the_cube]*/
//1 square = 1cm aka 10mm, 5 squares is about 2 inches (so .8mm above 2 inches)s
squares_the_cube_takes_up = 3;//[1:20]
if(squares_the_cube_takes_up%2 == 0){
	translate([0,0,squares_the_cube_takes_up*5]){
		cube(squares_the_cube_takes_up*10,center =true);
	}
}
else{
	translate([5,5,squares_the_cube_takes_up*5]){
		cube(squares_the_cube_takes_up*10,center =true);
	}
}
module build_plate(bp,manX,manY){
		build_plate_templates = [[manX,manY,"manual"],[252,199,"Replicator"],[285,153,"Replicator 2"],[246,152,"Replicator 2X"],[252,199,"Replicator (5th Generation)"],[100,100,"Replicator Mini"],[300,305,"Replicator Z18"],[120,120,"Thing-O-Matic"],[100,100,"Cupcake CNC"],[140,140,"Afinia H480"],[254,203.2,"Afinia H800"],[317.5,203.2,"AW3D HD"],[104,75,"B9Creator"],[210,150,"Robox"],[150,150,"Bukito"],[200,200,"Bukobot V2"],[125,125,"Form 1"],[145,145,"Form 2"],[200,200,"hyrel"],[230,270,"Creatr"],[280,220,"Xeed"],[298,275,"TAZ"],[152,152,"TAZ Mini"],[203.2,254,"Makergear M2"],[250,250,"Printrbot Plus"],[150,150,"Printrbot Simple Kit"],[203,152,"Printrbot Go small"],[406,203,"Printrbot Go medium"],[610,305,"Printrbot Go large"],[400,400,"Diamond Age Moa"]];
		translate([0,0,-.52]){
			%cube([build_plate_templates[bp][0],build_plate_templates[bp][1],1],center = true);
			
		}
		translate([0,0,-.5]){
			for(i = [-1*floor(build_plate_templates[bp][0]/20):build_plate_templates[bp][0]/20]){
					translate([i*10,0,0])
						%cube([.5,build_plate_templates[bp][1],1.01],center = true);
				}
				for(i = [-1*floor(build_plate_templates[bp][1]/20):build_plate_templates[bp][1]/20]){
					translate([0,i*10,0])
						%cube([build_plate_templates[bp][0],.5,1.01],center = true);
				}
		}
}