//Height of the 4 corner cylinders (mm)
cylinder_height=20; //[10:1:50]
//Lower diameter of the corner cylinders (mm)
lower_cylinder_diameter=25; //[10:1:30]
//Upper diameter of the corner cylinders (mm)
upper_cylinder_diameter=20; //[10:1:30]
//Size of the support structure (mm)
support_size=6; //[4:0.5:10]
//Length and width of the total assembly from center of corners
assembly_size=100; //[50:5:150]


Created by Standards Electronics, please do not modify.


use <write.scad>

difference(){
union (){
translate ([assembly_size/2,assembly_size/2,cylinder_height/2]) cylinder (h=cylinder_height, d1=lower_cylinder_diameter, d2=upper_cylinder_diameter, $fn=20, center=true);
translate ([assembly_size/2,-assembly_size/2,cylinder_height/2]) cylinder (h=cylinder_height, d1=lower_cylinder_diameter, d2=upper_cylinder_diameter, $fn=20, center=true);
translate ([-assembly_size/2,assembly_size/2,cylinder_height/2]) cylinder (h=cylinder_height, d1=lower_cylinder_diameter, d2=upper_cylinder_diameter, $fn=20, center=true);
translate ([-assembly_size/2,-assembly_size/2,cylinder_height/2]) cylinder (h=cylinder_height, d1=lower_cylinder_diameter, d2=upper_cylinder_diameter, $fn=20, center=true);
translate ([-assembly_size/2, 0, support_size/2]) cube ([support_size,assembly_size,support_size], center=true);
translate ([assembly_size/2, 0, support_size/2]) cube ([support_size,assembly_size,support_size], center=true);
translate ([0, assembly_size/2, support_size/2]) cube ([assembly_size,support_size,support_size], center=true);
translate ([0, -assembly_size/2, support_size/2]) cube ([assembly_size,support_size,support_size], center=true);
translate ([0,0,support_size/2]) rotate ([0,0,45]) cube ([assembly_size+(assembly_size/2),support_size,support_size], center=true);
translate ([0,0,support_size/2]) rotate ([0,0,-45]) cube ([assembly_size+(assembly_size/2),support_size,support_size], center=true);
translate ([-support_size,-support_size,0]) cube ([support_size*2,support_size*2,support_size]);
translate ([0,0,support_size]) writecube ("STANDARDS ELECTRONICS", [0,0,0], h=support_size/2, t=.5, face="top", rotate=[0,0,45], space=1.5);
}
translate ([(assembly_size/2)-(support_size/1.5),0,support_size/2]) rotate ([0,0,45]) cylinder (h=support_size, d=support_size, center=true);
translate ([-(assembly_size/2)+(support_size/1.5),0,support_size/2]) rotate ([0,0,45]) cylinder (h=support_size, d=support_size, center=true);
translate ([0,(assembly_size/2)-(support_size/1.5),support_size/2]) rotate ([0,0,45]) cylinder (h=support_size, d=support_size, center=true);
translate ([0,-(assembly_size/2)+(support_size/1.5),support_size/2]) rotate ([0,0,45]) cylinder (h=support_size, d=support_size, center=true);
}