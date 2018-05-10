dice_size=40;
font_size=8;//[6:Small,[8:Medium],[10:Large]

/* [Texts] */
text_front="faire";
text_back="être";
text_left="vouloir";
text_right="pouvoir";
text_top="avoir";
text_bottom="aller";

difference(){
intersection(){
cube(dice_size,center=true);
sphere(r=dice_size/2*1.4,$fa=0.5);
}
for (side=[[[0,0,0],text_top],[[0,180,0],text_bottom],[[90,-90,0],text_front],[[-90,-90,0],text_back],[[90,0,90],text_left],[[90,0,-90],text_right]]){
    rotate(side[0]){
translate([0,0,dice_size/2.1]){
//minkowski(){
    linear_extrude(height = dice_size/20, slices=2){
//        offset(r=-0.17){
            text(side[1], size=dice_size/40*font_size, font = "Liberation Sans", halign="center", valign="center", $fn=30);
        }
//    }
//    rotate([180,0,0]);{
//    cylinder(0.2,0.2,00,$fn=6);
//    }
//    }
}
}
}
}

