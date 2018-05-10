foot_diameter = 28;
foot_height = 6;
shaft_diameter = 21;
shaft_height = 30;

$fn=200;

minkowski()
{
    cylinder(h = foot_height-2, d=foot_diameter-2, center = false);
    sphere(r=1);
}

    cylinder(h = foot_height, d=foot_diameter, center = false);

minkowski()
{
    cylinder(h = shaft_height-2, d=shaft_diameter-2, center = false);
    sphere(r=1);
}
