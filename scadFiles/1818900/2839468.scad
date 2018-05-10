


$fn = 100;

// usage:   adjust the phone module to suite your device.  This module represents the "cutouts" into
//          the mount and the visor.  Export the mount to STL, comment the mount and uncomment the 
//          visor, and export the visor to STL.  


// this is the entire phone mount (no visor)
difference(){
    hull(){
        // main phone block
        rotate([90,0,0]) cube([161,86,18]);

        // phone block extension (chin) - will be cut with difference
        translate([0,0,-20])rotate([90,0,0]) cube([161,20,18]);

        // mounting area
        translate([80.5,0,0]) halfcylinder(80.5, 2, 0.2);        
    }
    
    // cuts off the back section for a flush mount
    rotate([-47,0,0]) translate([-1,0,-100])cube([200,200,200]);

    translate([3,-5,5]) // 3 is the (161-155) / 
        rotate([90,0,0])
            phone([155, 81.5, 10]);

    // visor mounting holes
    rotate([0,0,-90]) visorMountingHoles(0);

}


// this is the visor
%union(){
    difference() {    
        rotate([0,0,-90]) mountVisor();

        translate([3,-5,5]) // 3 is the (161-155) 
            rotate([90,0,0])
                phone([155, 81, 10]); // slightly smaller phone to avoid cutting into the visor
    }
    
    // visor mounting holes
    rotate([0,0,-90]) visorMountingHoles(1);
}





// ==========================================================================
// ============================ PHONE MODULE ================================
// ==========================================================================
module phone (size)
{
    //cornerrad = 5;
    x = size[0];// - cornerrad;
	y = size[1];// - cornerrad;
	z = size[2];

    //main phone cube
    cube([x,y,z]);
    

    //////// camera hump ////////
    // x center position from the top of the phone
    // how large is the bump
    // height how tall is the bump
    camerabump = [5, 20, 2.5];
    translate([camerabump[0],0,-camerabump[2]])
        cube([camerabump[1],y,camerabump[2]]);
    


    /////// button cutout ///////
    // the x and y location of the button cutout    
    buttoncutout = [20, y]; // x is mm from top of phone, y for right side of phone
    translate([buttoncutout[0], buttoncutout[1]]) 
        cube([50,15,z]);
    
    
    /////// usb cutout ///////
    // the x and y location of the usbcutout
    usbcutout = [x, y/2];
    translate([usbcutout[0], usbcutout[1] - 7.5]) // -7.5 is half the cutout size
        cube([25,15,z]);

    /////// screen visibility block //////////
    screencutout = [x-6,y,20];
    translate([(x-screencutout[0])/2, (y-screencutout[1])/2,z])
        cube([screencutout[0], screencutout[1], screencutout[2]]);
        
        
        
}






// ==========================================================================
// ============================= VISOR MODULES ==============================
// ==========================================================================

// isvisor = 1, then these will be the pegs for the visor.  else it's the holes for the pegs.
module visorMountingHoles(isVisor)
{
    
    if(isVisor == 1)
    {
        // left side mounts
        translate([9,0,70]) rotate([-90,0,0]) cylinder(2,2, 2);
        translate([9,0,16]) rotate([-90,0,0]) cylinder(2,2, 2);

        // right side mounts
        translate([9,161.5,70]) rotate([90,0,0]) cylinder(2,2, 2);
        translate([9,161.5,16]) rotate([90,0,0]) cylinder(2,2, 2);

    } else {
        
        // leftside has offset on y to compensate for rendering issues if creating holes for the pegs
        // left side mounts
        translate([9,-0.5,70]) rotate([-90,0,0]) cylinder(3,2.5, 2.5);
        translate([9,-0.5,16]) rotate([-90,0,0]) cylinder(3,2.5, 2.5);

        // right side mounts
        translate([9,161.5,70]) rotate([90,0,0]) cylinder(3,2.5, 2.5);
        translate([9,161.5,16]) rotate([90,0,0]) cylinder(3,2.5, 2.5);
        
    }
    
    
}

module mountVisor()
{

    coverpoints = [
        [  0,  0,  0], //0
        [  0, 86,  0], //1
        [ 70, 86,  0], //2
        [ 70, 56,  0], //3
        [ 18,  0,  0], //4

        [  0,  0,  2], //5
        [  0, 86,  2], //6
        [ 70, 86,  2], //7
        [ 70, 56,  2], //8
        [ 18,  0,  2], //9

    ];

    coverfaces = [
      [4,3,2,1,0],  
      [0,1,6,5],
      [1,2,7,6],
      [2,3,8,7],
      [3,4,9,8],
      [0,5,9,4],
      [5,6,7,8,9]
      ]; 




    //left side
        rotate([90,0,0])
            polyhedron(coverpoints, coverfaces);

    //right side 2 + 161 + 0.5 = visor width of left side + length of mount + 0.5mm tolerance
    translate([0,163.5,0]) 
        rotate([90,0,0])
            polyhedron(coverpoints, coverfaces);

    translate([0,-2,86])
        cube([70,165.5,2]); // 2*visor length + mount + tolerance

}








// ==========================================================================
// ============================== MISC MODULES ==============================
// ==========================================================================


module halfcylinder(r, h, e)
{
    difference(){
            cylinder(h,r,r);
            translate([-r,-2*r,-e]) cube([2*r,2*r,h+2*e]);
        }
}


module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}