$fn=40;

eps = 0.05;


NrOfHolesX = 3;
NrOfHolesY = 5;

Pitch = 8;
Radius1 = 4.8 / 2;
Radius2 = 6.1 / 2;
Height = 7.8;
Depth = 0.8;
Width = 7.5;
MidThickness = 2;


module drawXBeam()
{
    LengthX = (NrOfHolesX - 1) * Pitch;
	MidX = -LengthX / 2;
    LengthY = (NrOfHolesY - 1) * Pitch;
	MidY = -LengthY / 2;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			translate([MidX, 0, 0]) cube([LengthX, Thickness, Height]);
			translate([MidX, Width-Thickness,0]) cube([LengthX, Thickness, Height]);
			translate([MidX, 0, Height/2-MidThickness/2]) cube([LengthX, Width, MidThickness]);
			for (i = [1:NrOfHolesX])
			{
				translate([MidX + (i-1)*Pitch, Width/2, 0]) 
				{
					cylinder(r=Width/2, h=Height);
				}
			}

			translate([-Width/2, MidY + Width/2, 0]) cube([Thickness, LengthY, Height]);
			translate([Width/2-Thickness, MidY + Width/2, 0]) cube([Thickness, LengthY, Height]);
			translate([-Width/2, MidY + Width/2, Height/2-MidThickness/2]) cube([Width, LengthY, MidThickness]);
			for (i = [1:NrOfHolesY])
			{
				translate([0, MidY + Width/2 + (i-1)*Pitch,0]) 
				{
					cylinder(r=Width/2, h=Height);
				}
			}
		}

		union()
		{
			for (i = [1:NrOfHolesX])
			{
				translate([MidX + (i-1)*Pitch, Width/2, 0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
			}

			for (i = [1:NrOfHolesY])
			{
				translate([0, MidY + Width/2 + (i-1)*Pitch, 0]) 
				{
					translate([0,0,-eps]) cylinder(r=Radius2,h=Depth+eps);
					translate([0,0,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([0,0,Height-Depth]) cylinder(r=Radius2,h=Depth+eps);
				}
			}
		}
	}
}

drawXBeam();

