//drill press chuck removal tool
//all measurements are in inches

//4 gauge steel or aluminum


diam=.325; //rounds and hole
length=4.5; //full length of the tool  
height=1; //total height 

scale([25.4,25.4])
difference(){
    hull(){    
        circle(d=diam, center=true, $fn=100);
        translate([length-diam,0]) circle(d=diam, center=true, $fn=100);
        translate([0,height-diam]) circle(d=diam, center=true, $fn=100);
        translate([(2*length/4.5)-diam,height-diam]) circle(d=diam, center=true, $fn=100);
    }
    translate([height-diam,(height-diam)/2]) circle(d=diam, center=true, $fn=100);
}