// 2017 Pedro Luis Barrio - Mollet
//
// Remixed from
// Lucas Wilder - Michigan Technological University - EE 4777
// Microscope Slide Holder

// number Cols
nCols = 2 ;

// number Rows
nRows = 2;

// Number of slides
slNumber = 12;

// Slide thickness in mm
slThickness = 1.8;

// Slide Thickness Tolerance
slThicknessTol = 0.5;

// Slide spacing
slSpacing = 1.5;

// Slide length in mm
slLength = 61.5;

// Slide Length Tolerance
slLengthTol = 1;

// Slide Angle
slAngle = 30;

// Bottom Length in mm
btLength =  5;

// Bottom Thickness in mm
btThickness = 1.5;

// Slide width in mm
slWidth = 21.5;

// Wall thickness
wThickness = 1.5;


// Calculations
pSlSpacing   = slSpacing / cos (slAngle) ;
pSlThickness = (slThickness + slThicknessTol ) / cos (slAngle) ;

totalWide   =  (slNumber - 1 )* (pSlThickness + pSlSpacing ) + 2 * wThickness + slWidth * sin(slAngle) +  (slThickness + slThicknessTol ) * cos (slAngle)  ;
totalLength = slLength                                             + 2 * wThickness + slLengthTol;
        

for ( i = [ 0 : 1 : nRows -1 ] )
    for ( j = [ 0 : 1 : nCols -1 ] )
        translate ( [ i * (totalWide   - wThickness)    ,
                      j * (totalLength - wThickness)  , 
                      0 ] )
            rack();
   
module rack()
{

    difference()
    {
        // Union of main part to handle mounts
        union()
        {
            // Main body
            cube ( size = [ totalWide,
                            totalLength,
                            (slWidth/2) * cos (slAngle) + btThickness ], 
                   center = false );   
         
            // Slides representation
            for ( i = [ 0 : 1 :slNumber -1 ] )
            {
                translate( [ wThickness + slThicknessTol /2+i * (pSlThickness + pSlSpacing ),
                             wThickness + slLengthTol/2  ,
                             btThickness + (slThickness + slThicknessTol ) * sin (slAngle)    ] ) 
                    rotate([0,slAngle,0])
                    %cube ( size = [ slThickness ,
                                    slLength    ,
                                    slWidth ],
                           center = false);
            }   
            
        }
        
        // Slides with tolerance
        for ( i = [ 0 : 1 :slNumber -1 ] )
        {
            translate( [ wThickness + i * (pSlThickness + pSlSpacing ),
                         wThickness ,
                         btThickness + (slThickness + slThicknessTol ) * sin (slAngle)    ] ) 
                rotate([0,slAngle,0])
                cube ( size = [ slThickness + slThicknessTol,
                                slLength    + slLengthTol,
                                slWidth ],
                       center = false);
        }
        
        // Center cut
        translate ( [ wThickness , 
                      wThickness + btLength,
                      btThickness ] )
                  cube ( size = [ totalWide   - 2 * (wThickness ),
                                  totalLength - 2 * (wThickness + btLength  ),
                            slWidth  + 2 + btThickness ], 
                            center = false);
        // Bottom cut
        translate ( [ wThickness + btLength, 
                      wThickness + btLength,
                      -1 ] )
                  cube ( size = [ totalWide   - 2 * (wThickness + btLength ),
                                  totalLength - 2 * (wThickness + btLength ),
                            slWidth  + 2 + btThickness ], 
                            center = false);        
    }
}
