//filament guide clip


use<8bitArt.scad>; //@ http://www.thingiverse.com/thing:251582

//$fa=3;
//$fs=.5;

tableThickness=15;

//rotate([90,0,0])
difference(){
	roundedSquare(s=[36,tableThickness+4,15],r=3);

	translate([-8.5,0,0])
		roundedSquare(s=[15,tableThickness,15.2],r=1);

	translate([1,-tableThickness/2,-17.5]){
		cube([20,tableThickness,35]); //table mockup ;)
		%cube([20,tableThickness,35]); //table mockup ;)
	}

	translate([-8.5,0,0]) rotate([90,0,0])
		cylinder(r=5,h=tableThickness+4.2,center=true,$fs=.5);

	translate([-17.6,0,0]) rotate ([90,90,90])
		newPixel("__*_____*__ ___*___*___ __*******__ __*__*__*__ _**__*__**_ *********** *_*******_* *_*_____*_* ___**_**___",[12,9],[.8,.8,.8],1.1,true);
}


module roundedSquare(s = [10,10,10], r = 1){
	hull(){
		for (x=[-s[0]/2+r,s[0]/2-r])
			for (y=[-s[1]/2+r,s[1]/2-r])
				translate([x,y,0])
				cylinder(r=r,h=s[2],center=true,$fs=.5);
	}

	//cube(s,center=true);
}