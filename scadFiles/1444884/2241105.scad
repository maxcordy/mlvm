//
// Générateur de plans pour porte tubes à essai. (v 0.3)
// ──────────────────────────────────────────────────────
// écrit par Vanlindt Marc sous Licence GNU GPL v3. 
// ______
//(______)
// |    | Variables modifiables :                             o
// |    | ------------------------                              o 
// |    | ● HauteurTube : Donnez, en mm, la hauteur de        ___ 
// |    |   de vos tubes                                      | | 
// |____| ● DiamTube : Diamètre de vos tubes. Pensez à        | | 
// |.·.·|   rajouter un mm au diamètre réel pour faciliter    |o| 
// |·.·.|   l'insertion.                                     .' '. 
// |.··.| ● EpaisMater : Epaisseur du matériau qui sera     /  o  \ 
// |··..|   utilisé                                        :____o__:
//  \__/  ● NbrX et NbrY : Nombre de tubes en X et Y       '._____.'
//--------------------------------------------------------------------

// Hauteur des tubes, en mm.
HauteurTube     =140;   
// Diamètre des tubes, en mm.
DiamTube        =30;    
// Epaisseur des plaques utilisées, en mm.
EpaisMater      =4;     
// Nombre de tubes en profondeur.
NbrX            =2;     
// Nombre de tubes en largeur.
NbrY            =5;     

// En mode 3D, affichages des tubes.
Tubes = "avec";//[avec,sans]

// Mode de visualisation.
mode="3D";//[3D,plan]

if(mode=="3D")
{
    v3d(tubes=Tubes,convexity=16);
}
else
{
    plan();
}

module plan()
{
    cote();
    
    translate([((DiamTube+10)*NbrX)+20,0])
    cote();
    
    translate([((DiamTube+10)*NbrX)*2+40,0])
    plaquebas();
    
    translate([((DiamTube+10)*NbrX)*3+60,0])
    autresplaques();
    
    translate([((DiamTube+10)*NbrX)*4+80,0])
    autresplaques();
}

module autresplaques()
{
    difference()
    {
        plaquebas();
        for(i=[0:NbrX-1])
        {
            for(j=[0:NbrY-1])
            {
                translate([DiamTube/2+10+((DiamTube+10)*i),EpaisMater+DiamTube/2+10+(DiamTube+10)*j])
                circle(r=DiamTube/2);
            }
        }
    }
}

module plaquebas()
{
    difference()
    {
        square([((DiamTube+10)*NbrX)+10,(((DiamTube+10)*NbrY)+10)+2*EpaisMater]);
        square([(((DiamTube+10)*NbrX)+10)/10,EpaisMater]);
        translate([((((DiamTube+10)*NbrX)+10)/10)*9,0])
        square([(((DiamTube+10)*NbrX)+10)/10,EpaisMater]);
        translate([((((DiamTube+10)*NbrX)+10)/10)*9,((((DiamTube+10)*NbrY)+10)+EpaisMater)])
        square([(((DiamTube+10)*NbrX)+10)/10,EpaisMater]);
        translate([0,((((DiamTube+10)*NbrY)+10)+EpaisMater)])
        square([(((DiamTube+10)*NbrX)+10)/10,EpaisMater]);
    }
}

module v3d()
{
    color([0.9,0.9,0.9,1])
    rotate([90,0,0])
    linear_extrude(height=EpaisMater)
    cote();
    color([0.9,0.9,0.9,1])
    translate([0,((((DiamTube+10)*NbrY)+10)+EpaisMater),0])
    rotate([90,0,0])
    linear_extrude(height=EpaisMater)
    cote();
    color([0.8,0.8,0.8,1])
    translate([0,-EpaisMater,0])
    linear_extrude(height=EpaisMater)
    plaquebas();
    color([0.8,0.8,0.8,1])
    translate([0,-EpaisMater,HautTube/2])
    linear_extrude(height=EpaisMater)
    autresplaques();
    color([0.8,0.8,0.8,1])
    translate([0,-EpaisMater,HautTube])
    linear_extrude(height=EpaisMater)
    autresplaques();
    if(tubes=="avec")
    {
        for(i=[0:NbrX-1])
        {
            for(j=[0:NbrY-1])
            {   
                color([0.2,0.2,0.2,0.2])
                translate([DiamTube/2+10+((DiamTube+10)*i),DiamTube/2+10+(DiamTube+10)*j,EpaisMater])
                tube();
            }
        }
    }
}

module cote()
{
    difference()
    { 
        square([((DiamTube+10)*NbrX)+10,HautTube+EpaisMater*2]);
        translate([(((DiamTube+10)*NbrX)+10)/10,0])
        square([(((DiamTube+10)*NbrX)+10)/10*8,EpaisMater]);
        translate([(((DiamTube+10)*NbrX)+10)/10,HautTube/2])
        square([(((DiamTube+10)*NbrX)+10)/10*8,EpaisMater]);
        translate([(((DiamTube+10)*NbrX)+10)/10,HautTube])
        square([(((DiamTube+10)*NbrX)+10)/10*8,EpaisMater]);
    } 
}

module tube()
{
    difference()
    {
        hull()
        {
            translate([0,0,HauteurTube-1])
            cylinder(r=DiamTube/2,h=1,$fn=24);
            translate([0,0,DiamTube/2])
            sphere(r=DiamTube/2,$fn=24);
        }
        hull()
        {
            translate([0,0,HauteurTube])
            cylinder(r=DiamTube/2-1,h=1,$fn=24);
            translate([0,0,DiamTube/2+1])
            sphere(r=DiamTube/2,$fn=24);
        }
    } 
}

HautTube=HauteurTube-10;
