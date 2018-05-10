//ring size on US scale
size = 9; //[1:.5:20]

//thickness of the ring (inches from inner to outer diameter)
thickness = .125; //[.0625:.0005:.1875]

// Which part?
part = "both"; // [both:Both,ring:Ring Only,logo:Symbol Only]

//helpful variables
rs = size*.0326 + .455;
glod = 2*sqrt(pow((rs+2*thickness)/2,2)-pow(.46*rs,2));

print_part();

module print_part() {
	if (part == "ring") {
		ring();
	} else if (part == "logo") {
		logo();
	}else{
		both();
	}
}

//making the ring
module ring(){
	difference(){
		circle(r = rs/2+thickness, $fs = .1);
		union(){
			translate([0,0])circle(r = rs/2, $fs = .1);
			translate([rs*.46,-10]) square([5,20]);
			translate([1,0,thickness]) square([2,.46*glod]);
		}
	}
}

module logo(){
	difference(){
		union(){
			circle(r=glod/2, $fs=.1);
			translate([-glod/2,-.45*glod-.16*glod]){
				square([glod,.16*glod]);
			}
			translate([-glod/2,.45*glod]){
				square([glod,.16*glod]);
			}
		}
		union(){
			translate([0,0]) circle(r=.46*glod/2, $fs=.1);
		}
	}
}

module both(){
	translate([(rs+glod+.1)/2,0]) rotate(a=90,v=[0,1]) logo();
	ring();
}