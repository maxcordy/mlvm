inside_width = 23.5;
inside_length = 51.5;
inside_height = 8;

wall = 1;
rounded_radius = 1;
box_margin = 0.15;

lid_border = 3;
lid_sphere_radius = 0.5;
lid_sphere_radius_margin = 0;
lid_sphere_offset = lid_sphere_radius / 4;

/* [USB Hole] */
usb_hole = "on"; // [on, off]
usb_hole_width = 11;
usb_hole_height = 7;
usb_hole_vertical_offset = 0;

/* [Extra hole] */
wire_hole = "on"; // [on, off]
wire_hole_width = 7;
wire_hole_height = 2;

/* [Hidden] */
$fn = 100;

module rounded_cube(width, length, height, radius) {
  hull() {
    translate([radius, radius, 0]) cylinder(r = radius, h = height);
    translate([width - radius, radius, 0]) cylinder(r = radius, h = height);
    translate([radius, length - radius, 0]) cylinder(r = radius, h = height);
    translate([width - radius, length - radius, 0]) cylinder(r = radius, h = height);
  }
}

// box
union() {
  difference() {
    rounded_cube(inside_width + 2 * wall, inside_length + 2 * wall, inside_height + wall, rounded_radius);
    translate([wall, wall, wall]) rounded_cube(inside_width, inside_length, inside_height + wall, rounded_radius);
    // usb hole
    if (usb_hole == "on") translate([(inside_width + 2 * wall) / 2 - usb_hole_width / 2, -1, usb_hole_vertical_offset + wall]) cube([usb_hole_width, wall + 1.01, usb_hole_height]);
    // wire hole
    if (wire_hole == "on") translate([(inside_width + 2 * wall) / 2 - wire_hole_width / 2, inside_length + wall - 1, inside_height + wall - wire_hole_height]) cube([wire_hole_width, wall + 2, wire_hole_height + 1]);
  }
  // spheres
  translate([wall - lid_sphere_offset, wall + inside_length / 4, wall + inside_height - lid_border / 2]) sphere(r = lid_sphere_radius);
  translate([wall - lid_sphere_offset, wall + 3 * inside_length / 4, wall + inside_height - lid_border / 2]) sphere(r = lid_sphere_radius);
  translate([wall + lid_sphere_offset + inside_width, wall + inside_length / 4, wall + inside_height - lid_border / 2]) sphere(r = lid_sphere_radius);
  translate([wall + lid_sphere_offset + inside_width, wall + 3 * inside_length / 4, wall + inside_height - lid_border / 2]) sphere(r = lid_sphere_radius);
}

// lid
translate([inside_width + 2 * wall + 5, 0, 0]) difference() {
  union() {
    rounded_cube(inside_width + 2 * wall, inside_length + 2 * wall, wall, rounded_radius);
    difference() {
      translate([wall + box_margin, wall + box_margin, wall]) rounded_cube(inside_width - box_margin * 2, inside_length - box_margin * 2, lid_border, rounded_radius + box_margin);
      translate([wall * 2 + box_margin, wall * 2 + box_margin, wall]) rounded_cube(inside_width - 2 * wall - box_margin * 2, inside_length - 2 * wall - box_margin * 2, lid_border + 1, rounded_radius + box_margin);
    }
  }
  // spheres
  translate([2 * wall - lid_sphere_offset + box_margin, wall + inside_length / 4, wall + lid_border / 2]) sphere(r = lid_sphere_radius + lid_sphere_radius_margin);
  translate([2 * wall - lid_sphere_offset + box_margin, wall + 3 * inside_length / 4, wall + lid_border / 2]) sphere(r = lid_sphere_radius + lid_sphere_radius_margin);
  translate([inside_width + lid_sphere_offset - box_margin, wall + inside_length / 4, wall + lid_border / 2]) sphere(r = lid_sphere_radius + lid_sphere_radius_margin);
  translate([inside_width + lid_sphere_offset - box_margin, wall + 3 * inside_length / 4, wall + lid_border / 2]) sphere(r = lid_sphere_radius + lid_sphere_radius_margin);
  // usb hole
  if (usb_hole == "on") translate([(inside_width + 2 * wall) / 2 - usb_hole_width / 2, wall + box_margin - 1, wall + inside_height - usb_hole_height - usb_hole_vertical_offset]) cube([usb_hole_width, wall + 1.01, usb_hole_height]);
  // wire hole
  if (wire_hole == "on") translate([(inside_width + 2 * wall) / 2 - wire_hole_width / 2, inside_length - box_margin - 1, wall]) cube([wire_hole_width, wall + 2, lid_border + 1]);
}
