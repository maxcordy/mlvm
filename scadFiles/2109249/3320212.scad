/*


    Halterung für Raspi-Kamera in Strahlergehäuse

    14.02.2017  Initial version
    
*/

// Auflösung anpassen
//
$fn = 400;
//$fn = 10;

// Welches Modell?
//
zoom=false;

// Parameter
//
x_size=81;
y_size=62.5;
tiefe = 25;
skala=2;

module Huelse()
{
    linear_extrude(tiefe, scale = skala, center = true)
    {
        offset(0)
        {
            translate([-x_size/2, -y_size/2, 0])
            square([x_size, y_size], 0);
        }
    }
}

module Innenhuelse()
{
    linear_extrude(tiefe, scale = skala, center = true)
    {
        offset(0)
        {
            translate([-(x_size-3)/2, -(y_size-3)/2, 0])
            square([x_size - 3, y_size - 3], 0);
        }
    }
}

module Box()
{
    translate([-(x_size)/2, -(y_size)/2, -14])
    linear_extrude(2)
    {
        offset(0)
        {
            square([x_size, y_size], 0);
        }
    }
}

module Innenbox()
{
    if (!zoom)
    {
        translate([-(12)/2, -5, -14])
        linear_extrude(3)
        {
            offset(0)
            {
                square([12, 18], 0);
            }
        }
    }
}

module Zoomloch()
{
    if (zoom)
    {
     translate([-14/2, -1, -14])
    
     linear_extrude(3)
     {
         square([14,14]);
     }

     // Linsenbalken
     //
     translate([-23/2, 3.5, -14])
    
     linear_extrude(3)
     {
         square([23,5.5]);
     }
    }
}
module Steckerleiste()
{
    // Unteres Loch für die Steckerleiste
    //
    if (zoom)
    {
     translate([-23/2, -10, -14])
    
     linear_extrude(3)
     {
         square([23,7]);
     }
    }
}

module Schraubloecher()
{
    // Untere
    //
    translate([-21/2, -1, -14])
    
    linear_extrude(3)
    {
        circle(1);
    }

    translate([+21/2, -1, -14])
    
    linear_extrude(3)
    {
        circle(1);
    }

    // Obere
    //
    if (!zoom)
    {
        translate([-21/2, 12, -14])
        linear_extrude(3)
        {
            circle(1);
        }
    }
    else
    {
        translate([-21/2, 13, -14])
        linear_extrude(3)
        {
            circle(1);
        }
    }

    if (!zoom)
    {
        translate([+21/2, 12, -14])
        linear_extrude(3)
        {
            circle(1);
        }
    }
    else
    {
        translate([+21/2, 13, -14])
        linear_extrude(3)
        {
            circle(1);
        }
    }
}

difference()
{
    Huelse();
    Innenhuelse();
}

difference()
{
    Box();
    
    Schraubloecher();
    
    Zoomloch();
    Steckerleiste();
    
    Innenbox();
}
