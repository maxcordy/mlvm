
// Adjust the thickness of the piece
height=2; // min/max: [2:50]

//// RENDER



//// MODULES


module board_holder (lenght, width, height) {
     union () {           
        cube([lenght,width,height]);
        cube([width,lenght,height]);
     }


    translate ([0,0,height+10]) {
        union () {           
            cube([lenght,width,height]);
            cube([width,lenght,height]);
         }
     }
    union () {        
        translate ([0,0,height])
        cube ([lenght,height,height+10]);
        translate ([0,0,height])
        cube ([height,lenght,height+10]);
    }
}

module bottom (radius, size) {
    $fn=100;
    translate ([radius+5,radius+5,-size]){
        difference () {
            cylinder (r=radius,h=size);
            cylinder (r=radius-2,h=height);
        }
    }
}
