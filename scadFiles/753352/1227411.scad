// simple drawmaker

// preview[view:south, tilt:top]

thickness = 15;

// Draw one or more closed shapes in the box! If you draw one shape inside another, it will be taken out as a hole.
shape = [[[0,0]],[[0]] ]; //[draw_polygon:100x100]

linear_extrude(thickness)
polygon(points = shape[0], paths = shape[1]);