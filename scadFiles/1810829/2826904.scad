// Using Bolt template for rock wall assignment
// Inane imperial units inexplicably in use in a free state: 3/8" - 16x2-1/2"
// All measurements below in mm

//Bolt head diamter with clearance for tool
B=25;

// Bolt head height
h=8;

// Bolt overall length
l=69.5;

// diamter
d=11;

$fn=100;

//Top grip radius
r=l;

//Top grip distance from center
w=40;

//Angle of top bulbs
ang=40;

//Bulb Protrusion
p=5;

module bolt(){
union(){
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
		}
					}


module grip(){
    rotate([0,90,0])translate([-r/2+p,w*sin(40)+r,0])cylinder(h=2*w+2*r, r=r/3, center=true);
}

difference(){

hull(){
sphere(r=l+h-.1);
rotate([0,0,ang])translate([w,0,p])sphere(r=l);
rotate([0,0,180-ang])translate([w,0,p])sphere(r=l);
}
bolt();
grip();
translate([0,0,-(1*l)])cube([3*l,3*l, 2*l], center=true);
}
