use <MCAD/fonts.scad>

thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];

Name="Det";


theseIndicies=search(Name,thisFont[2],1,1);
module main(TEXT);
{
difference(){
import ("C:/Program Files/OpenSCAD/hallo.stl");
; 
translate ( 0,-10,-150);
   
for( j=[0:(len(theseIndicies)-1)] ) translate([-30+j*x_shift,10+y_shift/2]) {
     
linear_extrude(height=2.0) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);}}}
main(Name);
