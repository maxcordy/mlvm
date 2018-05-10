//Circuit Board Holder

// Gather Parameters
/* [Base]*/
// Base Width (All dimensions in mm)
BaseSideToSide = 120;
// Fase Depth
BaseFrontToBack=80;
// Base thickness
BaseThickness = 4;
// Side to side distance between post centers
/* [Post Locations] */
PostSideToSide = 58;
// Front to back distance between post centers
PostFrontToBack = 50;
// Distance from left edge to left post centers
PostFromLeft = 15;
// Distance from front edge to front post centers
PostFromFront = 17;
/* [Post and Hole Sizes] */
// Post Diameter
PostDia = 5;
// Post Height above Base
PostHeight=8;
// PostScrew Hole Diameter
PostHoleDia = 2.5;
//Mounting hole inset from base edges.
MountHoleInset = 5;
//Mounting hole diameter
MountHoleDia = 4;

/* [Hidden] */
$fn=60;

// Modules

module post(Phgt, Pdia, Xloc, Yloc) {
    
    translate([Xloc, Yloc, 0]) {
    cylinder(h=Phgt, d=Pdia);
        }
    }

// Calculate Dimensions
TotalPostHeight = PostHeight + BaseThickness;



    
/* First join the base and posts, then join the post holes, then join the base indents, then join the mounting holes, then subtract the groups of joined holes and indents from the first joined group of base plus posts. */
   

difference() { 
 // join the base and posts 
union() {
cube([BaseSideToSide, BaseFrontToBack, BaseThickness]);    
post(TotalPostHeight, PostDia, PostFromLeft, PostFromFront);
post(TotalPostHeight, PostDia, PostFromLeft + PostSideToSide, PostFromFront);
post(TotalPostHeight, PostDia, PostFromLeft, PostFromFront + PostFrontToBack);
post(TotalPostHeight, PostDia, PostFromLeft + PostSideToSide, PostFromFront + PostFrontToBack);
}
 // join the post screw holes to be subtracted
union() {
post(TotalPostHeight, PostHoleDia, PostFromLeft, PostFromFront);
post(TotalPostHeight, PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront);
post(TotalPostHeight, PostHoleDia, PostFromLeft, PostFromFront + PostFrontToBack);
post(TotalPostHeight, PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront + PostFrontToBack);
}
// join the post screw indents on bottom face
union() {
post(PostHoleDia,2 * PostHoleDia, PostFromLeft, PostFromFront);
post(PostHoleDia,2 * PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront);
post(PostHoleDia,2 * PostHoleDia, PostFromLeft, PostFromFront + PostFrontToBack);
post(PostHoleDia,2 * PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront + PostFrontToBack);
}

 // join the base mounting holes
 union() {
  post(BaseThickness, MountHoleDia,  BaseSideToSide/2, MountHoleInset); 
  post(BaseThickness, MountHoleDia,  BaseSideToSide/2, BaseFrontToBack - MountHoleInset);
   post(BaseThickness, MountHoleDia,  MountHoleInset, BaseFrontToBack/2); 
  post(BaseThickness, MountHoleDia,  BaseSideToSide - MountHoleInset, BaseFrontToBack/2); 
}
}

 


    