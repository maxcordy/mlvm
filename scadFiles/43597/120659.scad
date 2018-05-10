/*
 * Pipe (or Scooter Handle) Plug (Parametric), v0.42
 *
 * by Alex Franke (CodeCreations), Jan 2013
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
 * 
 * DESCRIPTION: This is a parametric plug that can be used with an elastic cord to 
 *   cover the end of a pipe. Using the default settings, it fits the ends of the 
 *   handles of my kids' Razor kick scooters. 
 * 
 * INSTRUCTIONS: Choose some values in the "User-defined values" section if 
 *   necessary, render, and print. Drill out the internal bridging, if necessary. 
 *     To replace an existing plug, grab the elastic band and clamp the end so it 
 *   doesn't to into the pipe. (I used a clothes pin.) Drill out the old plug if 
 *   necessary. Untie or cut the knot at the end of the elastic, thread it though 
 *   the new plug, and re-tie. You may need to file the inside of the tube a bit 
 *   if its really banged up. 
 * 
 * v0.42, Jan 20, 2013: Initial Release.
 * 
 * TODO: 
 *   * None at this time
 */

/////////////////////////////////////////////////////////////////////////////
// User-defined values... 
/////////////////////////////////////////////////////////////////////////////

// Diameter of the through hole. This should be big enough to fit the elastic through. 
throughHoleDiameter = 4; 

// Diameter of the opening that holds the knot in place. 
knotHoleDiameter = 9; 

// Depth of the opening that holds the knot in place
knotHoleDepth = 8; 

// Inside diameter of the pipe you're plugging 
pipeID = 19; 

// Outside diameter of the pipe you're plugging 
pipeOD = 22; 

// The distance (from the outside) of the chamber
chamferDistance = 0.75;

// The difference in radius between the top of the taper and the bottom
taperDistance = 2; 

// The distance the plug protrudes from the end of the pipe
outset = 2; 

// The thickness of the bridge layer on the inside (to support the smaller through-hole).
bridgeThickness = 0.4; 

// The total height of the plug 
totalHeight = 13; 


/////////////////////////////////////////////////////////////////////////////
// The code... 
/////////////////////////////////////////////////////////////////////////////

union() {
	rotate_extrude() 
		polygon(points=[
			[knotHoleDiameter/2,0],
			[knotHoleDiameter/2,knotHoleDepth],
			[throughHoleDiameter/2,knotHoleDepth],
			[throughHoleDiameter/2,totalHeight],
			[pipeID/2-taperDistance,totalHeight],
			[pipeID/2,outset],
			[pipeOD/2,outset],
			[pipeOD/2,chamferDistance],
			[pipeOD/2-chamferDistance,0],
			[knotHoleDiameter/2,0]
			]); 
	
	// bridge material 
	translate([0,0,knotHoleDepth]) 
		cylinder(h=bridgeThickness, r=knotHoleDiameter/2) ;
}