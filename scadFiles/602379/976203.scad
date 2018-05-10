// ************* Credits part *************
//            "Mini-sandwich Maker" 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//
//********************** License ******************
//**        "Mini-sandwich_Maker" by rr2s        **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
//
// ************* Declaration part *************
/* [Global] */

/* [Part] */
// Select the part you want to see. If you change the settings select all the parts with the same setting.
PartOfObject = "Base";// [Base:Base,Pusher:Pusher,Axispusher:Axis pusher,Cap:Cap]


/* [Type] */
// What type of Mini-sandwich you want.
Type = "Heart"; // [Cylinder:Cylinder,Square:Square,Hex:Hex,Octagonal:Octagonal,Rectangle:Rectangle,RectangleBevel:Rectangle/Square Bevel,Oval:Oval,Heart:Heart]
// What type cap of Mini-sandwich you want.
TypeCap = "Sphere";// [Cube:Cube,Sphere:Sphere]
// What type Axis Pusher of Mini-sandwich you want.
TypeAxis = "Cylinder";// [Square:Square,Cylinder:Cylinder,Hex:Hex]
// Resolution Bevel if you have choose Rectangle/Square Bevel
RectangleBevelResoltuion = 50;



/* [Settings] */
// (Height of your Mini-sandwich in mm)
Height = 35;
// (The width of your Mini-sandwich in mm. if it's a circle or oval this is the diameter.if it's Heart this is a size)
Width = 25; 
// (The length of your Mini-sandwich in mm. If it's Oval Length)
Length = 25;


/* [Hidden] */

	// ************* private variable *************
   // No change this variable. The code needs to be improved to use these variable.
	TP  = 5;//ThicknessPusher
	H   = Height+TP;
	W   = Width;
	L   = Length;
	TH  = 2 ; //ThicknessWall 
	// other
	HAP = H+10;  //Height Axis Of Piston
	WAP = W/3.5; //Width Axis Of Piston or diametre if cinylinder or oval
	LAP = L/3.5; //Length Axis Of Piston
	RSB = RectangleBevelResoltuion;


// ************* Executable part *************

Type_Part();

// ************* Module part Piston *************



// Axis Piston Print
module AxisOfPistonCylinder(){
		if (TypeAxis == "Cylinder"){
			translate([0,0,-HAP/2+H-TH]) cylinder(HAP+TH, WAP/2, WAP/2,$fn=100);
		}if (TypeAxis == "Square"){
			translate([0,0,-HAP/2+H-TH]) cylinder(HAP+TH, WAP/2, WAP/2,$fn=4);
		}else if (TypeAxis == "Hex"){
			translate([0,0,-HAP/2+H-TH]) cylinder(HAP+TH, WAP/2, WAP/2,$fn=6);
		}
	}



// Cap of the piston Sphere
module CapPistionSphere(){
		translate([0,0,HAP+H/2+-WAP*1.5]) difference(){
		sphere(W/2,$fn=150);
		translate([0,0,-W/2]) cube(W,center=true);
		}
}

// cap of the piston Cube
module CapPistionCube(){
	translate([0,0,HAP+H/2+WAP+-W/2]) cube ([W/1.5,L/1.5,W/2],center=true);
	}


// Axis Piston Cut
module AxisOfPistonCylinderCutBase(){
		if (TypeAxis == "Cylinder"){
			translate([0,0,-HAP/2+H-TH]) cylinder(HAP+TH, WAP/2+0.2, WAP/2+0.2,$fn=100);
		}if (TypeAxis == "Square"){
			translate([0,0,-HAP/2+H-TH]) cylinder(HAP+TH, WAP/2+0.2, WAP/2+0.2,$fn=4);
		}else if (TypeAxis == "Hex"){
			translate([0,0,-HAP/2+H-TH]) cylinder(HAP+TH, WAP/2+0.2, WAP/2+0.2,$fn=6);
		}
	}



// ************* Module part For Cylinder *************
module BaseCylinder(){
	translate([0,0,-H/2]) cylinder(H+TH, W/2+TH, W/2+TH,$fn=100);
}

module PusherCylinder(){
	translate([0,0,H/2-TP-TP/2]) cylinder(TP, W/2-0.5, W/2-0.5,$fn=100);
} 

module CutCylinder(){
	translate([0,0,-H/2-1]) cylinder(H+1, W/2, W/2,$fn=100);
}

module CutCylinderAngle(){
	difference(){
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH, W/2+TH+H/3,$fn=100);
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH-(TH/1.1), W/2+TH+H/3,$fn=100);
	}
}


// ************* Module part For Square *************	

module BaseSquare(){
	translate([0,0,-H/2]) cylinder(H+TH, W/2+TH*2, W/2+TH*2,$fn=4);
}

module PusherSquare(){
	translate([0,0,H/2-TP-TP/2]) cylinder(TP, W/2-0.5, W/2-0.5,$fn=4);
} 

module CutSquare(){
	translate([0,0,-H/2-1]) cylinder(H+1, W/2, W/2,$fn=4);
}

module CutSquareAngle(){
	difference(){
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH*2, W/2+TH+H/3,$fn=4);
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH*1.5-(TH/1.1), W/2+TH*4+H/3,$fn=4);
	}
}





// ************* Module part For Hex *************	
module BaseHex(){
	translate([0,0,-H/2]) cylinder(H+TH, W/2+TH, W/2+TH,$fn=6);
}

module PusherHex(){
	translate([0,0,H/2-TP-TP/2]) cylinder(TP, W/2-0.5, W/2-0.5,$fn=6);
} 

module CutHex(){
	translate([0,0,-H/2-1]) cylinder(H+1, W/2, W/2,$fn=6);
}

module CutHexAngle(){
	difference(){
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH, W/2+TH+H/3,$fn=6);
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH-(TH/1.1), W/2+TH+H/3,$fn=6);
	}
}



// ************* Module part For Octagonal *************	

module BaseOctagonal(){
	translate([0,0,-H/2]) cylinder(H+TH, W/2+TH, W/2+TH,$fn=8);
}

module PusherOctagonal(){
	translate([0,0,H/2-TP-TP/2]) cylinder(TP, W/2-0.5, W/2-0.5,$fn=8);
} 

module CutOctagonal(){
	translate([0,0,-H/2-1]) cylinder(H+1, W/2, W/2,$fn=8);
}

module CutOctagonalAngle(){
	difference(){
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH, W/2+TH+H/3,$fn=8);
	translate([0,0,-H/2-1]) cylinder(H+TH, W/2+TH-(TH/1.1), W/2+TH+H/3,$fn=8);
	}
}


// ************* Module part For Rectangle *************

module BaseRectangle(){
	translate([0,0,TH/2]) cube ([W+TH*2,L+TH*2,H+TH],center=true);
}

module PusherRectangle(){
	translate([0,0,H/2-TP]) cube ([W-0.5,L-0.5,TP],center=true);
} 

module CutRectangle(){
	translate([0,0,TH/2-1]) cube ([W,L,H+1],center=true);
}

module CutRectangleAngle(){
	difference(){
	translate([0,0,-H/2+-0.5])  linear_extrude(H+TH,scale=2)  square([W+TH*2,L+TH*2],center=true);
	translate([0,0,-H/2+-0.5])  linear_extrude(H+TH,scale=1.5)  square([W+TH,L+TH],center=true);
	}
}



// ************* Module part For RectangleBevel*************	

module BaseRectangleBevel(){
	minkowski(){
		translate([0,0,TH/2-1]) cube ([W+TH*2-20,L+TH*2-20,H+TH-2],center=true);
		cylinder(r=10,2,$fn = RSB);
	}
}

module PusherRectangleBevel(){
	minkowski(){
		translate([0,0,H/2-TP-TP/2+1.5])cube ([W-0.5-20,L-0.5-20,TP-2],center=true);
		cylinder(r=10,2,$fn = RSB);
	}
} 

module CutRectangleBevel(){
	minkowski(){
		translate([0,0,TH/2-2]) cube ([W-20,L-20,H-1],center=true);
		cylinder(r=10,2,$fn = RSB);
	}
}

module CutRectangleBevelAngle(){
	difference(){
			minkowski(){ BaseRectangleBevelAngle1(); cylinder(r=10,2,$fn = RSB);}
			minkowski(){ CutRectangleBevelAngle2(); cylinder(r=10,2,$fn = RSB);}
	}
}

module BaseRectangleBevelAngle1(){
	translate([0,0,-H/2+-0.5])  linear_extrude(H+TH,scale=2) square([W+TH*2-20,L+TH*2-20],center=true);
}

module CutRectangleBevelAngle2(){
	translate([0,0,-H/2+-0.5])  linear_extrude(H+TH,scale=3) square([W+TH-20,L+TH-20],center=true);
}






// ************* Module part For Oval *************

module BaseOval(){
	hull(){
		translate([0,-L/2,-H/2]) cylinder(H+TH, W/2+TH, W/2+TH,$fn=100);
		translate([0,L/2,-H/2]) cylinder(H+TH, W/2+TH, W/2+TH,$fn=100);
	}
}

module PusherOval(){
	hull(){
		translate([0,-L/2,H/2-TP-TP/2]) cylinder(TP, W/2-0.5, W/2-0.5,$fn=100);
		translate([0,L/2,H/2-TP-TP/2]) cylinder(TP, W/2-0.5, W/2-0.5,$fn=100);
	}
} 

module CutOval(){
	hull(){
		translate([0,-L/2,-H/2-1]) cylinder(H+1, W/2, W/2,$fn=100);
		translate([0,L/2,-H/2-1]) cylinder(H+1, W/2, W/2,$fn=100);
	}
}

module CutOvalAngle(){	
	difference(){
		hull(){
			translate([0,-L/2,-H/2-1]) cylinder(H+TH, W/2+TH, W/2+TH+H/3,$fn=100);
			translate([0,L/2,-H/2-1]) cylinder(H+TH, W/2+TH, W/2+TH+H/3,$fn=100);
		}
		hull(){
			translate([0,-L/2,-H/2-1]) cylinder(H+TH, W/2+TH-(TH/1.1), W/2+TH+H/3,$fn=100);
			translate([0,L/2,-H/2-1]) cylinder(H+TH, W/2+TH-(TH/1.1), W/2+TH+H/3,$fn=100);
		}
	}
}



// ************* Module part For Heart *************	

module BaseHeart(){
		translate ([-W/1.7+-TH,-W/1.7+-TH,-H/2]) 
		linear_extrude(H+TH)  
			union (){
			square (W+TH,W+TH);
			translate ([W/2+TH,W+TH,0]) circle(W/2+TH,$fn=100);
			translate ([W+TH,W/2+TH,0]) circle(W/2+TH,$fn=100);
		}
}

module PusherHeart(){
		translate ([-W/1.7+0.5,-W/1.7+0.5,H/2-TP-TP/2]) 
		linear_extrude(TP) union (){
			square (W-1,W-1);
			translate ([(W-1)/2,W-1,0]) circle((W-1)/2,$fn=100);
			translate ([W-1,(W-1)/2,0]) circle((W-1)/2,$fn=100);
		}
} 

module CutHeart(){
		translate ([-W/1.7,-W/1.7,-H/2+-1]) 
		linear_extrude(H+1) union (){
			square (W,W);
			translate ([W/2,W,0]) circle(W/2,$fn=100);
			translate ([W,W/2,0]) circle(W/2,$fn=100);
		}
}


module CutHeartAngle(){	
	difference(){
	translate ([0,0,-H/2-0.1]) linear_extrude(H+TH,scale=2) BaseHeartAngle1();
	translate ([0,0,-H/2-0.1]) linear_extrude(H+TH,scale=1.5)  CutHeartAngle2();
	}
}


module BaseHeartAngle1(){	
		translate ([-W/1.7+-TH,-W/1.7+-TH,0]) 
			union (){
			square (W+TH,W+TH);
			translate ([W/2+TH,W+TH,0]) circle(W/2+TH,$fn=100);
			translate ([W+TH,W/2+TH,0]) circle(W/2+TH,$fn=100);
		}
}


module CutHeartAngle2(){	
		translate ([-W/1.7+-TH/2,-W/1.7+-TH/2,0]) 
			union (){
			square (W+TH/2,W+TH/2);
			translate ([W/2+TH/2,W+TH/2,0]) circle(W/2+TH/2,$fn=100);
			translate ([W+TH/2,W/2+TH/2,0]) circle(W/2+TH/2,$fn=100);
		}
}



// ************* Type part *************

module Type_Part() {
// For the cylinder
	if (Type == "Cylinder"){
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
				BaseCylinder();
				AxisOfPistonCylinderCutBase();
				CutCylinder();
				CutCylinderAngle();
			}
		}else if (PartOfObject  == "Pusher") {
				difference(){
				PusherCylinder();
				AxisOfPistonCylinder();
				}
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}



// For the Square
	}else if (Type == "Square") {
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseSquare();
					AxisOfPistonCylinderCutBase();
					CutSquare();
					CutSquareAngle();
				}
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherSquare();
					AxisOfPistonCylinder();
				}
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}



// For the Hex
	}else if (Type == "Hex") {
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseHex();
					AxisOfPistonCylinderCutBase();
					CutHex();
					CutHexAngle();
				}
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherHex();
					AxisOfPistonCylinder();
				}
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}



// For the Octagonal
	}else if (Type == "Octagonal") {
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseOctagonal();
					AxisOfPistonCylinderCutBase();
					CutOctagonal();
					CutOctagonalAngle();
				}
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherOctagonal();
					AxisOfPistonCylinder();
				}
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}




// For the Rectangle
	}else if (Type == "Rectangle") {
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseRectangle();
					AxisOfPistonCylinderCutBase();
					CutRectangle();
					CutRectangleAngle();
				}				
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherRectangle();
					AxisOfPistonCylinder();
				}
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}

// For the Rectangle Bevel
	}else if (Type == "RectangleBevel") {
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseRectangleBevel();
					AxisOfPistonCylinderCutBase();
					CutRectangleBevel();
					CutRectangleBevelAngle();
				}				
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherRectangleBevel();
					AxisOfPistonCylinder();
				}
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}


// For the Oval
	}else if (Type == "Oval") {
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseOval();
					AxisOfPistonCylinderCutBase();
					CutOval();
					CutOvalAngle();
				}						
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherOval();
					AxisOfPistonCylinder();
				}			
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}



// For the Heart
	}else {// For the Heart
		if (PartOfObject  == "Base"){
				rotate([180,0,0])
				difference(){
					BaseHeart();
					AxisOfPistonCylinderCutBase();
					CutHeart();
					CutHeartAngle();
				}						
		}else if (PartOfObject  == "Pusher") {
				difference(){
					PusherHeart();
					AxisOfPistonCylinder();
				}			
		}else if (PartOfObject  == "Axispusher") {
			AxisOfPistonCylinder();
		}else{//cap
				if (TypeCap == "Sphere"){
					difference(){
						CapPistionSphere();
						AxisOfPistonCylinder();
					}
				}else if (TypeCap == "Cube"){
					difference(){
						CapPistionCube();
						AxisOfPistonCylinder();
					}
				}
		}

	}
}

















