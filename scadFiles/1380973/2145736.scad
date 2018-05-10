//iPad Retina
x=242;	//height of tablet
y=186;	//width of tablet
z=9.5;		//thickness of tablet

//iPad2
x=242;	//height of tablet
y=186;	//width of tablet
z=9;		//thickness of tablet

/*
//Xperia Tablet Z
x=266;	//height of tablet
y=172;	//width of tablet
z=7;		//thickness of tablet
*/

w=x/2.1;	//width
t=5;	//thickness of stand
e=2;	//edge radius
p=z*1.4;	//pad thickness
a=30;	//pad angle

//----------
te=t-e;	//thickness without edge radius
r=w/2;

module base(){
		difference(){
			scale([2,1,1])	cylinder(h=w*2.5,r=r, $fn=64);
			translate([-t,0,-1]) scale([2,1,1]) cylinder(h=w*2.5+2,r=r-t, $fn=64);
			translate([0,-w,-1])	cube([w*3,w*2,w*3]);
		}
}

module cut(){
	translate([w/20,-w,0]) 	rotate([0,-a,0])	{
		cube([w*3,w*2,w*3]);
		translate([-p-t,0,p*3.5]) cube([w*3,w*2,w*3]);
		translate([-p-t-e*3,0,p*2.5+1])	cube([p+e,w*2,w*3]);
	}
}

module stand(){
	minkowski(){
		sphere(e);
		difference(){
			base();
			cut();
		}
	}
}

//pad dummy
% rotate([0,0,180]) translate([-p*2-t,-y/2,p+t]) rotate([0,-a,0]) cube([z,y,x]);

rotate([0,0,180]) stand();