
// Carabinier parameters

// Coin parameters
// Thickness of the coin (2.33 for 1 €)
HCOIN=2.33; // Height. Euro=2.33/11.625

// Radius of the coin (11.625 for 1€)
DCOIN=11.625;

// Internal radius, ie radius of the thinner part. Arbitrary
DICOIN=10;

// Thickness of the inside. 1mm is strong enough, and let space for visible motif. 
THCOIN=1; 


// Dimensions of carabiner. Play with to understand each one role.
L1=8; // Length of the connection between coin and carabinier

// Radius
R=8; // Radius of the carabinier's semi-circle

// Angle
A=40; // Angle of the oblique line

// Length
L2=10; // Length of another line (just modify it if you want to know which one^^)

// Number of circonvolution of the flexible part. 0 for straight flexible part (not advised)
NL=3;

// Thickness of the flexible part
TH=0.8; // Thickness of the flexible part


// Logo file. Does not work with Thingiverse customizer.
YOURLOGOFILE="propositionNewLogo.dxf";

// Scale and center the logo if needed
LOGOX=-16; // Scale and center the logo
LOGOY=-5;
LOGOW=16;

// Text part
YOURTEXT="CLG";


use <MCAD/fonts.scad>

thisFont=8bit_polyfont();
module char(c){
   t=search(c,thisFont[2],1,1);
        polygon(points=thisFont[2][t[0]][6][0],paths=thisFont[2][t[0]][6][1]);
}

module txt(word, spc, sc){
   for(i=[0:len(word)-1]) translate([i*spc, 0, 0])  scale(sc) char(word[i]);
}



// === End of parameters =================================================

// La pièce
difference(){
   cylinder(h=HCOIN, r=DCOIN, $fn=100);
   translate([0, 0, THCOIN]) cylinder(h=HCOIN, r=DICOIN, $fn=100);
}
if (!YOURTEXT || YOURTEXT=="") {
// Attempt to automatically resize logo. It will not fit exactly, but at least your logo should not be 1000 times smaller or larger than the coin. Adjust with LOGOX/Y/W
translate([LOGOX,LOGOY,1]) resize([0,0,HCOIN-THCOIN]) resize([LOGOW,0,0], auto=true) scale([0.01, 0.01, 1]) linear_extrude(HCOIN-THCOIN) import(YOURLOGOFILE); // scale+resize is strange, I know. This is to bypass a bug in OpenScad 2013.06. This bug is documented and should be removed in next release of OpenScad
}
if(YOURTEXT && YOURTEXT!=""){
   translate([-DICOIN*((len(YOURTEXT)==1)?1:0.8), -DICOIN/2, 0]) resize([DICOIN*1.5, DICOIN*0.9, HCOIN]) linear_extrude(HCOIN) txt(YOURTEXT, 1, 0.14);
}

// Première zone droite (qui part de la pièce) de longueur L1
translate([-HCOIN/2, DCOIN-0.125, 0]) cube([HCOIN, L1, HCOIN]);

// Zone droite oblique (sur la droite) avec un angle A, et devant rejoindre le x du cercle
xbgoblique = -cos(A)*HCOIN/2;
ybgoblique = DCOIN-0.125+L1-HCOIN*0.5*cos(A)/sin(A)-HCOIN*0.5*cos(A)*cos(A)/sin(A);
lbgoblique = (R+xbgoblique)/sin(A);
translate([xbgoblique, ybgoblique ,0]) rotate(a=-A,v=[0,0,1]) cube([HCOIN,lbgoblique,HCOIN]);

// 2e zone droite (sur la droite)
ybdoblique=ybgoblique-sin(A)*HCOIN;
yhdoblique=ybdoblique+cos(A)*lbgoblique;
translate([R-HCOIN,yhdoblique,0]) cube([HCOIN,L2,HCOIN]);

// Demi cercle (crochet carabinier)
translate([0, yhdoblique+L2, 0]) difference(){
   cylinder(h=HCOIN, r=R, $fn=40);
   translate([0,0,-1]) cylinder(h=HCOIN+2, r=R-HCOIN, $fn=40);
   translate([-25, -50-0.375*R, -25]) cube([50,50,50]);
	translate([0,-50,-25]) cube([50,50,50]);
	translate([-R+HCOIN+0.27,-0.375*R-0.5,0]) rotate(a=20, v=[0,0,1]) rotate(a=-90, v=[1,0,0]) linear_extrude(4.5) polygon([[0,-HCOIN/2], [1,-HCOIN], [1,0]]);
}

// Ressort : longueur qu'il doit être
hress=yhdoblique+L2-DCOIN+0.125-L1-0.375*R-4.5;
lress=sqrt(R*R+hress*hress);

// Une boucle de taille non paramétrique (on scalera)
module oneloop(){
	difference(){
	   cylinder(h=HCOIN, r=1.3, $fn=10);
		translate([0,0,-0.01]) cylinder(h=HCOIN+0.02, r=1.3-TH, $fn=10);
		translate([0, -5, -0.01]) cube([10,10,HCOIN+0.02]);
	}
}

// Deux boucles
module chain(){
	translate([-0.6, 0,0]) oneloop();
   translate([0.6, 2.6-TH, 0]) mirror() oneloop();
	translate([-0.6,1.3-TH,0]) cube([1.2, TH, HCOIN]);
	translate([-0.6,3.9-2*TH,0]) cube([1.2, TH, HCOIN]);
}
LL=5.2-2*TH;

// Une chaine de longueur n
module chaine(n){
   for(i=[0:1:n]) translate([0, LL*i,0]) chain();
}

// 3.6*NL est la longueur fixe (non paramétrique) du ressort. Il faut mettre une échelle
// pour lui donner la longueur voulue

module finress(){
	translate([-1.8,0,0]) cube([HCOIN,HCOIN,HCOIN]);
	translate([-0.5,0,0]) cube([1,4.5, HCOIN]);
	translate([-1.5,0,0]) rotate(a=-90, v=[1,0,0]) linear_extrude(4.5) polygon([[0,-HCOIN/2], [1,-HCOIN], [1,0]]);
}

translate([0, DCOIN-0.125+L1+0.7, 0]) rotate(a=40, v=[0,0,1]) scale([lress/NL/LL, lress/NL/LL, 1]) {
	chaine(NL-1);
	translate([0,NL*LL-1.3, 0]) scale([NL*LL/lress, NL*LL/lress, 1]) finress();
}






