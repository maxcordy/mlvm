length=25;
width=11.8;
height=21;
mountlength=32.2;
mountwidth=1.7;
heightofmount=15.65;

//screws for the servo
mountscrewholes=2;
mountscrewholeslength=5;


$fn=100;

//vars for the carraige mounting hole
mountingholediameter=10; 
mountingholelength=14.5; //better for this to be smaller than larger. Make it easier to clamp.
lengthfromcarriagetoservo=37; // rough number around the hotend point ( bottom of carriage mounting hole to bottom of servo)

// screw for washer and fitting to mount to carriage
mountingboltdiameter=5;
mountingboltlength=8;

holecenteroffset = (length/2)+((mountlength/2)-(length/2))/2;

module servo(){

difference(){
	 union(){
		//servo
		cube([length,width,height], center=true);
		//servo mount
		translate([0,0,heightofmount]/2) cube([mountlength,width,mountwidth], center=true);
	};
	
	//screw holes
	mirror([0,1,0]) translate([holecenteroffset,0,heightofmount/2]) cylinder(d=2, h=mountwidth, center=true);
	translate([holecenteroffset,0,heightofmount/2]) cylinder(d=2, h=mountwidth, center=true);

};
}

//servo
% rotate([0,90,0]) servo();

difference(){

union(){

//mounting pole
 translate([0,0,(lengthfromcarriagetoservo/2)+(mountingholelength/2)]) cylinder(d=mountingholediameter,h=mountingholelength,center=true);


//servo mounting cylinder
difference(){
difference(){
cylinder(d=width+width*0.4,h=lengthfromcarriagetoservo,center=true);
rotate([0,90,0]) servo();

}


//screw holes

union(){
translate([(heightofmount/2),0,holecenteroffset]) rotate([0,90,0]) cylinder(d=mountscrewholes+0.01,h=mountscrewholeslength*2,center=true);

mirror([0,0,1]) translate([(heightofmount/2),0,holecenteroffset]) rotate([0,90,0]) cylinder(d=mountscrewholes+0.01,h=mountscrewholeslength*2,center=true);
}

}

}

translate([0,0,(lengthfromcarriagetoservo/2)+(mountingholelength/2)])  cylinder(d=mountingboltdiameter,h=mountingboltlength);

}



