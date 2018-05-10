
pet_name="NAME"; //Your pet name
phone_number="000-0000000"; //Your phone number
bone_height = 5; //Tag height in mm
font_height=2; //Font height in mm


module t(t){
 translate([-1,(-len(t)*3.8),bone_height])
   rotate([0, 0, 90])
    linear_extrude(height = font_height)
      text(t, 10, $fn = 16);
}
module t2(t){
 translate([-1,(-len(t)*3.8),bone_height])
   rotate([0, 0, 90])
    linear_extrude(height = font_height)
      text(t, 7, $fn = 16);
}



//bone
//left side of bone
translate([-10,-30,0]) 
{
    translate([20,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//right side of bone
translate([-10,30,0]) 
{
    translate([20,0,0]) cylinder(h=bone_height, r=14);
    cylinder(h=bone_height, r=14);
};
//center of bone
translate([-15,-25,0]) cube([30,50,bone_height]);
translate([0,-5,0])
t(pet_name);
translate([11,14,0]) t2(phone_number);

//tag attachment
difference(){
    translate([-16,0,0]) cylinder(r=6, h=bone_height);
    //prevents non-manifold
    translate([-16,0,-1]) cylinder(r=3, h=((bone_height)+2));
}
