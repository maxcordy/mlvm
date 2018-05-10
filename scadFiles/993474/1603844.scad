
// The part that connects to the upright Delta rail
side_rail_length = 55; //[55:80]
// The part that connects to the Delta crossmember
top_rail_length = 100; //[95:150]
// Radius of the hole for mounting
holeSize=1.5;
// How round the holes are, more sides = more round.
holeSizeSides=20; //[3:30]
// How thick the rails are 
rail_thickness = 3;//[2:5]
// crappy version of wire holes through the corners. 
wire_thickness=4; //[2:5]
// Enable or disable the holes
hole_cutouts=false; //[true,false];
// How wide the bracket mount plate is
rail_width = 20; //[15,20,25,30]
// 30 degree side angle on the 2020 extrusion from the side angle on the top extrusion
rail_angle = 30; 
//translate([0,0,rail_thickness]) cube(size=[rail_width, rail_width*10, rail_width]);
//rotate(a=[270,0,115]) translate([-rail_width,0,rail_thickness]) cube(size=[rail_width, rail_width*10, rail_width]);
module Rail(){
    union (){
        difference (){
        
            rotate(a=[0,90,0])
            rotate(a=[0,0,30]) 
            translate([-top_rail_length + 40,-top_rail_length+40,2]) 
            cube(size=[top_rail_length, top_rail_length * 2, rail_thickness]); //rail support
            
            rotate(a=[0,90,0])
            translate([-top_rail_length * 2,-top_rail_length,1]) 
            cube(size=[top_rail_length * 2, top_rail_length * 3, 5]); //rail support
            
            rotate(a=[0,90,0])
            rotate(a=[0,0,90])
            translate([-top_rail_length * 2 -10,-top_rail_length,1]) 
            cube(size=[top_rail_length * 2, top_rail_length * 3, 5]); //rail support
            
            rotate(a=[270,0,90 + rail_angle]) 
            translate([-rail_width-5,-1,1 ]) 
            cube(size=[rail_width*2, side_rail_length, rail_width]); //rail support cutaway

        if(hole_cutouts){
        //wire cutouts
rotate(a=[45,0,120])
translate([-rail_width/2,1,0 ])
cylinder(h = 40, r1 = wire_thickness, r2 = wire_thickness, center = true, $fn = holeSizeSides);
        }
        
                rotate(a=[270,0,90 + rail_angle]) 
        translate([-rail_width/2,side_rail_length/3,1 ]) 
        cylinder(h = rail_thickness * 2, r1 = holeSize, r2 = holeSize, center = true, $fn = holeSizeSides);
        
        rotate(a=[270,0,90 + rail_angle]) 
        translate([-rail_width/2,side_rail_length/3*2,1 ])
        cylinder(h = rail_thickness * 2, r1 = holeSize, r2 = holeSize, center = true, $fn = holeSizeSides);
                   
        }
        difference () {
        
            translate([0,-rail_width +2,0]) 
            cube(size=[rail_width, top_rail_length, rail_thickness]); //top piece
            
            rotate(a=[270,0,90 + rail_angle]) 
            translate([-rail_width-1 ,-top_rail_length / 2  , 0 ]) 
            cube(size=[rail_width*2, top_rail_length, rail_width]); //top piece cutaway
                        
            rotate(a=[0,0,65])
     translate([-15,-36.5,-0.01]) 1
            cube(size=[rail_width*2, rail_width, rail_thickness + .02]); //top piece 
            
            
        translate([rail_width/2,top_rail_length/3 * 2,1 ]) 
        cylinder(h = rail_thickness * 2, r1 = holeSize, r2 = holeSize, center = true, $fn = holeSizeSides); // top holes
        

        translate([rail_width/2,top_rail_length/3,1 ])
        cylinder(h = rail_thickness * 2, r1 = holeSize, r2 = holeSize, center = true, $fn = holeSizeSides); // top holes

            
            if(hole_cutouts){
            //wire cutouts
            rotate(a=[45,0,120])
            translate([-rail_width/2,1,0 ])
            cylinder(h = 40, r1 = wire_thickness, r2 = wire_thickness, center = true, $fn = holeSizeSides);}
            
            

        }
        
    difference(){
        
        rotate(a=[270,0,90 + rail_angle]) 
        translate([-rail_width,-rail_thickness,0 ]) 
        cube(size=[rail_width, side_rail_length, rail_thickness]); //side rail
        
        

        if(hole_cutouts){
            //wire cutouts
            rotate(a=[45,0,120])
            translate([-rail_width/2,1,0 ])
            cylinder(h = 40, r1 = wire_thickness, r2 = wire_thickness, center = true, $fn = holeSizeSides);
            }
            
                    rotate(a=[270,0,90 + rail_angle]) 
        translate([-rail_width/2,side_rail_length/3,1 ]) 
        cylinder(h = rail_thickness * 2, r1 = holeSize, r2 = holeSize, center = true, $fn = holeSizeSides);
        
        rotate(a=[270,0,90 + rail_angle]) 
        translate([-rail_width/2,side_rail_length/3*2,1 ])
        cylinder(h = rail_thickness * 2, r1 = holeSize, r2 = holeSize, center = true, $fn = holeSizeSides);
    }
}
};

Rail();