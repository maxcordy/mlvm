/***********************************************************************
Name ......... : pacmanGhost.scad
Description....: Pacman Ghosts
Author ....... : Garrett Melenka
Version ...... : V1.0 2016/10/15
Licence ...... : GPL
***********************************************************************/

//Dimensions for Ghosts
//Pixel Size- size of each square
pixelSize = 5;
//Pixel Height- height of each square
pixelHeight = 5;


ghostSelect = 1; //[1:Ghost 01, 2:Ghost 02]

//Matricies to setup the different Pacman Ghosts
ghost01 =   [[0,0,0,0,0,1,1,1,1,0,0,0,0,0,0],
             [0,0,0,1,1,1,1,1,1,1,1,0,0,0,0],
             [0,1,1,1,1,1,1,1,1,1,1,1,0,0,0],
             [0,1,0,0,1,1,1,1,0,0,1,1,1,0,0],
             [0,0,0,0,0,1,1,0,0,0,0,1,1,1,0],
             [0,2,2,0,0,1,1,2,2,0,0,1,1,1,0],
             [1,2,2,0,0,1,1,2,2,0,0,1,1,1,1],
             [1,1,0,0,1,1,1,1,0,0,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
             [1,1,0,1,1,1,0,0,1,1,1,0,1,1,1],
             [1,0,0,0,1,1,0,0,1,1,0,0,0,1,1]];

ghost02 = [[0,0,0,0,0,1,1,1,1,0,0,0,0,0,0],
           [0,0,0,1,1,1,1,1,1,1,1,0,0,0,0],
           [0,0,1,1,1,1,1,1,1,1,1,1,0,0,0],
           [0,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
           [0,1,1,1,1,1,1,1,1,1,1,1,1,0,0],
           [0,1,1,1,0,0,1,1,0,0,1,1,1,0,0],
           [1,1,1,1,0,0,1,1,0,0,1,1,1,1,0],
           [1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
           [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0],
           [1,0,1,1,0,0,1,1,0,0,1,1,0,1,0],
           [1,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
           [1,1,1,1,0,1,1,1,1,0,1,1,1,1,0],
           [0,1,1,0,0,0,1,1,0,0,0,1,1,0,0]];
             


module pixel()
{
    
    cube(size = [pixelSize, pixelSize, pixelHeight], center = true);
}


module pacmanGhost()
{
    
    for(i = [0:14])
    {
        for(j = [0:14])
        {
            //ghost 01
            if (ghostSelect ==1)
            {
            if (ghost01[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel();
            }
            }
            
            if (ghost01[i][j] == 2)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                color([1,1,1])
                pixel();
            }
            }
            
                        
            }
            //ghost 02
            if (ghostSelect == 2)
            {
            if (ghost02[i][j] == 1)
            {
                    
            
            translate([pixelSize*i, pixelSize*j,0])
            {
                pixel(); 
            }
            }
            }
            
        }
    }
    
    
    
}
//Show the Ghost
pacmanGhost();