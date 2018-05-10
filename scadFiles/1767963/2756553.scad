Height=50; //
X=40; //
Y=20; //
A=17.2;

C=11.48;

Borediameter=5;
Nutdiameter=3;
Nutscrewdiameter=5.5;
difference() {
        
    cube([(X+20),(Y+20),Height+3],center=true);
    translate([0,0,-3])
    cube([X,Y,Height+3],center=true);
    translate([0,0,0])
    cylinder(h=(Height+3)/2,r1=Borediameter/2,r2=Borediameter/2,$fn=100);
    translate([((((X+20)-X)/4)+(X/2)),((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    translate([-((((X+20)-X)/4)+(X/2)),((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    translate([((((X+20)-X)/4)+(X/2)),-((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    translate([-((((X+20)-X)/4)+(X/2)),-((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)])
    cylinder(h=Height+3,r1=Nutdiameter/2,r2=Nutdiameter/2,$fn=100);
    
    
    translate([((((X+20)-X)/4)+(X/2)),((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    translate([-((((X+20)-X)/4)+(X/2)),((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    translate([((((X+20)-X)/4)+(X/2)),-((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    translate([-((((X+20)-X)/4)+(X/2)),-((((Y+20)-Y)/4)+(Y/2)),-((Height+3)/2)+10])
    cylinder(h=Height+3,r1=Nutscrewdiameter/2,r2=Nutscrewdiameter/2,$fn=100);
    
    translate([-A/2,Y/2,-((Height+3)/2)])

    cube(size = [A,10000,C], center = false);
}
