//Code by Zach K
//July 2015
//makes customizable lego brick sand castle molds

width = 2;//[1,2,3,4,5,6,7,8,9,10]
length = 3;//[1,2,3,4,5,6,7,8,9,10]
//Size of the mold. Small is 3x as large as a lego. Medium is 5x and large is 10x.
size = 5;//[3:Small,5:Medium,10:Large]
module brick(x,y){
    //creates the pegs
    for(i = [1:x]){
        for(j = [1:y]){
            translate([80*(i-1),80*(j-1),0]){
                difference(){
                    cylinder(18,d=54,false);
                    
                    translate([0,0,-3])
                    cylinder(17, d = 50, false);
                    
                    translate([-23,-5,13])
                    linear_extrude(height=4)
                    text("Lego", size = 14, font = "Helvetica:style=Bold Oblique");
                }
            }
        }
    }
    //creates the box
    difference(){
        translate([-43,-43,-96])
        cube([80*x+6, 80*y+6,99],false);
        
        translate([-40,-40,-97])
        cube([80*x,80*y,96],false);
        
        for(i = [1:x]){
            for(j = [1:y]){
                translate([80*(i-1),80*(j-1),-3])
                cylinder(17, d = 50, false);
            }
        }
    }
}
scale(size * 1/10)
brick(width,length);

        