//male or female part
partType="Both";//[Male,Female,Both]

//This is the max width of the tongue
width=4;

//This is the length of the tongue
length=4;

//This is the height of the block that the tongue is attached to
height=4;

//This is the height from the bottom of the block to the bottom of the tongue
height_2=1;

//this is the height of the end of the tongue (Height - Height_2 > height_3 > 0
height_3=1;

//angle of tongue
angle =30;

//Additional width of male block, amount wider than tongue
Male_Block_Width = 0;

//Additional width of female block, amount wider than tongue
Female_Block_Width = 10;

//Length of block the tongue is attached to
Male_Block_Length = 20;

//Depth of Block (>=0) 
Block_Depth = 0;

//Tolerance Gap to ensure a good fit (0.2 a good starting point assuming exporting using mm)
Tolerance=0.2;


if(partType=="Male"){

color([1,0,0])    
polyhedron(
  points=[ [width-((height-height_2)*tan(angle)),0,height],[width,0,height_2],[0,0,height_2],[(height-height_2)*tan(angle),0,height],[width-(height_3)*tan(angle),length,height],[width,length,(height-height_3)],[0,length,height-height_3],[(height_3)*tan(angle),length,height] ],          
  faces=[ [0,1,2],[0,2,3],//base face
          [0,4,1],[1,4,5], //side 1
          [0,3,4],[3,7,4], //top
          [2,7,3],[2,6,7], //side 2
          [1,5,2],[2,5,6], //bottom
          [6,5,4],[4,7,6]]  //end
);
color([1,0,0])        
translate([-Male_Block_Width/2,-Male_Block_Length,0]){cube([width+Male_Block_Width, Male_Block_Length, height]);}}


if (partType=="Female"){
    
    difference(){
          translate([-(Female_Block_Width)/2,0,0]){cube([width+Female_Block_Width, length+Block_Depth,      height]);}

          polyhedron(
               points=[ [width-((height-height_2)*tan(angle)),0,height],[width,0,height_2           ],[0,0,height_2],[(height-height_2)*tan(angle),0,height],[width-(height_3)*           tan(angle),length,height],[width,length,(height-height_3)],[0,length,height           -height_3],[(height_3)*tan(angle),length,height] ],          
               faces=[ [0,1,2],[0,2,3],//base face
                       [0,4,1],[1,4,5], //side 1
                       [0,3,4],[3,7,4], //top
                       [2,7,3],[2,6,7], //side 2
                       [1,5,2],[2,5,6], //bottom
                       [6,5,4],[4,7,6]],  //end
               convexity=10);
    
     }
 }
   
if(partType=="Both") { 
    color([1,0,0])
    polyhedron(
  points=[ [width-((height-height_2)*tan(angle)),0,height],[width,0,height_2],[0,0,height_2],[(height-height_2)*tan(angle),0,height],[width-(height_3)*tan(angle),length,height],[width,length,(height-height_3)],[0,length,height-height_3],[(height_3)*tan(angle),length,height] ],          
  faces=[ [0,1,2],[0,2,3],//base face
          [0,4,1],[1,4,5], //side 1
          [0,3,4],[3,7,4], //top
          [2,7,3],[2,6,7], //side 2
          [1,5,2],[2,5,6], //bottom
          [6,5,4],[4,7,6]]  //end
);
    color([1,0,0])    
translate([-Male_Block_Width/2,-Male_Block_Length,0]){cube([width+Male_Block_Width, Male_Block_Length, height]);}

    difference(){
          translate([-(Female_Block_Width)/2,0,0]){cube([width+Female_Block_Width, length+Block_Depth,      height]);}

          polyhedron(
               points=[ [width-((height-height_2)*tan(angle)),0,height],[width,0,height_2           ],[0,0,height_2],[(height-height_2)*tan(angle),0,height],[width-(height_3)*           tan(angle),length,height],[width,length,(height-height_3)],[0,length,height           -height_3],[(height_3)*tan(angle),length,height] ],          
               faces=[ [0,1,2],[0,2,3],//base face
                       [0,4,1],[1,4,5], //side 1
                       [0,3,4],[3,7,4], //top
                       [2,7,3],[2,6,7], //side 2
                       [1,5,2],[2,5,6], //bottom
                       [6,5,4],[4,7,6]],  //end
               convexity=10);
    
     }
 }