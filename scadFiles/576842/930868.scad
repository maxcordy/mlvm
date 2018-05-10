baseX=10;//radius of a 3 sided circle.
baseN=3;//number legs on the base star.
baseStretch=10; //stretch of each 3 sided circle on the base star.

iterations=7;// number of stars on each base arm.
teir1Shift=0.35;//multiplier of where to start first iteration of teir1 stars.

teir1X=1;
teir1N=3;
teir1Stretch=6;

//Don't mess with these unless you really know your trig/geometric formulas and you figured out how this code works.
triCircleBase=(baseX*sin(180/baseN)/(sin(60)));
baseRadius=2*(baseStretch*triCircleBase/2+baseX*(cos(180/baseN))+triCircleBase*(cos(180/3))-triCircleBase/2)-baseX*(cos(180/baseN));

//////////////////////////////polyNstar//////////////////////////////////
module polyNstar(x,n,triStretch)
{
triCircle=(x*sin(180/n)/(sin(60)));
trans=triStretch*triCircle/2+x*(cos(180/n))+triCircle*(cos(180/3))-triCircle/2;


union()
{
	rotate([0,0,360/(2*n)])circle(x,$fn=n);

	for(i=[0:n])

	rotate([0,0,i*360/n])translate([trans,0,0])
	scale([triStretch,1,1])
	circle(triCircle,$fn=3);
}
}
/////////////////////////////////////////////////////////////////////////

polyNstar(baseX,baseN,baseStretch);
for(i=[0:baseN])
{
	rotate([0,0,i*360/baseN])

	for(i=[1:iterations])
		translate([i*baseRadius/iterations+teir1Shift*baseRadius,0,0]) 
		//Switch these to try something new.
		polyNstar(teir1X*iterations/i,teir1N,teir1Stretch);
		//polyNstar(teir1X*i/iterations,teir1N,teir1Stretch);
}



