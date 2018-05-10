
// (C) Radus Linuxbashev 2015
// http://vk.com/linuxbashev

lay=0.2;

m4d=4+0.3;
m4nd = 7.8+0.4;
m4nh=3.4;
m4shd=8.9+0.7;


x=70;				// x length
y=130;			//	y length

bwx=60;			// spool height between sliders
bwy=110;			//	Y length beetween rails

z=3;				// height of base
ry=15;			// rail width

wx=15;			// base part size
wz=10;			// rail height

w=2;


slx=12+5;			// spool rollers X size
slx1=5+5+0.9+0.9;	// roller bearing height with washings

d1=13;		// diameter roller bearings
d2=20;		// diameter flange rollers
d3=d2;		// diameter flange rollers2

dk=205;

osz=wz+1+d1/2;

z2=13;

pw=1;
pw1=1;
py=4;
pph1=wz-4;
pph2=wz-6;

fs=2;

$fn=64;

//---------------------------
module paz(px, ppy, pz, ph) {
difference() {
union() {
hull() {
translate([0,ppy-pw-pw1/2,0]) cube([px, pw1, ph], true);
translate([0,ppy-pw/2,0]) cube([px, pw, pz], true);
} // hl
translate([0,ppy/2-ppy/4,0]) cube([px, ppy, ph], true);
} // un

} // df
} // mod paz;


module sph() {
difference() {
union() {
for (mx=[0,1]) mirror([mx,0,0])
translate([-x/2, 0, z/2]) cube([wx, y, z], true);

for (my=[0,1]) mirror([0,my,0])
for (mx=[0,1]) mirror([mx,0,0])
translate([-x/2, -y/2, z/2]) cylinder(z, wx/2, wx/2, true);

for (my=[0,1]) mirror([0,my,0])
translate([0,bwy/2, (wz+z)/2]) cube([x+wx, ry, wz+z], true);

} // un

for (myy=[0,1]) mirror([0,myy,0])
translate([0,bwy/2,0])
for (my=[0,1]) mirror([0,my,0])
translate([0,-ry/2,z+wz/2]) paz(x+wx+1, py, pph1, pph2);

for (mx=[0,1]) mirror([mx,0,0])
for (my=[0,1]) mirror([0,my,0])
translate([0,-bwy/2,0])
for (myy=[0,1]) mirror([0,myy,0])
translate([-x/2-wx/2, -ry/2, z+wz/2+0.1]) rotate([0,0,45]) cube([fs, fs, wz+0.2], true);

} // df
} // mod sph


module spsl() {
difference() {
union() {
translate([0,0,osz/2]) cube([slx, d2, osz], true);
translate([-slx/2+(slx-slx1)/4,0,osz]) rotate([0,90,0]) cylinder((slx-slx1)/2, d3/2, d3/2, true);

translate([+slx/2-(slx-slx1)/4,0,osz]) rotate([0,90,0]) cylinder((slx-slx1)/2, d3/2, d3/2, true);
} // un

%translate([0,0,osz]) rotate([0,90,0]) cylinder(slx1, d1/2, d1/2, true);


translate([0,0,osz+d2/2]) cube([slx1, d2+1, d2], true);

translate([0,0,osz-d1/2]) cube([slx1, d1/2, d1], true);

translate([0,0,osz]) rotate([0,90,0]) cylinder(slx1, d1/2+1, d1/2+1, true);

translate([0,0,osz]) rotate([0,90,0]) cylinder(slx+1, m4d/2, m4d/2, true);


translate([0,0,wz/2]) cube([slx+1, ry+lay*2, wz+lay*2], true);
} // df
} // mod spsl

module spsl1() {
difference() {
union() {
spsl();
translate([-slx/2-m4nh/2, 0, osz]) rotate([0,90,0]) cylinder(m4nh+0.1, m4nd/2+1, d3/2-3, true);

for (my=[0,1]) mirror([0,my,0])
translate([0,-ry/2,wz/2]) paz(slx, py-lay, pph1-lay*2, pph2-lay*2);

} // un

translate([-slx/2-m4nh, 0, osz]) rotate([0,90,0]) cylinder(m4nh*2+0.2, m4nd/2, m4nd/2, true, $fn=6);

for (my=[0,1]) mirror([0,my,0]) {
translate([-slx/2-1,d2/2-(d2-ry)+1.5,(wz-pph2+lay*2)/2]) mirror([0,0,1]) cube([slx+2, (d2-ry), wz]);
translate([0,d2/2,(wz-pph2+lay*2)/2]) rotate([45,0,0]) cube([slx+1, fs, fs], true);
} // for

//translate([slx/2,0,osz]) rotate([45,0,0]) translate([0,d2/2+d1/2,0]) cube([slx, d2, d2], true);

} // df
} // mod spsl1


module spsl22() {
difference() {
union() {
translate([0,0,z2/2]) cube([slx, d2, z2], true);

for (my=[0,1]) mirror([0,my,0]) {
translate([0,-d2/2,z2+w]) rotate([-90,0,0]) cylinder((d2-ry)/2, slx/2, slx/2);
translate([0,-d2/2+((d2-ry)/2)/2,z2]) cube([slx, (d2-ry)/2, w*2], true);
} // for

} // un

translate([0,0,z2+w]) rotate([-90,0,0]) cylinder(d2+1, 2.5/2, 2.5/2, $fn=8, true);

translate([0,0,wz/2]) cube([slx+1, ry+lay*2, wz+lay*4], true);




} // df
} // mod spsl

module spsl2() {
difference() {
union() {
spsl22();

for (my=[0,1]) mirror([0,my,0])
translate([0,-ry/2,wz/2]) paz(slx, py-lay, pph1-lay*2, pph2-lay*2);

} // un


for (my=[0,1]) mirror([0,my,0]) {
translate([-slx/2-1,d2/2-(d2-ry)+1.5,(wz-pph2+lay*2)/2]) mirror([0,0,1]) cube([slx+2, (d2-ry), wz]);
translate([0,d2/2,(wz-pph2+lay*2)/2]) rotate([45,0,0]) cube([slx+1, fs, fs], true);
} // for

//translate([slx/2,0,osz]) rotate([45,0,0]) translate([0,d2/2+d1/2,0]) cube([slx, d2, d2], true);

} // df
} // mod spsl2



// ---------------------------

//%translate([0,0,dk/2+12]) rotate([0,90,0]) cylinder(bwx, dk/2, dk/2, true);

//sph();

//for (my=[0,1]) mirror([0,my,0])
//for (mx=[0,1]) mirror([mx,0,0])
//translate([-bwx/2, -bwy/2, z])
spsl1();

//translate([0, -bwy/2, z])
//spsl2();

