//	based off of:
//	Thingiverse Customizer Template v1.2 by MakerBlock
//  which can be found here:
//	http://www.thingiverse.com/thing:44090

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
//	include <utils/build_plate.scad> scrapping this one and using the one I made

//CUSTOMIZER VARIABLES
/* [Adjusting the block] */
//by having the /*[name of what you want shown]*/ you can make the drop down menu

//	This section is displays the box options
//	Measurement of box on the X axis
x_measurement = 5;	//	[1,5,10,15,20,25]
//	This creates a drop down box of numbered options

//	Measurement of box on the Y axis
y_measurement = 5;	//	[1:small, 5:medium small, 10:medium, ,15:medium large, 20:large, 25:extra large]
//	This creates a drop down box of text options with numerical values

//	Measurement of box on the Z axis
z_measurement = 5;	//	[1:25]
//	This creates a slider with a minimum and maximum

/* [Misc Demonstrations] */
//	This section demonstrates how we can create various options

text_box = 10;

//	This is the explanation text
another_text_box = 10;

//	This creates a drop down box of numbered options
number_drop_down_box = 1;	//	[0,1,2,3,4,5,6,7,8,9,10]

//	This creates a drop down box of text options
text_drop_down_box = "yes";	//	[yes,no,maybe]

//	This creates a drop down box of text options with numerical values
labeled_drop_down_box = 5;	//	[1:small, 5:medium, 10:large, 50:supersized]

//	This creates a slider with a minimum and maximum
numerical_slider = 1;	//	[0:10]

//	This option will not appear due to the *1
hidden_option = 100*1;

//	This option will also not appear
//	another_hidden_option = 101;

/*[build_plate]*/

//this is taken from my build plate library here: http://www.thingiverse.com/thing:1457320

//build plate numbers subject to change, 
build_plate_selector = 1; //[0: Manual, 1: Replicator, 2: Replicator 2, 3: Replicator 2X, 4: Replicator (5th Generation), 5: Replicator Mini, 6: Replicator Z18, 7: Thing-O-Matic, 8: Cupcake CNC, 9: Afinia H480, 10: Afinia H800, 11: AW3D HD, 12: B9Creator, 13: Robox, 14: Bukito, 15: Bukobot V2, 16: Form 1, 17: Form 2, 18: hyrel, 19: Creatr, 20: Xeed, 21: TAZ, 22: TAZ Mini, 23: Makergear M2, 24: Printrbot Plus, 25: Printrbot Simple Kit, 26: Printrbot Go small, 27: Printrbot Go medium, 28: Printrbot Go large,29:Diamond Age Moa,]
//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]
//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//as a bonus I also want to show my unit conversion option
/* [Unit adjustment] */
//Here are they units you deisgn in
units_entered = 10;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//and this is the unit the file is out put in, the default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]
//CUSTOMIZER VARIABLES END


//just include this module into your code or have it as a library
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



//this allows you to just multiply the units in here by this factor to adjust size, in the example case, cm to mm
unit_conversion_factor = units_entered*desired_units_for_output;

//	This is the cube we've customized!
translate([0,0,z_measurement/2*unit_conversion_factor]) cube([x_measurement, y_measurement, z_measurement]*unit_conversion_factor, center=true);
