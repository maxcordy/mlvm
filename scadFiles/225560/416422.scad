// variable description
Phone_W_Input = 65; // 60 to 75mm
Phone_T_Input = 9.5; // 5 to 17mm

W_Shift = Phone_W_Input - 65;
T_Shift = Phone_T_Input - 9.5;

union(){
	translate([0,-40,0])import("openSCAD1.stl", convexity = 5);

	if (W_Shift <= 0){
		translate([23+W_Shift,-40,0])import("openSCAD2.stl", convexity = 5);
	}

	if (W_Shift > 0){
		translate([23,-40,0])import("openSCAD2.stl", convexity = 5);
		translate([23+W_Shift,-40,0])import("openSCAD2.stl", convexity = 5);
	}

	translate([33+W_Shift,-40,0])import("openSCAD3.stl", convexity = 5);
}

union(){
	translate([-60,-40,0])import("openSCAD4.stl", convexity = 5);

	if (T_Shift > 0){
		translate([-60,-40,3])import("openSCAD5.stl", convexity = 5);
	}

	translate([-60,-40,T_Shift])import("openSCAD6.stl", convexity = 5);
}
