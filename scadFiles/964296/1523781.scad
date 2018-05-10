// of cards
number = 52;

feetSize = 10;
feetWidth = 10;

// of card
height = 92;

// of card
width = 60;

// angle
fan = 35;

// beyond necessity
boxExtension = 10;

module cardHolder() {
    translate([0,0,fannedHeight/2])
    rotate([90,0,0])
    difference() {
        translate ([-(fannedWidth+2)/2,-fannedHeight/2,-(number/2+2)/2])
        cube ([fannedWidth+2,box,number/2+2]);
        translate([0,2,0])
        linear_extrude(center=true, height=number/2 ,twist=fan, slices=100)
        rotate([0,0,fan/2])
        square ([width,height],center=true);
    }
    translate([-(fannedWidth+2)/2,-(number/2+2+feetSize*2)/2,0])
    cube([feetWidth,number/2+2+feetSize*2,1]);
    translate([(fannedWidth+2)/2-feetWidth,-(number/2+2+feetSize*2)/2,0])
    cube([feetWidth,number/2+2+feetSize*2,1]);
}

module cards() {
    translate([0,0,fannedHeight/2])
    rotate([90,0,0])
    translate([0,2,0])
    linear_extrude(center=true, height=number/2 ,twist=fan, slices=100)
    rotate([0,0,fan/2])
    square ([width,height],center=true);
    
}
$fn=90;

// ; height
box = (width*sin(fan/2)+4)+boxExtension;
fannedWidth = width*cos(fan/2)+height*sin(fan/2);
fannedHeight = width*sin(fan/2)+height*cos(fan/2);

cardHolder();
%cards();