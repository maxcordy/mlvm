
//Which support would you like to use
Support = "Rectangle"; //[Rectangle,Cylinder,NONE]

// if rectangular, width of the support
rect_support_x = 4.5; 
// if rectangular, height of support
rect_support_y = 1.5; 
// if rectangular, depth of the support
rect_support_z = 5; 

//if cylinder, depth of  support
cyl_support_h = 4; 
//if cylinder, diameter of cylinder support
cyl_support_d = 3; 


// button size
// radius of the button
button_radius = 4; 
// height of the button
button_height = 7; 
// radius of rounded corner
button_angle_radius = 2; 
//to not have the marker, let 0.
marker_size = 1; 


/* [hidden] */

// ignore variable values
$fn=100;

difference(){
    union(){
        cylinder(h = button_height - button_angle_radius, r = button_radius, center = false); 
        cylinder(h = button_height , r = button_radius - button_angle_radius, center = false);
        translate([0,0,button_height - button_angle_radius])
            rotate_extrude(convexity = 10)
                translate([2, 0, 0])
                    circle(r = button_angle_radius);
    if( marker_size > 0){
        translate([0,0,0])
            rotate(a = 90, v = ([1,0,0])){
                cylinder(h = marker_size + button_radius, r1 = button_radius * 0.9, r2 = 0);
            }; 
        }  
    }
    union(){
        translate([0,0,0- 2*(marker_size+button_radius)]) cube((marker_size+button_radius) * 4, center=true); 
        if (Support == "Rectangle"){
            translate([-rect_support_x / 2,-rect_support_y /2,0]) cube([rect_support_x, rect_support_y, rect_support_z], center= false);
        }
        if (Support == "Cylinder"){
            translate([0,0,0]) cylinder(h = cyl_support_h, r = cyl_support_d / 2, center= false);
        }
    }
}