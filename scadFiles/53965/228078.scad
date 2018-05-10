/*    
yegahD - yru's exstruder
Copyright (C) 2012  Michał Liberda (yru)


    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

contact me on zephyru.com or yru@o2.pl
see videos on yru2501 yt channel

thanks for heavy testing goes to Krzysztof Dymianiuk - mojreprap.pl

before you make any changes take into cosideration this is a work in progress and team work makes it better so cotact me with any good ideas or code instead off making another subversion of deriveration of inspiration of whatever type thing on thingiverse for example (excluding just variable values manipulation). let's stick to http://www.reprap.org/wiki/Yegah for code mods for this one! 

i do encourage to put stl's and linkback to reprap.org wherever you like. 

to do:
- general cleanup
done:
- screw tuner
- abs printed one part hinge - springloaded - idea droped in and tested in YRUDS by Krzysztof

choose gears as you see fit, i use GregFrost's great script - http://www.thingiverse.com/thing:3575

I wrote it fom scratch and it's hard to say it was derived from anything. Still it's just fair to say I was greatly inspired by Wade's and Greg's work:
http://www.thingiverse.com/thing:8252
http://www.thingiverse.com/thing:1794

*/

// preview[view:north, tilt:top diagonal]
//user serviceable vars

//clock wise bolt - mirror 
cwbolt=1;
//type of mount - reprap style foot mount - wade's stepstruder drop in replacement
ftype=0; //[0:mendel,1:BiBone,2:golemD]
//foot mount holes distance
fmd=50;
hmdist=fmd+8*ftype;
//toof mh offset
fmo=0;
hfxtr=25-10*ftype;
//foot central hole diameter - 0 for none
fch=3.5;
//foot central hole head diameter - 0 for none
fchh=6.5*0;
//standard side jh mount holes
jhm=1;
//extra side mount holes
ehm=0;

//mendel presets
//stepper mount options - horizontal offset
engoff=-6; 
//stepper mount Z offset
engoffz=-10; 
//stepper mount thickness 
engmt=8; 
//stepper angle
engang=10;

//see filament path in cross section
inspect=0; //[0,1]
//see axes in cs
csaxes=0; //[0,1]
//show mockups
showmu=1; //[0,1]

//attack gear mockup dia
attmd=15; 
//reciever gear mockup dia
recmd=78;

// JH16 wall thickness - directly impacts offset from side mount
jhwal=3; 

//main axis elevation
drvele=15;
//drive roll params -  filament diameter
fild=3.2;
//drive roller diameter - not grove diameter
roldia=9.22;
//as above with filament on one side 
rolfil=11.34;
//drive roller eat in
tdep=0.6; 
//main bearing diameter
mbdia=13.2+.4; 
//main bearing thickness
mbth=5; 
//main general quality
msthns=43;
//bearign brace wall
bbw=3.5; 

//abs hinge config - cut offset for abs hinge
cutof=5.8-.2; 
//abs hinge elevation
absele=10; 
//gap size
abscw=2.5; 
//abs hinge diam
absdd=3;
//wal abs spring
abshw=2.65; 
//wal abs link2spring
absdw=4.5; 
//upper wall
absdwB=20.;


//idler vars  - idler screw nut size (measure the actual screw's largest dimension for press fit)
idlernut=8.2;
//idler nut heigth
idlernuh=4;
//idler axis diameter - use ca. 0.5 lower value for threaded plastic version
idlerrod=4.;
//idler diameter at grove
idlerd=22; 
//idler grove depth
idlgrv=0.45;
//idler arm thickness
idarmt=6;
//idler brace wall
ibbw=3.7;
//idler general quality
isthns=23;

//j-head mount options -  main diameter
jhdia=16;
//j-head len
jhlen=25;
//j-head grove from end spacing
jhgrvs=5;
//j-head screw diameter
jhmsd=3.4;
//j-head screw head diameter
jhmshd=6.2;
//j-head screw head n/o sides - make a nut slot with 6
jhmshdsides=6;
//jh elevation
jhele=-6; 

//base mount wall
bbmwal=3;
//foot base enwide (cuting shapes)
fben=-1;
//foot mount nut dia
fmbnd=8;
//foot mount bolt dia
fmbd=4.4;
gcm_ele=1;
engmul=-1; 

//filament guide vars - ptfe insert outer diameter
guideinsert=5;
//fg wall thickness
guidewal=5;

//---------------------

mshift=0;
mshifty=4;
gcm_ele=1;
//below not cleaned up vars
//filament guide build in
fguide=1;
idlerdpr=2;
//eng mount vars
sspac=31.5; 



//------------------internal vars-------------------
absch=drvele+mbdia*3;
gtot=(guideinsert+guidewal);
//spring screw dia
sscdia=4; 
//wall
sscw=4;
//spring enwidening
sscew=1.8;
//spring mount extra elev / steep angle cancelation
sscc=6;
//spring preasure point offset
psof=2;
mntsp=25;
//filament center from end of body - bearing edge
fcfe=3; 
//tested for 25
bases=25-4; 
moubr=bases+jhdia/2+fcfe+jhwal;
bspacing=bases-(5+5)/2;
filgap=0; 
rolo=roldia/2+(rolfil-roldia)-tdep;
filof=rolo-(fild/2); 
beard=mbdia+0.2;
rolgrv=roldia-(rolfil-fild);
iaoff=idlerd/2+roldia/2+fild-rolgrv-idlgrv;//idler axis offset
faoff=roldia/2+fild/2-rolgrv;//fil center axis offset
xwal=3.5;
xiwal=0;

filgele=-1; //filament guide elev calib
filgyoff=2;
filgzoff=2;


ptfbe=-3.4; //reciever ptfe inset -3.4 for flat



mirror([cwbolt,0,0])
rotate([90,0,0]) intersection(){ difference(){ union(){

translate([0,-bases/2+engmt/2,0]){ //eng mount---------------------------------------------------------------------------------

hull(){ //upper single arm
translate([0,-0/2,drvele+2]) rotate([90,0,0]) cylinder(center=true,r=(beard)/2+bbw-2,h=engmt);

translate([engmul*(engoff+46),0,engoffz+24.5]) rotate([0,engmul*engang,0]) 
translate([-engmul*sspac/2+mshifty/1.5,0,sspac/2+mshift/2]) 
rotate([90,0,0]) cylinder(center=true,r=3.2,h=engmt);
}

hull(){ //single brace
for(i=[1,-1])  translate([engmul*(engoff+46),0,engoffz+24.5]) rotate([0,engmul*engang,0]) 
translate([-engmul*sspac/2+mshifty/2*i,0,sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=5.2,h=engmt);
}

hull(){ //lower double arm
for(i=[1,-1]) translate([engmul*(engoff+46),0,engoffz+24.5]) rotate([0,engmul*engang,0]){ 
translate([-engmul*sspac/2+mshifty/2*i,0,-sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=5.2,h=engmt);
translate([engmul*sspac/2-mshifty/2*i,0,-sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=5.2,h=engmt);
}}

hull(){ //lower double fore arm
translate([0,0,5]) rotate([90,0,0]) cylinder(center=true,r=6,h=engmt);
for(i=[1,-1]) translate([engmul*(engoff+46),0,engoffz+24.5]) rotate([0,engmul*engang,0]){ 
translate([-engmul*sspac/2+mshifty/2*i,0,-sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=5.2,h=engmt);
}}

if(ftype==1||ftype==0){  
translate([0,0,0])  //base arm link
hull(){
for(i=[1]) translate([engmul*(engoff+46),0,engoffz+24.5]) rotate([0,engmul*engang,0]){ 
translate([-engmul*sspac/2+mshifty/2*i,0,-sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=3.2,h=engmt);
}
translate([hfxtr-hmdist+10,0,-drvele+2]) rotate([90,0,0]) cylinder(r=3/2,h=engmt+0,center=true,$fn=23);
}}

hull(){ //lower reinforcement
translate([0,-0/2,drvele+2]) rotate([90,0,0]) cylinder(center=true,r=(beard)/2+bbw-2,h=engmt);

for(i=[1]) translate([engmul*(engoff+46),0,engoffz+24.5]) rotate([0,engmul*engang,0]){ 
translate([-engmul*sspac/2+mshifty/2*i,0,-sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=5.2,h=engmt);
*translate([engmul*sspac/2-mshifty/2*i,0,-sspac/2+mshift/2*i]) 
rotate([90,0,0]) cylinder(center=true,r=5.2,h=engmt);
}}

} //end eng mount

union(){ //body union------------------------------------------------------------------------------------------------------------------------

hull() //idler
translate([0+iaoff,0,drvele]){
translate([0,-0/2,0]) rotate([90,0,0]) cylinder(center=true,r=(idlerrod)/2+ibbw,h=bases,$fn=isthns);
translate([-iaoff,-0/2,0]) rotate([90,0,0]) cylinder(center=true,r=(beard)/2+bbw-0.2,h=bases);
}


translate([-0,0,drvele]){ //drive and recievergear bezel
translate([0,-0/2,0]) rotate([90,0,0]) cylinder(center=true,r=(beard)/2+bbw,h=bases+0.01);
}

hull() //main
translate([-0,0,drvele]){ //drive and recievergear bezel
translate([0,-0/2,0]) rotate([90,0,0]) cylinder(center=true,r=(beard)/2+bbw/2,h=bases);
#translate([faoff,-bases/3*0,-drvele-(6-jhele)+3]) rotate([90,0,0]) cylinder(center=true,r=18/2,h=bases);
if(showmu==1) %translate([0,-14,0]) rotate([90,0,0]) cylinder(center=true,r=recmd/2,h=2);
if(showmu==1) %translate([0,16,0]) rotate([90,0,0]) cylinder(center=true,r=roldia/2,h=4);
}

}//body union

if(ftype==1||ftype==0){ //hotend mount----------------------------------------------------------------------------------------
translate([0,(moubr-bases)/2,0])  //base module union
hull()
translate([faoff,0,jhele-5]) hull(){
translate([jhdia/2,0,0])  rotate([90,0,0])  cylinder(r=jhmshd/2+xiwal+3,h=moubr,center=true,$fn=23);
translate([-jhdia/2,0,0])  rotate([90,0,0])  cylinder(r=jhmshd/2+xiwal+3,h=moubr,center=true,$fn=23);
translate([0,0,jhgrvs])  rotate([90,0,0]) scale([1.6,1,1]) cylinder(r=jhdia/2+xiwal,h=moubr,center=true,$fn=23);
}

translate([0,0,0]) difference(){  //base module union
hull(){
translate([faoff,(moubr-bases)/2,gcm_ele-mntsp/2]) {
translate([0,0,2])  rotate([90,0,0]) cylinder(r=7/2,h=moubr,center=true,$fn=23);
translate([hfxtr+bbmwal,0,-2]) rotate([90,0,0]) scale([1,1.8,1]) rotate([0,0,45]) cylinder(center=true,r=4/2,h=moubr,$fn=14);
translate([hfxtr-bbmwal-hmdist,0,-2]) rotate([90,0,0]) scale([1,1.8,1]) rotate([0,0,45]) cylinder(center=true,r=4/2,h=moubr,$fn=14);
}
}
//BBm side cutouts
translate([faoff,fcfe+bases/2,-8.5]){
translate([hfxtr+6.5+fben,-3,-8])   rotate([0,0,-20]) translate([0,-40,0]) cube([15,50,10]); 
translate([hfxtr+0+fben,12,-8])   rotate([0,0,36]) translate([0,-40,0]) cube([20,50,10]);
translate([-19+hfxtr-hmdist-fben,1,-8])   rotate([0,0,20]) translate([0,-40,0]) cube([10,40,8]);
echo(hfxtr-hmdist);
translate([-15+hfxtr-hmdist-fben,25+1,-8]) rotate([0,0,-36]) translate([0,-40,0]) cube([20,50,10]);
}
translate([faoff,(moubr-bases)/2,gcm_ele-mntsp/2-3/2-3]) translate([-50,-50,-100]) cube([100,100,100]);
}
}

if(ftype==2){
translate([0,(moubr-bases)/2,0])  //base module union
hull()
translate([faoff,0,gcm_ele]){
translate([10,0,2])  rotate([90,0,0]) cylinder(r=3/2+xiwal,h=moubr,center=true,$fn=23);
translate([-10,0,2])  rotate([90,0,0]) cylinder(r=3/2+xiwal,h=moubr,center=true,$fn=23);
translate([-10,0,-mntsp/2]) rotate([90,0,0]) cylinder(r=3/2+xwal,h=moubr,center=true,$fn=23);
translate([10,0,-mntsp/2]) rotate([90,0,0]) cylinder(r=3/2+xwal,h=moubr,center=true,$fn=23);
}
}

hull(){ //lower guide
translate([faoff,fcfe+bases/2,0]) 
cylinder(r=guideinsert/2+1.5,h=drvele,$fn=20);

translate([faoff,fcfe,0]) cylinder(r=guideinsert/3,h=drvele,$fn=20);

translate([faoff,fcfe+bases/2,drvele-10])  cube(center=true,[gtot*1,guideinsert+guidewal*2,10]);

}

if(fguide==1) translate([5.2+rolo+idlerd/2+filgap-cutof,-fcfe,filgele+(beard+idlerrod)/2+bbw+drvele-(sscdia/2+sscw+2)])   //head filguide mount upper pipe
difference(){
union(){
hull(){
translate([-gtot/9-3+idarmt/2,fcfe-.1,-1+sscc/2]) rotate([0,0,0]) cube(center=true,[idarmt,bases-.2,1+sscc]);
translate([-gtot/9-3+idarmt/2,fcfe-fild/2+sscw+filgyoff,sscdia/2+sscw+2+filgzoff]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2+sscw,h=idarmt);
translate([-gtot/9-3+idarmt/2,fcfe+3+filgyoff-sscew,sscdia/2+sscw+2+filgzoff]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2+sscw,h=idarmt);
}
}
}//dif end

if(fguide==1) translate([faoff,0,filgele+(beard+idlerrod)/2+bbw+drvele-(sscdia/2+sscw+2)])   //head filguide mount upper pipe
difference(){
union(){
translate([0,fcfe+bases/2,4+(sscdia/2+sscw+filgzoff)/2]) rotate([0,0,0]) cylinder(center=true,r=gtot/2+1,h=8+sscdia/2+sscw+filgzoff,$fn=26);
hull(){
translate([-gtot/9,fcfe+bases/2,4+(sscdia/2+sscw+filgzoff)/2]) rotate([0,0,0]) cube(center=true,[gtot*1,guideinsert+guidewal*2,8+sscdia/2+sscw+filgzoff]);

translate([-gtot/9,-.04,0+sscc/2]) rotate([0,0,0]) cube(center=true,[gtot,bases-.1,1+sscc]);
translate([-gtot/9,fcfe+3-4+filgyoff,sscdia/2+sscw+2+filgzoff]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2+sscw+.1,h=gtot);
translate([-gtot/9,fcfe+3-4+filgyoff-sscew,sscdia/2+sscw+2+filgzoff]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2+sscw+.1,h=gtot);

}
}
translate([0,fcfe+bases/2,0]) rotate([0,0,0]) cylinder(center=true,r=guideinsert/2,h=25+6+sscdia/2+sscw+filgzoff,$fn=26);
}//dif ends

translate([0+rolo+idlerd/2+filgap-cutof,0,drvele-absele]){ //abs hinge section
hull(){
translate([0,0,absele/2]) cube([abscw+absdw,bases-.1,absele],center=true);
translate([-4,0,absele]) cube([abscw+absdwB+8,bases-.1,1],center=true);
}
//hull(){
translate([0,0,0]) rotate([90,0,0]) cylinder(center=true,r=absdd/2+abshw,h=bases,$fn=26);
//translate([0,0,-absdd]) rotate([90,0,0]) cube(center=true,[absdd,absdd,bases]);
//}
}

}//main union ends

union(){ //cutter union

//-abs hinge cutter

translate([0+rolo+idlerd/2+filgap-cutof,0,drvele-absele]){
translate([0,0,absch/2]) cube([abscw,bases+.1,absch],center=true);
translate([0,0,0]) rotate([90,0,0]) cylinder(center=true,r=absdd/2,h=bases+.1,$fn=26);
}

//filgyoff=1;
//filgzoff=2;

if(fguide==1) translate([5.1+rolo+idlerd/2+filgap-cutof,-4+filgyoff+1.5,filgele+(beard+idlerrod)/2+bbw+drvele-(sscdia/2+sscw+2-filgzoff)]){
translate([-gtot/9,fcfe+psof,sscdia/2+sscw+2]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2,h=50,$fn=23);
translate([-(guideinsert/2+guidewal+rolo+idlerd/2+filgap-cutof)-10+1.3,fcfe+psof,sscdia/2+sscw+2]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2+2,h=20,$fn=23);
translate([10-4.5+gtot,fcfe+psof,sscdia/2+sscw+2]) rotate([0,90,0]) cylinder(center=true,r=sscdia/2+3,h=20,$fn=13);
} //abshinge screw hole

//x mount holes
if(ftype==2&&ehm==1) translate([faoff,0,gcm_ele]) for(i=[90,180]) rotate([0,i,0]) translate([mntsp/2,0,mntsp/2]) rotate([90,0,0]) cylinder(r=3/2,h=100,center=true,$fn=23);

translate([faoff,-0/2,-5+.2]) { //jmount, h & fil guide

if(jhm!=0){
translate([0,35+0.25,0]) {
translate([jhdia/2,0,jhele]) rotate([90,0,0]) cylinder(center=true,r=jhmsd/2,h=70,$fn=16);
translate([-jhdia/2,0,jhele]) rotate([90,0,0]) cylinder(center=true,r=jhmsd/2,h=70,$fn=16);
}

translate([0,-40,0]) {
translate([jhdia/2,0,jhele]) rotate([90,0,0]) cylinder(center=true,r=jhmshd/2,h=70,$fn=jhmshdsides);
translate([-jhdia/2,0,jhele]) rotate([90,0,0]) cylinder(center=true,r=jhmshd/2,h=70,$fn=jhmshdsides);
}
}

if(fch>0){ //central hole mount
translate([0,-8,jhele]) rotate([90,0,0]) cylinder(center=true,r=fch/2,h=50,$fn=16);
translate([0,-40,jhele]) rotate([90,0,0]) cylinder(center=true,r=fchh/2,h=70,$fn=16);
}

if(ftype==0||ftype==1) translate([0,fcfe+bases/2,-4.5]) { //bbm screw and eye candy
translate([hfxtr,0,-2]) rotate([0,0,0])  rotate([0,0,45]) cylinder(center=true,r=fmbd/2,h=10,$fn=14);
translate([hfxtr-hmdist,0,-2]) rotate([0,0,0])  rotate([0,0,45]) cylinder(center=true,r=fmbd/2,h=10,$fn=14);

translate([hfxtr,0,2]) rotate([0,0,0])  rotate([0,0,30]) cylinder(center=true,r=fmbnd/2,h=10,$fn=6);
translate([hfxtr-hmdist,0,2]) rotate([0,0,0])  rotate([0,0,30]) cylinder(center=true,r=fmbnd/2,h=10,$fn=6);

if(ftype==1) translate([3,0,0]) hull(){ //BBmount middle cutout
translate([(hfxtr-hmdist)/2-1,-12,-2]) rotate([0,0,0])  rotate([0,0,30]) cylinder(center=true,r=15/2,h=20,$fn=26);
translate([(hfxtr-hmdist)/2-5,4,-2]) rotate([0,0,0])  rotate([0,0,30]) cylinder(center=true,r=2/2,h=20,$fn=26);
translate([(hfxtr-hmdist)/2-8,-12,-2]) rotate([0,0,0])  rotate([0,0,30]) cylinder(center=true,r=15/2,h=20,$fn=26);
}

}

//--------------------------------------fialment path----------------------------------------------------------------------------------------------------
translate([0,fcfe+bases/2,jhele+jhgrvs]) JHm(diam=fild,mrg=0.1,heiA=jhlen,heiB=90,rsthns=30,jdiam=jhdia);
translate([0,fcfe+bases/2,jhele+jhgrvs+drvele/2+1]) cylinder(center=true,r=guideinsert/2,h=drvele,$fn=16);
}


translate([0,0,0]){ //main axis mount
translate([0,-0/2,drvele]) rotate([90,0,0]) cylinder(center=true,r=mbdia/2-.5,h=bases+30,$fn=msthns);
translate([0,bases/2+15-mbth,drvele]) rotate([90,0,0]) cylinder(center=true,r=mbdia/2,h=30,$fn=msthns);
translate([0,-bases/2+mbth/2-.49,drvele]) rotate([90,0,0]) cylinder(center=true,r=mbdia/2,h=mbth+1,$fn=msthns);
translate([0,-bases/2+.6+mbth,drvele]) rotate([90,0,0]) cylinder(center=true,r2=mbdia/2-0.02,r=mbdia/2-.6,h=1.2,$fn=msthns);
}


translate([rolo+idlerd/2+filgap,-0/2,drvele]){  //idler axis, mockup, clearance ---------------------------------------------------
translate([0,-0/2,0]) rotate([90,0,0]) cylinder(center=true,r=idlerrod/2,h=60,$fn=36);
translate([0,-bases/2,0]) rotate([90,0,0]) rotate([0,0,30]) cylinder(center=true,r=idlernut/2,h=idlernuh,$fn=6);
translate([idlerdpr*1-fild,bases/2+3+1+3,0]) rotate([90,0,0]) rotate([0,0,30]) cylinder(center=true,r=(idlerd)/2+idlgrv+fild/3,h=7.8+6,$fn=36);
if(idlernut>idlerrod) translate([0,1,0]) hull(){
translate([0,-bases/2+idlernuh/2-1,0]) rotate([90,0,0]) rotate([0,0,30]) cylinder(center=true,r=idlernut/2,h=0.2,$fn=6);
translate([0,-bases/2+idlernuh/2+2-2,0]) rotate([90,0,0]) rotate([0,0,30]) cylinder(center=true,r=idlerrod/2-.1,h=.2,$fn=26);
}
if(showmu==1) 
translate([0,bases/2+3,0]) rotate([90,0,0]) rotate([0,0,30]) %difference() {
cylinder(center=true,r=idlerd/2,h=7,$fn=36);
cylinder(center=true,r=idlerrod/2,h=9,$fn=36);
}
}


translate([engmul*(43+3+engoff),-7+(25-bases)+engmt-4,45/2+2+engoffz])  rotate([0,engmul*engang,0])  rotate([0,0,180])  ynema17(eshift=engmul*mshift,eshiftY=mshifty,nemaf=20);

translate([15,0,-53.9-(6-jhele)]) cube([45,100,100],center=true);

if(inspect==1) translate([0,64,-10]) cube([100,100,100],center=true);
if(csaxes==1) translate([0,0,50+drvele]) cube([100,100,100],center=true);


}//cutter union ends
}//main diff ends
}//part doff inter - module ends - put part divisions before here


module JHm(diam=8,mrg=0.1,heiA=20,heiB=25,rsthns=30,jdiam=16){
translate([0,0,-.1]) cylinder(r=diam/2+mrg,h=heiA+heiB,$fn=rsthns);
translate([0,0,-(heiA)]) cylinder(r=jdiam/2+mrg,h=heiA,$fn=rsthns);
}


module ynema17(eshift=0,eshiftY=4,sthns=30,nemaf=23){

spac=70-12; wida=90; berl=30; glide=12; outer=21+4*2;
nemam=3.2/2; nmsp=31.5;

translate([0,-35/2,0]) union(){
rotate([0,0,0]) cube([41+eshiftY,40,41+eshift],center=true);
%translate([0+0/2,20+9,0/2]) rotate([90,0,0]) cylinder(r=attmd/2,h=5,center=true,$fn=sthns);
hull() for(i=[1,-1]) translate([0+i*eshiftY/2,20,i*eshift/2]) rotate([90,0,0]) cylinder(r=nemaf/2,h=50,center=true,$fn=sthns);
for(i=[[1,1],[-1,-1],[1,-1],[-1,1]]) hull(){
translate([i[0]*nmsp/2+eshiftY/2,20,i[1]*nmsp/2+eshift/2]) rotate([90,0,0]) cylinder(r=nemam,h=50,center=true,$fn=sthns);
translate([i[0]*nmsp/2-eshiftY/2,20,i[1]*nmsp/2-eshift/2]) rotate([90,0,0]) cylinder(r=nemam,h=50,center=true,$fn=sthns);
}}//nema union ends
}//module ends

