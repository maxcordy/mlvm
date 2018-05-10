/* [Global] */

// Mode
t_slot_box_demo_mode = ""; // [Flat, 3D]

// Box width
t_slot_box_demo_width = 150; // [70:300]

// Box height
t_slot_box_demo_height = 200; // [70:300]

// Box depth
t_slot_box_demo_depth = 270; // [70:300]

// Plywood thickness
stock_thickness = 6.5;

// End mill diameter for CNC router or 0 for laser
tool_diameter = 3.175;

// Screw diameter
t_slot_screw_d = 4;

// Screw length
t_slot_screw_l = 16;



/* [Hidden] */

cnc_tolerance = 0.05;
end_mill_d = tool_diameter * 1.1;
t_slot_hole_width = stock_thickness + 2 * cnc_tolerance;
t_slot_pins_o = stock_thickness - 0.5;
t_slot_holes_o = end_mill_d / 2 + 2 + t_slot_hole_width;
t_slot_min_spacing = 50;

module t_slot(kind, stage, screw_d = 4, screw_l = 16)
{
    t_slot_pin_offset = 15;
    if (kind == 0)
    {
        // kind = slot
        if (stage == 0)
        {
            // stage = difference
            hole_height = 10 + 2 * cnc_tolerance;;
            
            screw_hole_d = 
                screw_d + 2 * cnc_tolerance > end_mill_d ? 
                screw_d + 2 * cnc_tolerance : 
                end_mill_d;
            
            for (y = [-t_slot_pin_offset, t_slot_pin_offset])
            {
                translate([0, y]) 
                    translate([0, -hole_height / 2]) square([t_slot_hole_width, hole_height]);

                translate([t_slot_hole_width, y + (hole_height / 2 - end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([t_slot_hole_width, y - (hole_height / 2 - end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([0, y + (hole_height / 2 - end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([0, y - (hole_height / 2 - end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
            }
            translate([t_slot_hole_width / 2, 0]) circle(r = screw_hole_d / 2, $fn = screw_hole_d * 5);
        }
        else
        {
            // stage = union
        }
    }
    else
    {
        // kind = pin
        pin_height = 10;
        
        if (stage == 0)
        {
            // stage = difference
            nut_thickness = 
                screw_d * 0.7> end_mill_d ? 
                screw_d * 0.7: 
                end_mill_d;
            nut_d = 
                nut_thickness > 2 * end_mill_d ? 
                screw_d * 1.8 : 
                screw_d * 1.5;
            screw_slit_width = 
                screw_d > end_mill_d ? 
                screw_d : 
                end_mill_d;
            extra_screw_l = 
                screw_slit_width > 2 * end_mill_d ?
                0.5 :
                -screw_slit_width / 2 + 1;
            screw_slit_l = screw_l - stock_thickness + extra_screw_l;
            nut_offset = 2 + extra_screw_l;
            
            translate([-screw_slit_l, -screw_slit_width / 2]) 
                square([
                    screw_slit_l + 1, // QUICKFIX: +1 to cut the border
                    screw_slit_width]);
            if (screw_slit_width > 2 * end_mill_d)
            {
                translate([-screw_slit_l, (screw_slit_width / 2 - end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([-screw_slit_l, -(screw_slit_width / 2 - end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
            }
            else
            {
                translate([-screw_slit_l, 0]) circle(r = screw_slit_width / 2, $fn = screw_slit_width * 5);
            }
            
            translate([-screw_slit_l + nut_offset, -nut_d / 2]) square([nut_thickness, nut_d]);
            if (nut_thickness > 2 * end_mill_d)
            {
                translate([-screw_slit_l + nut_offset + end_mill_d / 2, -nut_d / 2]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([-screw_slit_l + nut_offset + nut_thickness - end_mill_d / 2, -nut_d / 2]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([-screw_slit_l + nut_offset + end_mill_d / 2, nut_d / 2]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([-screw_slit_l + nut_offset + nut_thickness - end_mill_d / 2, nut_d / 2]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
            }
            else
            {
                translate([-screw_slit_l + nut_offset + nut_thickness / 2, -nut_d / 2]) circle(r = nut_thickness / 2, $fn = nut_thickness * 5);
                translate([-screw_slit_l + nut_offset + nut_thickness / 2, nut_d / 2]) circle(r = nut_thickness / 2, $fn = nut_thickness * 5);
            }

            for (y = [-t_slot_pin_offset, t_slot_pin_offset])
            {
                translate([0, y + (pin_height / 2 + end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
                translate([0, y - (pin_height / 2 + end_mill_d / 2)]) circle(r = end_mill_d / 2, $fn = end_mill_d * 5);
            }
        }
        else
        {
            // stage = union
            pin_narrowing = 0.3;

            for (y = [-t_slot_pin_offset, t_slot_pin_offset])
            {
                translate([0, y])
                    polygon([[0, pin_height / 2], [t_slot_pins_o, pin_height / 2 - pin_narrowing], [t_slot_pins_o, -(pin_height / 2 - pin_narrowing)], [0, -pin_height / 2]]);
            }
        }
    }
}

module t_slot_box_panel(inner_width, inner_height, r, b, l, t, name, screw_d = 4, screw_l = 16)
{
    t_slot_height = 55;

    w = (l == 0 ? t_slot_holes_o : 0) + inner_width + (r == 0 ? t_slot_holes_o : 0);
    h = (b == 0 ? t_slot_holes_o : 0) + inner_height + (t == 0 ? t_slot_holes_o : 0);

    function slot_positions(length) = 
        length - 2 * t_slot_height > t_slot_min_spacing ?
        let(
            middle_section_l = length - t_slot_height * 2,
            middle_t_slot_count = floor((middle_section_l - t_slot_min_spacing) / (t_slot_height + t_slot_min_spacing)),
            actual_spacing = (middle_section_l - middle_t_slot_count * t_slot_height) / (middle_t_slot_count + 1)
        )
        concat(
            t_slot_height / 2 - length / 2,
            [for (cnt = [0:1:(middle_t_slot_count - 1)]) 1.5 * t_slot_height + actual_spacing + cnt * (actual_spacing + t_slot_height) - length / 2],
            length / 2 - t_slot_height / 2
        ):
        [0];

    
    h_slot_positions = slot_positions(inner_width);
    v_slot_positions = slot_positions(inner_height);

    difference()
    {
        union()
        {
            translate([-(l == 0 ? t_slot_holes_o : 0) - inner_width / 2, -(b == 0 ? t_slot_holes_o : 0) - inner_height / 2])
                square([w, h]);
            for (p = v_slot_positions)
                translate([0, p])
                {
                    translate([inner_width / 2, 0]) t_slot(r, 1, screw_d, screw_l);
                    translate([-inner_width / 2, 0]) rotate([0, 0, 180]) t_slot(l, 1, screw_d, screw_l);
                }
            for (p = h_slot_positions)
                translate([p, 0])
                {
                    translate([0, inner_height / 2]) rotate([0, 0, 90]) t_slot(t, 1, screw_d, screw_l);
                    translate([0, -inner_height / 2]) rotate([0, 0, -90]) t_slot(b, 1, screw_d, screw_l);
                }
        }
        for (p = v_slot_positions)
            translate([0, p])
            {
                translate([inner_width / 2, 0]) t_slot(r, 0, screw_d, screw_l);
                translate([-inner_width / 2, 0]) rotate([0, 0, 180]) t_slot(l, 0, screw_d, screw_l);
            }
        for (p = h_slot_positions)
            translate([p, 0])
            {
                translate([0, inner_height / 2]) rotate([0, 0, 90]) t_slot(t, 0, screw_d, screw_l);
                translate([0, -inner_height / 2]) rotate([0, 0, -90]) t_slot(b, 0, screw_d, screw_l);
            }
    }
    %translate([-inner_width / 2, -inner_height / 2 - 20]) text(name, font = "style:Bold", size = 10);
}

module t_slot_box_top(width, height, depth, r = 1, b = 1, l = 1, t = 1, screw_d = 4, screw_l = 16)
{
    t_slot_box_panel(width, depth, r, b, l, t, name = "Top", screw_d = screw_d, screw_l = screw_l);
}

module t_slot_box_bottom(width, height, depth, r = 1, b = 1, l = 1, t = 1, screw_d = 4, screw_l = 16)
{
    t_slot_box_panel(width, depth, r, b, l, t, name = "Bottom", screw_d = screw_d, screw_l = screw_l);
}

module t_slot_box_front(width, height, depth, r = 0, b = 0, l = 0, t = 0, screw_d = 4, screw_l = 16)
{
    t_slot_box_panel(width, height, r, b, l, t, name = "Front", screw_d = screw_d, screw_l = screw_l);
}

module t_slot_box_back(width, height, depth, r = 0, b = 0, l = 0, t = 0, screw_d = 4, screw_l = 16)
{
    t_slot_box_panel(width, height, r, b, l, t, name = "Back", screw_d = screw_d, screw_l = screw_l);
}

module t_slot_box_left(width, height, depth, r = 0, b = 1, l = 0, t = 1, screw_d = 4, screw_l = 16)
{
    t_slot_box_panel(height, depth, r, b, l, t, name = "Left", screw_d = screw_d, screw_l = screw_l);
}

module t_slot_box_right(width, height, depth, r = 0, b = 1, l = 0, t = 1, screw_d = 4, screw_l = 16)
{
    t_slot_box_panel(height, depth, r, b, l, t, name = "Right", screw_d = screw_d, screw_l = screw_l);
}

module t_slot_box_3d(width, height, depth)
{
    translate([0, 0, height / 2 + stock_thickness / 2]) 
        rotate([0, 0, 0]) 
            linear_extrude(height = stock_thickness, center = true) 
                children(0);
    translate([0, 0, -height / 2 - stock_thickness / 2]) 
        rotate([0, 180, 0]) 
            linear_extrude(height = stock_thickness, center = true) 
                children(1);
    translate([0, -depth / 2 - stock_thickness / 2, 0]) 
        rotate([90, 0, 0]) 
            linear_extrude(height = stock_thickness, center = true) 
                children(2);
    translate([0, depth / 2 + stock_thickness / 2, 0]) 
        rotate([-90, 0, 0]) 
            linear_extrude(height = stock_thickness, center = true) 
                children(3);
    translate([-width / 2 - stock_thickness / 2, 0, 0]) 
        rotate([0, 90 + 180, 0]) 
            linear_extrude(height = stock_thickness, center = true) 
                children(4);
    translate([width / 2 + stock_thickness / 2, 0, 0]) 
        rotate([0, 90, 0]) 
            linear_extrude(height = stock_thickness, center = true) 
                children(5);
}

module t_slot_box_flat(width, height, depth)
{
    d = 50;
    translate([0, 0]) 
        children(0); 
    translate([-width / 2 - height / 2 - height / 2 - width / 2 - d - d, 0]) 
        children(1);
    translate([0, -depth / 2 - height / 2 - d]) 
        children(2);
    translate([0, depth / 2 + height / 2 + d]) 
        children(3);
    translate([-width / 2 - height / 2 - d, 0]) 
        children(4);
    translate([width / 2 + height / 2 + d, 0]) 
        children(5);
}

module t_slot_box_demo(width, height, depth)
{
    if (t_slot_box_demo_mode == "Flat")
    {
        t_slot_box_flat(width, height, depth)
        {
            t_slot_box_top(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_bottom(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_front(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_back(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_left(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_right(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
        }
    }
    else if (t_slot_box_demo_mode == "3D")
    {
        t_slot_box_3d(width, height, depth)
        {
            t_slot_box_top(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_bottom(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_front(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_back(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_left(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
            t_slot_box_right(width, height, depth, screw_d = t_slot_screw_d, screw_l = t_slot_screw_l);
        }
    }
    else
    {
        // Do nothing
    }
}

t_slot_box_demo(t_slot_box_demo_width, t_slot_box_demo_height, t_slot_box_demo_depth);

