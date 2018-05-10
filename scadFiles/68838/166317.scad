// Nano wristband

band();

//Tolerance on joints (larger is looser)
tol=0.4;
//Thickness of band
T=4;
//Width of band (it will actually be slightly larger)
W=20;//[10:28]
//Minimum total circumference
Length=170;
//Smoother renders slower
quality=1;//[1:Coarse,2:Fine]

use <utils/build_plate.scad>

//for display only, doesn't contribute to final object
build_plate_selector = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
build_plate_manual_x = 220; //[100:400]
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

$fa=6/quality;
$fs=1/quality;
nub=T/2;
L=41*1;
Wn=35.5*1;
w=6*1;
n=round((Length-Wn-2*(tol+nub))/(4*nub+2*tol)+0.5);// total links needed
echo(n);

module band(){
translate([-n/2*(4*nub+2*tol)-Wn/2-nub-tol,0,0])clipF();
translate([n/2*(4*nub+2*tol)+Wn/2+nub+tol,0,0])clipM();
chain(n=n);
}

module chain(n=3)
translate([0,0,T/2])for(i=[1:n])translate([(i-n/2-1/2)*(4*nub+2*tol),0,0])link();

module clipM()
difference(){
	clip();
	translate([Wn/4,0,0])rotate([0,45,0])translate([Wn/2,0,0])cube(Wn,center=true);
	translate([0,2.9+tol/2,0])rotate([0,0,180])tines();
	translate([0,-L/2+11.8+2*tol-5,0])cube([23+2*tol,10,6],center=true);
	translate([0,0,2-tol+T])cube([Wn,L,2*T],center=true);
	translate([Wn/2,-L/2,2-tol])rotate([0,-60,0])cube([T,L,T]);
	translate([-Wn/2,-L/2,2-tol])rotate([0,-30,0])cube([T,L,T]);
	translate([-14,0,1.5])rotate([0,0,-90])monogram();
}

module clipF()
difference(){
	clip();
	translate([-Wn/4,0,0])rotate([0,-45,0])translate([-Wn/2,0,0])cube(Wn,center=true);
	translate([0,2.9+tol/2,0])tines();
	translate([0,-L/2+11.8+2*tol-5,0])cube([23+2*tol,10,6],center=true);
	translate([0,0,2-tol+T])cube([Wn,L,2*T],center=true);
	translate([Wn/2,-L/2,2-tol])rotate([0,-60,0])cube([T,L,T]);
	translate([-Wn/2,-L/2,2-tol])rotate([0,-30,0])cube([T,L,T]);
	translate([14,0,1.5])rotate([0,0,90])monogram();
}

module tines()
for(i=[-1:2])translate([0,2*(w+1-tol/2)*(i-0.25),0])
difference(){
	union(){
		cube([Wn,w,3*T],center=true);
		translate([Wn/4-tol/2,0,0])cube([Wn/2,w+2,3*T],center=true);
	}
	translate([Wn/4,0,0])rotate([0,45,0])translate([Wn/2,0,0])cube(Wn,center=true);
}

module clip()
union(){
	translate([0,0,1])cube([Wn,L-12-2*tol,2],center=true);
	translate([Wn/2-nub,0,nub])rotate([180,0,0])link();
	translate([-Wn/2+nub,0,nub])rotate([180,0,0])link();
}

module link()
render()
union(){
	halflink();
	mirror([0,1,0])halflink();
}

module halflink()
difference(){
	union(){
		rotate([90,0,0])cylinder(r=nub,h=W/2);
		translate([2*nub+tol,0,0])rotate([90,0,0])cylinder(r=nub-0.01,h=W/2);
		translate([0,-W/2,-nub])cube([2*nub+tol,nub,2*nub]);
		translate([0,-W/2,0])rotate([0,90,0])cylinder(r=nub,h=2*nub);
		translate([0,-W/2,0])sphere(r=nub);
		translate([2*nub+tol,-W/2,0])sphere(r=nub);
		translate([-2*nub-tol,0,0])connector(inside=1);
		translate([-2*nub-tol,nub+tol-W/2,-nub])cube([2*nub+tol,W/2-nub-tol,2*nub]);
	}
	translate([2*nub+tol,0.01,0])connector(inside=0);
	translate([0,0,-W-T/2])cube(2*W,center=true);
}

module connector(inside=0)
union(){
	rotate([90,0,0])cylinder(r=nub,h=W/2-nub-tol*inside);
	rotate([90,0,0])translate([0,0,W/2-nub-tol*inside])cylinder(r1=nub,r2=0,h=nub);
}

module monogram(h=1)
linear_extrude(height=h,center=true)
translate(-[3,2.5])union(){
	difference(){
		square([4,5]);
		translate([1,1])square([2,3]);
	}
	square([6,1]);
	translate([0,2])square([2,1]);
}