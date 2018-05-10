// Bestückungshilfe für Elektronikbauteile
// Platinen Bestückungs Biege Tool
// PCB-Assembling Forming Tool
// STEVE6330 > 12.10.2013

//06/2014: Makkuro: Modified Version for SMD components.
use<Write/Write.scad>


//Do write the codes?
Write_Codes="yes"; //["yes","no","maybe"] 

//Height of the tool
heightbasis=12; //[2:40]

//Printing distance so the SMDs fit in snugly
printdist=.4;




difference()
{
 	scale([.5,.8,1]) 
		BasisKoerper(); 
	translate([0,0,heightbasis+.1])
		smds();
}

// Basis Körper
 module  BasisKoerper()
{ 
  color  ([1,0.2,0.2]){ 
  linear_extrude( height = heightbasis, center=false, 
               convexity = 10, twist = 0,$fn = 20)
  polygon(points = [
  [0.00,0.00],
  [0.00,8.75],
  [32.00,8.75],
  [33.00,7.30],
  [67.00,7.30],
  [68.00,6.30],
  [102.00,6.30],
  [103.00,4.75],
  [120.00,4.75],
  [121.00,3.70],
  [133.00,3.70],
  [133.00,-3.70],
  [121.00,-3.75],
  [120.00,-4.75],
  [103.00,-4.75],
  [102.00,-6.30],
  [68.00,-6.30],
  [67.00,-7.30],
  [33.00,-7.30],
  [32.00,-8.75],
  [0.00,-8.75]
  ]
 ,paths = 
 [[0,1,2,3,4,5,6,7,8,9,10,11,
   12,13,14,15,16,17,18,19,20]]);
 }
}

module smds()
{
//length,width,height
smdsizes=[[0.30,0.60,0.25],
			[.5,1,0.35],
			[0.8,1.6,0.50],
			[1.25,2,0.50],
			[1.6,3.2,0.60],
			[2.6,3.2,0.50],
			[3.00,4.20,0.900],
			[2.6,5,0.70],
			[5.08,5.08,0.90],
			[5.00,11.50,0.90],
			[3.1,6.3,0.60]];
smdnames=["0201",
			"0402",
			"0603",
			"0805",
			"1206",
			"1210",
			"1217",
			"2010",
			"2020",
			"2045",
			"2512"];

	for (i=[0:len(smdsizes)-1])
	{
		translate([(len(smdsizes)-.5-i)*6,0,-smdsizes[i][2]/2])
		{
			cube([smdsizes[i][0]+printdist,smdsizes[i][1]+printdist,smdsizes[i][2]+printdist],center=true);
			if(Write_Codes=="yes" || (Write_Codes=="maybe" && rands(0,10,1)[0]>5) )
				translate([0,(len(smdsizes)-i)*.3,0])
					writecube( smdnames[i],[0,0,-5],[0,20,0],h=3,rotate=-90,t=10);
		}
	}
}
