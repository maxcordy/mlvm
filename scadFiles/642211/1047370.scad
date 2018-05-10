// Sphere puzzle 
// (C) by Joachim Eibl 2015
// Licence: CC BY-NC-SA 3.0 
// Creative Commons: attribution, non commercial, share alike
// See: http://creativecommons.org/licenses/by-nc-sa/3.0/

// Some comments are for thingiverse customizer
// preview[view:north, tilt:top]

/* [Sphere/Global] */

// number of equatorial pieces (make up a circle)
longitudeSteps=8;

// number of pieces from equator to top
latitudeSteps = 3;

// total number of pieces = longitudeSteps * (latitudeSteps * 2 - 1) + 2 [top and bottom piece]
// e.g.: longitudeSteps=8, latitudeSteps= 3: 42

sphereRadius = 60;
pieceThickness = 10;

connectorSizeFactor = 0.06;
connectorGap = 0.3; 

// (read instructions)
connectorNeckGap = 0.3;

// gap between pieces
pieceGap = 0.2; 

connectorQuality = 30;
sphereQuality = 100;

/* [Puzzle/Piece] */

// Range +/-Latitude Steps, e.g. [-3 ... +3])
latitudeIndex = 0;

northConnector = -1; //[-1:in, 0:none, 1:out]
southConnector = 1; //[-1:in, 0:none, 1:out]
westConnector = 1; //[-1:in, 0:none, 1:out]
eastConnector = -1; //[-1:in, 0:none, 1:out]

// array with one item for each longitude step
northPoleConnectors = [1,1,1,1,1,1,1,1];
// array with one item for each longitude step
southPoleConnectors = [-1,-1,-1,-1,-1,-1,-1,-1];

/* [Text] */

text = "A";
// text size factors for [x,y,z]
textScale = [1,1,1];
// text position offset for [x,y]
textOffset = [0,0];

include <write/Write.scad>;
font = "write/Letters.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy,"write/knewave.dxf":Knewave,"write/braille.dxf":Braille]

/* [hidden] */

r = sphereRadius - pieceThickness;  // inner radius
h = pieceThickness; // thickness of puzzle pieces in the middle
// outer radius is r+h

rl=r * connectorSizeFactor; // radius of puzzle connectors

textMethod = 1;
//textMethod=0 for fonts created with ttf2dxf from:
//http://www.thingiverse.com/thing:96714
// font = "text_and_fonts/DejaVuSans-Bold.dxf"; //

module connector(i,j,bInverse=false,nc=0,sc=0)
{
	j1 = j-0.5;
	j2 = j+0.5;
	f = cos(0.5 *90/latitudeSteps);
	r1=r*cos(j1 *90/latitudeSteps);
	r2=r*cos(j2 *90/latitudeSteps);
	x1 = r1/f * tan( 180 /*3.1415927*/ * 2 / (longitudeSteps * 2) ); // xSize bottom
	x2 = r2/f * tan( 180 /*3.1415927*/ * 2 / (longitudeSteps * 2) ); // xSize top
	y = r * tan( 90 / (latitudeSteps*2) ); // y size

	sl = rl * 1.5 + (!bInverse ? 0 : 2*connectorNeckGap);

	extrudeScale = !bInverse ? (r+h)/r : (r+h)/(r-h);
	scaleFact = !bInverse ? 1 : (r-h)/r;
	h2 = !bInverse ? h : 2*h;
   cr = !bInverse ? rl : rl+connectorGap;

	bSC = !bInverse ? southConnector==1 : northConnector==-1;
	bNC = !bInverse ? northConnector==1 : southConnector==-1;
	bEC = !bInverse ? eastConnector==1  : westConnector==-1;
	bWC = !bInverse ? westConnector==1  : eastConnector==-1;

	translate([0,!bInverse ? 0 : -h ,0])
		rotate([-90,0,0]) 
			linear_extrude(height = h2, center = false, convexity = 10, scale=extrudeScale )
				scale([scaleFact,scaleFact])
	{
		if( (bSC && (nc==0 && sc==0)) || sc )
		{
			translate([0,y]) square([sl,sl],center=true);
			translate([0,y+rl]) circle(r=cr, $fn=connectorQuality);
		}
		if( (bNC && (nc==0 && sc==0)) || nc)
		{
			translate([0,-y]) square([sl,sl],center=true);
			translate([0,-y-rl]) circle(r=cr, $fn=connectorQuality);
		}
		if (bWC && (nc==0 && sc==0))
		{
			translate([(x1+x2)/2,0]) rotate(-j*10) 
			{
				translate([0,0]) square([sl,sl],center=true);
				translate([rl,0]) circle(r=cr, $fn=connectorQuality);
			}
		}
		if (bEC && (nc==0 && sc==0))
		{
			translate([-(x1+x2)/2,0]) rotate(j*10) 
			{
				translate([0,0]) square([sl,sl],center=true);
				translate([-rl,0]) circle(r=cr, $fn=connectorQuality);
			}
		}
	}
}

module piece(i,j)
{
	j1 = j-0.5;
	j2 = j+0.5;
   f = cos(0.5 *90/latitudeSteps);
	r1=r*cos(j1 *90/latitudeSteps);
	r2=r*cos(j2 *90/latitudeSteps);
	x1 = r1/f * tan( 180 /*3.1415927*/ * 2 / (longitudeSteps * 2) )- pieceGap/4 ; // half xSize bottom
	x2 = r2/f * tan( 180 /*3.1415927*/ * 2 / (longitudeSteps * 2) )- pieceGap/4 ; // half xSize top
	y = r * tan( 90 / (latitudeSteps*2) ) - pieceGap/4; // half y size

	p = [ [-x1,+y], [x1,+y], 
			[x2,-y],[-x2,-y] ];

	difference()
	{
		rotate([j*90/latitudeSteps,0,0])	translate([0,r,0])
		union(){
			rotate([-90,0,0]) 
				linear_extrude(height = h, center = false, convexity = 10, scale=(r+h)/r)
					polygon( points = p  );

			connector(i,j);
		}
		if ( eastConnector==-1 )
			rotate([0,0,1*360/longitudeSteps]) rotate([j*90/latitudeSteps,0,0])  translate([0,r,0])
				connector( i+1,j,true );

		if ( westConnector==-1 )
			rotate([0,0,-1*360/longitudeSteps]) rotate([j*90/latitudeSteps,0,0])  translate([0,r,0])
				connector( i-1,j,true );
		
		if ( northConnector==-1 )
			rotate([(j+1)*90/latitudeSteps,0,0]) translate([0,r,0])
				connector( i,j+1,true );

		if ( southConnector==-1 )
			rotate([(j-1)*90/latitudeSteps,0,0]) translate([0,r,0])
				connector( i,j-1,true );
	}
}

module polePiece( connectors )
{
   f = cos(0.5 *90/latitudeSteps);
	r1=r*cos((latitudeSteps-0.5) *90/latitudeSteps);

	difference()
	{
		translate([0,0,r])
		union()
		{
			rotate([0,0,-90+180/longitudeSteps])
				linear_extrude(height = h, center = false, convexity = 10, scale=(r+h)/r)
					circle( r=r1 / (f*cos(180/longitudeSteps)) ,$fn=longitudeSteps );
			for(i=[0:longitudeSteps-1])
				if(connectors[i]==1)
					rotate([90,0,i*360/longitudeSteps]) 
						connector(0,latitudeSteps-1,0,1);
		}

		for(i=[0:longitudeSteps-1])
			if(connectors[i]==-1)
				rotate([(latitudeSteps-1)*90/latitudeSteps,0,180+i*360/longitudeSteps])	
					translate([0,r,0])
						connector(i,latitudeSteps-1,connectorGap,1,0);
	}
}

module spherePuzzle()
{
	intersection() {
		union()
		{
			for( i=[0:longitudeSteps-1] )
				rotate([0,0,i*360/longitudeSteps])
					for( j=[-latitudeSteps+1:latitudeSteps-1])
						piece(i,j);
			polePiece([1,1,1,1,1,1,1,1]);
			rotate([180,0,0]) polePiece([0,0,0,0,0,0,0,0]);
		}
		sphere(r=r+h,$fn=sphereQuality);
	}	
}

module spherePiece(j)
{
	intersection(){
		sphere(r=r+h,$fn=sphereQuality);
		piece(0,j);
	}
}

module spherePolePiece(connectors)
{
	intersection(){
		sphere(r=r+h,$fn=sphereQuality);
		polePiece(connectors);
	}
}


module sphereLetterPuzzle()
{
	intersection() {
		union()
		{
			for( i=[0:longitudeSteps-1] )
				rotate([0,0,i*360/longitudeSteps])
					for( j=[-latitudeSteps+1:latitudeSteps-1])
						piece(i,j);
			polePiece([1,1,1,1,1,1,1,1]);
			rotate([180,0,0]) polePiece([0,0,0,0,0,0,0,0]);
		}
		sphere(r=r+h,$fn=sphereQuality);
	}

	s = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	for( i=[0:longitudeSteps-1] )
		rotate([0,0,i*360/longitudeSteps])
			for( j=[-latitudeSteps+1:latitudeSteps-1])
				rotate([j*90/latitudeSteps,0,0])	translate([0,r,0])
					rotate([-90,0,0]) 
						translate([-textOffset[0],-textOffset[1],(h+textScale[2])/2]) 
							rotate([0,0,180]) 
								write(s[i-(j-2)*8],t=(h+textScale[2]),h=15,center=true);
}

module letterPiece(j,l)
{
	if (latitudeIndex<=-latitudeSteps)
		rotate([180,0,0]) spherePolePiece(southPoleConnectors);
	else if (latitudeIndex>=latitudeSteps)
		spherePolePiece(northPoleConnectors);
	else
		spherePiece(j);

	rotate([j*90/latitudeSteps,0,0])	translate([0,r,0])
		rotate([-90,0,0]) 
			if(textMethod==1)
				translate([-textOffset[0],-textOffset[1],(h+textScale[2])/2]) 
					rotate([0,0,180]) 
						write(l,t=(h+textScale[2]),h=15,center=true);
			else
				linear_extrude(height = h+1, center = false, convexity = 10, scale=(r+h)/r)
					translate([-textOffset[0],-textOffset[1]])
						scale([0.004* textScale[0],0.004*textScale[1]])
							letter(l);
}

// l is layer
module letter(l) {
	minx = dxf_dim(file=font, name="minx",layer=l );
	maxx = dxf_dim(file=font, name="maxx",layer=l );
	miny = dxf_dim(file=font, name="miny",layer=l );
	maxy = dxf_dim(file=font, name="maxy",layer=l );
	advx = dxf_dim(file=font, name="advx",layer=l );
	advy = dxf_dim(file=font, name="advy",layer=l );
	rotate(180)
		translate([-advx/2,-maxy/2])
	   	import(font, layer=l);
}

//jp=2;
//translate([2*r,0,0]) piece(0,jp);
//spherePiece(-2);
//rotate([0,0,1*360/longitudeSteps]) spherePiece(1);
//rotate([0,0,1*360/longitudeSteps]) spherePiece(-1);
//rotate([0,0,1*360/longitudeSteps]) spherePiece(0);
//spherePiece(0);
//rotate([0,0,1*360/longitudeSteps])spherePiece(1);
//rotate([0,0,2*360/longitudeSteps])spherePiece(-2);
//spherePolePiece([1,1,1,1,1,1,1,1]);
//spherePuzzle();

//sphereLetterPuzzle();


rotate([90,0,0]) 
	translate([0,-r,0]) 
		rotate([-latitudeIndex*90/latitudeSteps,0,0])
			letterPiece(latitudeIndex,text);


