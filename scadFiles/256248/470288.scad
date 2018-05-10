use <write/Write.scad> //WriteScad By Harlan Martin harlan@sutlog.com
letter="Q";
number="10";
/* [Hidden] */
ht=6.28; // tile height
t_size=[18.9,20.2,ht]; // tile size
		
difference() {
	rect(t_size);
	if (number == "10") {
		translate([-1.2,0,ht/2]) write(letter,t=.8,h=12,center=true);	
		translate([5.5,-5.3,ht/2]) write(number,t=.8,h=4,center=true);
	}
	else {
		translate([0,0,ht/2]) write(letter,t=.8,h=12,center=true);	
		translate([6.3,-5.3,ht/2]) write(number,t=.8,h=4,center=true);
	}
	translate([0,0,-2]) cylinder(r=8,h=4,center=true);
}

//--------------------------------------------------------------------------------
module rect(s) {
cube(size=[s[0],s[1],s[2]],center=true);
}