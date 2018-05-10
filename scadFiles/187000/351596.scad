// Height of the wristband
h=20; //[10:40]
//Width of the writsband
w=80; //[40:100]
//Size of the logo Canvas
c=h-2; //[(h/2):(h-2)]
//radius of the sideholes
r=2; //[2:5]

module Band(){
difference(){
square([w,h], center = true);
translate([((w/2)-4),0,0]){
circle(r);
		}
translate([(-(w/2)+4),0,0]){
circle(r);
		}
	}
}

module Logo(){

union(){
//square(c, center = true);
scale([(c/18),(c/18)]){
polygon(points=[[0,8.5],[4,0.5],[-4,0.5]]);
polygon(points=[[-4.5,0],[-8.5,-8],[-0.5,-8]]);
polygon(points=[[4.5,0],[0.5,-8],[8.5,-8]]);
	}
}
}

difference()
{

Band();
Logo();
}