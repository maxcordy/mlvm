/* [Outer Dimensions] */
//Width of the Box in mm
width = 50; 	// [0:0.1:500]
//Depth of the Box in mm
depth = 150; // [0:0.1:500]
//Height of the Box in mm
height = 30;	// [0:0.1:500]

/* [Wall Settings] */
//Wallthickness in mm 
wall = 5; 	// [0:0.1:25]
//Radius of rounded Corner
corner = 2;	// [0:0.1:20]
//Gap between Case and Bottom in mm
gap = 0.2; 	// [0:0.05:2]

/* [Hole Settings] */
//Threaddiameter in mm 
screw_hole = 2; // [0:0.1:20]
//Diameter of Screw Head in mm
screw_head = 7; // [0:0.1:50]
//Distance from Hole to Wall in mm
hole_distance = 5; // [0:0.1:50]
//Thickness of Circuit Board to be sandwiched between Case and Bottom in mm
pcb_height = 1.6; // [0:0.1:15]
//Step between Case and Bottom in mm
step = 1; 	// [0:0.1:10]

/* [Quality] */
//Quality (simply experiment) 
Quality = 25;	// [1:100]

$fn = Quality;
case_with_bottom(width, depth, height, wall, corner, gap, screw_hole, screw_head, hole_distance, pcb_height, step, Quality);

//Case with rounded corners, screwholes and bottom
module case_with_bottom
(
	width = 30, 
	depth = 30, 
	height = 30, 
	wall = 2.5, 
	corner = 2, 
	gap = 0.2, 
	screw_hole = 2, 
	screw_head = 7,
	hole_distance = 5, 	
	pcb_height = 1.6, 	
	step = 1,
	quality = 25
)
{
    //case
    union()
    {
        difference()
        {
            translate([corner, corner, corner])
            {
                minkowski()
                {   
                    cube([width - 2*corner, depth - 2*corner, height - 2*corner], false);
                    $fn = quality;
                    sphere(corner);
                }        
            }
            translate([wall, wall, wall])
            {
                cube([width - 2*wall, depth - 2*wall, height + corner], false);
            }
			
			translate([wall - step, wall - step, height - wall])
            {
                cube([width + 2*step - 2*wall, depth + 2*step - 2*wall, 2*wall], false);
            } 			
        }
    
        if(screw_hole > 0)
            {
                h_offset = wall + hole_distance;
                h_height = height - 2 * wall - gap - pcb_height + 0.1;
                dia = screw_head + hole_distance;
                
                translate([h_offset, h_offset, wall - 0.1])
                {                                        
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder((height), d = screw_hole);
                    }
                }
                
                translate([width - h_offset, h_offset, wall - 0.1])
                {                                  
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder((height), d = screw_hole);
                    }
                }
                
                translate([h_offset, depth - h_offset, wall - 0.1])
                {                                        
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder((height), d = screw_hole);
                    }
                }
                
                translate([width - h_offset, depth - h_offset, wall - 0.1])
                {                    
                    difference()
                    {
                        cylinder(h_height, d = dia);
                        cylinder((height), d = screw_hole);
                    }
                }
            }    
    }
    
    
    //Bottom
    translate([wall, depth * 1.5, 0]) 
    {
        difference()
        {
            cube([width + 2*step - 2*wall - gap, depth + 2*step - 2*wall - gap, wall - gap], false);
        
            if(screw_hole > 0)
            {
                $fn = quality;
                h_offset = hole_distance - gap;
                b_width = width - 2 * wall;
                b_depth = depth - 2 * wall;
                h_depth = wall * (1/4);
                
                
                translate([h_offset, h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
                }
                translate([h_offset, h_offset, h_depth])
                {
                    cylinder(wall, d = screw_head);
                }
                
                translate([b_width - h_offset, h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
                }
                translate([b_width - h_offset, h_offset, h_depth])
                {
                    cylinder(wall, d = screw_head);
                }
                
                translate([h_offset, b_depth - h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
                }
                translate([h_offset, b_depth - h_offset, h_depth])
                {
                    cylinder(wall, d = screw_head);
                }
                
                translate([b_width - h_offset, b_depth - h_offset, -1])
                {
                    cylinder(wall + 2, d = screw_hole);
                }
                translate([b_width - h_offset, b_depth - h_offset, h_depth])
                {
                    cylinder(wall, d = screw_head);
                } 
                    
            }
        }
    }   
}