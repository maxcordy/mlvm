
/*[Object parameters]*/
//Width
ObjectWidth=280;
//Length
ObjectLenght=400;
//Depth
ObjectH=4.5;

//Displacement of object from the tip of the stand
ObjectLoffset=17;

//Displacement of object from the top of the stand
ObjectHdifference=12;

//Object Tilt (90 is vertical)
ObjectA=100;

ObjectS=[ObjectWidth,ObjectLenght,ObjectH];

/*[Stand Parameters]*/
//Total Length of the stand
VLenght=160;
//Arms width of the stand
VArmWidth=12;
//Maximum Stand Height
VHeight=25;
//Edge smoothing
Smooth=5;
//Select if you want to use angle value or total stand width value
method="width";// [width:Use total stand width,angle:Use V angle]
//Total stand width, only if selected
VWidth=50;
//V angle, only if selected
VAngle=35;

//Declining angle
angleBack=5;

if (method=="width")
        stand(ObjectS,
                ObjectA,
                ObjectHdifference,
                ObjectLoffset,
                fixedDelta(VWidth-VArmWidth,VArmWidth,VLenght),
                angleBack,
                VLenght,
                VArmWidth,
                VHeight,
                Smooth);
if (method=="angle")
       stand(ObjectS,
                ObjectA,
                ObjectHdifference,
                ObjectLoffset,
                VAngle,
                angleBack,
                VLenght,
                VArmWidth,
                VHeight,
                Smooth);

//function to determine the angle so that the V has a fixed size (between midpoints of arms). x= size to set, w = width of arms, l = length of V.
function fixedDelta(x,w,l) = atan((x+w/2)/l);
module stand(ObjectS,ObjectA,ObjectHdifference,ObjectLoffset,angleV,angleBack,length,armW,maxHeight,smooth){
    translate([0,smooth,smooth]){
    minkowski(){
    difference(){
        taperedV(angleV,angleBack,length-smooth*2,armW-smooth*2,maxHeight-smooth*2,smooth);
        translate([0,length-ObjectLoffset,maxHeight-ObjectHdifference-smooth])
        rotate([ObjectA,0,0]) 
            translate([0,ObjectS[1]/2,ObjectS[2]/2])
        cube([ObjectS[0]+2*smooth,ObjectS[1]+2*smooth,ObjectS[2]+2*smooth], center=true);
    }
    sphere(r=smooth);
    }
    %translate([0,length-ObjectLoffset,maxHeight-ObjectHdifference-smooth])
        rotate([ObjectA,0,0]) 
            translate([0,ObjectS[1]/2,ObjectS[2]/2])
        %cube(ObjectS, center=true);
}
}




module v(angle,length, armW){
    width=armW/sin(angle);
polygon([
			[0,0],
			[length*tan(angle),length],
			[length*tan(angle)-width,length],
			[0,width/tan(angle)],
			[-length*tan(angle)+width,length],
			[-length*tan(angle),length]
		]);
}

module taperedV(a1,a2, length, w, maxh){
    difference(){
        linear_extrude(height = maxh)
            v(a1,length,w);
        //translate[]
        cubeS=2*max(length,length*sin(a1)*2);
        translate([0,0,maxh-cubeS/2*sin(a2)])
        rotate([a2,0,0])
        translate([0,0,cubeS/2])
            cube(cubeS, center=true);
    }
    
}