// Copyright Antony Jordan 2017
// This work is licensed under a Creative Commons Attribution 4.0 International License:
//     http://creativecommons.org/licenses/by/4.0/

// Width of the toggle.
Width = 15; // [7:50]

// Length of the toggle.
Length = 20; // [8:50]

// Heinght of the toggle.
Height = 5; // [5:20]

// Width of the bulldog clip arm.
Arm_Gap = 8; // [4:47]

// Radius of the bulldog clip arm.
Hole_Radius = 1; // [1:5]

$fn=100*1;

module assert(cond, message)
{
    if(cond)
        children();
    else
        echo(str("Assert failed: ", message));
}

module rounded_box(w, l, h, r)
{
    r2 = r*2;
    
    q_w = w - r2;
    q_l = l - r2;
    q_h = h - r2;
    
    assert(w > r2, str("Radius [", r, "] is incompatible with width[",w,"]."))
    assert(l > r2, str("Radius [", r, "] is incompatible with length[",l,"]."))
    assert(h > r2, str("Radius [", r, "] is incompatible with height[",h,"]."))
    {
        
        translate([r,r,r])
        minkowski()
        {
            cube([q_w, q_l, q_h]);
            sphere(r=r);
        }
    }
}


module Bulldog_Zip(width, length, height, arm_gap=8, hole_r=1)
{
    radius = (height/2) - 0.01;
    hole_padding = 2;
    hole_padding_half = hole_padding / 2;

    hole_x_pos = -hole_padding_half;
    hole_y_pos = 2 + hole_r;
    hole_z_pos = height / 2;

    arm_gap_w = arm_gap;
    arm_gap_l = hole_y_pos*2 + hole_r;
    arm_gap_h = height + hole_padding;

    nub_width = (width - arm_gap_w)/2;

    arm_gap_x = nub_width;
    arm_gap_y = -hole_padding_half;
    arm_gap_z = -hole_padding_half;

    assert(nub_width > 1, str("The nub width must be greater than 1."))
    assert(height >= hole_r + (hole_padding*2), str("The height[", height, "] needs to be longer than ", hole_r + (hole_padding*2), "."))
    assert(length >= arm_gap_l+1, str("The length[", length, "] needs to be longer than ", arm_gap_l+1, "."))
    assert(width > arm_gap_w+nub_width, str("The width[", width, "] must be wider than the arm_gap[", arm_gap_w+nub_width, "]."))
    {
        difference()
        {        
            rounded_box(width, length, height, radius);
            translate([arm_gap_x, arm_gap_y, arm_gap_z])
                cube([arm_gap_w, arm_gap_l, arm_gap_h]);

            translate([hole_x_pos, hole_y_pos, hole_z_pos]) rotate([0,90,0])
                cylinder(r = hole_r, h=width+hole_padding);
        }
    }
}

Bulldog_Zip(Width, Length, Height, Arm_Gap, Hole_Radius);
