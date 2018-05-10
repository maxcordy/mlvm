//display only
00_build_plate = 0; //[0:Replicator 2,1:Replicator,3:Thing-o-Matic]
//total length of the car in mm
01_length = 60; //[30:200]
//how wide the car is (height on the build platform)
02_width_factor = 50;//[0:100]

03_wheel_size = 100;//[0:100]
//the maximum number of wheels your car can have (will automatically be reduced based on length and wheel size)
04_max_number_of_wheels = 8; //[2:8]
//how round your wheels are
05_wheel_facets = 24;//[16:32]
//how wide your tires are
06_tire_width_factor = 0;//[0:100]
//how thick your axel is
07_axel_radius_factor = 0;//[0:100]
//how many treads are cut out of the wheel
08_tread_density = 0;//[0:100]
//how deep are the treads
09_tread_depth_factor = 100;//[20:100]
//how big are the treads
10_tread_size_factor = 50;//[20:100]
//how much do the wheel wells enclose the wheels
11_wheel_well_coverage_factor = 50; //[10:75]
//height of the body of the car
12_platform_thickness = 0;//[0:10]






length = 01_length/1;

width_factor = 02_width_factor/1;

wheel_size = 03_wheel_size/1;

tire_width_factor = 06_tire_width_factor/1;

wheel_resolution = 05_wheel_facets/1;

axel_radius_factor = 07_axel_radius_factor/1;

platform_thickness = 12_platform_thickness/1;

tread_amount = 08_tread_density/1;

tread_depth_factor = 09_tread_depth_factor/1;

tread_size_factor = 10_tread_size_factor/1;

well_coverage_percent = 11_wheel_well_coverage_factor/1;

max_number_of_wheels = 04_max_number_of_wheels/1;


width = length*(.5+(width_factor/200));

well_thickness = .8/1;
well_tolerance = .6/1;
wheel_separation = 1/1;

wheel_width = width/8*(.5+(tire_width_factor/200)); 

max_wheel_radius = 6 + (((length-30)/170)*34);
min_wheel_radius = 4 + (((length-30)/170)*12);
wheel_radius = min_wheel_radius + (wheel_size/100*(max_wheel_radius-min_wheel_radius));
//echo("wheel radius",wheel_radius);
inner_wheel_width = wheel_width*.8; 

height = 10/1;


tread_number = wheel_resolution*(1+(tread_amount/100));
tread_depth = wheel_radius/10*(tread_depth_factor/100);
tread_peak_width = wheel_radius*2*PI/wheel_resolution*(tread_size_factor/100);
tread_valley_width = 0.1/1;

axel_radius = wheel_radius*(.25+axel_radius_factor/500);
axel_width = width/3;


auto_num_wheels = length/(wheel_radius+wheel_separation)/2;


well_coverage = wheel_radius*2*(well_coverage_percent/100);




front_wheel_pos_total = length/2 - wheel_radius - well_thickness - well_tolerance;

fudge = .05/1;


build_plate();

main(length,height,width,wheel_width,inner_wheel_width,wheel_radius,axel_width,axel_radius,wheel_resolution,well_coverage,well_thickness,well_tolerance,max_number_of_wheels,auto_num_wheels,front_wheel_pos_total,tread_number,tread_depth,tread_valley_width,tread_peak_width,platform_thickness);

module build_plate(){
	translate([0,0,-.5]){
		if(00_build_plate == 0){
			%cube([285,153,1],center = true);
		}
		if(00_build_plate == 1){
			%cube([225,145,1],center = true);
		}
		if(00_build_plate == 3){
			%cube([120,120,1],center = true);
		}
	
	}
}

module main(l,h,w,ww,iww,wr,aw,ar,res,wellco,wellth,wellto,mnw,anw,fwpt,tn,td,tvw,tpw,pt){
	number_of_wheels = 0;
	//echo(anw);
	//echo(floor(anw));
	translate([0,0,width/2])
	if(mnw < floor(anw)){
		assign(number_of_wheels = mnw){
			//echo(number_of_wheels);
			car(l,h,w,ww,iww,wr,aw,ar,res,wellco,wellth,wellto,fwpt,number_of_wheels,tn,td,tvw,tpw,pt);
		}
	} else {
		assign(number_of_wheels = floor(anw)){
			//echo(number_of_wheels);
			car(l,h,w,ww,iww,wr,aw,ar,res,wellco,wellth,wellto,fwpt,number_of_wheels,tn,td,tvw,tpw,pt);
		}
	}
}


module car(l,h,w,ww,iww,wr,aw,ar,res,wellco,wellth,wellto,fwpt,nw,tn,td,tvw,tpw,pt){
	difference(){
		car_body(l,h,w,ww,wr,aw,ar,res,wellco,wellth,wellto,fwpt,nw,pt);

		for(i = [0:nw-1]){
			translate([fwpt-(fwpt*2/(nw-1))*i,-h/2,0])
				wheel_well(w+.05,ww,iww,wr,aw,ar,res,wellth,wellto);
		}

	}
	

	for(i = [0:nw-1]){
		translate([fwpt-(fwpt*2/(nw-1))*i,-h/2,0])
			wheel(w,ww,iww,wr,aw,ar,res,tn,td,tvw,tpw);
	}
	car_top_simple();
}

module car_top_simple(){
	difference(){
		union(){
			difference(){
				translate([0,wheel_radius-height/2+platform_thickness+well_thickness+well_tolerance-fudge,0])
					scale([1,.3,1])
						cylinder(h = width, r = length/2, center = true);
				translate([0,-length/4+wheel_radius-height/2+platform_thickness+well_thickness+well_tolerance,0])
					cube([length+fudge,length/2,width+fudge], center = true);
			}
			difference(){
				translate([0,wheel_radius-height/2+platform_thickness+well_thickness+well_tolerance,0])
					scale([.6,.7,1])
					cylinder(h = width, r = length/2, center = true);
				translate([0,-length/4+wheel_radius-height/2+well_tolerance+well_thickness+platform_thickness,0])
					cube([length+fudge,length/2,width+fudge], center = true);
			}
		}
		difference(){
			translate([0,wheel_radius-height/2+platform_thickness+well_thickness+well_tolerance,0])
				scale([.5,.6,1])
				cylinder(h = width+fudge, r = length/2, center = true);
			translate([0,-length/8+wheel_radius-height/2+platform_thickness+well_thickness+well_tolerance,0])
				cube([length+fudge,length/2,width+fudge*2], center = true);
		}
	}
}

module car_body(l,h,w,ww,wr,aw,ar,res,wellco,wellth,wellto,fwpt,nw,pt){
	hull(){
		hull(){
			translate([0,wr-h/2+wellth+wellto+pt-(wellth+wellto+pt+wellco)/2,0])
				cube([l,wellth+wellto+pt+wellco,w],center = true);
			hull(){
				translate([0,(wr-h/2)/2,0])
					cube([l,wr-h/2,aw],center = true);
				for(i = [0:1]){
					translate([fwpt-((fwpt*2))*i,-h/2,0])
							cylinder(h = aw, r = ar+wellto+wellth, $fn = res, center = true);
				}
			}
		}
	}

}

module wheel_well(w,ww,iww,wr,aw,ar,res,wellth,wellto){
	union(){
		hull(){
			translate([0,0,w/2+(ww+2)/2-ww])
				cylinder(h = ww+2, r = wr+wellto, $fn = res, center = true);
			
			translate([0,0,w/2-ww-iww+.5])
				cylinder(h = 1, r = wr-iww+wellto, $fn = res, center = true);
		}
		hull(){
			translate([0,0,w/2-ww-iww+.5])
				cylinder(h = 1, r = wr-iww+wellto, $fn = res, center = true);
			
			translate([0,0,axel_width/2+.5])
				cylinder(h = 1, r = ar+wellto, $fn = res, center = true);
		}
		hull(){
			translate([0,0,-(axel_width/2+.5)])
				cylinder(h = 1, r = ar+wellto, $fn = res, center = true);
			
			translate([0,0,-(w/2-ww-iww+.5)])
				cylinder(h = 1, r = wr-iww+wellto, $fn = res, center = true);
		}
		hull(){
			translate([0,0,-(w/2-ww-iww+.5)])
				cylinder(h = 1, r = wr-iww+wellto, $fn = res, center = true);
		
			translate([0,0,-(w/2+(ww+2)/2-ww)])
				cylinder(h = ww+2, r = wr+wellto, $fn = res, center = true);
		}
		cylinder(h = aw+1, r = ar+wellto, $fn = res, center = true);
	}
}



module wheel(w,ww,iww,wr,aw,ar,res,tn,td,tvw,tpw){
	





	difference(){

		union(){
			hull(){
				translate([0,0,w/2-ww/2])
					cylinder(h = ww, r = wr, $fn = res, center = true);
				
				translate([0,0,w/2-ww-iww+.5])
					cylinder(h = 1, r = wr-iww, $fn = res, center = true);
			}
			hull(){
				translate([0,0,w/2-ww-iww+.5])
					cylinder(h = 1, r = wr-iww, $fn = res, center = true);
				
				translate([0,0,axel_width/2+.5])
					cylinder(h = 1, r = ar, $fn = res, center = true);
			}
			hull(){
				translate([0,0,-(axel_width/2+.5)])
					cylinder(h = 1, r = ar, $fn = res, center = true);
				
				translate([0,0,-(w/2-ww-iww+.5)])
					cylinder(h = 1, r = wr-iww, $fn = res, center = true);
			}
			hull(){
				translate([0,0,-(w/2-ww-iww+.5)])
					cylinder(h = 1, r = wr-iww, $fn = res, center = true);
			
				translate([0,0,-(w/2-ww/2)])
					cylinder(h = ww, r = wr, $fn = res, center = true);
			}
			cylinder(h = aw, r = ar, $fn = res, center = true);
		}
		for(i = [0:tn-1]){
		rotate([0,0,360/tn*i])
		translate([wr,0,0])
		hull(){
			translate([.1/2,0,0])
				cube([.1,tpw,w+.05],center = true);
			translate([-td+.1/2,0,0])
				cube([.1,tvw,w+.05],center = true);
		}
		}
	}
}
