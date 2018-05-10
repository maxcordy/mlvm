$fn=40;

eps = 0.05;


NrOfHoles = 10;

Pitch = 8;
Radius1 = 4.8 / 2;
Radius2 = 6.1 / 2;
Height = 7.8;
Depth = 0.8;
Width = 7.5;
MidThickness = 2;


module drawBeam()
{
	Length = (NrOfHoles - 1) * Pitch;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			cube([Length, Thickness, Height]);
			translate([0, Width-Thickness,0]) cube([Length, Thickness, Height]);
			translate([0, 0, Height/2-MidThickness/2]) cube([Length, Width, MidThickness]);
			for (i = [1:NrOfHoles])
			{
				translate([(i-1)*Pitch, Width/2,0]) 
				{
					cylinder(r=Width/2, h=Height);
				}
			}
		}

		union()
		{
			for (i = [1:NrOfHoles])
			{
				translate([(i-1)*Pitch, Width/2,0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
			}
		}
	}
}

drawBeam();

