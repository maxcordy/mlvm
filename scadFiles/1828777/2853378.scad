inner_hole = 6; // [3:8]
outer_hole=10; // [3:14]
distance_between_holes=11; // [10:13]
pattern_density=20; // [15:40]
lenght_of_holder=20; //[22:41]

module cup_base(){
union(){
    difference(){
    sphere(d=50, $fn=150);
    cylinder(30,60,60);
    };

    translate([0,0,0]){
    cylinder(10,25,25, $fn=150);
    };

    difference(){
    translate([0,0,10])
    rotate([0,0,0]){
        rotate_extrude($fn=100)
        translate([22.6,0,0])
            circle(2.4, $fn=150);
        };
    };
}
}

module cup_hole(){
for( i = [1:inner_hole]){
    rotate((360/inner_hole)*i, [0,0,1])
    translate( [6,0,0] )
    cylinder(50,1.5,1.5, center=true, $fn=250);
} 
}

module cup_hole2(){
for( i = [1:outer_hole]){
    rotate((360/outer_hole)*i, [0,0,1])
    translate( [distance_between_holes,0,0] )
    cylinder(50,1.5,1.5, center=true, $fn=250);
} 
}

module handle(){
    translate([30,0,7])
    rotate([0,90,0]){
            cylinder(15,2.5,2.5, center=    true, $fn=150);};
    }

module pattern_handle(){
translate([0,0,7])
rotate([90,90,90]){
    for(r=[0:(360/pattern_density):360]){
        rotate([0,0,r])
        linear_extrude(height=lenght_of_holder, twist=180, center=true)
        translate([3,0,10])
        circle(0.8, $fn=150);
    };
};
}

module handle_edge_cylinder(){
    translate([0,0,7])
    rotate([0,90,0]){
            cylinder(15,3.2,3.2, center=    true, $fn=150);};
    }    
    
module handle_edge(){
    union(){
    translate([0,0,7])
    rotate([90,90,90]){
        for(r=[0:(360/pattern_density):360]){
        rotate([0,0,r])
        linear_extrude(height=4, twist=45, center=true)
        translate([4,0,10])
        circle(1.5, $fn=15);
        };
        };
    
        };
    translate([0,0,7])
    rotate([0,90,0]){       
        cylinder(4,3.4,3.4, center=true);
        };
}


difference(){
    cup_base();
    sphere(d=42, $fn=150);
    cylinder(15,21,21, $fn=150);
    translate([0,0,-40]){
        cylinder(50,1.5,1.5, center=    true, $fn=150);   
    };
    translate([0,0,-40]){
        cup_hole();
    };
    translate([0,0,-40])
    rotate ([0,0,90]){
        cup_hole2();
    };
}

difference (){
    translate([-32-lenght_of_holder/10,0,0]){   
    pattern_handle();
    };
    
    translate([0,0,3]){
    cylinder(11,25,25, $fn=150);
    };
}

difference (){
    translate([32+lenght_of_holder/10,0,0]){
    pattern_handle();
    };
    
    translate([0,0,3]){
    cylinder(11,25,25, $fn=150);
    };
}


if (lenght_of_holder<=21){
    translate([45.5+lenght_of_holder/38,0,0]){
    handle_edge();
    }
}
if (lenght_of_holder>=30){
    translate([45.5+lenght_of_holder/4.5,0,0]){
    handle_edge();
    }
} else {
    translate([45.5+lenght_of_holder/15,0,0]){
    handle_edge();
    }
}



if (lenght_of_holder<=21){
    translate([-45.5-lenght_of_holder/38,0,0]){
    handle_edge();
    }
}
if (lenght_of_holder>=30){
    translate([-45.5-lenght_of_holder/4.5,0,0]){
    handle_edge();
    }
} else {
    translate([-45.5-lenght_of_holder/15,0,0]){
    handle_edge();
    }
}

/*
difference(){
    translate([0,0,7])
        rotate([0,90,0]){
        cylinder(95,3.4,3.4, center=true);
    };
    translate([0,0,3]){
    cylinder(10,25,25, $fn=150);
    };
}
*/

    
/*
translate([32.5,0,0]){
    handle_edge_cylinder();
}

translate([-32.5,0,0]){
    handle_edge_cylinder();
}
*/


/*
translate([0,0,-20])
rotate([0,0,0]){
    for(r=[0:(360/60):360]){
        rotate([0,0,r])
        linear_extrude(height=30, twist=180)
        translate([25,0,50])
        circle(3, $fn=150);
    };
};
/*
   sphere(d=40, $fn=150);    