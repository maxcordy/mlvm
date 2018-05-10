//Yet another utility blade holder (YAUBH)
//by Khairulmizam Samsudin, Sept 2016
//xource@gmail.com
//"yaubh" is licenced under Creative Commons :
//Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
//http://creativecommons.org/licenses/by-nc-sa/4.0/

//UPDATES:
//05/09/2016 - Released

/* [Options] */
// preview[view:south, tilt:top]
// Blade thickness. Adjust to obtain smooth deployment of blade
Blade_thickness = 0.6; // [0.4:1.2]
// Tolerance for blade width. Adjust to reduce cutout width and obtain snug fit
Blade_width_tolerance = 1; // [0:5]
// Option for left handed user
Left_handed_user = 0; // [0:No,1:Yes]


/* [Hidden] */
bladeT=Blade_thickness;
left=Left_handed_user;

epsilon=0.1;
holderT=bladeT+5;
//blade
bL1=33;
bL2=64;
bW=20-Blade_width_tolerance;
notchL=3;
notchW=3;
tabL=3.5;

diff=(bL2-bL1)/2;
holderL1=bL1+diff;
holderL2=bL2+diff;
hnotchX=holderL1/2-diff+notchL/2+notchL;
hedgeR=3;//5;//4; - remove pin
hpinD=2.5;//2; //1.75mm filament
hpinR=hpinD/2;
hdepth=holderT/4; //frame cutout depth
hbottomT=holderT/2+hdepth;
htopT=holderT-hbottomT;
bopenX=tabL/2+notchL/2+hnotchX;
bcloseX=-diff/2;
bZ=hbottomT/2-bladeT/2-hdepth;
//frame cut
fcW=1;
fcL=18; //fixme. need to minus -notchL-tabL
//holder clip
hclipL=10;
hclipW=hedgeR;
hclipT=htopT;
hclipRotX=30;//20;
hclipY1=-bW/2;
hclipX1=holderL1/3;
hclipX2=-hclipX1-hedgeR;
hclipX3=-fcL/1.5;
hclipX4=+hclipX1+diff-hedgeR/1.5;
//jimping
jcR=1;
jcH=10;
jcY=bW/2+hedgeR;
jcX1=bL1+jcR*1;            
jcX2=bL1-jcR*2;            
jcX3=bL1-jcR*2-jcR*3;            
jcX4=bL1-jcR*2-jcR*3-jcR*3;            

module trapezoid(L1,L2,W,T,type=1,R=0) {
    //used for blade
    if (type==1) {
        p=[[L2/2,-W/2],[-L2/2,-W/2],[-L1/2,W/2],[L1/2,W/2]];
        translate([0,0,-T/2]) linear_extrude(height=T) polygon(p);
    //used for holder
    } else if (type==2) {
        cover_tip=13;
        p=[[L1/2-diff+cover_tip,-W/2],[-L2/2,-W/2],[-L1/2,W/2],[L1/2+cover_tip,W/2]];
        if (R !=0) {    
        hull() {
                for (loc = [0:3]) {
                    translate([p[loc][0],p[loc][1],-T/2]) cylinder(r=R,h=T,$fn=20);
                }
            }
            //loca=0;
            //translate([p[loca][0],p[loca][1],-T/2]) #cylinder(r=R,h=T*2,$fn=20);
        } else {
            translate([0,0,-T/2]) linear_extrude(height=T) polygon(p);
        }
    }
}

module blade(T=bladeT,notch=0) {
    difference() {
        trapezoid(bL1,bL2,bW,T);
        //notch
        if (notch) {
            translate([notchL/2+tabL/2,bW/2-notchW/2,0]) cube([notchL,notchW+epsilon,T+epsilon],center=true);
            translate([-notchL/2-tabL/2,bW/2-notchW/2,0]) cube([notchL,notchW+epsilon,T+epsilon],center=true);
        }
    }
}


module handlec(T,e=0) {
    translate ([-bL1/6,-notchW/4,0]) scale([0.4,0.4,1]) trapezoid(bL1,bL2,bW-e,T+epsilon,type=2,R=hedgeR-e);
    translate ([-bL1/2,-notchW/4,0]) scale([0.4,0.4,1]) trapezoid(bL1,bL2,bW-e,T+epsilon,type=2,R=hedgeR-e);
}


module jimpc() {
    translate([jcX1,jcY,0]) rotate([0,0,90]) cylinder(r=jcR,h=jcH,$fn=20,center=true);
    translate([jcX2,jcY,0]) rotate([0,0,90]) cylinder(r=jcR,h=jcH,$fn=20,center=true);
    translate([jcX3,jcY,0]) rotate([0,0,90]) cylinder(r=jcR,h=jcH,$fn=20,center=true);
    translate([jcX4,jcY,0]) rotate([0,0,90]) cylinder(r=jcR,h=jcH,$fn=20,center=true);
}
//holder clip
module clip(L=hclipL,e=0) {
    difference() {
        translate([-L/2,-hclipW-epsilon/2,-hclipT/2-epsilon/2]) cube([L,hclipW*2,hclipT+e]);
        rotate([-hclipRotX,0,0]) translate([-L/2-epsilon/2,0,-hclipT]) cube([L+epsilon,hclipW*2,hclipT*3]);  
    }
}

module hclip(Z=0,e=0) {
    translate([hclipX1,hclipY1,Z]) clip(e=e);
    translate([hclipX2,hclipY1,Z]) clip(e=e);
    mirror([0,1,0]) translate([hclipX3,hclipY1,Z]) clip(e=e);
    mirror([0,1,0]) translate([hclipX4,hclipY1,Z]) clip(L=hclipL*1.5, e=e);
}

module holder(T=holderT/2,e=0,jimping=1,clip=0) {
    difference() {
        //trapezoid(holderL1,holderL2,bW,bladeT,type=2);
        trapezoid(holderL1,holderL2,bW,T,type=2,R=hedgeR+e);
        //holder clip cutout
        if (clip==2) {hclip(Z=0,e=epsilon); }
    
        //handle cutout
        handlec(T,e=e);
    
        //jimping
        if (jimping) jimpc();
    }
    //holder clip
    if (clip==1) {
        difference() {    
            hclipZ=hbottomT/2+htopT/2;
            hclip(Z=hclipZ);
            //jimping
            jimpc();
        }
    }
}

module bhframe(opennotch=1,bladecut=1,e=0,jimping=1,clip=0) {
    difference() {
        holder(T=hbottomT+e,e=e,jimping=jimping,clip=clip);
        //blade cutout
        bcT=bladeT+hdepth+epsilon;
        bcZ=hbottomT/2-bcT/2+epsilon/2;
        if (bladecut) {
            //blade close and open position
            translate([bcloseX,0,bcZ]) blade(notch=0,T=bcT+epsilon);
            translate([bopenX,0,bcZ]) blade(notch=0,T=bcT+epsilon);
            //blade access
            translate([bopenX+bL1,0,bcZ]) blade(notch=1,T=bcT+epsilon);
        }
     
    }
}
//bottom holder - additional hdepth recessed
module bholder() {
    difference() {
        bhframe(clip=1);

        //frame cut
        translate([hnotchX,bW/2-notchW/2,holderT/2-hbottomT/2]) union() {
            translate([-fcL/2-notchL/2,-fcW/2+notchW/2,0]) cube([fcL,fcW,10],center=true); 
            //two catch
            //c1L=notchL*2+tabL+fcW*2;
            //only catch1 i.e. one notch
            c1L=notchL+fcW;            
            c1W=notchW+fcW;
            //two catch
            //c1X=c1L/2-notchL/2-fcW;
            c1X=c1L/2-notchL-tabL+fcW;
            c1Y=-fcW/2;
            //only catch2 i.e. one notch
            c3L=notchL+tabL;
            c3W=notchW;
            c3X=c1X-c1L/2-c3L/2+notchW+tabL;
            c3Y=-c3W/2+fcW/2;
            difference() {
                //catch1 plate
                // translate([c1X,c1Y,0]) cube([c1L,c1W,10],center=true);
                //longer plate
                translate([c1X,c1Y,0]) cube([c1L+notchL+tabL,c1W,10],center=true);
            //    translate([c3X,c3Y,0]) cube([c3L,c3W,11], center=true);
            }
            
            c2W=notchW+hedgeR+fcW+epsilon;
            c2L=fcW;
            c2X=-c2L/2+c1L/2+c1L/2-notchL/2;
            c2Y=c2W/2+c1Y-c1W/2;
            translate([c2X,c2Y,0]) cube([c2L,c2W,10], center=true);
        }
        //frame lock stress reliever
        hsrR=1;
        hsrY=bW/2+hedgeR/2;
        hsrX=hnotchX-fcL-hsrR;    
        hsrZ=hbottomT/2;
        translate([hsrX,hsrY,hsrZ]) rotate([90,0,0]) cylinder(r=hsrR,h=10,center=true,$fn=20);
            
    }
    //catch
    translate([hnotchX,bW/2-notchW/2,-hdepth/2]) union() { 
        //catch1
        cube([notchL,notchW,hbottomT-hdepth],center=true);
        //catch2
        //translate([tabL+notchL,0,0]) cube([notchL,notchW,hbottomT-hdepth],center=true);
            
        //bottom index finger plate
        tpL=tabL+notchL*2;
        translate([-tabL/2-notchL/2,0,-bladeT/2]) cube([tpL,notchW,hbottomT-hdepth-bladeT],center=true);
        //top index finger plate
        tpL=tabL+notchL*2;
        translate([-tabL/2-notchL/2,notchW/2+hedgeR/2,holderT/2-(hbottomT-hdepth)/2]) difference() {
            cube([tpL,hedgeR,holderT],center=true);
            //translate([0,0,hedgeR/2]) rotate([90,0,0]) cylinder(r=1,h=hedgeR*2,$fn=20,center=true);
            //translate([tpL/2,0,hedgeR/2]) rotate([90,0,0]) cylinder(r=1,h=hedgeR*2,$fn=20,center=true);
            //translate([-tpL/2,0,hedgeR/2]) rotate([90,0,0]) cylinder(r=1,h=hedgeR*2,$fn=20,center=true);
        }
    }
    
    
}
module bg() {
    difference() {
        bhframe(opennotch=0,bladecut=0);
        bhframe(opennotch=0,bladecut=1,e=epsilon);
    }
}


//top holder - additional hdepth raised
module tholder() {
    difference() {
        holder(T=htopT,clip=2);
        //index finger plate cut
        c1L=notchL*2+tabL+fcW*2;
        translate([notchL+tabL-fcW,bW/2-notchW/2,holderT/2-hbottomT/2])
        translate([c1L/2-notchL/2,hedgeR/2+notchW/2,0]) cube([c1L,hedgeR+epsilon,10],center=true);
        
    }
    
    
    
    //blade clamp
    bgT=hdepth;
    bgZ=-bgT/2-bgT;
    translate([0,0,-htopT/2]) difference() {
        translate([0,0,-hbottomT/2]) bhframe(opennotch=0,bladecut=0,jimping=0);
        translate([0,0,-hbottomT/2]) bhframe(opennotch=0,bladecut=1,e=epsilon,jimping=0);
        translate([0,0,bgZ]) cube([bL2*2,bL2,bgT],center=true);
    }    
}

debug=0;
if (debug) {
        tholder();
        translate([0,0,-10]) bholder();
} else {
    tholderZ = (left==0) ? htopT/2-hbottomT/2 : -htopT/2+hbottomT/2;
    rotX = (left==0) ? 0 : 180;
    rotate ([rotX,0,0]) {
        translate([0,40,tholderZ]) mirror([0,0,left]) rotate([180,0,0]) tholder();
        translate([0,0,0]) mirror([0,0,left]) bholder();
    //translate([bcloseX,0,bZ]) %blade(notch=1);
    translate([bopenX,0,bZ]) %blade(notch=1);
}
}
