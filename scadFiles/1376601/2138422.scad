//Basic definition:
//Higher number = more faces = smoother model = slower processing.
$fn=50; 

//Case definition: 6.5x55 Swedish Mauser
//Base diameter of casing/rim 
d0=12.2; 
//Rim thickness 0=no rim
h0=0; 
//Base diameter of casing (above rim). Set d1=d0 if no rim.
d1=12.2; 
//Height from base to start of neckdown
h1=43.49;  
//Diameter before neckdown
d2=11.04; 
//Height from base to end of neckdown
h2=47.13;  
//Diameter after neckdown
d3=7.6; 
//Height from base to mouth
h3=55;  
//Diameter at case mouth
d4=7.52; 
//Totalt height
h4=80;  
//Bullet diameter
d5=6.71; 

//Case scaling to allow oversized/fired cases
casescaling=1.01; 

//Block definition:
//Total number of cases you want
noOfCases=20;
//No of rows in the Y direction.
Rows=4;  
//Thickness of material outside hole
rim=3;  
//Total height of the block.
height=50;  
//Bottom thickness below round.
bottomthickness=2; 
//Height of locking pins 0=no pin. Minimum 4 rows is needed to have pins.
pinheight=2;  
//Marking text first row.
markingtext1="6.5";  
//Second row. Singel row if this is "". " " will give you a second empty row.
markingtext2="55"; 
//Chamfer distance of the hole 0=no chamfer
holechamfer=0.5;  
//Chamfer distance of the outside edge 0=no chamfer.
outerchamfer=1;  
//Bullet down in the holder if set to 1. Base of the case down if set to 0.
bulletdown=1; 
//Set to 1 if you want to see the round in the holder and a demo bullet is shown. Set to 0 before you render.
showrounds=1; 


module case(xpos,ypos,zpos,chamfer){
    if(bulletdown){
        if(chamfer){
            translate([xpos,ypos,height])
                rotate_extrude(convexity=10)
                    translate([holediameter*0.3,0,0])
                        circle(holediameter*0.2+holechamfer,$fn=4);
        }
        translate([xpos,ypos,zpos+casescaling*h4])
        rotate([180,0,0])
        scale([casescaling,casescaling,casescaling]){
            translate([0,0,0])
                cylinder(h=h0, d1=d0,d2=d0);
            translate([0,0,h0])
                cylinder(h=h1-h0, d1=d1,d2=d2);
            translate([0,0,h1])
                cylinder(h=h2-h1, d1=d2,d2=d3);
            translate([0,0,h2])
                cylinder(h=h3-h2, d1=d3,d2=d4);
            translate([0,0,h3])
                cylinder(h=h4-h3, d1=d4,d2=d4);
                    //resize(newsize=[d5,d5,(h4-h3)*2])
                    //sphere(d=d5);
        }
    }else{
        translate([xpos,ypos,zpos])
        scale([casescaling,casescaling,casescaling]){
            translate([0,0,0])
                cylinder(h=h0, d1=d0,d2=d0);
            translate([0,0,h0])
                cylinder(h=h1-h0, d1=d1,d2=d2);
            translate([0,0,h1])
                cylinder(h=h2-h1, d1=d2,d2=d3);
            translate([0,0,h2])
                cylinder(h=h3-h2, d1=d3,d2=d4);
            translate([0,0,h3])
                 resize(newsize=[d5,d5,(h4-h3)*2])
                 sphere(d=d5);
        }
    }
}

module corner(xpos,ypos,height,cornerradius,outerchamfer){
    translate([xpos,ypos,0])
    difference(){
      cylinder(h=height,r=cornerradius);
      translate([0,0,height])
         rotate_extrude(convexity=10)
             translate([cornerradius,0,0])
                circle(outerchamfer,$fn=4);  
     rotate_extrude(convexity=10)
         translate([cornerradius,0,0])
            circle(outerchamfer,$fn=4);  
    }   
}

module hole(xpos,ypos,zpos){
    translate([xpos,ypos,zpos]){
        cylinder(h=height,d=holediameter);
        translate([0,0,depth])
            rotate_extrude(convexity=10)
                translate([holediameter/2,0,0])
                    circle(holechamfer,$fn=4);
    }
}

module exttext(textrow,xpos,zpos,textsize){
translate([xpos,0.5,zpos])
    rotate(a=[90,0,0])
        linear_extrude(height = 5)
            text(textrow, font = "Liberation Sans:style=Bold", size=textsize, halign="center");
}

function offset(rows)=(rows>1)?0:xoffset/2;

depth=height-bottomthickness;  //Seating dept of round in block. 
casesperrow=noOfCases/Rows; //No of cases in X direction. 

holediameter=d0*casescaling;
xoffset=holediameter+rim;
yoffset=xoffset*0.866;//Sqrt(3)/2=cos(30deg)
cornerradius=holediameter/2+rim;
xpin=(rim+xoffset-holediameter/2)/2;

x=xoffset*(casesperrow-0.5)+holediameter+2*rim-2*cornerradius;
y=yoffset*(Rows-1)+holediameter+2*rim-2*cornerradius;
textheight=(height-outerchamfer);
textcenter=((casesperrow-0.5)*xoffset-offset(Rows)+holediameter)/2+rim;

difference(){

    hull()
    translate([cornerradius,cornerradius,0]){
        corner(0,0,height,cornerradius,outerchamfer);
        corner(0,y,height,cornerradius,outerchamfer);
        corner(x-offset(Rows),0,height,cornerradius,outerchamfer);
        corner(x-offset(Rows),y,height,cornerradius,outerchamfer);
    }
 
    translate([holediameter/2+rim,holediameter/2+rim,0]){
        for(i=[0:casesperrow-1]){
            for(j=[0:Rows-1]){
               if(bulletdown){
                   case((i+(j/2-floor(j/2)))*xoffset,j*yoffset,bottomthickness,holechamfer>0);
               }else{
                   hole((i+(j/2-floor(j/2)))*xoffset,j*yoffset,bottomthickness);
               } 
            }
        }
    }
    if(Rows>3){
        translate([xpin,holediameter/2+rim,-0.5]){
            translate([0,yoffset,0]) cylinder(h=pinheight+1,d=xpin+0.1);
            translate([xoffset*casesperrow,yoffset*(floor((Rows-2)/2)*2),0]) cylinder(h=pinheight+1,d=xpin+0.1);
        }
    }

    if(markingtext2>""){
        exttext(markingtext1,textcenter,textheight*0.55,textheight*0.35);
        exttext(markingtext2,textcenter,textheight*0.1,textheight*0.35);

    }else{
        exttext(markingtext1,textcenter,textheight*0.1,textheight*0.8);
    }
}


if(Rows>3){
    translate([xpin,holediameter/2+rim,height]){
        translate([0,yoffset,0]) cylinder(h=pinheight,d=xpin);
        translate([xoffset*casesperrow,yoffset*(floor((Rows-2)/2)*2),0]) cylinder(h=pinheight,d=xpin);
    }
}
    

if(showrounds){
     case(-holediameter/2-rim,0,0,false);
     %translate([holediameter/2+rim,holediameter/2+rim,0]){
        for(i=[0:casesperrow-1]){
            for(j=[0:Rows-1]){
               if(bulletdown){
                   case((i+(j/2-floor(j/2)))*xoffset,j*yoffset,bottomthickness,false);
               }else{
                   case((i+(j/2-floor(j/2)))*xoffset,j*yoffset,bottomthickness,false);
               } 
            }
        }
    }   
}