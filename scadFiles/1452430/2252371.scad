include <utils/arduino.scad>
include <K.scad>
// Variables pouvant être modifiés

// : Type de vis pour la fixation du socle
vis = "A"; // [A,B,C]

//
modele = "ambidextre"; // [droitier,gaucher,ambidextre]

// mm : longueur du socle
L = 130; // [130 : 180]

// mm : largeur du socle
l = 90; // [90 : 150]

// mm : hauteur du socle
h = 35; // [35 : 60]

/*----------------------- VARIABLES UTILISEES POUR LA CONCEPTION -----------------------------*/
{
    // TOUT EST EN MILIMETRES (il faut faire un calcul pour que les valeur ne puisse pas être modifié sous Thingiverse, d'où les divions par 1)

    // rayon de la sphère utilisé pour les congé et à retiré 2 fois pour les cotes du cube
        s = 2/1;
    
    // Epaisseur du socle en mm
        e = 4/1;

    // Dimentions du cube intérieur :Longueur cube ext. - 2 * epaisseur
        L2 = (L-2*s/2)-2*e;
        l2 = (l-2*s/2)-2*e;
        h2 = (h-2*s/2)-2*e;
  
    // Tranchées  sur le tour pour emboiter
        pt = 5/1;// Profondeur de la tranchee -1.01mm
        s2=0.5/1;// Rayon des spheres utilisés pour les congés de la tranchée

    /*--------------------------------- VIS FIXATION + COINS---------------------------------------*/
    {
        // Rayons des trous pour les 4 vis  :
        
            rv = 1.45/1;

        // Adaptation des mesures pour placer les vis

        r4=rv+rv; // 4 : cylindre plein
        h4=1/4*h; // accueillant la vis
    
        r42=rv+0.5;      // 42 : cylindre pour
        h42=h; // percer 4 et le socle
    
        rtv1 = 5.6/2 ; // : rayon de la tête de vis
        rtv2 = rv; // : rayon du bas la tête de vis
        htv = 1.65 ; // : hauteur de la vis

        //  Variables utilisé pour arrondire les coins
        
        x=2/1; // Coté d'un cube utilisé pour remplir les bord, pour découpé avec un cylindre pour arrondir
        
        h1=1/4*h; // Hauteur des cube = cylindres
    }
    //////////////////////////////////////////
    
    /*--------------------------------- Arduino --------------------------------------*/
    {
        // Coordonnee [x,y] des 4 picos pour la carte arduino
       
        // Pico 1
        Lp1 = L/4-28.76; // Position en X du pico 1 de la carte A.
        lp1 = (modele == "gaucher") ? (l2/2-0.54)-20 : l2/2-0.54+5; // Position en Y du pico 1 de la carte A.
        
        // Pico 2        
        Lp2 = Lp1-1.27;
        lp2 = lp1-48-0.26;
        
        // Pico 3        
        Lp3 = Lp1+50.8;
        lp3 = lp1-15-0.24;
        
        // Pico 4       
        Lp4 = Lp3;
        lp4 = lp3-27-0.94;
        
        hrc = (modele == "gaucher") ? (13-1.8)  : 2;
        // Hauteur Rehaussement Carte A. (pour éviter quelle touche le fond du socle)
            
        rp=1.59/1; // Rayon des picos
        hp= (hrc+1.8*2.5); // Hauteur des picos (2.5 * hauteur de la carte)
    }
        
    //////////////////////////////////////////

    /*--------------------------------- Cable USB --------------------------------------*/
    {
    // Coordonnee [x,y] des 3 picos pour passer le cable.

    hfc = pt+0.5; // Hauteur Fente Cable
    hpc = 5.5/1; // Hauteur Pico Cable
    hcc = 2/1; // Hauteur Couronne Cable
    rc = 1.5/1; // Rayon Cable

    Lpc1 = -L2/2+7.5; // Position en X du pico 1 du cable
    lpc1 = (modele == "gaucher") ? -(lp1-2) : (lp1-27); // Position en Y du pico 1 du cable

    Lpc3 = -L2/4+8;
    lpc3 = (modele == "gaucher") ? -3.5 : 3.5;
    }
}
//////////////////////////////////////////

module enveloppe_socle_bas () // Gris
{    
    color("grey")
    translate ([0,0,h/2]) // On remonte la base du socle au niveau du repère
    
    difference()
    {
    
        minkowski() // Enveloppe exterieure
        {        
            cube ([L-2*s,l-2*s,h-2*s], center = true);
            sphere(s,$fn=50);
        }
        minkowski() // Enveloppe intérieure
        {   
            cube ([L2,l2,h2], center = true);
            sphere(s/2,$fn=50);
        }
    
        //Division du haut et du bas du socle   
        translate ([0,0,1/4*h]) cube([L+1,l+1,h],center = true);
        
        // Diminution de l'épaisseur du haut et du bas (de moitier), ceci permet d'obtenir un hauteur minimale intérieur de 35mm (au lieu de 39)
        minkowski()
        {   
            cube ([L2,l2,h-2*s/2-e], center = true);
            sphere(s/2,$fn=50);
        }
    
    }

}
//////////////////////////////////////////

module vis_fixation () // Jaune
{
    color ("yellow")
    difference()
    {
        for (i = [-1:2:1],
         j = [-1:2:1])    
        {
        difference()
        {
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h4/2])
            cylinder (r=r4,h=h4,center = true, $fn=50);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1])
            cylinder (r=r42,h=h42,center = true, $fn=50);
        }
        }
        tete_de_vis();
    }
}
//////////////////////////////////////////

module tete_de_vis () // Sans couleur (Trou)
{
    for (i = [-1:2:1], // i allant de -1 à 1 avec un pas de 2 donc i =-1 puis 1
         j = [-1:2:1]) // i dem
    {
        translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),htv/2+1-0.02])
        cylinder (r1=rtv1,r2=rtv2,h=htv,center = true, $fn=50);
        translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),1/2-0.01])
        cylinder (r=rtv1,h=1,center = true, $fn=50);
    }
}
//////////////////////////////////////////

module tranchee () // Bleue
{
    color ("blue")
    for (i = [-1:2:1])
    {
        minkowski ()
        {
            translate ([i*(L/2-e/2),0,(-(pt/2+s2-1/4*h)+1.01)]) cube ([e-2*s2-1.6,3/4*l2,pt], center = true);
            sphere(s2, $fn=40);
        }
        minkowski ()
        {
            translate ([0,i*(l/2-e/2),(-(pt/2+s2-1/4*h)+1.01)]) cube ([3/4*L2,e-2*s2-1.6,pt], center = true);
            sphere(s2, $fn=40);
        }
    }
}
//////////////////////////////////////////

module coins () // Rouge
{
 color("red")
difference()
{
    for (i = [-1:2:1],
         j = [-1:2:1])
    {
        difference()
        {        
            linear_extrude(height=h4)
            polygon(points = 
            [[i*(L2/2-r4+2*s2),j*(l2/2+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2-r4+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2+2*s2)]],
            paths = [[0,1, 2,3]]);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1])       
            cylinder (r=r42,h=h42,center = true, $fn=50);
        }
        difference() 
        {        
            linear_extrude(height=h4)
            polygon(points = 
            [[i*(L2/2-2*r4+2*s2),j*(l2/2+2*s2)],
            [i*(L2/2+2*s2-2*r4),j*(l2/2-r4+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2+2*s2)]],
            paths = [[0,1, 2,3]]);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1]) 
            cylinder (r=r42,h=h42,center = true, $fn=50);
        }
        difference()
        {        
            linear_extrude(height=h4)
            polygon(points = 
            [[i*(L2/2-r4+2*s2),j*(l2/2+2*s2-2*r4)],
            [i*(L2/2+2*s2),j*(l2/2-r4+2*s2)],
            [i*(L2/2+2*s2),j*(l2/2+2*s2-2*r4)]],
            paths = [[0,1, 2,3]]);
            translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1]) 
            cylinder (r=r42,h=h42,center = true, $fn=50);
        }
        difference()
        {
            translate ([i*(L2/2-2*r4+2*s2),j*(l2/2+2*s2),h1/2])
            cube ([x,x,h1], center = true);
           translate ([i*(L2/2-2*r4+2*s2),j*(l2/2+2*s2+1.7),h1/2+0.01])
            cube ([x+1,x,h1], center = true);
            translate ([i*(L2/2-2*r4+2*s2-x/2),j*(l2/2+2*s2-x/2),h1/2+0.01])
            cylinder (r=x/2, h=h1, center = true, $fn=50);
        }
        difference()
        {
            translate ([i*(L2/2+2*s2),j*(l2/2-2*r4+2*s2),h1/2])
            cube ([x,x,h1], center = true);
            translate ([i*(L2/2+2.2),j*(l2/2-2*r4+1),h1/2+1])
            cube ([x,x+1,h1], center = true);
            translate ([i*(L2/2+2*s2-x/2),j*(l2/2-2*r4+2*s2-x/2),h1/2+0.01])
            cylinder (r=x/2, h=h1, center = true, $fn=50);
        }
    }
    tete_de_vis();
}
}
//////////////////////////////////////////

module placement_picos_arduino (x,y) // Coordonnée [x,y] d'un pico à rentrer
{
    difference() // Pico
    {
        minkowski()
        {
            translate ([x,y,(hp)/2+e/2])
            cylinder (r=rp-s2,h=hp-2*s2,$fn=50, center = true);
            sphere (s2,$fn=50);
        }
    //////////////////////////////////////////
        
        // Ces deux "difference()" ne sont la que pour remplire les picos (sans sa limprimante les rempli a 20% et ils ne sont pas assez résistant)"
        translate ([x,y,10]) difference()
        {
            cylinder (r=rp+0.02, h=hp, center = true, $fn = 50);
            cylinder (r=rp+0.01, h=hp+0.01, $fn = 50, center = true);
        }
        translate ([x,y,10]) difference()
        {
            cylinder (r=rp+0.6, h=hp, center = true, $fn = 50);
            cylinder (r=rp+0.59, h=hp+0.01, $fn = 50, center = true);
        }
    }
    
    //////////////////////////////////////////
    
    // Cylindre de rehaussement
    translate ([x,y,hrc/2+e/2])
    cylinder (r=rp+1.2,h=hrc,$fn=50, center = true);
}
//////////////////////////////////////////

module fente_cable ()
{
        translate ([-(L/2-e/2),0,-hfc/2+1/4*h+s2]) cube ([e+0.01,6,hfc], center = true);
}
//////////////////////////////////////////

module picos_arduino () // Jaune
{
    color ("yellow")
    {
        if (modele == "ambidextre")
        {
            placement_picos_arduino(Lp1,lp1);
            placement_picos_arduino(Lp2,lp2);
            placement_picos_arduino(Lp3,lp3);
            placement_picos_arduino(Lp4,lp4);
        }
        if (modele=="droitier")
        {
            placement_picos_arduino(Lp1,lp1);
            placement_picos_arduino(Lp2,lp2);
            placement_picos_arduino(Lp3,lp3);
            placement_picos_arduino(Lp4,lp4);
        }
            if (modele=="gaucher")
        {
            placement_picos_arduino(Lp1,-lp1);
            placement_picos_arduino(Lp2,-lp2);
            placement_picos_arduino(Lp3,-lp3);
            placement_picos_arduino(Lp4,-lp4);
        }
    }
}
//////////////////////////////////////////

module placement_picos_cable(x,y)
{
    translate ([x,y,hpc/2+e/2])
    cylinder (r=rc, h= hpc, $fn = 50, center = true);
    translate ([x,y,hcc/2+hpc+e/2])
    cylinder (r=2*rc, h= hcc, $fn = 50, center = true); 
}
//////////////////////////////////////////

module picos_cable ()
{
    placement_picos_cable (Lpc1,lpc1);
    placement_picos_cable (Lpc3,lpc3);
}
//////////////////////////////////////////

module socle_bas () // Ensembe
{
    union()
    {
    
        // Trous dans le socle pour les vis
        difference()
        {
            enveloppe_socle_bas();
            for (i = [-1:2:1],j = [-1:2:1])
            {
                translate ([i*(L2/2-(r4-s/2)),j*(l2/2-(r4-s/2)),h42/2-1]) 
                cylinder (r=r42,h=h42,center = true, $fn=50);
            }
            fente_cable ();
            tete_de_vis();
            tranchee();
        }
        vis_fixation();
        coins();
        picos_cable();
        if (modele == "gaucher")
        {
            translate([0,-15,0])
            {
                picos_arduino();
            }
        }
        else translate([0,-10,0])
            {
                picos_arduino();
            }
    }
}
//////////////////////////////////////////
//////////////////////////////////////
//////////////////////////////////
//////////////////////////////////////
//////////////////////////////////////////

difference()
{
    socle_bas();
    minkowski()
    {
        K([-6,4,0],[0,0,-90],[1.5,1.5]);
        sphere(1);
    }
}
//////////////////////////////////////////
//////////////////////////////////////
//////////////////////////////////
//////////////////////////////////////
//////////////////////////////////////////

/*
//////////////////////////////////////////
if (modele == "gaucher")
{
    translate([0,-l/4+2.12+36-7.5,12+7]) rotate ([180,0,0])
    {
        translate ([-11.5,45,4]) rotate ([0,0,-90]) arduino(4);    
        hull()
        {
        translate ([-12,24,5/2+4]) rotate ([0,0,90]) cube ([11,11,5]);
        translate ([-25,24.5,5/2+4]) rotate ([0,0,90]) cube ([10,10,5]);
        translate ([-12-43,24.5-1+3.5,2/2+11]) rotate ([0,0,90]) cube ([5,5,5]);
        }
    }
}
else 
{
    translate([0,-l/4+2.12-1+21,0])
    {
        translate ([-11.5,45,4]) rotate ([0,0,-90]) arduino(4);    
        hull()
        {
        translate ([-12,24,5/2+4]) rotate ([0,0,90]) cube ([11,11,5]);
        translate ([-25,24.5,5/2+4]) rotate ([0,0,90]) cube ([10,10,5]);
        translate ([-12-43,24.5-1+3.5,2/2+2]) rotate ([0,0,90]) cube ([5,5,5]);
        }
    }
}
//////////////////////////////////////////
//////////////////////////////////////////
//////////////////////////////////////////
/*

u=48;
hj=13; // Hauteur joystick
u2=30;
hj2=7;
u3=10;
hj3=2;



color ("green") translate ([(-1/4*L-2),0,-hj/2+h-e/2]) cube ([u,u,hj], center = true);
color ("green") translate ([(-1/4*L-2),0,-hj/2+h-e/2-hj/2-3.5]) cube ([u2,u2,hj2], center = true);
color ("green") translate ([(-1/4*L-2),0,-hj/2+h-e/2-hj/2-3.5-4]) cylinder (r=u3/2,h=hj3, center = true);