/*      
        Customizable LEGO Technic Bracket
        March 2015
*/
$fn=50*1.0;

// Parameters modified for best print on my Replicator 2 with PLA
Pitch = 8*1.0;
Radius1 = 5.0/2;
Radius2 = 6.1/2;
Height = 7.8*1.0;
Depth = 0.85*1.0;
Width = 7.3*1.0; 

vertOff = Height;
horiOff = Width;

// user parameters
// number of holes =
Holes = 2; // [2:20]

module drawBeam()
{
    Length = (Holes-1) * Pitch;
    difference()
    {
	union()
	{			
        {
        cube([Length,Width+Height,Height+Width]);
        translate([-Width/2,Width/2,0])
        cube([Length+Width, Width/2+Height, Height+Width/2]);
        }
            //     horizontal
            for (i = [1:Holes])
                {
                translate([(i-1)*Pitch, Width/2,0]) 
                cylinder(r=Width/2, h=Height);
                } 
            //      vertical
             for (i = [1:Holes])
                {
                rotate ([-90,0,0])                
                translate([(i-1)*Pitch, -(Width/2+vertOff),horiOff]) 
                cylinder(r=Width/2, h=Height);
                }                
	}
        union()
	{
           // horizontal
            for (i = [1:Holes])
            {
                translate([(i-1)*Pitch, Width/2,0]) 
                {
                    cylinder(r=Radius2,h=Depth);
                    cylinder(r=Radius1,h=Height);
                    
                    translate([0,0,Height-Depth]) 
                    cylinder(r=Radius2,h=Depth);
                    
                    translate([0,0,Depth])
                    cylinder(h=(Radius2 - Radius1), r1=Radius2, r2=Radius1);
                }
            }
            //  vertical
            for (i = [1:Holes])
            {
                rotate ([-90,0,0])                
                translate([(i-1)*Pitch, -(Width/2+vertOff),horiOff-.02]) 
                {
                    cylinder(r=Radius2,h=Depth);
                    cylinder(r=Radius1,h=Height+5);
                    
                    translate([0,0,Height-Depth]) 
                    cylinder(r=Radius2,h=Depth+5);
                }
            }
        }
      translate([-Width/2,0,Height])  
        cube([Length+Width, Width, Height]);       
    }
}

drawBeam();

 

