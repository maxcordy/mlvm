// Customisable Latching Broom Holder by GregFrost
// Licensed under the Creative Commons - Attribution - Non-Commercial - Share Alike license
// © 2017 by GregFrost
// http://www.thingiverse.com/thing:2029895

//Remixed to add more options
// http://www.thingiverse.com/thing:2034340

//The diameter of the broom to be mounted. consider adding a small clearance.
broom_diameter=21;

//Total height of the hinge.
hinge_height=25;

//Distance from wall to broom. If this is set below the minimum required, it will be ignored.
wall_offset=28;

//The vertical gap where the layers should break.
vertical_clearance=0.39;

//Your printer's extruded width.
extruded_width=0.5;

//Number of passes of filament surrounding hinge holes. 
//The the thickness of the rest of the model is about double this.
num_filament_passes=4;

//Used for a half filament width inset on the first later to enable squishing without a lip.
first_layer_height=0.425;

//Diameter of the holes for the hinge pins.
hinge_pin_hole_diameter=3;

//Space around hinge parts.
hinge_clearance=1;

//The diameter of the wall mounting holes.
mount_screw_diameter=4;

//The depth of countersink/bore for mounting holes.
mount_screw_countersunk_depth=3;

//Counterbore for pan-head screws. Set to 0 to countersink.
mount_screw_counterbore_diameter=8;

//if True, leaves a clean print but drastically slows compile.
inset_first_layer=false;

/////////////////////////////////////////////////////////////////////////////////////////////////

// The arbitrary part with first layer inset. 
module inset_first_layer(inset_height=0.31,inset_width=0.2)
{ 
    difference()
    { 
        children();

        translate([0,0,-1])
        linear_extrude(height=inset_height+1)
        difference()
        {
            offset(r = inset_width) 
            projection(cut=true) 
            translate([0,0,-inset_height])
            children();

            offset(r = -inset_width) 
            projection(cut=true) 
            translate([0,0,-inset_height])
            children();
        }
    } 
} 

show_cross_section=false;

//This controls the angle of the hinge loop. 
//For small diameters it is necessary to reduce the angle so it doesnt join the front support arm.
x=(broom_diameter >= 12)?48:(48-(12-broom_diameter)*4);
t=extruded_width*num_filament_passes;
$fn=64;
epsilon=0.01;
final_angle=78;

spacing=3;

A=[0,broom_diameter/2+t+hinge_pin_hole_diameter/2];
B=(broom_diameter/2+t*2+hinge_pin_hole_diameter/2)*[sin(x),cos(x)];
B2=[B[0]+hinge_pin_hole_diameter/2+t,B[1]];
C=[B2[0],A[1]-t];
D=[C[0]+t+hinge_pin_hole_diameter/2,C[1]];
E=[D[0]+t+hinge_pin_hole_diameter/2,D[1]];
F=[E[0],broom_diameter/2*0.6];
F2=[F[0]+hinge_pin_hole_diameter/2,F[1]];
G=[broom_diameter/2+t+hinge_pin_hole_diameter/2,0];

I=F2+(2*t+spacing)*[1,1];
J=[I[0],A[1]+hinge_pin_hole_diameter/2+t+spacing+t];
K=(broom_diameter/2+t)*[cos(final_angle),-sin(final_angle)];

mount_wall_offset=wall_offset>J[1] ? wall_offset-J[1] : 0;

// Locate key design waypoints.
*translate(B)
color("blue")
cylinder(d=1,h=hinge_height*1.5);

module arc(r1=1,r2=2,angle=45)
{
	difference()
	{
		intersection()
		{
			circle(r=r2);
			translate([-r2*3/2,0])
			square(3*r2);
			rotate(angle-180)
			translate([-r2*3/2,0])
			square(3*r2);
		}
		circle(r=r1);
	}
}

module hinge1()
{
	translate(A) 
	circle(d=hinge_pin_hole_diameter);
	
	rotate(90-x)
	arc(r1=broom_diameter/2+t,r2=broom_diameter/2+t+epsilon,angle=x);
}

module hinge2()
{
	translate(B)
	rotate(-x-90)
	arc(r1=t+hinge_pin_hole_diameter/2,r2=t+hinge_pin_hole_diameter/2+epsilon,angle=90+x);

	translate(B2)
	square([epsilon,C[1]-B2[1]]);

	translate(D)
	arc(r1=t+hinge_pin_hole_diameter/2,r2=t+hinge_pin_hole_diameter/2+epsilon,angle=180);
}

module hinge3()
{
	translate(F)
	square([epsilon,E[1]-F[1]]);

	hull()
	{
		translate(F+[hinge_pin_hole_diameter/2,0])
		circle(d=hinge_pin_hole_diameter);
	
		translate(G)
		circle(d=hinge_pin_hole_diameter);
	}

	rotate(-final_angle)
	arc(r1=broom_diameter/2+t,r2=broom_diameter/2+t+epsilon,angle=final_angle);
}

module hinge_holes()
{
        translate(A)
        circle(d=hinge_pin_hole_diameter);
        translate(F2)
        circle(d=hinge_pin_hole_diameter);
}

module hinge()
{
    difference ()
    {
        z=3;
    
        union()
        {
            offset(r=-z)
            offset(r=t+z)
            hinge1();
            
            offset(r=t)
            hinge2();
    
            offset(r=-z)
            offset(r=t+z)
            hinge3();
        }
    }
}

module hinge_clearance()
{
    offset(r=hinge_clearance)
    hinge();

    translate(F2)
    rotate(90)
    translate(-F2)
    offset(r=hinge_clearance)
    hinge();
}

module hinge_cone()
{
    cylinder(d1=hinge_pin_hole_diameter+2*t-2.1*extruded_width,d2=0,h=hinge_pin_hole_diameter+2*t-2.1*extruded_width);
}

module right_hinge()
{
    difference()
    {
        linear_extrude(height=hinge_height,convexity=4)
        hinge();
        
        translate([0,0,1])
        linear_extrude(height=hinge_height,convexity=4)
        hinge_holes();
 
        translate([0,0,hinge_height/4-vertical_clearance/2])
        linear_extrude(height=hinge_height/2+vertical_clearance,convexity=4)
        union()
        {
            mount_clearance();
            translate(A)
            circle(d=hinge_pin_hole_diameter+2*t+2*hinge_clearance,h=hinge_height/4+vertical_clearance/2+1);
        }

        translate([0,0,hinge_height*3/4+vertical_clearance/2-epsilon])
        translate(A)
        hinge_cone();
        
        translate([0,0,hinge_height*3/4+vertical_clearance/2-epsilon])
        translate(F2)
        hinge_cone();
    }
}

module left_hinge()
{
    mirror([1,0,0])
    difference()
    {
        linear_extrude(height=hinge_height,convexity=4)
        hinge();
 
        translate([0,0,1])
        linear_extrude(height=hinge_height,convexity=4)
        hinge_holes();
        
        for (z=[-1,hinge_height*3/4-vertical_clearance/2])
        translate([0,0,z])
        linear_extrude(height=hinge_height/4+vertical_clearance/2+1,convexity=4)
        union()
        {
            mount_clearance();
            translate(A)
            circle(d=hinge_pin_hole_diameter+2*t+2*hinge_clearance,h=hinge_height/4+vertical_clearance/2+1);
        }
        
        translate([0,0,hinge_height/4+vertical_clearance/2-epsilon])
        translate(F2)
        hinge_cone();

        translate([0,0,hinge_height/4+vertical_clearance/2-epsilon])
        translate(A)
        hinge_cone();
    }
}

module mount1()
{
    translate(F2)
    circle(d=hinge_pin_hole_diameter+2*t);
}
module mount2()
{
    translate(I)
    circle(d=hinge_pin_hole_diameter+2*t);
}
module mount3()
{
    translate(J+[0,(mount_wall_offset/2)])
    square([hinge_pin_hole_diameter+2*t,t*2+mount_wall_offset],center=true);
}
module mount4()
{
    translate([0,J[1]-t])
    square([hinge_pin_hole_diameter+2*t,t*2+mount_wall_offset]);
}

module half_mount()
{
    hull()
    {
        mount1();
        mount2();
    }
    
    hull()
    {
        mount2();
        mount3();
    }
    
    hull()
    {
        mount3();
        mount4();
    }
}

module mount_profile()
offset(r=-3)
offset(delta=3)
{
    half_mount();
    mirror([1,0,0])
    half_mount();
}

module mount_outline()
{
    difference()
    {
        mount_profile();
        offset(r=-0.5)
        mount_profile();
    }
}

*mount_outline();

module mount_clearance()
{
    offset(r=hinge_clearance)
    mount_profile();

    translate(F2)
    rotate(-90)
    translate(-F2)
    offset(r=hinge_clearance)
    mount_profile();
}

*mount_clearance();

module mount_holes()
{
    // Mounting holes.

    for (z=[2]*hinge_height/4)
//    for (z=[1,3]*hinge_height/4)

    for (x=[1,-1]*J[0]*1/2)
    translate([x,J[1]+mount_screw_countersunk_depth+(mount_wall_offset/2),z])
    rotate([90,0,0])
    rotate(180/8)
    {
        cylinder(h=t*t+0.5+mount_wall_offset,d=mount_screw_diameter,$fn=8,center=true);
            
        translate([0,0,t+(mount_wall_offset/2)])
        if (mount_screw_counterbore_diameter>0){
            cylinder(d=mount_screw_counterbore_diameter,
            h=mount_screw_countersunk_depth+epsilon,$fn=8);
        } else {
        cylinder(d1=mount_screw_diameter,
            d2=mount_screw_diameter+(mount_screw_countersunk_depth+epsilon)*2,
            h=mount_screw_countersunk_depth+epsilon,$fn=8);
        }
    }
}

module mount(assembled=false)
{ 
    difference()
    {
        linear_extrude(height=hinge_height,convexity=4)
        mount_profile();
        
        mirror([1,0,0])
        translate([0,0,hinge_height/4-vertical_clearance/2])
        linear_extrude(height=hinge_height/2+vertical_clearance,convexity=4)
        hinge_clearance();
        
        translate([0,0,-1])
        linear_extrude(height=hinge_height/4+vertical_clearance/2+1,convexity=4)
        hinge_clearance();

        translate([0,0,hinge_height-hinge_height/4-vertical_clearance/2])
        linear_extrude(height=hinge_height/4+vertical_clearance/2+1,convexity=4)
        hinge_clearance();
        
        translate(F2)
        translate([0,0,1])
        cylinder(d=hinge_pin_hole_diameter,h=hinge_height+2);

        mirror([1,0,0])
        translate(F2)
        translate([0,0,1])
        cylinder(d=hinge_pin_hole_diameter,h=hinge_height+2);

        translate([0,0,hinge_height/4+vertical_clearance/2-epsilon])
        translate(F2)
        hinge_cone();
        
        mirror([1,0,0])
        translate([0,0,hinge_height*3/4+vertical_clearance/2-epsilon])
        translate(F2)
        hinge_cone();

        mount_holes();
    }
}

module assembled()
{
    left_hinge();
    right_hinge();
    
    mount(assembled=true);

    if (!show_cross_section)
    {
        // The broom handle.
        translate([0,0,-hinge_height/2])
        %cylinder(d=broom_diameter,h=hinge_height*2);
    }
}


module assembled_and_inset()
{
    inset_first_layer(inset_height=first_layer_height*1.01,inset_width=extruded_width/2)
    {
        assembled();
    }
}

if (show_cross_section)
{
    intersection()
    {
        if(inset_first_layer){
            assembled_and_inset();
        } else {
            assembled();
        }
        translate([0,F[1]])
        cube(100);
    }
}
else
{
    if(inset_first_layer){
        assembled_and_inset();
    } else {
        assembled();
    }
}
