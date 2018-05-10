use <parametric_star.scad>
use <build_plate.scad>
use <honeycomb.scad>
use <estrella.scad>
use <write/write.scad>

//TEXTO
text= "";
text1= "";

    //PARAMETROS ESTRELLA
//N: Numero de puntas
N=5;

    //PARAMETROS DE RELLENO
//Tipo de relleno
sides = 30; //[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (30-sided)]
//Radio Relleno
r= 5; //[4:22]
//Espesor Relleno
th=1;

//MEDIDAS CAJETEADO
ancho = 42;
alto= 12;
posicion= 2; //(alto/posicion)
//MEDIDAS CAJETEADO 2
ancho2 = 35;
alto2= 11;
posicion2= 10;


module estrella_bien()
{
union(){    
intersection(){
                parametric_star(N,1,25,50);
                honeycomb(200,100,3,r,1,th,sides);
              }
estrella(N,1,25,50);
        }
}

union(){
difference(){
    estrella_bien();
    translate([(alto/posicion),-(ancho/2),0])
    cube([alto,ancho,1]);
    translate([-5,-(ancho2/2),0])
    cube([alto2,ancho2,1]);
 
            }       
                rotate([0,0,270])
                translate([0,((alto/posicion)+5.5),0.4])
                write(text, t=0.5, h= 10, center=true);
                //BASE    
                translate([(alto/posicion),-(ancho/2),0])
                color("red")cube([1,ancho,0.5]);
                //LADO DCHA
                translate([(alto/posicion),-(ancho/2),0])
                color("blue")cube([alto,1,0.5]);
                //ARRIBA
                translate([(alto+(alto/posicion)),-(ancho/2),0])
                color("black")cube([1,ancho,0.5]);
                //LADO IZQDA
                translate([(alto/posicion),(ancho/2),0])
                color("white")cube([(alto+1),1,0.5]);

                
    //TEXTO 2///////////////////////////////////////////////
                rotate([0,0,270])
                translate([0,0,0.4])
                write(text1, t=0.5, h= 10, center=true);
                //BASE    
                translate([-5,-(ancho2/2),0])
                color("grey")cube([1,ancho2,0.5]);
                //LADO DCHA
                translate([-5,-(ancho2/2),0])
                color("orange")cube([alto2,1,0.5]);
                //ARRIBA
                translate([(-5+alto2),-(ancho2/2),0])
                color("green")cube([1,ancho2,0.5]);
                //LADO IZQDA
                translate([-5,(ancho2-(ancho2/2)),0])
                color("pink")cube([(alto2+1),1,0.5]);

}