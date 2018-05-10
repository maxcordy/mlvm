use <pins/pins.scad>
use <utils/build_plate.scad>
// preview[view:north east, tilt:top diagonal]

/* [chain] */
// Number of chain links, should be a multiple of links per step
link_number = 30; // [15:1:60]
// How many links are connected for one step
links_per_step = 2; // [1:1:4]
// Should be smaller than half the link number. With more links per steps this should increase or the chain might not be able to bend enough around the pulley.
links_per_pulley = 8; // [7:1:20]
// Angle of escalator, when it derives from 45° strongly, the length or links per step should be increased or the steps will become too narrow. Otherwise it could be used as a conveyor belt without the steps.
alpha = 45; // [0:0.1:90]
// When the chain sits too tight use positive values, otherwise negative values if it is too loose
chain_length_correction = 0; // [-10:0.1:10]

/* [chain link] */
length = 12; // [10:0.1:30]
width = 20; // [10:0.1:200]
// The length should be increased alongside the breadth
breadth = 3.5; // [3:0.1:5]
// Needs to be less or equal than the hole
joint_size = 2.25; // [1.5:0.05:4]
// Should be smaller than the breadth
joint_hole_size = 2.75; // [1.5:0.05:4]
// Width should be increased when increasing this value
wall_thickness = 3; // [1:0.1:5]
// The cavity connects to the pulley, should be smaller than breadth
cavity_depth = 2.5; // [1:0.01:4]
// Should be smaller than length-2*breadth
cavity_breath = 3.5; // [2:0.01:5]

/* [chassis] */
chassis_thickness = 7.5; // [3:0.1:15]
separator_radius = 5; // [3.5:0.1:10]
// How much the chassis should prodtrude from the chain
chassis_extra_radius = 5; // [0:0.1:30]
stand_thickness = 10; // [5:0.1:20]
// Radius of axis that connects the pulleys
axis_radius = 6.5; // [5:0.1:10]
// How deep the axis permeates into the pulley
axis_length = 5; // [3:0.1:20]
crank_length = 40; // [30:0.1:100]
crank_thickness = 7.5; // [5:0.1:10]
handle_length = 20; // [5:0.1:50]

/* [tolerances and various] */
// Tolerance for links and chassis
tolerance = 0.3; // [0.1:0.01:0.4]
// Height of pin connectors, should be less or equal than chassis thickness
pin_height = 7.5; // [0.5:0.1:15]
pin_radius = 3; // [2:0.1:5]
pin_tolerance = 0.4; // [0.2:0.01:0.6]
// Resolution of big parts
resolution = 100; // [30:1:200]
// Resolution of small parts
resolution_small = 30; // [10:1:100]

/* [display] */
// Which part to display
part = "all"; // [all:all parts,chain_link1:chain link 1,chain_link2:chain link 2,stepv:vertical step,steph:horizontal step,pulley1:pulley 1,pulley2:pulley 2,chassis1:chassis part 1,chassis2:chassis part 2,stand1: stand 1,stand2: stand 2,crank:crank,handle:handle,separator1:separator 1,separator2:separator 2,pin:pin]
// For display only, doesn't contribute to final object
build_plate_selector = 0; // [0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
// When Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; // [100:1:400]
// When Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; // [100:1:400]


build_plate(build_plate_selector, build_plate_manual_x, build_plate_manual_y);

$fn = resolution;

width_s = width - 2 * wall_thickness;
joint_radius = joint_size / 2;
hole_radius = joint_hole_size / 2;

effective_length = length - breadth;
pulley_radius = links_per_pulley * effective_length / (2 * PI) - breadth / 2 + cavity_depth - tolerance;

vertical = sin(alpha) * effective_length * links_per_step + breadth * 1.5;
horizontal = cos(alpha) * effective_length * links_per_step + breadth * 1.5;

pulley_distance = effective_length * (link_number - links_per_pulley) / 2 - chain_length_correction / 2;

pulley_margin = links_per_pulley * effective_length / (2 * PI) + breadth + max(vertical, horizontal) + separator_radius * 2;

stand_connection_1 = (pulley_distance / 2 - pin_radius + axis_radius + tolerance) / 2;
stand_connection_2 = (pulley_distance * 1.5 + pin_radius - axis_radius - tolerance) / 2;
stand_length = cos(alpha) * pulley_distance + (pulley_radius + chassis_extra_radius) * 2 + stand_thickness;
stand_distance = cos(alpha) * (stand_connection_2 - stand_connection_1);
stand_heigth_difference = sin(alpha) * (stand_connection_2 - stand_connection_1);

axis_square = axis_radius / sqrt(2);

module male(width) {
    translate([breadth / 2, tolerance, 0]) cube([breadth / 2, width - tolerance * 2, breadth]);
    translate([breadth / 2, tolerance, breadth / 2]) rotate([-90, 0, 0]) cylinder(d = breadth, h = width - tolerance * 2, $fn = resolution_small);
    translate([breadth / 2, tolerance, breadth / 2]) sphere(joint_radius, $fn = resolution_small);
    translate([breadth / 2, width - tolerance, breadth / 2]) sphere(joint_radius, $fn = resolution_small);
}

module female(width) {
    width_s = width - 2 * wall_thickness;
    difference() {
        union() {
            translate([breadth / 2, 0, 0]) cube([breadth / 2, width, breadth]);
            translate([breadth / 2, 0, breadth / 2]) rotate([-90, 0, 0]) cylinder(d = breadth, h = wall_thickness, $fn = resolution_small);
            translate([breadth / 2, width - wall_thickness, breadth / 2]) rotate([-90, 0, 0]) cylinder(d = breadth, h = wall_thickness, $fn = resolution_small);
        }
        translate([0.01, wall_thickness, -0.01]) cube([breadth + 0.01, width_s, breadth + 0.02]);
        translate([breadth / 2, wall_thickness, breadth / 2]) sphere(hole_radius, $fn = resolution_small);
        translate([breadth / 2, width - wall_thickness, breadth / 2]) sphere(hole_radius, $fn = resolution_small);
    }
}

module round_corner() {
    difference() {
        cube([breadth / 2, width + 0.02, breadth / 2], center = true);
        cube([breadth / 2 + 0.02, width_s - tolerance * 2, breadth / 2 + 0.02], center = true);
        translate([-breadth / 4, 0, breadth / 4]) rotate([-90, 0, 0]) cylinder(d = breadth, h = width + 0.04, center = true, $fn = resolution_small);
    }
}

module rounding_cylinder() {
    rotate([-90, 0, 0]) cylinder(d = breadth, h = width, $fn = resolution_small);
}

module tooth(width) {
    polyhedron(points = [
        [0, width / 8, cavity_depth],
        [0, width * 7 / 8 - wall_thickness * 2, cavity_depth],
        [-cavity_breath / 2, 0, -0.01],
        [-cavity_breath / 2, width - wall_thickness * 2, -0.01],
        [cavity_breath / 2, 0, -0.01],
        [cavity_breath / 2, width - wall_thickness * 2, -0.01]
    ], faces = [
        [0, 2, 3, 1],
        [0, 1, 5, 4],
        [2, 4, 5, 3],
        [0, 4, 2],
        [1, 3, 5]
    ]);
}

module chain_link(connector = true) {
    difference() {
        translate([breadth - 0.01, 0, 0]) cube([length - breadth * 2 + 0.02, width, breadth * (connector ? 2 : 1)]);
        if (connector) {
            translate([breadth - 0.02, wall_thickness, breadth]) cube([length - breadth * 2 + 0.04, width_s, breadth + 0.01]);
            translate([length / 2, wall_thickness, breadth * 1.5]) sphere(hole_radius, $fn = resolution_small);
            translate([length / 2, width - wall_thickness, breadth * 1.5]) sphere(hole_radius, $fn = resolution_small);
            translate([breadth * 1.25 - 0.02, width / 2, breadth * 1.75 + 0.01]) rotate([0, 180, 0]) round_corner();
        }
        translate([length - breadth * 1.25 + 0.02, width / 2, breadth * (connector ? 1.75 : 0.75) + 0.01]) rotate([0, -90, 0]) round_corner();
        translate([length - breadth * 1.25 + 0.02, width / 2, breadth * 0.25 - 0.01]) round_corner();
        translate([length / 2, wall_thickness, 0]) tooth(width);
    }
    female(width);
    translate([length, wall_thickness, breadth]) rotate([0, 180, 0]) male(width_s);
}

module vertical_step() {
    translate([breadth - 0.01, 0, 0]) cube([vertical - breadth * 1.5 - effective_length / 2 + 0.02, width, breadth]);
    translate([vertical - effective_length / 2 - breadth / 2, 0, breadth / 2]) rounding_cylinder();
    female(width);
    difference() {
        union() {
            translate([vertical - effective_length / 2 - breadth * 0.5 - 0.01, wall_thickness + tolerance, 0]) cube([effective_length / 2 - breadth * 0.5 + 0.02, width_s - tolerance * 2, breadth]);
            translate([vertical, wall_thickness, breadth]) rotate([0, 180, 0]) male(width_s);
        }
        translate([vertical - breadth + 0.01, (width - width_s / 2 - breadth) / 2, -0.01]) cube([breadth, width_s / 2 + breadth, breadth + 0.02]);
        translate([vertical - effective_length / 2, (width - width_s / 2 - breadth) / 2 + wall_thickness, -0.01]) cube([effective_length / 2 + 0.01, width_s / 2 + breadth - 2 * wall_thickness, breadth + 0.02]);
    }
    translate([vertical, (width - width_s / 2) / 2 - breadth / 2, breadth]) rotate([0, 180, 0]) female(width_s / 2 + breadth);
}

module horizontal_step() {
    translate([breadth * 1.5 - 0.01, 0, 0]) cube([horizontal - effective_length / 2 - breadth * 2 + 0.02, width, breadth]);
    translate([breadth - 0.01, wall_thickness + tolerance, 0]) cube([breadth / 2 + 0.02, width_s - tolerance * 2, breadth]);
    translate([breadth * 1.5, 0, breadth / 2]) rounding_cylinder();
    translate([horizontal - effective_length / 2 - breadth / 2, 0, breadth / 2]) rounding_cylinder();
    translate([horizontal - effective_length / 2 - breadth / 2 - 0.01, (width - width_s / 2 - breadth) / 2 + wall_thickness + tolerance, 0]) cube([effective_length / 2 - breadth * 0.5 + 0.02, width_s / 2 + breadth - 2 * wall_thickness - tolerance * 2, breadth]);
    translate([0, wall_thickness, 0]) male(width_s);
    translate([horizontal, (width - width_s / 2 - breadth) / 2 + wall_thickness, breadth]) rotate([0, 180, 0]) male(width_s / 2 + breadth - 2 * wall_thickness);
}

module pulley(part2 = false) {
    difference() {
        union() {
            cylinder(r = pulley_radius - cavity_depth, h = width + wall_thickness * 2 + tolerance * 2);
            cylinder(r1 = pulley_radius - cavity_depth + wall_thickness, r2 = pulley_radius - cavity_depth, h = wall_thickness);
            translate([0, 0, width + wall_thickness + tolerance * 2]) cylinder(r1 = pulley_radius - cavity_depth, r2 = pulley_radius - cavity_depth + wall_thickness, h = wall_thickness);
            for (i = [0: 1: links_per_pulley - 1]) rotate([0, 0, 360 * i / links_per_pulley]) {
                translate([0, pulley_radius - cavity_depth - tolerance, width]) rotate([-90, 0, 0]) tooth(width - 2 * tolerance);
                translate([-cavity_breath / 2, 0, wall_thickness * 2 + tolerance * 2]) cube([cavity_breath, pulley_radius - cavity_depth - tolerance + 0.01, width_s - 2 * tolerance]);
            }
        }
        translate([0, 0, -0.01]) cylinder(r1 = axis_radius + tolerance, r2 = 0, h = axis_length + tolerance);
        if (part2) {
            translate([0, 0, width + wall_thickness * 2 + tolerance - axis_length + 0.01]) cylinder(r1 = 0, r2 = axis_radius + tolerance, h = axis_length + tolerance);
        } else {
            translate([0, 0, width + wall_thickness * 2 + tolerance * 2 - pin_height - axis_length]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
            translate([-axis_square - tolerance, -axis_square - tolerance, width + wall_thickness * 2 + tolerance * 2 - axis_length + 0.01]) cube([axis_square * 2 + tolerance * 2, axis_square * 2 + tolerance * 2, axis_length]);
        }
    }
}

module chassis(part2 = false) {
    translate([0, pulley_distance, chassis_thickness - 0.01]) cylinder(r1 = axis_radius, r2 = 0, h = axis_length);
    translate([0, pulley_distance, chassis_thickness - 0.01]) cylinder(r1 = axis_radius, r2 = 0, h = axis_length);
    translate([0, pulley_distance, chassis_thickness - 0.01]) cylinder(r1 = axis_radius, r2 = 0, h = axis_length);
    difference(part2) {
        union() {
            translate([-pulley_radius - chassis_extra_radius, 0, 0]) cube([(pulley_radius + chassis_extra_radius) * 2, pulley_distance, chassis_thickness]);
            cylinder(r = pulley_radius + chassis_extra_radius, h = chassis_thickness);
            translate([0, pulley_distance, 0]) cylinder(r = pulley_radius + chassis_extra_radius, h = chassis_thickness);
            if (!part2) {
                translate([0, 0, chassis_thickness - 0.01]) cylinder(r1 = axis_radius, r2 = 0, h = axis_length);
            }
        }
        if (part2) {
            translate([0, 0, -0.01]) cylinder(r = axis_radius + tolerance, h = chassis_thickness + 0.02);
        }
        translate([0, pulley_distance / 2, chassis_thickness - pin_height]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
        translate([0, stand_connection_1, pin_height]) rotate([180, 0, 0]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
        translate([0, stand_connection_2, pin_height]) rotate([180, 0, 0]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
    } % translate([0, pulley_distance, chassis_thickness]) cylinder(r = pulley_radius, h = width + wall_thickness * 2 + tolerance * 2); % translate([0, 0, chassis_thickness]) cylinder(r = pulley_radius, h = width + wall_thickness * 2 + tolerance * 2); % translate([0, pulley_distance / 2, chassis_thickness]) cylinder(r = separator_radius, h = width + wall_thickness * 2 + tolerance * 4 + 0.02);
}

module stand() {
    s1 = (stand_length - stand_distance - stand_thickness) / 2;
    difference() {
        union() {
            translate([-stand_thickness / 2, 0, 0]) cube([stand_thickness, stand_length, chassis_thickness]);
            cylinder(r = stand_thickness / 2, h = chassis_thickness);
            translate([0, stand_length, 0]) cylinder(r = stand_thickness / 2, h = chassis_thickness);
            translate([-pulley_margin, s1, 0]) cube([pulley_margin, stand_thickness, chassis_thickness]);
            translate([-pulley_margin - stand_heigth_difference, s1 + stand_distance, 0]) cube([pulley_margin + stand_heigth_difference, stand_thickness, chassis_thickness]);
            translate([-pulley_margin, s1 + stand_thickness / 2, 0]) cylinder(r = stand_thickness / 2, h = chassis_thickness);
            translate([-pulley_margin - stand_heigth_difference, s1 + stand_distance + stand_thickness / 2, 0]) cylinder(r = stand_thickness / 2, h = chassis_thickness);
        }
        translate([0, 0, chassis_thickness - pin_height]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
        translate([0, stand_length, chassis_thickness - pin_height]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
        translate([-pulley_margin, s1 + stand_thickness / 2, chassis_thickness - pin_height]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
        translate([-pulley_margin - stand_heigth_difference, s1 + stand_distance + stand_thickness / 2, chassis_thickness - pin_height]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
    }
}

module crank() {
    difference() {
        union() {
            translate([-axis_square, -axis_square, chassis_thickness * 2 + tolerance + crank_thickness + 3.01]) cube([axis_square * 2, axis_square * 2, axis_length]);
            cylinder(r = axis_radius, h = chassis_thickness * 2 + tolerance + crank_thickness + 3.01);
            translate([0, 0, crank_thickness + 3]) cylinder(r1 = axis_radius, r2 = axis_radius + 1, h = chassis_thickness);
            translate([-axis_radius, 0, 0]) cube([axis_radius * 2, crank_length - 2 * axis_radius, crank_thickness]);
            translate([0, crank_length - axis_radius * 2, 0]) cylinder(r = axis_radius, h = crank_thickness);
        }
        translate([0, 0, chassis_thickness * 2 + tolerance + crank_thickness + axis_length - pin_height + 3]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
        translate([0, crank_length - axis_radius * 2, pin_height]) rotate([180, 0, 0]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
    }
}

module handle() {
    difference() {
        cylinder(r = axis_radius, h = handle_length + 0.01);
        translate([0, 0, handle_length - pin_height]) pinhole(h = pin_height, t = pin_tolerance, r = pin_radius);
    }
}

module separator(height) {
    difference() {
        cylinder(r = separator_radius, h = height + 0.02);
        translate([0, 0, height - pin_height]) pinhole(h = pin_height, r = pin_radius);
        translate([0, 0, pin_height]) rotate([180, 0, 0]) pinhole(h = pin_height, r = pin_radius);
    }
}

if (part == "all") {
    translate([pulley_radius * 2 + 5, 0, 0]) {
        chain_link();
    }
    translate([pulley_radius * 2 + 5, width + 5, 0]) {
        chain_link(connector = false);
    }
    translate([pulley_radius * 2 + length + 10, 0, 0]) {
        vertical_step();
    }
    translate([pulley_radius * 2 + length + 10, width + 5, 0]) {
        horizontal_step();
    }
    translate([pulley_radius, pulley_radius + wall_thickness + 5, 0]) {
        pulley();
    }
    translate([pulley_radius, pulley_radius * 3 + wall_thickness * 3 + 10, 0]) {
        pulley(part2 = true);
    }
    translate([-pulley_radius - chassis_extra_radius - 5, -pulley_distance / 2, 0]) {
        chassis();
    }
    translate([-(pulley_radius + chassis_extra_radius) * 3 - 10, pulley_distance / 2, 0]) {
        mirror([0, 90, 0]) chassis(part2 = true);
    }
    translate([-(pulley_radius + chassis_extra_radius) * 4 - stand_thickness / 2 - 15, stand_thickness / 2 + 5, 0]) {
        stand();
    }
    translate([-(pulley_radius + chassis_extra_radius) * 4 - stand_thickness / 2 - 15, -stand_thickness / 2 - 5, 0]) {
        mirror([0, 90, 0]) stand();
    }
    translate([axis_radius + 5, -crank_length + axis_radius - 5, 0]) {
        crank();
    }
    translate([axis_radius * 4 + 10, -axis_radius - 5, 0]) {
        handle();
    }
    translate([axis_radius * 4 + 10, -axis_radius * 2 - separator_radius - 10, 0]) {
        separator(width + wall_thickness * 2 + tolerance * 4);
    }
    translate([axis_radius * 4 + 10, -axis_radius * 2 - separator_radius * 3 - 15, 0]) {
        separator(width + wall_thickness * 2 + tolerance * 4 + chassis_thickness * 2);
    }
    translate([axis_radius * 6 + 15, -pin_height - 5, 0]) {
        pinpeg(h = pin_height * 2, r = pin_radius);
    }
} else if (part == "chain_link1") {
    translate([-length / 2, -width / 2, 0]) {
        chain_link();
    }
} else if (part == "chain_link2") {
    translate([-length / 2, -width / 2, 0]) {
        chain_link(connector = false);
    }
} else if (part == "stepv") {
    translate([-vertical / 2, -width / 2, 0]) {
        vertical_step();
    }
} else if (part == "steph") {
    translate([-horizontal / 2, -width / 2, 0]) {
        horizontal_step();
    }
} else if (part == "pulley1") {
    pulley();
} else if (part == "pulley2") {
    pulley(part2 = true);
} else if (part == "chassis1") {
    translate([0, -pulley_distance / 2, 0]) {
        chassis();
    }
} else if (part == "chassis2") {
    translate([0, pulley_distance / 2, 0]) {
        mirror([0, 90, 0]) chassis(part2 = true);
    }
} else if (part == "stand1") {
    translate([(pulley_margin + stand_heigth_difference) / 2, -stand_length / 2, 0]) {
        stand();
    }
} else if (part == "stand2") {
    translate([(pulley_margin + stand_heigth_difference) / 2, stand_length / 2, 0]) {
        mirror([0, 90, 0]) stand();
    }
} else if (part == "crank") {
    translate([0, -crank_length / 2 + axis_radius, 0]) {
        crank();
    }
} else if (part == "handle") {
    handle();
} else if (part == "separator1") {
    separator(width + wall_thickness * 2 + tolerance * 4);
} else if (part == "separator2") {
    separator(width + wall_thickness * 2 + tolerance * 4 + chassis_thickness * 2);
} else if (part == "pin") {
    pinpeg(h = pin_height * 2, r = pin_radius);
}