/*[Ring Config]*/
//in mm
outer_diameter=55; //[40:140]
ring_thickness=1.4;   //[.2:.1:10]
ring_space=0.6; //[.2:.1:2]
cylinder_diameter=7; //[0:10]
cylinder_sides=6;  //[3:20]
sides=60;
Max_Rings=outer_diameter/((ring_thickness*2)+(ring_space*2));

echo ((ring_thickness*2)+(ring_space*2));
difference(){
    for (i = [outer_diameter:0-((ring_thickness*2)+(ring_space*2)):Max_Rings]) {
        echo (i);
        if (i >= (outer_diameter*0.4)) {
           echo ("fff",outer_diameter*0.4);
           difference(){
               translate([0,0,0])sphere( d=i,$fn=sides); 
               //  if ((i-((ringwall*2)+(ringspace*2)))>start) {
               if (i-((ring_thickness*2)+(ring_space*2)) >= (outer_diameter*0.4)) {
                    translate([0,0,0])sphere( d=(i-(ring_thickness*2)),$fn=sides);
               }
           }    
        }
                 //   rotate([90,0,00])translate([0,0,0]){linear_extrude(3) text(i, font = "Kenteken", size = 50 * 1.2, valign = "center", halign="center");}

        //sphere( d=((outer_diameter/pi)*4+2.5),$fn=sides);
    } 
     translate([-outer_diameter/2,-outer_diameter/2,-outer_diameter-(outer_diameter/5)]){cube(outer_diameter);}
    translate([-outer_diameter/2,-outer_diameter/2,outer_diameter/5]){cube(outer_diameter);}
   // translate([-20,-20,-47]){cube(outer_diameter);}
    translate([0,0,-20]){cylinder( d=cylinder_diameter,h=outer_diameter,$fn=cylinder_sides);}
 //rotate([90,0,00])translate([0,1,19]){linear_extrude(3) #text("R", font = "Kenteken", size = 5 * 1.2, valign = "center", halign="center");}
}

