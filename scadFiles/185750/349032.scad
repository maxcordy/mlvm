include <write.scad>
board_x=70;
board_y=70;
thickness=2;
gap=.5;
bone_width=5;
text_height=5;
/*what to make*/
make_board=1;
make_bone1=1;
make_bone2=1;
make_bone3=1;
make_bone4=1;
make_bone5=1;
make_bone6=1;
make_bone7=1;
make_bone8=1;
make_bone9=1;


text_spacing=(board_y-thickness*2)/9;

x=0;
translate([0,0,0])bones_1();
x=1;
translate([(thickness+bone_width)*x,0,0])bones_2();
x=2;
translate([(thickness+bone_width)*x,0,0])bones_2();


module board(){
	union(){
		difference(){
			translate([0,-gap,0])cube([board_x,board_y+gap*2,thickness*3]);
			translate([bone_width+thickness,thickness-gap,thickness])cube([board_x-2*thickness-bone_width,gap*2+board_y-thickness*2,thickness*3]);
			translate([thickness,thickness-gap,2*thickness])cube([board_x-2*thickness,board_y-thickness*2+gap*2,thickness*3]);
			}
		translate([thickness+bone_width/2,thickness+text_spacing*8.5,3*thickness/2])write("1",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*7.5,3*thickness/2])write("2",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*6.5,3*thickness/2])write("3",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*5.5,3*thickness/2])write("4",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*4.5,3*thickness/2])write("5",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*3.5,3*thickness/2])write("6",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*2.5,3*thickness/2])write("7",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*1.5,3*thickness/2])write("8",h=text_height,center=true,t=thickness*3);
		translate([thickness+bone_width/2,thickness+text_spacing*.5,3*thickness/2])write("9",h=text_height,center=true,t=thickness*3);
	}
}

module bones_1(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("1",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("2",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("3",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("4",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("5",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("6",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("7",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("8",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("9",h=text_height,center=true,t=thickness*2);
	}
}

module bones_2(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("2",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("4",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("6",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("8",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}

module bones_3(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("3",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("6",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("9",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("7",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}


module bones_4(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("4",h=text_height,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("8",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*6.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*6.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}

module bones_5(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("5",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*7.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*7.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*6.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*6.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}

module bones_6(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("6",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*7.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*7.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*6.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*6.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}

module bones_7(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("7",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*7.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*7.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*6.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*6.25,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("9",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}

module bones_8(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("8",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*7.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*7.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*6.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*6.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("0",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("7",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}

module bones_9(){
	union(){
		cube([bone_width,board_y-thickness*2,thickness]);
		translate([bone_width/2,text_spacing*8.5,thickness])write("9",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*7.75,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*7.25,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*7.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*6.75,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*6.25,thickness])write("7",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*6.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*5.75,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*5.25,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*5.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*4.75,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*4.25,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*4.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*3.75,thickness])write("5",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*3.25,thickness])write("4",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*3.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*2.75,thickness])write("6",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*2.25,thickness])write("3",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*2.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*1.75,thickness])write("7",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*1.25,thickness])write("2",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*1.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
		translate([(3/4)*bone_width/2,text_spacing*0.75,thickness])write("8",h=text_height*0.6,center=true,t=thickness*2);
		translate([(3/2)*bone_width/2,text_spacing*0.25,thickness])write("1",h=text_height*0.6,center=true,t=thickness*2);
		translate([bone_width/2,text_spacing*0.5,thickness])write("/",h=text_height,center=true,t=thickness*2);
	}
}