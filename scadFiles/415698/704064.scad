// preview[view:south,tiLt:top]
///////////////////////////////////////////////////////////////////////////////
/*[General]*/
overall_length=100;
overall_width=50;
overall_depth=10;
thickness_of_walls=.5;
inset_distance_of_rim=1;
///////////////////////////////////////////////////////////////////////////////
/*[Ports and Buttons]*/
side_charge_port_is_on="bottom";//[top,left,right,bottom,none]
charge_port_y_or_x_position=25;
charge_port_z_position=5;
charge_port_width=5;
charge_port_height=2;
side_aux_port_is_on="top";//[top,left,right,bottom,none]
aux_port_y_or_x_position=15;
aux_port_z_position=5;
aux_port_width=2.5;
side_camera_button_is_on="right";//[top,left,right,bottom,none]
camera_button_y_or_x_position=75;
camera_button_z_position=5;
camera_button_width=5;
camera_button_height=2;
side_volume_button_is_on="left";//[top,left,right,bottom,none]
is_volume_two_buttons="yes";//[no,yes]
volume_button_y_or_x_position=50;
volume_button_z_position=5;
volume_button_width=5;
volume_button_height=2;
distance_between_volume_buttons=1;
side_power_button_is_on="right";//[top,left,right,bottom,none]
power_button_y_or_x_position=30;
power_button_z_position=5;
power_button_width=5;
power_button_height=2;
/////////////////////////////////////////////////////////////////////////////////
/*[Geometry]*/
//Each of the corners of this case are controlled by spheres, these are there measurements
top_of_phone_back_edge_left_x=4;
top_of_phone_back_edge_left_y=4;
top_of_phone_back_edge_left_z=4;
top_of_phone_back_edge_right_x=4;
top_of_phone_back_edge_right_y=4;
top_of_phone_back_edge_right_z=4;
top_of_phone_front_edge_left_x=4;
top_of_phone_front_edge_left_y=4;
top_of_phone_front_edge_left_z=4;
top_of_phone_front_edge_right_x=4;
top_of_phone_front_edge_right_y=4;
top_of_phone_front_edge_right_z=4;
bottom_of_phone_back_edge_right_x=4;
bottom_of_phone_back_edge_right_y=4;
bottom_of_phone_back_edge_right_z=4;
bottom_of_phone_back_edge_left_x=4;
bottom_of_phone_back_edge_left_y=4;
bottom_of_phone_back_edge_left_z=4;
bottom_of_phone_front_edge_right_x=4;
bottom_of_phone_front_edge_right_y=4;
bottom_of_phone_front_edge_right_z=4;
bottom_of_phone_front_edge_left_x=4;
bottom_of_phone_front_edge_left_y=4;
bottom_of_phone_front_edge_left_z=4;
///////////////////////////////////////////////////////////////////////////////////
/*[Hidden]*/
difference(){
	union(){
		hull(){//Outer Shape
			translate([top_of_phone_back_edge_left_x/2,top_of_phone_back_edge_left_y/2,top_of_phone_back_edge_left_z/2]){
				resize([top_of_phone_back_edge_left_x,top_of_phone_back_edge_left_y,top_of_phone_back_edge_left_z]){
					sphere(2,$fn=36);
				}
			}
			translate([top_of_phone_back_edge_right_x/2,overall_width-(top_of_phone_back_edge_right_y/2),top_of_phone_back_edge_right_z/2]){
				resize([top_of_phone_back_edge_right_x,top_of_phone_back_edge_right_y,top_of_phone_back_edge_right_z]){
					sphere(2,$fn=36);
				}
			}
			translate([overall_length-(bottom_of_phone_back_edge_right_x/2),overall_width-(bottom_of_phone_back_edge_right_y/2),bottom_of_phone_back_edge_right_z/2]){
				resize([bottom_of_phone_back_edge_right_x,bottom_of_phone_back_edge_right_y,bottom_of_phone_back_edge_right_z]){
					sphere(2,$fn=36);
				}
			}
			translate([overall_length-(bottom_of_phone_back_edge_left_x/2),bottom_of_phone_back_edge_left_y/2,bottom_of_phone_back_edge_left_z/2]){
				resize([bottom_of_phone_back_edge_left_x,bottom_of_phone_back_edge_left_y,bottom_of_phone_back_edge_left_z]){
					sphere(2,$fn=36);
				}
			}
			translate([top_of_phone_front_edge_left_x/2,top_of_phone_front_edge_left_y/2,overall_depth-(top_of_phone_front_edge_left_z/2)]){
				resize([top_of_phone_front_edge_left_x,top_of_phone_front_edge_left_y,top_of_phone_front_edge_left_z]){
					sphere(2,$fn=36);
				}
			}
			translate([top_of_phone_front_edge_right_x/2,overall_width-(top_of_phone_front_edge_right_y/2),overall_depth-(top_of_phone_front_edge_right_z/2)]){
				resize([top_of_phone_front_edge_right_x,top_of_phone_front_edge_right_y,top_of_phone_front_edge_right_z]){
					sphere(2,$fn=36);
				}
			}
			translate([overall_length-(bottom_of_phone_front_edge_right_x/2),overall_width-(bottom_of_phone_front_edge_right_y/2),overall_depth-(bottom_of_phone_front_edge_right_z/2)]){
				resize([bottom_of_phone_front_edge_right_x,bottom_of_phone_front_edge_right_y,bottom_of_phone_front_edge_right_z]){
					sphere(2,$fn=36);
				}
			}
			translate([overall_length-(bottom_of_phone_front_edge_left_x/2),bottom_of_phone_front_edge_left_y/2,overall_depth-(bottom_of_phone_front_edge_left_z/2)]){
				resize([bottom_of_phone_front_edge_left_x,bottom_of_phone_front_edge_left_y,bottom_of_phone_front_edge_left_z]){
					sphere(2,$fn=36);
				}
			}
		}
	}
	union(){
		hull(){//Inner Shape
			translate([(top_of_phone_back_edge_left_x/2)+thickness_of_walls,(top_of_phone_back_edge_left_y/2)+thickness_of_walls,(top_of_phone_back_edge_left_z/2)+thickness_of_walls]){
				resize([(top_of_phone_back_edge_left_x-thickness_of_walls),(top_of_phone_back_edge_left_y-thickness_of_walls),(top_of_phone_back_edge_left_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Topofthecase,Bottomofthatedge,Leftsideinside
				}
			}
			translate([((0)+((top_of_phone_back_edge_right_x/2)+(thickness_of_walls))),((overall_width)-((top_of_phone_back_edge_right_y/2)+(thickness_of_walls))),((0)+((top_of_phone_back_edge_right_z/2)+(thickness_of_walls)))]){
				resize([(top_of_phone_back_edge_right_x-thickness_of_walls),(top_of_phone_back_edge_right_y-thickness_of_walls),(top_of_phone_back_edge_right_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Topofthecase,Bottomofthatedge,Rightsideinside
				}
			}
			translate([((overall_length)-((bottom_of_phone_back_edge_right_x/2)+(thickness_of_walls))),((overall_width)-((bottom_of_phone_back_edge_right_y/2)+(thickness_of_walls))),((0)+((bottom_of_phone_back_edge_right_z/2)+(thickness_of_walls)))]){
				resize([(bottom_of_phone_back_edge_right_x-thickness_of_walls),(bottom_of_phone_back_edge_right_y-thickness_of_walls),(bottom_of_phone_back_edge_right_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Bottomofthecase,Bottomofthatedge,Rightsideinside
				}
			}
			translate([((overall_length)-((bottom_of_phone_back_edge_left_x/2)+(thickness_of_walls))),((0)+((bottom_of_phone_back_edge_left_y/2)+(thickness_of_walls))),((0)+((bottom_of_phone_back_edge_left_z/2)+(thickness_of_walls)))]){
				resize([(bottom_of_phone_back_edge_left_x-thickness_of_walls),(bottom_of_phone_back_edge_left_y-thickness_of_walls),(bottom_of_phone_back_edge_left_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Bottomofthecase,Bottomofthatedge,Leftsideinside
				}
			}
			translate([((0)+((top_of_phone_front_edge_left_x/2)+(thickness_of_walls))),((0)+((top_of_phone_front_edge_left_y/2)+(thickness_of_walls))),((overall_depth)-((top_of_phone_front_edge_left_z/2)+(thickness_of_walls)))]){
				resize([(top_of_phone_front_edge_left_x-thickness_of_walls),(top_of_phone_front_edge_left_y-thickness_of_walls),(top_of_phone_front_edge_left_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Topofthecase,Topofthatedge,Leftsideinside
				}
			}
			translate([((0)+((top_of_phone_front_edge_right_x/2)+(thickness_of_walls))),((overall_width)-((top_of_phone_front_edge_right_y/2)+(thickness_of_walls))),((overall_depth)-((top_of_phone_front_edge_right_z/2)+(thickness_of_walls)))]){
				resize([(top_of_phone_front_edge_right_x-thickness_of_walls),(top_of_phone_front_edge_right_y-thickness_of_walls),(top_of_phone_front_edge_right_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Topofthecase,Topofthatedge,Rightsideinside
				}
			}
			translate([((overall_length)-((bottom_of_phone_front_edge_right_x/2)+(thickness_of_walls))),((overall_width)-((bottom_of_phone_front_edge_right_y/2)+(thickness_of_walls))),((overall_depth)-((bottom_of_phone_front_edge_right_z/2)+(thickness_of_walls)))]){
				resize([(bottom_of_phone_front_edge_right_x-thickness_of_walls),(bottom_of_phone_front_edge_right_y-thickness_of_walls),(bottom_of_phone_front_edge_right_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Bottomofthecase,Topofthatedge,Rightsideinside
				}
			}
			translate([((overall_length)-((bottom_of_phone_front_edge_left_x/2)+(thickness_of_walls))),((0)+((bottom_of_phone_front_edge_left_y/2)+(thickness_of_walls))),((overall_depth)-((bottom_of_phone_front_edge_left_z/2)+(thickness_of_walls)))]){
				resize([(bottom_of_phone_front_edge_left_x-thickness_of_walls),(bottom_of_phone_front_edge_left_y-thickness_of_walls),(bottom_of_phone_front_edge_left_z-thickness_of_walls)]){
					sphere(2,$fn=36);//Bottomofthecase,Topofthatedge,Leftsideinside
				}
			}
		}
		hull(){//Inner inset_distance_of_rim
			translate([(top_of_phone_front_edge_left_x/2)+(thickness_of_walls+inset_distance_of_rim),(top_of_phone_front_edge_left_y/2)+(thickness_of_walls+inset_distance_of_rim),(overall_depth-(thickness_of_walls*2))]){
				resize([top_of_phone_front_edge_left_x,top_of_phone_front_edge_left_y,10]){
					cylinder((thickness_of_walls),1,$fn=36);//insideofinset_distance_of_rimtopleft
				}
			}
			translate([(top_of_phone_front_edge_right_x/2)+(thickness_of_walls+inset_distance_of_rim),(overall_width-((top_of_phone_front_edge_right_y/2)+(thickness_of_walls+inset_distance_of_rim))),(overall_depth-(thickness_of_walls*2))]){
				resize([top_of_phone_front_edge_right_x,top_of_phone_front_edge_right_y,10]){
					cylinder((thickness_of_walls),1,$fn=36);//insideofinset_distance_of_rimtopright
				}
			}
			translate([(overall_length-((bottom_of_phone_front_edge_right_x/2)+(thickness_of_walls+inset_distance_of_rim))),(overall_width-((bottom_of_phone_front_edge_right_y/2)+(thickness_of_walls+inset_distance_of_rim))),(overall_depth-(thickness_of_walls*2))]){
				resize([bottom_of_phone_front_edge_right_x,bottom_of_phone_front_edge_right_y,10]){
					cylinder((thickness_of_walls),1,$fn=36);//insideofinset_distance_of_rimbottomright
				}
			}
			translate([(overall_length-((bottom_of_phone_front_edge_left_x/2)+(thickness_of_walls+inset_distance_of_rim))),((bottom_of_phone_front_edge_left_y/2)+(thickness_of_walls+inset_distance_of_rim)),(overall_depth-(thickness_of_walls*2))]){
				resize([bottom_of_phone_front_edge_left_x,bottom_of_phone_front_edge_left_y,10]){
					cylinder((thickness_of_walls),1,$fn=36);//insideofinset_distance_of_rimbottomleft
				}
			}
		}
		if(side_charge_port_is_on!="none"){
			if(side_charge_port_is_on=="top"){
				translate([(overall_length-(overall_length*1.1)),(charge_port_y_or_x_position-(charge_port_width/2)),(charge_port_z_position-(charge_port_height/2))]){
					cube([overall_length/5,charge_port_width,charge_port_height]);//ChargeHoleTop
				}
			}
			if(side_charge_port_is_on=="right"){
				translate([(charge_port_y_or_x_position-(charge_port_width/2)),(overall_width-(overall_width/10)),(charge_port_z_position-(charge_port_height/2))]){
					cube([charge_port_width,overall_width/5,charge_port_height]);//ChargingHoleRight
				}
			}
			if(side_charge_port_is_on=="bottom"){
				translate([(overall_length-(overall_length/10)),(charge_port_y_or_x_position-(charge_port_width/2)),(charge_port_z_position-(charge_port_height/2))]){
					cube([overall_length/5,charge_port_width,charge_port_height]);//ChargingHoleBottom
				}
			}
			if(side_charge_port_is_on=="left"){
				translate([(charge_port_y_or_x_position-(charge_port_width/2)),(overall_width-(overall_width*1.1)),(charge_port_z_position-(charge_port_height/2))]){
					cube([charge_port_width,overall_width/5,charge_port_height]);//ChargingHoleLeft
				}
			}
		}
		if(side_aux_port_is_on!="none"){
			if(side_aux_port_is_on=="top"){
				translate([(overall_length-(overall_length*1.1)),aux_port_y_or_x_position,aux_port_z_position]){
					rotate([0,90,0]){
						cylinder(h=overall_length/5,d=aux_port_width,$fn=36);;//AuxilaryHoleTop
					}
				}
			}
			if(side_aux_port_is_on=="right"){
				translate([aux_port_y_or_x_position,(overall_width-(overall_width/10)),aux_port_z_position]){
					rotate([0,90,90]){
						cylinder(h=overall_width/5,d=aux_port_width,$fn=36);//AuxilaryHoleRight
					}
				}
			}
			if(side_aux_port_is_on=="bottom"){
				translate([(overall_length-(overall_length/10)),aux_port_y_or_x_position,aux_port_z_position]){
					rotate([0,90,0]){
						cylinder(h=overall_length/5,d=aux_port_width,$fn=36);//AuxilaryHoleBottom
					}
				}
			}
			if(side_aux_port_is_on=="left"){
				translate([aux_port_y_or_x_position,(overall_width-(overall_width*1.1)),aux_port_z_position]){
					rotate([0,90,90]){
						cylinder(h=overall_width/5,d=aux_port_width,$fn=36);//AuxilaryHoleLeft
					}
				}
			}
		}
		if(side_power_button_is_on!="none"){
			if(side_power_button_is_on=="top"){
				translate([(overall_length-(overall_length*1.1)),(power_button_y_or_x_position-(power_button_width/2)),(power_button_z_position-(power_button_height/2))]){
					cube([overall_length/5,power_button_width,power_button_height]);//PowerHoleTop
				}
			}
			if(side_power_button_is_on=="right"){
				translate([(power_button_y_or_x_position-(power_button_width/2)),(overall_width-(overall_width/10)),(power_button_z_position-(power_button_height/2))]){
					cube([power_button_width,overall_width/5,power_button_height]);//PowerHoleRight
				}
			}
			if(side_power_button_is_on=="bottom"){
				translate([(overall_length-(overall_length/10)),(power_button_y_or_x_position-(power_button_width/2)),(power_button_z_position-(power_button_height/2))]){
					cube([overall_length/5,power_button_width,power_button_height]);//PowerHoleBottom
				}
			}
			if(side_power_button_is_on=="left"){
				translate([(power_button_y_or_x_position-(power_button_width/2)),(overall_width-(overall_width*1.1)),(power_button_z_position-(power_button_height/2))]){
					cube([power_button_width,overall_width/5,power_button_height]);//PowerHoleLeft
				}
			}
		}
		if(side_camera_button_is_on!="none"){
			if(side_camera_button_is_on=="top"){
				translate([(overall_length-(overall_length*1.1)),(camera_button_y_or_x_position-(camera_button_width/2)),(camera_button_z_position-(camera_button_height/2))]){
					cube([overall_length/5,camera_button_width,camera_button_height]);//CameraHoleTop
				}
			}
			if(side_camera_button_is_on=="right"){
				translate([(camera_button_y_or_x_position-(camera_button_width/2)),(overall_width-(overall_width/10)),(camera_button_z_position-(camera_button_height/2))]){
					cube([camera_button_width,overall_width/5,camera_button_height]);//CameraHoleRight
				}
			}
			if(side_camera_button_is_on=="bottom"){
				translate([(overall_length-(overall_length/10)),(camera_button_y_or_x_position-(camera_button_width/2)),(camera_button_z_position-(camera_button_height/2))]){
					cube([overall_length/5,camera_button_width,camera_button_height]);//CameraHoleBottom
				}
			}
			if(side_camera_button_is_on=="left"){
				translate([(camera_button_y_or_x_position-(camera_button_width/2)),(overall_width-(overall_width*1.1)),(camera_button_z_position-(camera_button_height/2))]){
					cube([camera_button_width,overall_width/5,camera_button_height]);//CameraHoleLeft
				}
			}
		}
		if(side_volume_button_is_on!="none"){
			if(side_volume_button_is_on=="top"){
				if(is_volume_two_buttons=="yes"){
					translate([(overall_length-(overall_length*1.1)),volume_button_y_or_x_position-((volume_button_width)+(distance_between_volume_buttons/2)),(volume_button_z_position-(volume_button_height/2))]){
						cube([overall_length/5,volume_button_width,volume_button_height]);//VolumeHoleSplitTop
					}
					translate([(overall_length-(overall_length*1.1)),(((overall_width/100)*volume_button_y_or_x_position)+(distance_between_volume_buttons/2)),(((overall_depth/100)*volume_button_z_position)-(volume_button_height/2))]){
						cube([overall_length/5,volume_button_width,volume_button_height]);//VolumeHoleSplitTop
					}
				}
				if(is_volume_two_buttons=="no"){
					translate([(overall_length-(overall_length*1.1)),(volume_button_y_or_x_position-(volume_button_width/2)),(volume_button_z_position-(volume_button_height/2))]){
						cube([overall_length/5,volume_button_width,volume_button_height]);//VolumeHoleTop
					}
				}
			}
			if(side_volume_button_is_on=="right"){
				if(is_volume_two_buttons=="yes"){
					translate([volume_button_y_or_x_position-((volume_button_width)+(distance_between_volume_buttons/2)),(overall_width-(overall_width/10)),(volume_button_z_position-(volume_button_height/2))]){
						cube([volume_button_width,overall_width/5,volume_button_height]);//VolumeHoleSplitRight
					}
					translate([(volume_button_y_or_x_position+(distance_between_volume_buttons/2)),(overall_width-(overall_width/10)),(volume_button_z_position-(volume_button_height/2))]){
						cube([volume_button_width,overall_width/5,volume_button_height]);//VolumeHoleSplitRight
					}
				}
				if(is_volume_two_buttons=="no"){
					translate([(volume_button_y_or_x_position-(volume_button_width/2)),(overall_width-(overall_width/10)),(volume_button_z_position-(volume_button_height/2))]){
						cube([volume_button_width,overall_width/5,volume_button_height]);//VolumeHoleRight
					}
				}
			}
			if(side_volume_button_is_on=="bottom"){
				if(is_volume_two_buttons=="yes"){
					translate([(overall_length-(overall_length/10)),(volume_button_y_or_x_position-((volume_button_width)+(distance_between_volume_buttons/2))),(volume_button_z_position-(volume_button_height/2))]){
						cube([overall_length/5,volume_button_width,volume_button_height]);//VolumeHoleSplitBottom
					}
					translate([(overall_length-(overall_length/10)),(volume_button_y_or_x_position+(distance_between_volume_buttons/2)),(volume_button_z_position-(volume_button_height/2))]){
						cube([overall_length/5,volume_button_width,volume_button_height]);//VolumeHoleSplitBottom
					}
				}
				if(is_volume_two_buttons=="no"){
					translate([(overall_length-(overall_length/10)),(volume_button_y_or_x_position-(volume_button_width/2)),(volume_button_z_position-(volume_button_height/2))]){
						cube([overall_length/5,volume_button_width,volume_button_height]);//VolumeHoleBottom
					}
				}
			}
			if(side_volume_button_is_on=="left"){
				if(is_volume_two_buttons=="yes"){
					translate([(volume_button_y_or_x_position-((volume_button_width)+(distance_between_volume_buttons/2))),(overall_width-(overall_width*1.1)),(volume_button_z_position-(volume_button_height/2))]){
						cube([volume_button_width,overall_width/5,volume_button_height]);//VolumeHoleSplitLeft
					}
					translate([((volume_button_y_or_x_position)+(distance_between_volume_buttons/2)),(overall_width-(overall_width*1.1)),(volume_button_z_position-(volume_button_height/2))]){
						cube([volume_button_width,overall_width/5,volume_button_height]);
					}
				}
				if(is_volume_two_buttons=="no"){
					translate([(volume_button_y_or_x_position-(volume_button_width/2)),(overall_width-(overall_width*1.1)),(volume_button_z_position-(volume_button_height/2))]){
						cube([volume_button_width,overall_width/5,volume_button_height]);
					}
				}
			}
		}
	}	
}