//Cardboard planters
//Ari M Diacou
//Feb 2017

//These are planters designed to be cut from carboard on a laser cutter. You then fold up ithe sides, and put soil in them. Up to you if you want to transplant them without removing the cardboard first.

////////////////// Parameters //////////////////////
////////////// User Parameters /////////////////////
//The maximum x dimension of your laser's bed (left-right)
maximum_bed_x=240;
//The maximum y dimension of your laser's bed (towards-away from user)
maximum_bed_y=240;
//debugging feature, turn off before full render/export
user_wants_guides=true; //[true,false]
//Width of the planter in mm, will be scaled if it causes a stupid design.
user_width=50;
//Height of the planter in mm, will be scaled if it causes a stupid design.
user_height=100;
//How high up the sides do you want the tabs?
tab_height_factor=.7;
//The tabs have a width that is this factor of the height
tab_width_factor=.2;
//The thickness in mm of the cardboard you are cutting 
thickness=5;
//The tab cutouts will be this factor deeper than the thickness of the cardboard (recommend 0 to 1)
tab_width_tolerance=.2;
//The tab cutouts will be this factor shorter of the thickness of the cardboard (recommend -1 to 1)
tab_height_tolerance=.0;
//The angle that the sides of the tab make with the edges of the side the tab is on (90 is perpendicular, 0 is infinite)
tab_angle=75;
//////////// Derived Parameters ////////////////////
ep=0+0.05; //Epsilon, a small value
max_size=.9*min(maximum_bed_x,maximum_bed_y);
scale_factor=max_size/(user_width+2*user_height); echo(scale_factor);
user_dimensions_are_too_big=scale_factor < 1.0 ? true : false;
width=user_dimensions_are_too_big ? user_width*scale_factor : user_width;
height=user_dimensions_are_too_big ? user_height*scale_factor : user_height;
size=user_dimensions_are_too_big ? max_size : user_width+2*user_height;
tab_dimension_range=[tab_width_factor*height,2*thickness*cos(tab_angle)];//[min,max]
/////////////////// Main() /////////////////////////
// user_wants_guides=true;
if(user_wants_guides){ %debug(); }
print_info();
difference(){
    base();
    foldup_clearance();
    tab_cutout1();
    }
tabs(tab_angle);

///////////////// Functions ////////////////////////
module tab_cutout1(){
    double_mirror(.5*width*[1,1]+[thickness+ep,height*(tab_height_factor-tab_width_factor/2)])
        mirror([1,0]) 
            square([(1+tab_width_tolerance)*thickness,tab_width_factor*height+thickness*tab_height_tolerance]);
    }

module test_roundto(input,precision=1,fraction=false){
    ans=roundto(input, precision);
    int=roundto(input, 1);
    numerator=(ans-int)/precision;
    denominator=1/precision;
    if(!fraction)
        echo(str(input, ", rounded to the nearest ",precision," is ",ans));
    else
        echo(str(input, ", rounded to the nearest ",precision ," is ",int," ",numerator,"/",denominator));
    }
    
function roundto(input, precision)=round(pow(10,-log(precision))*input)*pow(10,log(precision));

module tabs(angle=75){
    double_mirror([width/2+tab_height_factor*height,width/2-ep]) tab1(angle=angle);
    }
module tab1(angle=75){
    w=tab_width_factor*height;
    A=[w/2,0];
    D=[-A[0],0];
    B=A+2*thickness*[cos(angle),1];
    C=[-B[0],B[1]];
    polygon([A,B,C,D]);
    }

module base(){
    difference(){
        square(size,center=true);
        double_mirror(dist=[size/2-height+ep+thickness,size/2-height+ep]) color("blue") square([height-thickness,height]);
        }
    }
module foldup_clearance(){
    //cuts in the front/back sides which allow the left right sides to fold up flush with the front/back sides
   double_mirror(dist=[width/2+ep,size/2-height+ep]) color("yellow") line(1.0*thickness);
    } 
module line(l=1){
    //a way to create a "line" from a "square()" object
    line_thickness = user_wants_guides ? min(0.006*size, 0.25*l) : ep;
    square([l,line_thickness]);
    }
module double_mirror(dist=0){
    //Flips an object over the x, y and x+y axes to create 4 objects centered about the origin. I.e. what you would see if you placed an object between two orthogonal mirrors.
    //Can be used with a vector or scalar distance from the origin to move the object (i.e. translate() is built into the function). 
    if(len(dist)>1){
        mirror([0,0]) translate(dist) children(0);
        mirror([1,0]) translate(dist) children(0);
        mirror([0,1]){
            mirror([0,0]) translate(dist) children(0);
            mirror([1,0]) translate(dist) children(0);
            }
        }
    else{    
        mirror([0,0]) translate(dist*[1,1]) children(0);
        mirror([1,0]) translate(dist*[1,1]) children(0);
        mirror([1,0]) mirror([0,1]) translate(dist*[1,1]) children(0);
        mirror([0,1]) translate(dist*[1,1]) children(0);
        }
    }
module cutout(){
    //The base() function is a square, with 4 squares cut out at the corners to form a cross. These are those squares.
    shift=size/2+ep-height;
    translate(shift*[1,1]) square(height);
    }
module debug(){
    //Shows a square of "size", as well as some guide lines, and tab/hole relative sizes. The % used in calling this function keeps it from being displaed on F6/render.
    
    //Outside square
    square(size,center=true);
    //the distance of the center of the tabs
    center=width/2+tab_height_factor*height;
    //lines||x-axis
    #double_mirror(center*[0,1])
        line(l=size/2);
    //lines || y-axis
    #double_mirror(center*[1,0])
        rotate(90) line(l=size/2);
    //mapping of cutouts onto tabs
    double_mirror([center-tab_dimension_range[0]/2,width/2-ep])    #square([tab_width_factor*height+thickness*tab_height_tolerance,(1+tab_width_tolerance)*thickness]);
    //score lines (cut through, top, and coregation, but not bottom layer
    #double_mirror([width/2,0]) mirror([1,1]) 
        line(width/2);
    msg="←score here";
    //score here message, 
    translate([width/2,0]) 
        #text(msg,size=len(msg)*tab_height_factor*.9);
    double_mirror(.5*width*[1,1]+[thickness+ep,height*(tab_height_factor-tab_width_factor/2)-tab_dimension_range[1]/2])
        mirror([1,0]) 
            #square([thickness,tab_dimension_range[0]+tab_dimension_range[1]]);    
    
    }
    
module print_info(){
    size=str("Max size based on laser bed = ", max_size, ", h=",height,"mm, w=",width,"mm.");
    too_big_warning=str("You have entered dimensions (h=",user_height,",w=",user_width,")which are larger (h+2*w=",max_size/scale_factor,"mm) than 90% of your laser cutter's minimum dimenstion (",max_size,"mm). Your dimensions have been scaled to fit by -",100*(1-scale_factor),"%.");
    echo(size);
    if(user_dimensions_are_too_big) 
        echo(too_big_warning);
    
    }