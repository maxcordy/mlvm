number_of_rows = 2; //[1:10]
number_of_columns = 2; //[1:10]
//Height (in bricks)
layers = 3; //[1:10]
//Add a surrounding row of studs on top
add_upper_surrounding_studs = "Yes"; //[Yes,No]
//Add a surrounding row of studs around the base
add_surrounding_studs = "Yes"; //[Yes,No]
//Diameter of pen (mm)
pen_diameter = 12;
//Space around pen in holder (mm), to much and the pen will wobble...
pen_clearance = 0.5;    
//the minimum allowed distance between each hole (1.5mm is forced minimum)
min_dist_between_pens = 1.5;
//Overall margin affecting holes and outer dimensions to compensate for inaccuracy and material (mm)
margin = 0.1;   
//Adjust to get a snug fitting of the studs (mm)
margin_studs = 0.1;     
//If set to No the number of studs on each side will allways be even
allow_uneven_number_of_studs = "No";  //[Yes,No]  

//constants
stud_width = 4.9 * 1.0;
stud_height = 1.88 * 1.0;
plate_height_thick = 9.56 * 1.0;
plate_height_thin = 3.2 * 1.0;
single_module_width = 8.0 * 1.0;
distance_to_remove_on_sides = 0.2 * 1.0;
outer_corner_radius = 0.4 * 1.0;
wall_thickness = 1.5 * 1.0;
total_pen_size = pen_diameter + pen_clearance + margin;
min_distance_between_pens = min_dist_between_pens < wall_thickness ? wall_thickness : min_dist_between_pens;

module AddLowerBase( width, depth, height )
{
    xOffset = width/2-outer_corner_radius-distance_to_remove_on_sides/2;
    yOffset = depth/2-outer_corner_radius-distance_to_remove_on_sides/2;
    
    linear_extrude(height=height, center = false)
    {
        hull()
        {
            square([width-outer_corner_radius*2, depth-outer_corner_radius*2], center = true);
            translate([-xOffset, -yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);
            translate([-xOffset, yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);
            translate([xOffset, -yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);
            translate([xOffset, yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);                
        }        
    }
    
    noVerticalStuds = ceil(depth / single_module_width);
    noHorizontalStudes = ceil(width / single_module_width);
    
    translate( [-width/2+single_module_width/2,-depth/2+single_module_width/2, height] )
    for( r = [1:noVerticalStuds])
    {
        for( c = [1:noHorizontalStudes])
        {
            if( r == 1 || r == noVerticalStuds || c == 1 || c == noHorizontalStudes )
            {
                translate([(c-1)*single_module_width, (r-1)*single_module_width, 0])
                cylinder( d = stud_width - margin_studs, h = stud_height, $fn=24);
            }
        }
    }
}

module AddCenter( width, depth, height, addStuds )
{
    xOffset = width/2-outer_corner_radius-distance_to_remove_on_sides/2;
    yOffset = depth/2-outer_corner_radius-distance_to_remove_on_sides/2;
    
    linear_extrude(height=height, center = false)
    {
        hull()
        {
            square([width-outer_corner_radius*2, depth-outer_corner_radius*2], center = true);
            translate([-xOffset, -yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);
            translate([-xOffset, yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);
            translate([xOffset, -yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);
            translate([xOffset, yOffset, 0])
            circle(r=outer_corner_radius, $fn=24);                
        }        
    } 
    if( addStuds )
    {
        noVerticalStuds = ceil(depth / single_module_width);
        noHorizontalStudes = ceil(width / single_module_width);
        
        translate( [-width/2+single_module_width/2,-depth/2+single_module_width/2, height] )
        for( r = [1:noVerticalStuds])
        {
            for( c = [1:noHorizontalStudes])
            {
                if( r == 1 || r == noVerticalStuds || c == 1 || c == noHorizontalStudes )
                {
                    translate([(c-1)*single_module_width, (r-1)*single_module_width, 0])
                    cylinder( d = stud_width - margin_studs, h = stud_height, $fn=24);
                }
            }
        }        
    }    
}

module AddHoles(width, depth, height)
{
    //Sorry for this one, I cant muster the strength to clean up this module...
    
    xDistance = number_of_columns > 1 ? (width-min_distance_between_pens*2-total_pen_size-distance_to_remove_on_sides-margin) / (number_of_columns-1) : 0;
    
    yDistance = number_of_rows > 1 ? (depth-min_distance_between_pens*2-total_pen_size-distance_to_remove_on_sides-margin) / (number_of_rows-1) : 0;
    
    startXpos = number_of_columns > 1 ? -width/2+min_distance_between_pens+total_pen_size/2 +distance_to_remove_on_sides/2 + margin/2 : 0;
    
    startYpos = number_of_rows > 1 ? -depth/2+min_distance_between_pens+total_pen_size/2 + distance_to_remove_on_sides/2 + margin/2 : 0;
    
    wedgeSize = xDistance == 0 || yDistance == 0 ? single_module_width : sqrt(xDistance*xDistance+yDistance*yDistance);
    
    dist_to_remove = distance_to_remove_on_sides/2+margin/2+outer_corner_radius;
    
    difference()
    {
        union()
        {
            children();
            intersection()
            {
                translate([startXpos, startYpos, 0])
                union()
                {
                    for( r = [1:number_of_rows] )
                    {
                        for( c = [1:number_of_columns] )
                        {
                            translate([(c-1)*xDistance, (r-1)*yDistance, 0])
                            union()
                            {
                                    cylinder(d=pen_diameter+pen_clearance+margin+wall_thickness*2,h=height-wall_thickness, $fn=48);
                                
                                    translate([0,0,height-wall_thickness])
                                    rotate([180,0,0])
                                    rotate_extrude(convexity=10, $fn=8)
                                    translate([(pen_diameter+pen_clearance+margin)/2,0,0])
                                    
                                    polygon(points = [[0,0],[wedgeSize,0],[0,5]], convexity=10);
                                                                
                                
                                if(add_surrounding_studs == "Yes")
                                {
                                    translate([0,0,-plate_height_thin])
                                    cylinder(d=pen_diameter+pen_clearance+margin+wall_thickness*2,h=plate_height_thin, $fn=48);
                                }
                            }
                        }
                    }
                }
                union()
                {
                    if( add_upper_surrounding_studs == "Yes" )
                    {
                        
                        translate([-width/2-single_module_width+dist_to_remove,-depth/2-single_module_width+dist_to_remove,-plate_height_thin])
                        
                        cube([(width+single_module_width*2)-distance_to_remove_on_sides-margin-outer_corner_radius*2, (depth+single_module_width*2)-distance_to_remove_on_sides-margin-outer_corner_radius*2, height+plate_height_thin], center = false);
                    
                     } else {
                        
                         translate([-width/2+dist_to_remove,-depth/2+dist_to_remove,-plate_height_thin])
                        
                         cube([width-distance_to_remove_on_sides-margin-outer_corner_radius*2, depth-distance_to_remove_on_sides-margin-outer_corner_radius*2, height+plate_height_thin], center = false);
                    }
                }
            }
        }
        union()
        {
            translate([startXpos, startYpos, wall_thickness])
            for( r = [1:number_of_rows] )
            {
                for( c = [1:number_of_columns] )
                {
                    translate([(c-1)*xDistance, (r-1)*yDistance, 0])
                    union()
                    {
                        translate([0,0,height-1])
                        rotate([180,0,0])
                        rotate_extrude(convexity=10, $fn=48)
                        translate([(pen_diameter+pen_clearance+margin)/2-1,0,0])
                        polygon(points = [[0,0],[2,0],[0,2]], convexity=10);  
                        
                        cylinder(d=pen_diameter+pen_clearance+margin,h=height, $fn=48);
                        if(add_surrounding_studs == "Yes")
                        {
                            translate([0,0,-plate_height_thin])
                            cylinder(d=pen_diameter+pen_clearance+margin,h=height, $fn=48);
                        }
                    }
                }
            }
        }
    }
}

module MakeHollow(width, depth, height)
{
    //There must be a better way to make the inner wedges, but I dont want to spend mor time on this
    
    difference()
    {
        children();
        union()
        {
            if( add_upper_surrounding_studs == "Yes" )
            {
                xOffset = (width+single_module_width*2-wall_thickness*2)/2;
                yOffset = (depth+single_module_width*2-wall_thickness*2)/2;
                tempWidth = width+single_module_width*2-wall_thickness*2;
                tempDepth = depth+single_module_width*2-wall_thickness*2;
                
                difference()
                {
                    translate([-xOffset, -yOffset, -plate_height_thin-wall_thickness])
                    cube([tempWidth, tempDepth, height + plate_height_thin], center = false);
                    union()
                    {
                        translate([-xOffset, -yOffset-1, height-wall_thickness-single_module_width])
                        rotate([0,-45,0])
                        cube([single_module_width*2,tempDepth+2, single_module_width*2]);
                        translate([xOffset, -yOffset-1, height-wall_thickness-single_module_width])
                        rotate([0,-45,0])
                        cube([single_module_width*2,tempDepth+2, single_module_width*2]);
                        translate([-xOffset-1, yOffset, height-wall_thickness-single_module_width])
                        rotate([45,0,0])
                        cube([tempWidth+2, single_module_width*2,, single_module_width*2]);
                        translate([-xOffset-1, -yOffset, height-wall_thickness-single_module_width])
                        rotate([45,0,0])
                        cube([tempWidth+2, single_module_width*2,, single_module_width*2]);
                        
                    }
                }
            }
            else
            {
                xOffset = (width-wall_thickness*2)/2;
                yOffset = (depth-wall_thickness*2)/2;
                tempWidth = width-wall_thickness*2;
                tempDepth = depth-wall_thickness*2;
                
                difference()
                {
                    translate([-xOffset, -yOffset, -plate_height_thin-wall_thickness])
                    cube([tempWidth, tempDepth, height + plate_height_thin], center = false);
                    union()
                    {
                        translate([-xOffset, -yOffset-1, height-wall_thickness-single_module_width])
                        rotate([0,-45,0])
                        cube([single_module_width*2,tempDepth+2, single_module_width*2]);
                        translate([xOffset, -yOffset-1, height-wall_thickness-single_module_width])
                        rotate([0,-45,0])
                        cube([single_module_width*2,tempDepth+2, single_module_width*2]);
                        translate([-xOffset-1, yOffset, height-wall_thickness-single_module_width])
                        rotate([45,0,0])
                        cube([tempWidth+2, single_module_width*2,, single_module_width*2]);
                        translate([-xOffset-1, -yOffset, height-wall_thickness-single_module_width])
                        rotate([45,0,0])
                        cube([tempWidth+2, single_module_width*2,, single_module_width*2]);
                        
                    }
                }
            }
        }
    }
}


module Main()
{
    moduleWitdh = ceil((number_of_columns * total_pen_size + (number_of_columns+1) * min_distance_between_pens) / single_module_width);
    
    innerWidth = allow_uneven_number_of_studs == "Yes" ? moduleWitdh * single_module_width : ceil(moduleWitdh/2.0) * 2 * single_module_width;
    
    moduleDepth = ceil((number_of_rows * total_pen_size + (number_of_rows+1) * min_distance_between_pens) / single_module_width);
    
    innerDepth = allow_uneven_number_of_studs == "Yes" ? moduleDepth * single_module_width : ceil(moduleDepth/2.0) * 2 * single_module_width;
    
    innerHeight = plate_height_thick * layers;

    AddHoles(innerWidth, innerDepth, innerHeight)
    {
        MakeHollow(innerWidth, innerDepth, innerHeight)
        {
            if( add_upper_surrounding_studs == "Yes" )
            {
                if( add_surrounding_studs == "Yes" )
                {
                    translate([0,0,-plate_height_thin])
                    AddCenter( innerWidth+single_module_width*2, innerDepth+single_module_width*2, innerHeight+plate_height_thin, true );
                    translate([0,0,-plate_height_thin])
                    AddLowerBase(innerWidth+single_module_width*4, innerDepth+single_module_width*4, plate_height_thin);
                } else {
                    AddCenter( innerWidth+single_module_width*2, innerDepth+single_module_width*2, innerHeight, true );
                }
            } else {
                
                if( add_surrounding_studs == "Yes" )
                {
                    translate([0,0,-plate_height_thin])
                    AddCenter( innerWidth, innerDepth, innerHeight+plate_height_thin, false );
                    translate([0,0,-plate_height_thin])
                    AddLowerBase(innerWidth+single_module_width*2, innerDepth+single_module_width*2, plate_height_thin);
                } else {
                    AddCenter( innerWidth, innerDepth, innerHeight, false );    
                }
            }
        }
    }
}

Main();