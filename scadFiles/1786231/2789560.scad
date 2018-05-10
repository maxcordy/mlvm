spherediam=55;
ringwall=2;
ringspace=1.5;
cylinderdiam=4;
cylinderdpth=40;
sides=50;
start=45;
end=12;

pi=3.141592653589793238;
//translate([0,0,0])sphere( d=((spherediam)),$fn=sides);

//translate([0,0,0])
echo (start);
echo ((ringwall*2)+(ringspace*2));
difference(){
    for (i = [spherediam:0-((ringwall*2)+(ringspace*2)):start]) {
    //    echo
        difference(){
            translate([0,0,0])sphere( d=i,$fn=sides);
            translate([0,0,0])sphere( d=(i-(ringwall*2)),$fn=sides);
        }
                 //   rotate([90,0,00])translate([0,0,0]){linear_extrude(3) text(i, font = "Kenteken", size = 50 * 1.2, valign = "center", halign="center");}

       // sphere( d=((spherediam/pi)*4+2.5),$fn=sides);
    } 
    translate([-spherediam/2,-spherediam/2,-spherediam-(spherediam/5)]){cube(spherediam);}
    translate([-spherediam/2,-spherediam/2,spherediam/5]){#cube(spherediam);}
   // translate([-20,-20,-47]){cube(spherediam);}
   // translate([0,0,-20]){cylinder( d=cylinderdiam,h=cylinderdpth,$fn=6);}
 //rotate([90,0,00])translate([0,1,19]){linear_extrude(3) #text("R", font = "Kenteken", size = 5 * 1.2, valign = "center", halign="center");}
}

