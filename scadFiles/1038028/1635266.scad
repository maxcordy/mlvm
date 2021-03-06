/*
	.scad file created for the subwheel system of the 3D Printable Omni-Wheels used for a robot.
	
	
	Author 	= Xasin
	Website = https://www.github.com/xasin/hexa-bot.git
	Created	= 17.09.15
*/


function subwheelRadius(n, r) = r - cos(360/(2*n) + subwheelOverlap)*r + subwheelBaseSize;		//Calculate the radius of a standard subwheel at largest point (Center)
function wheelOffset(n, r) = cos(360/(2*n) + subwheelOverlap)*r;						//Calculate the offset of a subwheel that is required to shift it so that it aligns with the main circle (CAUTION Does not implement subwheel size shift!!)
function connectorOffset(n, r) = (sin(360/(2*n) + subwheelOverlap)*r);					//Calculate the offset for the cuts on the wheels. (Y axis on the 2D model of a subwheel before being rotated.
	
$fs = 1;

//What to generate - 1 means base frame, 2 means subwheel piece
generate = 1;

//GENERATION VARIABLES 
//Number of all subwheels to create. (Has to be a round number!!)
num = 5*2;	
//Radius of the omni-wheel.
radius = 30;	

//CONNECTION AXIS VARIABLES 
//Diameter of the axis the Omni-Wheel will be connected to.
axisDiameter = 3;	
//Height of the cylinder that will connect axis and omniwheel together.
axisConnectorHeight = 3; 	
//Thickness of the axis connector.
axisConnectorThickness = 0.8; 	

//SUBWHEEL VARIABLES
//Size of the subwheels at their smallest point (The edge)
subwheelBaseSize = 3.5;
//The additional size that will be cut out around the subwheels to ensure smooth movement
subwheelPlay = 1; 		
//By what angle should the wheels overlap? This should result in smoother running, but at the same time might cause problems if this value is too big.
subwheelOverlap = 1; 	

//SUBWHEEL AXIS HOLE VARIABLE
subwheelAxisDiameter = 1.75;
subwheelAxisPlay = 0.4;

//SUBWHEEL CONNECTOR VARIABLES
//Radius of the connectors to the subwheels (Best is slightly smaller than the subwheel.
cRad = subwheelAxisDiameter/2 + 1.5; 	
//Thickness of the connectors.
cThick = 0.8; 					
//Play room for the connector ports (distance to the subwheel)
cPlay = 0.3; 					

//FRAME VARIABLES
//frameRadius = connectorOffset(num, radius) + cPlay + cThick;	
//Radius of the frame Cylinder
frameRadius = 15;
//Height of the frame (not including the connectors
frameHeight = cRad + subwheelRadius(num, radius);
//Thickness of the main frame
frameThickness = 0.8;		

//STABILITY BEAM VARIABLES
//Thickness of the stability beams
beamThickness = 2.5; 	
//How many beams should be created?
beamNum = 5;

//CONNECTOR VARIABLES
//Thickness of the vertical connectors
connectorThickness = 0.8;	
//Inwards shift of the vertical connector beams (for smoother connection)
connectorInShift = 0.2;		
//Height of the connector pieces above the main frame.
connectorHeight = 2.5;		
//How many connectors should be created
connectorNum = 4;			


module shine(angle=10, length=10, height=10, center=true) {
    if($children != 0) {
        intersection() {
            linear_extrude(height) {
                if(center) {
                    polygon([[0,0] , [length*cos(angle/2),length*sin(angle/2)] , [length,0] , [length*cos(-angle/2),length*sin(-angle/2)]]);
                }
                else {
                    polygon([[0,0] , [length*cos(angle),length*sin(angle)] ,  [length*cos(angle/2),length*sin(angle/2)] , [length,0]]);
                }
            } 
            children(); 
        }
    }   
    else {
        linear_extrude(height) {
            if(center) {
                polygon([[0,0] , [length*cos(angle/2),length*sin(angle/2)] , [length,0] , [length*cos(-angle/2),length*sin(-angle/2)]]);
            }
            else {
                polygon([[0,0] , [length*cos(angle),length*sin(angle)] ,  [length*cos(angle/2),length*sin(angle/2)] , [length,0]]);
            }
        }
    }  
}  

module subwheelBase(n, r=20, p=0, shift = subwheelBaseSize, split=true, positioned=true) {  //The base structure of a Subwheel, basically a slice of a circle of the radius of the wheel, cut down to be rotated into a proper subwheel for a wheel of Radius R with N Subwheels.
	
	//Position the wheel according to the given parameters (Aling it to the outside of the main wheel and rotate it around into position p.)
	render(4) if(positioned) {
		//Rotate to the according outside position.
		rotate([0, 0, (360/n) * p])
		//Translate to the edge of the circle
		translate([ wheelOffset(n, r) - shift, 0, 0])
		//Rotate into horizontal position
		rotate([-90, 0, 0]) 
		//The main core of the subwheel
		subwheelBase(n, r, p, shift, split, false);
	}
	//Generate a standard subwheel without moving it around.
	else {
		render(convexity=4) difference() {				//Render the subwheel and make it hollow.
			union() {
				rotate_extrude() difference() {		//Generate the main subwheel
					intersection() {					//2D Model for the basic subwheel
						translate([ - wheelOffset(n, r) + shift, 0]) circle(r=r, $fn = 70);		//Main circle	
						translate([0, - sin(360/(2*n) + subwheelOverlap)*r]) square(sin(360/(2*n) + subwheelOverlap)*r *2);			//Intersecting square to only have the desired part of the circle
					}	
						
				}
				translate([0, 0, - sin(360/(2*n) + subwheelOverlap)*r]) cylinder(r=shift, h= sin(360/(2*n) + subwheelOverlap)*r *2);	//Central cylinder inside for the axis.
			}
			
			if(split) {
				translate([0,0,-(sin(360/(2*n) + subwheelOverlap)*r)]) cylinder(d= subwheelAxisDiameter + subwheelAxisPlay, h= 2* sin(360/(2*n) + subwheelOverlap)*r,$fn=15);	//Slot for the Filament-Axis, rolling
			}
		}
	}
}

//Create the connecting beams for the subwheels
module subwheelConnector(n, r, i) {
	render(convexity = 3)
	rotate([0,0, (360/n)*i]) 
	difference() {				//The difference cuts the hole for the axis into the connectors
		intersection() {		//The intersection makes sure that the subwheel connectors don't poke outside of the wheel radius. This should not be nececary, but for smaller subwheel base sizes might be desirable.
			union() {		//The cylinders here are the end cylinders on either side of the connector, the cubes are the beams that connect those cylinders to the main frame.
				translate([wheelOffset(n, r) - subwheelBaseSize, connectorOffset(n, r) + cPlay + cThick]) rotate([90, 0, 0]) cylinder(r= cRad, h= cThick, $fn = 13);		
				
				translate([0, connectorOffset(n, r) + cPlay, -cRad]) 
					cube([wheelOffset(n, r) - subwheelBaseSize, cThick, cRad*2]);
				
				translate([wheelOffset(n, r) - subwheelBaseSize, -connectorOffset(n, r) - cPlay]) rotate([90, 0, 0]) cylinder(r= cRad, h= cThick, $fn = 13);
						
				translate([0, -connectorOffset(n, r) - cPlay - cThick, -cRad]) 
					cube([wheelOffset(n, r) - subwheelBaseSize, cThick, cRad*2]);
			}
			
			translate([0,0, -cRad]) cylinder(r=r - 0.3, h= cRad*2);
		}
		
		translate([wheelOffset(n, r) - subwheelBaseSize, connectorOffset(n, r) + 5, 0]) rotate([90,0,0]) cylinder(d= subwheelAxisDiameter + 0.3, h= connectorOffset(n, r)*2 + 10, $fn=14);		//Cylinder for the axis hole.
	}
}

//Create a set of subwheels as they would be normally positioned. Inflated = true makes them bigger; useful for creating space around the wheels.
module subwheelSet(n, r, inflated=false) {
	for(i=[0:2:n]) { 	
		if(inflated) {		
			subwheelBase(n, r, i, shift = subwheelBaseSize + subwheelPlay, split=false);									//Create a /bigger/ subwheel in normal, ground position.
		}
		else {
			subwheelBase(n, r, i);									//Do the same as above, however using default subwheels instead of bigger subwheels here.
		}
	}
}

//Create a subwheel connector set for the according wheel of size r with n subwheels.
module connectorSet(n, r) {
	for(i=[0:2:n]) {
		subwheelConnector(n, r, i);
	}
}

//Create the central cylinder piece.
module centralCylinder(n, r) {
	render(convexity = 4) translate([0,0, - cRad]) difference() {
		cylinder(r= frameRadius, h= frameHeight);		//Create the central cylinder.
		cylinder(r= frameRadius - frameThickness, h= frameHeight);	//Hollow it out
	}
}
		
//Create the pieces that connect the two Omniwheel pieces together
module interconnectorPiece(r) {
	difference() {
		shine(height= frameHeight + connectorHeight, angle=(360/connectorNum/2) - 0.5, length= r)
		//"Shine" is a custom function that cuts down an object to a specific angle
		union() {
			cylinder(r= frameRadius - 0.1, h= frameHeight);		//Cylinder piece to connect the connector to the main frame.
			cylinder(r= frameRadius - frameThickness - connectorInShift, h= frameHeight + connectorHeight);		//Cylinder piece for the actual interconnector. This one is slightly smaller due to printing imperfections, thusly making sure that the pieces fit together nicely.
		}
		cylinder(r= frameRadius - frameThickness - connectorThickness - connectorInShift, h= frameHeight + connectorHeight);		//Hollow the interconnection pieces out so that they have the correct thickness.
		
	}
}
//Create the interconnections between two wheel pieces
module interconnections(n, r) {
	render(convexity= 2) translate([0,0, -cRad])
		for(i=[0:(360/connectorNum):360]) 
			rotate([0,0, i + 360/connectorNum])											
			interconnectorPiece(r);	
}

//Create the structural beams inside the subwheel for better stability.
module structuralBeams() {
	render(convexity = 4) translate([0,0, -cRad]) intersection() {
		cylinder(r= frameRadius, h= cRad*2);		//Make sure that the structural beams don't poke out of the main frame.
		
		for(i=[0:360/beamNum:360]) 
			rotate([0,0, i + 360/beamNum/2]) translate([0, -beamThickness/2, 0]) cube([frameRadius, beamThickness, 1]);		//Create the beams.
	}
}

//The Mainframe of the OmniWheel
module omniWheel(n, r, subwheels = false) {
	difference() {  
		union() {
		
			//Central Cylinder 
			centralCylinder(n, r);
			
			//Cylinder Interconnections
			interconnections(n, r);

			//Structural beams
			structuralBeams();
			
			//Connectors
			render(convexity = 5) difference() {
				connectorSet(n, r);			//Create the connectors
				translate([0,0, -cRad]) cylinder(r= frameRadius - 0.001, h= frameHeight); //Make sure they don't enter the central cylinder
			}
			
			translate([0,0, -cRad]) cylinder(d= axisDiameter + 2* axisConnectorThickness, h= axisConnectorHeight);
		}
		subwheelSet(n, r, true); 	//Make sure that there is enough space for the subwheels.
		translate([0,0, -cRad]) cylinder(d= axisDiameter, h= frameHeight);
	}
	
	%subwheelSet(n, r);		//Create subwheels around the model for a better visual inspection.
}

if(generate == 1) {
	omniWheel(num, radius, true);
}
else if(generate == 2) { 
	subwheelBase(num, radius, positioned=false);
}