$fn=40;

eps = 0.05;


NrOfHoles = 5;

Pitch = 8;
Radius1 = 4.8 / 2;
Radius2 = 6.1 / 2;
Height = 7.8;
Depth = 0.8;
Width = 7.5;
MidThickness = 2;
MiniCubeOffset = 1.1; // was 0.9
MiniCubeWidth = Radius1 - MiniCubeOffset;
CrossInnerRadius = 1.5;


module drawCross(x)
{	
	translate([x - MiniCubeOffset - MiniCubeWidth, Width/2 + MiniCubeOffset, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
	translate([x + MiniCubeOffset, Width/2 + MiniCubeOffset, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
	translate([x - MiniCubeOffset - MiniCubeWidth, Width/2 - MiniCubeOffset - MiniCubeWidth, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
	translate([x + MiniCubeOffset, Width/2 - MiniCubeOffset - MiniCubeWidth, 0]) cube([MiniCubeWidth, MiniCubeWidth, Height]);
}

module drawLiftArm()
{
    Length = (NrOfHoles - 1) * Pitch;
	Thickness = (Width - 2 * Radius2) / 2;

	difference()
	{
		union()
		{			
			cube([Length, Thickness, Height]);
			translate([0, Width-Thickness,0]) cube([Length, Thickness, Height]);
			translate([Pitch, 0, Height/2-MidThickness/2]) cube([Length - 2 * Pitch, Width, MidThickness]);
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
			difference()
			{
				union()
				{
					translate([0, Width/2,-eps]) cylinder(r=Radius1,h=Height+2*eps);
					translate([(NrOfHoles - 1)*Pitch, Width/2,-eps]) cylinder(r=Radius1,h=Height+2*eps);

					translate([0, Width/2 - MiniCubeOffset,-eps]) cube([Width/2, 2* MiniCubeOffset, Height+2*eps]);
					translate([(NrOfHoles - 1) * Pitch - Width/2, Width/2 - MiniCubeOffset,-eps]) cube([Width/2, 2* MiniCubeOffset, Height+2*eps]);
				}

				union()
				{
					drawCross(0);
					drawCross((NrOfHoles - 1) * Pitch);					
				}
			}

			translate([0, Width/2,0]) cylinder(r=CrossInnerRadius,h=Height);
			translate([(NrOfHoles - 1)*Pitch, Width/2,0]) cylinder(r=CrossInnerRadius,h=Height);

			for (i = [2:NrOfHoles - 1])
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

drawLiftArm();

