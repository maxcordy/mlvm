tolerance = 0.5;

height = 40;
fitHeight = 20;
FitWallThickness = 2;
zTranslate = -height;
radius = 20;
wallThickness = 4;
bendRadius = 60;

convertRadius = 60;

//Stuff to add
//Valves
//Spouts
//Grates
//Open Pipe/Slides
//Rails
// Pipe Scaffold Sipports

//Adds Drop Down box to choose parts in the thingiverse customizer
part = ""; // [Straight:Straight Pipe, Corner:Corner Pipe, Converter:Converter Pipe]

//Idle text for display
module displayIdle(){
    text("Perfect Pipes! 3D Printable Piping", "Liberation Sans");
}
module straightPipe(radius){
    
    
    
    difference(){
        //Lower fit Cylinder subtraction
        difference(){
            //Top Fit Cylinder joining
            union(){
                //Initial Cylinder size
                cylinder(height, radius, radius);
                //Above Cylinder
                cylinder(height+fitHeight, 
                radius-FitWallThickness-tolerance, 
                radius-FitWallThickness-tolerance);
            }
            //Lower Fit cylinder
            translate([0,0,zTranslate]){
            cylinder(fitHeight-zTranslate, 
            radius-FitWallThickness, 
            radius-FitWallThickness);
            }
        }


        //Inner Hole Cylinder subtracts inside from all cylinders
        translate([0,0,zTranslate]){
        cylinder(
            height*height, 
            radius-wallThickness, 
            radius-wallThickness);}
    }
}


module straightPipeNoTopInsert(radius){
    
    difference(){
        //Lower fit Cylinder subtraction
        difference(){
            //Top Fit Cylinder joining

                //Initial Cylinder size
                cylinder(height, radius, radius);

            //Lower Fit cylinder
            translate([0,0,zTranslate]){
            cylinder(fitHeight-zTranslate, 
            radius-FitWallThickness, 
            radius-FitWallThickness);
            }
        }


        //Inner Hole Cylinder subtracts inside from all cylinders
        translate([0,0,zTranslate]){
        cylinder(
            height*height, 
            radius-wallThickness, 
            radius-wallThickness);}
    }
}


module straightPipeNoLowerInsert(radius){
    
    difference(){
            //Top Fit Cylinder joining
            union(){
                //Initial Cylinder size
                cylinder(height, radius,            radius);
                
                //Above Cylinder
                cylinder(height+fitHeight, 
                radius-FitWallThickness-             tolerance, 
                radius-FitWallThickness-             tolerance);
            }

        //Inner Hole Cylinder subtracts inside from all cylinders
        translate([0,0,zTranslate]){
        cylinder(
            height*height, 
            radius-wallThickness, 
            radius-wallThickness);}
    }
}

module rightAnglePipe(){
    
    union(){
        //Lower Pipe Handle 1
        union(){
            translate([bendRadius,-height,0]){
                rotate([-90,0,0]){
                    straightPipeNoTopInsert(radius);
                }
            }
            //Create Hollow torus using 
            intersection(){
                difference(){
                    //Outer Tube
                    rotate_extrude(){
                        translate([bendRadius,0,0]){
                            circle(r = radius);
                        }
                    }
                    //Inner Tube
                    rotate_extrude(){
                        translate([bendRadius,0,0]){
                            circle(
                            r = radius-wallThickness);
                        }
                    }
                }
            //Corner Subtraction
            translate([0,0,-1*bendRadius]){
                cube(bendRadius*2);
                }
            }

        }
        //Pipe Handle 2
        translate([0,bendRadius-.15,0]){
            rotate([90,0,-90]){
            straightPipeNoLowerInsert(radius);
            }
        }
    }
}  






module pipeSizeConverter(radius,convertRadius){
    
    //Top Pipe
    translate([0,0,height]){
        straightPipeNoLowerInsert(convertRadius);
    }
    
    //Middle Converting pipe
    difference(){
        //Outer Pipe
        cylinder(
        height,
        radius,
        convertRadius
        );
        //Hollowing
        translate([0,0,-1]){
            cylinder(
            height+2,
            radius-wallThickness,
            convertRadius-wallThickness
            );
        }
    }
    //lower pipe
    translate([0,0,-height]){
        straightPipeNoTopInsert(radius);
    }
    
}


module renderParts(){
    if (part == "Straight"){
        straightPipe(radius);
    }
    else if(part == "Corner"){
        rightAnglePipe();
    }
    else if(part == "Converter"){ 
        pipeSizeConverter(radius,convertRadius);
    }
    else {
        displayIdle();
    }
}

renderParts();