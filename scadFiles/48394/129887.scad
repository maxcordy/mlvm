dia=10000;
sections=10000;
union(){
for(i=[(-sections/2): sections/2])
{
color("MediumBlue")translate([(i*(dia/sections)),sqrt(dia/2-(i*i)), 0])
cube([dia/sections,2*sqrt(dia/2-(i*i)),2*sqrt(dia/2-(i*i))], center=true);
}}