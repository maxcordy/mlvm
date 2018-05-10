//Version 2
//Evelyn Boettcher
topd=105; //Top Flange diameter
toph=11; //Top Flange Height
topid=70; //Top Flange inner diameter
btmid=45; //btmid
fth=2;
gid=48;
god=69.75;
gth=4;

//funnel();
pressadpter();
//gaskethlder();
//TopFlg();
module gaskethlder(){
 $fn=75;

 difference(){
   union(){
     difference(){
        cylinder(d=god+2,h=gth+1, center=true);
        translate([0,0,1]) cylinder(d=god,h=gth,center=true);
     }   
   cylinder(d=gid,h=gth+1, center=true);
 }
 cylinder(d=gid-2,h=7, center=true);
 }}

module pressadpter(){
   translate([0,0,toph/2]) TopFlg();  
   funnel();
   color("blue") translate([0,0,-4-(gth+1)/2+.1]) rotate([180,0,0])gaskethlder();
}
module TopFlg(){
    difference(){      
    intersection(){
        cylinder(d1=topid+37,d2=topd+5,h=toph,$fn=6, center=true);
        cylinder(d1=topid+3,d2=topd+1,h=toph,$fn=75, center=true);
              }
        cylinder(d=topid, h=toph+2, $fn=80, center=true);
         translate([0,0,toph/2]) rotate([0,90,30])cylinder(d=3,h=topid+37,center=true,$fn=40);
              
}}

module funnel(){
    hh=4;
    translate([0,0,-hh/2])
    difference(){
        cylinder(d2=topid+3, d1=god+2,h=hh, center=true, $fn=75);
          cylinder(d2=topid, d1=gid-2,h=hh, center=true, $fn=75);
    
    }
}
