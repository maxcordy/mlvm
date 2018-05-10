///////////////////////////////////////////Version and License /////////////////////////////////////////////////////////////
//Licensed under Creative Commons non commercial license
//V.1.0
//Created by Sandi Rakovec, Kranj, Slovenia
//Last modified by Sandi Rakovec, Slovenia on 04.09.2015 21.36
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////Parameters/////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// (Inner diameter of holes ranges from 10 mm to 30 mm)
InnerDiameterOfSplint = 18;//[10:1:30]
// (Thicknes of a splint possible value are 2 and 3 mm 2mm works just fine)
ThicknessOfASplint=2; //[2:1:3]


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////Modules////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module param(){} // this one actualy does nothing

ExternalDiameterOfSplint=InnerDiameterOfSplint+ThicknessOfASplint;
LengthOfASplint=2*ExternalDiameterOfSplint+5;
y=LengthOfASplint;
x=2*ExternalDiameterOfSplint/3;
UpperCubeLength = ExternalDiameterOfSplint/3;
$fa=0.5;
$fn=200;
r=(exp(ln(y)*2)) / (8*x) + x/2;
pozicija=24;
echo("ExternalDiameterOfSplint:",ExternalDiameterOfSplint);
echo("LengthOfASplint",LengthOfASplint);
echo("r",r);
echo("x",x);
echo("y",y);
echo("UpperCubeLength",UpperCubeLength);
echo("r-x",r-x);

module ZunanjaCev() {
difference() {
cylinder(d=ExternalDiameterOfSplint,h=LengthOfASplint,center=true);
cylinder(d=ExternalDiameterOfSplint-ThicknessOfASplint*2,h=LengthOfASplint,center=true);
}
}

module ZunanjiDelProfila() 	{
difference() 	{
	cylinder(ExternalDiameterOfSplint,d=2*r,center=true);
	translate([(ExternalDiameterOfSplint-ThicknessOfASplint*2)/2,0,0])
	cube([(2*r)-x,2*r,ExternalDiameterOfSplint],center=true);
				}
		translate([-(r-x)-2*UpperCubeLength-UpperCubeLength/2,0,0])
		cube([UpperCubeLength,ThicknessOfASplint,ExternalDiameterOfSplint],center=true);
							}
module NotranjiDelProfila() {
// render(convexity = 2)
cylinder(ExternalDiameterOfSplint,d=2*r-ThicknessOfASplint,center=true);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////Program////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
intersection() {
rotate([90,0,0]){
translate ([0,ThicknessOfASplint,0])
ZunanjaCev();
}
rotate ([0,90,0]) {

 translate ([((2*r)-x)/2,0,0]) {
 difference(){
ZunanjiDelProfila();
NotranjiDelProfila();
 }
 }
 }
 }