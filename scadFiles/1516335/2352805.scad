//vise dimensions
viseLength = 100;
//Jaw Width
jawWidth = 12.7;
//Jaw Depth
jawDepth = 25;
//Desired Part Thickness. Make sure part thickness is greater than magnet size
thickness = 6.35;
faceThickness = 6.35;

//knurl pattern settings
//Angle of knurling
knurlAngle = 45;
//Width of knurling
knurlWidth = 0.5;
//Knurling Depth
knurlDepth = 2;
//Spacing Between Knurls
knurlSpacing = 7;

//v groove size
vGrooveSize = 10;
//Set posotion of V-groove
//Use values between -0.5 and 0.5 groove position is based on overall jaw length
vGroovePosition = -0.4;

//Magnet Options
//Select 0 for square magnets
//Select 1 for cylindrical magnets;
magnetSelect = 0;
//Magnet Dimensions if cylindrical magnets are used
cylinderHeight = 1;
magnetDiameter = 5;
//Dimensions of magnets if cubic magnets are used
magnetSize = 5.1; //oversize magnet hole slightly to ensure close fit
//Spacing Between Magnets
magnetSpacing = 25;


module viseSoftJaws(length, width, thickness, angle, knurl_width, knurl_depth, knurl_spacing, magnet_size, magnet_spacing, v_groove_size){
    //cylinder(h=cylinderHeight, r=magnetDiameter*0.5);
    union(){
    difference(){
    //top that rests on top of vise jaws    
    cube(size = [length, width, thickness], center=true);
 
    space = length*0.5 - magnet_spacing;    
    
    
        
    //for loop for magnets
    for (i = [-space:magnet_spacing:space]){    
        if (magnetSelect == 0){
        translate([i, 0, thickness-magnetSize])
        {
        
        
        cube(size = [magnet_size, magnet_size, magnet_size],center = true);
        }
        }
        
        
        if (magnetSelect == 1){
            translate([i,0, thickness*0.5-cylinderHeight]){
              
        cylinder(h = cylinderHeight, r=magnetDiameter*0.5);
        
        }
        }
    
    }
    }
    //Jaw side walls
    translate([0.5*(length+thickness), thickness*0.5, jawDepth*0.5-thickness*0.5]){
    cube(size = [thickness, thickness+width, jawDepth], center = true);
    }
    translate([-0.5*(length+thickness), thickness*0.5, jawDepth*0.5-thickness*0.5]){
    cube(size = [thickness, thickness+width, jawDepth], center = true);
    }
    }
    //jaws gripping face
    translate([0, 0.5*(width+thickness), thickness]){
    rotate([90,0,0]){
    difference(){
    difference(){
        //jaw gripping face
        translate([0,jawDepth*0.5-thickness*1.5,0]){
        cube(size = [length, jawDepth, faceThickness], center=true);
        }
        //for loop to create gripping knurl pattern
        for (a = [-viseLength:knurl_spacing:viseLength]){
        
            translate([0,a,-3]){
                rotate([0, 0,knurlAngle]){ 
                    cube(size = [1000, knurl_width, knurl_depth], center = true);    
                    }
                 rotate([0,0,-knurlAngle]){
                    cube(size = [1000, knurl_width, knurl_depth], center = true);
                }   
                }
                
            }
        
    
    }
    //v groove for holding round stock
    translate([-length*vGroovePosition,0,-v_groove_size*0.5]){
        rotate([0,45,0]){
            cube(size = [v_groove_size, 2*jawDepth, v_groove_size], center = true);
        }
        }
    }
    }
    }
    

}


viseSoftJaws(viseLength, jawWidth, thickness, knurlAngle, knurlWidth, knurlDepth, knurlSpacing, magnetSize, magnetSpacing, vGrooveSize, $fn = 100);
//create 2nd Vise Jaw by mirroring original part
translate([0,viseLength*0.5, 0]){
mirror([0,1,0]){
    
    viseSoftJaws(viseLength, jawWidth, thickness, knurlAngle, knurlWidth, knurlDepth, knurlSpacing, magnetSize, magnetSpacing, vGrooveSize, $fn = 100);

}
}