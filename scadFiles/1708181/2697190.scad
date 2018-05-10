part = "both"; // [first:Mold Only,second:Stencil Only,both:Mold and Stencil]

/* [Parameters] */
// Load a 100x100 pixel image. (images will be automatically stretched to fit) Simple, high contrast images like logos work best.
Image = "image-surface.dat"; // [image_surface:100x100]
//Length of the sides of the square actuator
Side_Length = 50; //[1:100]
//Thickness of the first layer of silicone (Having different thicknesses on the layer will create varying effects)
Layer_1_Height = 4; //[1:4]
//Thickness of the second layer of silicone (Having different thicknesses on the layer will create varying effects)
Layer_2_Height = 4; //[1:4]

/* [Hidden] */
height = Layer_2_Height;
tolerance = .3;
thickness = height*2;
scaleFactor = Side_Length/100;
Layer_1_Height_2 = Layer_1_Height;
Layer_2_Height_2 = Layer_2_Height;

print_part();

module print_part() {
	if (part == "first") {
		mold();
	} else if (part == "second") {
		stencil();
	} else if (part == "both") {
		both();
	} else {
		both();
	}
}

module both() {
    mold();
    stencil();
}


module stencil() {
    translate([0,0,Layer_1_Height+Layer_2_Height+23]) {

        scale([scaleFactor,scaleFactor,1]) {
            difference() {
                scale([1.01,1.01,thickness]) {
                    surface(file=Image, center=true, convexity=5);
                }
 
                translate([0,0,-(height)]) {
                    cube([135,135,2*thickness],center=true);
                }
            }
        }
    }
}


module mold() {
    difference() {
        difference() {
            translate([0,0,(Layer_1_Height+Layer_2_Height+3)/2]) {
                cube([Side_Length+10,Side_Length+10,Layer_1_Height+Layer_2_Height+3], center = true);
            }
            translate([0,0,Layer_1_Height+3]) {
                translate([0,0,(Layer_2_Height_2)/2]) {
                    cube([Side_Length+tolerance,Side_Length+tolerance,Layer_2_Height_2], center = true);
                }
            }
        }

        translate([0,0,3]) {
            translate([0,0,(Layer_1_Height_2)/2]) {
                cube([Side_Length-2,Side_Length-2,Layer_1_Height_2], center = true);
            }
        }
    }
}