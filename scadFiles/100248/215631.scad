// Exploded Buckyball
// Paul Murrin - May 2013

// Length of an edge on the buckyball segments (mm)
// Note, overall radius is approximately 2.3 times the edgeLen 
EdgeLen = 25;
// Minimum explosion radius (mm) - 0 for solid buckyball
ExplodedMin = 20;
// Maximum explosion radius (mm) - 0 for solid buckyball, random widths are chosen between the min and max
ExplodedMax = 20;
// Choose segment to render
part = "whole"; // [whole:Whole object,core:Center section,pentagon:Pentagon section,hexagon:Hexagon section]

/* [Hidden] */

tol=0.01;
dh56 = 142.62;			// Dihedral angle for hexagon-hexagon faces
dh66 = 138.189685;		// Dihedral angle for pentagon-hexagon faces
coreEdgeLen = 0.6*EdgeLen;

print_part();

module print_part() {
	R5 = getR5(EdgeLen);
	R6 = getR6(EdgeLen);

	if (part == "whole") {
		union()
		{
			buckyball(edgeLen = EdgeLen, thickness=4*EdgeLen, explodedMin=ExplodedMin, eplodedMax=ExplodedMax);
			buckyball(edgeLen = EdgeLen*0.6, thickness=4*EdgeLen);
		}
	} else if (part == "core") {
		difference()
		{
			buckyball(edgeLen = EdgeLen*0.6, thickness=4*EdgeLen);
			buckyball(edgeLen = EdgeLen, thickness=4*EdgeLen, explodedMin=ExplodedMin, eplodedMax=ExplodedMax, ballRadius=1.5);
		}
	} else if (part == "pentagon") {
		mirror([0,0,1]) buckyPentagonSection(EdgeLen, R5-2);
	} else if (part == "hexagon") {
		mirror([0,0,1]) buckyHexagonSection(EdgeLen, R6-2);
	} else {
		union()
		{
			buckyball(edgeLen = EdgeLen, thickness=4*EdgeLen, explodedMin=ExplodedMin, eplodedMax=ExplodedMax);
			buckyball(edgeLen = EdgeLen*0.6, thickness=4*EdgeLen);
		}
	}
}







// Functions related to Buckyball geometry

// face radius of pentagon (center of face to vertex)
function getPentagonLongRadius(edgeLen) = (edgeLen/2)/cos(54);
// Short face radius of pentagon (center of face to center of edge)
function getPentagonShortRadius(edgeLen) = edgeLen/2*tan(54);
// Short face radius of hexagon (center of face to center of edge)
function getHexagonShortRadius(edgeLen) = edgeLen/2*tan(60);
// Radius from object center to center of pentagonal face
function	 getR5(edgeLen) = (edgeLen/2)*tan(54)*tan((dh56-dh66/2));	
// Radius from object center to center of hexagonal face
function	 getR6(edgeLen) = (edgeLen/2)*tan(60)*tan(dh66/2);	
// Angle between center of pentagon face to center of pentagon edge via center of buckyball
function getInternalR5ShortAngle() = 90-(dh56-dh66/2);	
// Angle between center of pentagon face to vertex of pentagon via center of buckyball
function getInternalR5LongAngle(edgeLen) = atan(getPentagonLongRadius(edgeLen)/getR5(edgeLen));	
// Angle between center of hexagon face to center of hexagon edge via center of buckyball
function getInternalR6Angle() = 90-dh66/2;	
// Angle between vertices on each end of an edge via center of buckyball
function getInternalAngleVertexToVertex(edgeLen) = 2*atan((edgeLen/2)/(getR6(edgeLen)/cos(getInternalR6Angle()))); 


module buckyPentagonSection(edgeLen = 30, thickness = 4, ballRadius=0)
{
	rs5 = getPentagonShortRadius(edgeLen);	
	r5 = getPentagonLongRadius(edgeLen);	
	ShortToLongRatio5 = rs5/r5;	// Ratio of short diameter to long diameter for pentagon (equal to cos(36))
	// Radius decrease for inside (of buckyball ie base of segment) radius
	shortRadDecrease = thickness * tan(90-(dh56-dh66/2));
	baseRadius = (rs5-shortRadDecrease)/ShortToLongRatio5;


	render() 
		union()
		{
			// outside
			hull()
			{
				// Outside face
				cylinder(r=r5, h=tol, $fn=5);
				// lower (interior) face
				translate([0,0,-thickness])
					cylinder(r=baseRadius, h=tol, $fn=5);
			}
			if (ballRadius>0)
			{
				translate([0,0,-thickness]) sphere(r=ballRadius);
			}
		}
}




module buckyHexagonSection(edgeLen = 30, thickness = 4, ballRadius=0)
{
	r6 = edgeLen;	// face radius of hexagon (center of face to vertex)
	rs6 = getHexagonShortRadius(edgeLen);
	long2ShortRatio = r6/rs6;
	// Radius decrease for inside (of dodeca ie base) radius
	ShortRadDecrease = thickness * tan(90-(dh66/2));
	baseRadius = (r6-ShortRadDecrease*long2ShortRatio);

	render()
		union()
		{
			// outside
			hull()
			{
				// Outside face
				cylinder(r=r6, h=tol, $fn=6);
				// lower (interior) face
				translate([0,0,-thickness])
					cylinder(r=baseRadius, h=tol, $fn=6);
			}
			if (ballRadius>0)
			{
				translate([0,0,-thickness]) sphere(r=ballRadius);
			}
		}
}



//half buckyball
module halfbuckyball(edgeLen = 30, thickness = 4, explodedMin=0, explodedMax=0, ballRadius=0)
{
	r5 = getPentagonLongRadius(edgeLen);
	R5 =  getR5(edgeLen);
	R6 =  getR6(edgeLen);
	internalR5ShortAngle = getInternalR5ShortAngle();
	internalR5LongAngle = getInternalR5LongAngle(edgeLen);
	internalR6Angle = getInternalR6Angle();
	internalAngleVertexToVertex = getInternalAngleVertexToVertex(edgeLen);
	thickness5=thickness>(R5-1)?(R5-1):thickness;
	thickness6=thickness>(R6-1)?(R6-1):thickness;
	explosion=rands(min_value=explodedMin, max_value=explodedMax, value_count=16);
	angles = (360/5)*[0,1,2,3,4];

	render() 
	union()
	{
		translate([0,0,R5+explosion[0]]) rotate([0,0,0]) buckyPentagonSection(edgeLen+tol, thickness5, ballRadius);
		for( i=[0:4]) 
			union()
				rotate([0,0,angles[i]+360/10]) 
				{
					rotate([0, internalR5ShortAngle+internalR6Angle, 0]) 
						translate([0,0,R6+explosion[1+i]]) 
							rotate([0,0,360/12]) 
								buckyHexagonSection(edgeLen+tol, thickness6, ballRadius);
					rotate([0, internalR5ShortAngle+3*internalR6Angle, 0]) 
						translate([0,0,R6+explosion[6+i]]) 
							rotate([0,0,360/12]) 
								buckyHexagonSection(edgeLen+tol, thickness6, ballRadius);
				}
		for( i=[0:4]) 
			rotate([0,0,angles[i]]) 
				rotate([0, 2*internalR5LongAngle+internalAngleVertexToVertex, 0]) 
					translate([0,0,R5+explosion[11+i]]) 
						rotate([0,0,360/10]) 
							buckyPentagonSection(edgeLen+tol, thickness5, ballRadius);
	}
}

module buckyball(edgeLen = 30, thickness = 4, explodedMin=0, eplodedMax=0, ballRadius=0)
{
	halfbuckyball(edgeLen, thickness, explodedMin, eplodedMax, ballRadius);
	rotate([0,0,360/10]) mirror([0,0,1]) halfbuckyball(edgeLen, thickness, explodedMin, eplodedMax, ballRadius);
}





