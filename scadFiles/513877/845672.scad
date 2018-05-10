// paperclip (c)g3org 2014 

//in mm
inner_heart_size=25; 
//thickness
height=1.5; 

$fn=50*1;

module inner_heart() {
	linear_extrude(height = height)
		{
			square(inner_heart_size,center=true);
			translate([0, inner_heart_size/2, 0])
			circle(inner_heart_size/2);
			translate([inner_heart_size/2, 0, 0])
			circle(inner_heart_size/2);
		}
	
}

module outer_heart(){
	scale([1.2,1.2]){
			difference(){
				translate([-0.5,-0.5,0]) scale([1.3,1.3]) inner_heart();
				inner_heart();
			}
	}
}

module bridge(){
	translate([inner_heart_size/2*1.1,inner_heart_size/2*1.1,0]) {
		rotate([0,0,45]) {
			linear_extrude(height = height) square([inner_heart_size/2,inner_heart_size],center=true);
		}
	}
}

bridge();
inner_heart();
outer_heart();




