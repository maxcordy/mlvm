text = "I AM A PROGRAMMER I HAVE NO LIFE ";
radius = 40;
height = 120;
wall_thickness = 1;
bottom_height = 5;

bottom_factor = 0.825;
font_density = 1.7;

function PI() = 3.14159;

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the radius of arc
//     angle - the angle of arc
//     width - the width of arc
module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=48); 
            circle(radius, $fn=48);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 360.
// Parameters: 
//     radius - the radius of arc
//     angle - the angle of arc
//     width - the width of arc
module arc(radius, angles, width = 1) {
    angle_from = angles[0];
    angle_to = angles[1];
    angle_difference = angle_to - angle_from;
    outer = radius + width;
    rotate(angle_from)
        if(angle_difference <= 90) {
            a_quarter_arc(radius, angle_difference, width);
        } else if(angle_difference > 90 && angle_difference <= 180) {
            arc(radius, [0, 90], width);
            rotate(90) a_quarter_arc(radius, angle_difference - 90, width);
        } else if(angle_difference > 180 && angle_difference <= 270) {
            arc(radius, [0, 180], width);
            rotate(180) a_quarter_arc(radius, angle_difference - 180, width);
        } else if(angle_difference > 270 && angle_difference <= 360) {
            arc(radius, [0, 270], width);
            rotate(270) a_quarter_arc(radius, angle_difference - 270, width);
       }
}

// Creates a hollow cylinder or cone.
// Parameters: 
//     r1 - radius, bottom of cone
//     r2 - radius, top of cone
//     height - height of the cylinder or cone
module hollow_cylinder(r1, r2, height) {
	difference() {
		cylinder(height, r1=r1,  r2=r2, $fn = 96);
		translate([0, 0, -1]) 
		    cylinder(height + 2, r1=r1 - 1,  r2=r2 - 1, $fn = 96);    			
    }
}

// Creates a ring text.
// Parameters: 
//     text - the text you want to create
//     radius - the inner radius of the ring
//     font_density - adjust the density between words
module ring_text(text, radius, font_density = 1) {
    font_size = 2 *  PI() * radius / len(text) * font_density;
	
	negative_self_font_size = -font_size / 2;
	font_size_div_5 = font_size / 5;
	arc_angle = 360 / len(text);
	outer_r = radius + font_size;
	
    font_height = 2 * radius;
	
	projection() intersection() {
		union() {
			for(i = [0 : len(text) - 1]) {
				rotate([90, 0, i * arc_angle]) 
					 translate([negative_self_font_size, 0, 0]) 
						 linear_extrude(height = font_height) 
							 text(text[i], font = "Courier New:style=Bold", size = font_size);	
			}
		}
	
	    hollow_cylinder(outer_r - font_size_div_5, radius - font_size_div_5, font_size);
	}
}

// The same as `ring_text` without using the `projection` internally.
// Parameters: 
//     text - the text you want to create
//     radius - the inner radius of the ring
//     font_density - adjust the density between words
module ring_text_without_projection(text, radius, font_density = 1) {
    font_size = 2 *  PI() * radius / len(text) * font_density;
	negative_self_font_size = -font_size / 2;
	arc_angle = 360 / len(text);
	font_r = radius + font_size * 0.8;
    
	for(i = [0 : len(text) - 1]) {
	    rotate([0, 0, i * arc_angle]) 
		    translate([negative_self_font_size, -font_r , 0]) 
		         text(text[i], font = "Courier New:style=Bold", size = font_size);	
	}
}

// Create a character_container. 
// Parameters: 
//     text - the text you want to create
//     radius - the inner radius of the container
//     bottom_height - the height of the bottom
//     wall_thickness - the thickness of the inner wall
//     bottom_factor - adjust the radius of the bottom
//     font_density - adjust the density between words
module character_container(text, radius, bottom_height, wall_thickness = 1, bottom_factor = 0.8, font_density = 1.5) { 
    font_size = 2 *  PI() * radius / len(text) * font_density;
	
	linear_extrude(height) union() {
		ring_text(text, radius, font_density);
		arc(radius - wall_thickness, [0, 360], wall_thickness);
	}
		
	linear_extrude(bottom_height) 
	    circle(radius + font_size * bottom_factor, $fn = 96);	  
}

// The same as `ring_text` but use `ring_text_without_projection` internally.
// Parameters: 
//     text - the text you want to create
//     radius - the inner radius of the container
//     bottom_height - the height of the bottom
//     wall_thickness - the thickness of the inner wall
//     bottom_factor - adjust the radius of the bottom
//     font_density - adjust the density between words
module character_container_without_projection(text, radius, bottom_height, wall_thickness = 1, bottom_factor = 0.825, font_density = 1.5) { 
    font_size = 2 *  PI() * radius / len(text) * font_density;
	
	linear_extrude(height) union() {
		ring_text_without_projection(text, radius, font_density);
		arc(radius - wall_thickness, [0, 360], wall_thickness);
	}
	
	linear_extrude(bottom_height) 
		circle(radius + font_size * bottom_factor, $fn = 96);	 
}

character_container_without_projection(text, radius, bottom_height, wall_thickness, bottom_factor, font_density);

// Use this if you have little words. It's slow because it uses the `projection` function internally.
// character_container(text, radius, bottom_height, wall_thickness, 0.8, font_density);

	