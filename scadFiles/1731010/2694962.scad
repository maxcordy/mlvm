// Olympic Medal Holder
// Neon22  CC-BY-SA
// http://www.thingiverse.com/thing:1731010

// preview[view:north east, tilt:top diagonal]

/* [Medal] */
// Medal diameter (mm) 2016=85
Diameter = 85;      //[20:120]
// Medal thickness (mm) 2016=6
Thickness = 6;      //[2:0.5:12]
// Insertion angle (degrees). Lean towards rear.
Medal_angle = 8;    //[0:20]
// Insertion depth into base
Insertion_depth = 12; //[2:30]
// Slide medal position
Slide = 5;         //[-20:0.5:40]
// Show Medal (not printed)
Show_medal = true;  //[true, false]
/* [Base] */
// Height (mm)
Base_height = 20;   //[6:60]
//Shape of Base
Base_shape = "Round"; //[Round, Rectangle]
// Diameter if Round 
Base_Diameter = 90; //[10:100]
Top_Diameter = 85; //[10:100]
// Dimensions if Rectangular
Rect_Width = 80;    //[10:100]
Rect_Depth = 60;    //[10:100]
// Show Label
Show_text = true;   //[true, false]
// Label
Label = "2016 Olympics";
Extrusion = 2;      //[1:0.5:10]
// Font Height
Label_Height = 8;   //[4:20]
// Slide Label position
Label_slide = 4;   //[-20:0.5:20]

/* [Hidden] */
cyl_res = 80;
Delta = 0.1;
Thin = 0.01;
Roundness = min(Rect_Depth,Rect_Width)/10;


//--------------
module Medal () {
	rotate ([0,90-Medal_angle,0])  
		cylinder(d=Diameter, h=Thickness+Delta, center=true, $fn=cyl_res*3);
	if (Show_medal) {
		%color([0.9,0.7,0])
		rotate ([0,90-Medal_angle,0])  
		cylinder(d=Diameter, h=Thickness+Delta, center=true, $fn=cyl_res*3);
	}
}

module label() {
	linear_extrude(Extrusion+Delta) 
	rotate ([0,0,90])   
		text(Label, valign="center", halign = "center", size=Label_Height);
}

module Base() {
	coinr=Diameter/2;
	if (Base_shape == "Round") {
		difference() { 
			cylinder(d1=Base_Diameter, d2=Top_Diameter,h=Base_height, center=false, $fn=cyl_res*4);
			translate([Thickness-Slide,0,Diameter/2+Base_height-Insertion_depth])
				Medal();
		}
		if (Show_text) {
			translate([Base_Diameter/4-Label_slide,0, Base_height])  
			label();
		}
	} else { // Rectangular
		translate([0,0,Base_height/2]) {
			difference() {
				minkowski() {
					cube([Rect_Depth,Rect_Width,Base_height],center=true); 
					cylinder(d=Roundness, h=Thin, $fn=cyl_res);
				}
				// coin
				translate([Thickness-Slide, 0, Diameter/2+Base_height/2-Insertion_depth])
					Medal();
			}
			// Label
			if (Show_text) {
				translate([Rect_Depth/2-Label_Height-Label_slide, 0, Base_height/2-Delta])
				label();
			}
		}
	}
}


Base();
echo(Roundness);


