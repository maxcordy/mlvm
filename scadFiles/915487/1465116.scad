// Drag chain, best printed together as much as possible
// Common sizes 8x8, 10x10, 10x20
// Copyright (c) R. Linder
// This work is licensed under a Creative Commons Attribution 4.0 International License.

// Internal dimension (min 5)
link_height=8;
// Internal dimension (min 5)
link_width=10;
// Thickness of part body (Typical 1.8 min 1.4)
shell_thickness=1.8;
// Print as many as your bed can fit
number_of_links = 5;
// Add anti stick if your chain is fused solid.
anti_stick = 0.15;		// [0.0:0.01:0.35]
// Select what to print
part_selection = 3;		// [0:Chain only, 1:Male mount, 2:Female mount, 3:Chain with mounts]

linkHeight = link_height + 2 * shell_thickness;
linkWidth = link_width + 4 * shell_thickness;

linkLength = link_height * 2.8;
pinRad = linkHeight / 6;
pinSpace = ((linkLength / 2) - (linkHeight / 2)) * 2;
tabLen = linkHeight / 2;

$fn=140;

module femaleMount ()
{
	difference ()
	{
		union ()
		{
			difference ()
			{
				translate ([linkHeight/2, 0, 0]) hull ()
				{
					translate ([0, pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
					translate ([-linkHeight/2,-pinSpace/6, 0]) cube ([linkHeight, 1, linkWidth+0.6]);
					translate ([0,-pinSpace*1.5, 0]) cube ([linkHeight/2, 5, linkWidth+0.6]);
				}
				femaleEnd (mount=1);
			}
		}
		translate ([-shell_thickness,-pinSpace*1.5-0.6, shell_thickness*2]) cube (size=[linkHeight, pinSpace*2.5, linkWidth- (shell_thickness*4)+0.6]);

		// M3 Holes
		if (link_width >= 10)
		{
			for (off = [0:2])
			{
				rotate ([0, 90, 0]) translate ([-linkWidth/2-off- (link_width) /6+0.6,-linkLength/2.5- (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);

				rotate ([0, 90, 0]) translate ([-linkWidth/2+off+ (link_width) /6-1.2,-linkLength/2.5+ (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);

			}
		}
		else
		{
			rotate ([0, 90, 0]) translate ([-linkWidth/2-0.3,-linkLength/2.5, link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
		}

	}
}
module maleMount ()
{
	difference ()
	{
		union ()
		{
			difference ()
			{
				union ()
				{
					translate ([linkHeight/2, 0, 0]) hull ()
					{
						translate ([0, pinSpace, 0]) cube ([linkHeight/2, 5, linkWidth+0.6]);
						translate ([0, -pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
						translate ([-linkHeight/2,-pinSpace/6, 0]) cube ([linkHeight, 1, linkWidth+0.6]);
					}
					translate ([0,- (linkLength+tabLen) /2, shell_thickness+0.3]) cube (size=[(linkHeight+shell_thickness) /2, tabLen*2, linkWidth-shell_thickness*2+0.2]);
				}
				maleEnd ();
			}
			// Locking pins (0.2mm narrower)
			translate ([linkHeight/2, (-pinSpace/2)-1.5, 0.4]) cylinder (h=linkWidth-0.2, r=pinRad-0.25);


		}
		// Top Champher on stopper
		translate ([linkHeight/2+1,-linkLength/2-sqrt (tabLen*tabLen*2), 0]) rotate ([0, 0, 45]) cube ([tabLen, tabLen, linkWidth]);
		// Front Champher on stopper
		translate ([linkHeight/2-0.6,-linkLength/2-tabLen+0.6, 0]) rotate ([0, 0, 70]) cube (size=[2.5, 5, linkWidth+5]);
		// Hole for wires
		translate ([0-shell_thickness,-pinSpace*1.5, shell_thickness*2]) cube (size=[linkHeight, pinSpace*3.5, linkWidth- (shell_thickness*4)+0.6]);

		if (link_width >= 10)
		{
			for (off = [0:2])
			{
				rotate ([0, 90, 0]) translate ([-linkWidth/2-off- (link_width) /6+0.6, linkLength/3+ (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);

				rotate ([0, 90, 0]) translate ([-linkWidth/2+off+ (link_width) /6-1.2, linkLength/3- (linkLength/6), link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
			}
		}
		else
		{
			rotate ([0, 90, 0]) translate ([-linkWidth/2-0.3, linkLength/2, link_height+0.6]) cylinder (h=shell_thickness*2, r=1.6);
		}
	}
}


module link ()
{
	difference ()
	{
		union ()
		{
			difference ()
			{
				union ()
				{
					translate ([linkHeight/2, 0, 0]) hull ()
					{
						translate ([0, pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
						translate ([0,-pinSpace/2, 0]) cylinder (h=linkWidth+0.6, r=linkHeight/2);
					}
					translate ([0,- (linkLength+tabLen) /2, shell_thickness+anti_stick/2]) cube (size=[(linkHeight+shell_thickness) /2, tabLen*2, linkWidth-shell_thickness*2+0.2]);
				}

				maleEnd ();
				femaleEnd ();
			}

			// Locking pins (0.2mm narrower)
			translate ([linkHeight/2, (-pinSpace/2)-1.5, 0.4]) cylinder (h=linkWidth-0.2, r=pinRad-0.25);
		}
		// Top Champher on stopper
		translate ([linkHeight/2+1,-linkLength/2-sqrt (tabLen*tabLen*2), 0]) rotate ([0, 0, 45]) cube ([tabLen, tabLen, linkWidth]);

		// Front Champher on stopper
		translate ([linkHeight/2-0.6,-linkLength/2-tabLen+0.6, 0]) rotate ([0, 0, 70]) cube (size=[2.5, 5, linkWidth+5]);

		// Hole for cables
		translate ([0+shell_thickness+0.2,-linkLength/2-tabLen, shell_thickness*2]) cube (size=[linkHeight-shell_thickness*2, linkLength+tabLen+1, linkWidth- (shell_thickness*4)+0.6]);

		// trim top brace
		translate ([0,-pinSpace-pinRad*2, shell_thickness*2]) cube (size=[linkHeight+3, linkLength/2, linkWidth- (shell_thickness*4)+0.6]);
	}
}

// The Male end with cutouts

module maleEnd ()
{
	//Cutouts for opposite side
	translate ([-0.6,-linkLength/2, (linkWidth+0.4)-shell_thickness])  cube (size=[linkHeight+1, pinRad*6-shell_thickness, shell_thickness+0.7]);

	translate ([-0.6,-linkLength/2, -0.6]) cube (size=[linkHeight+1, pinRad*6-shell_thickness, shell_thickness+0.8]);
	// Cut out on rounds to fit on base
	translate ([-0.6, (- (linkLength+tabLen) /2)-0.6, 0]) cube (size=[shell_thickness+1.2+anti_stick, pinRad*2.5+tabLen+0.6, linkWidth+0.6]);

}

module femaleEnd (mount=0)
{
	translate ([linkHeight/2, (pinSpace/2)+1.5,-1]) cylinder (h=linkWidth+3, r=pinRad);
	// Bottom brace
	translate ([-0.6, pinRad*2.5, shell_thickness-anti_stick]) cube (size=[linkHeight+2, pinRad*3+1.2, linkWidth- (shell_thickness*2)+0.6+ (2*anti_stick)]);
	// Top brace
	translate ([linkHeight-shell_thickness-0.6, pinRad*2, shell_thickness-anti_stick]) cube (size=[shell_thickness*2, pinRad*4, linkWidth- (shell_thickness*2)+0.6+anti_stick*2]);
	if (mount)
	{
		translate ([0, 0, shell_thickness]) cube (size=[linkHeight- (shell_thickness), (linkLength/2), linkWidth- (shell_thickness*2)+0.6]);
	}
	else
	{
		translate ([shell_thickness+0.2, -0.6, shell_thickness-anti_stick]) cube (size=[linkHeight- (shell_thickness*2), (linkLength/2)+0.6, linkWidth- (shell_thickness*2)+0.6+ (2*anti_stick)]);
	}
}



rotate ([0, 90, 0])
{
	if (part_selection == 1)
	{
		maleMount ();
	}
	else if (part_selection == 2)
	{
		femaleMount ();
	}
	else if (part_selection <= 3)
	{
		if (part_selection == 3)
		{
			femaleMount ();
			translate ([0, (number_of_links+1) *(pinSpace+3), 0]) maleMount ();
		}

		for (cnt = [0:number_of_links-1])
		{
			translate ([0, (cnt+1) *(pinSpace+3), 0]) link ();
		}
	}
	else
	{
		echo ("Invalid Part Selection");
	}
}
