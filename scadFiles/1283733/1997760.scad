/* Copyright (C) 2011  Philipp Klostermann
Email the autor: philipp.klostermann@pksl.de
*/

fn=72;
tol=0.02;
wackel=0.6;
spuleninnendurchmesser=55;
kugellageraussendurchmesser=22;
kugellagerdicke=7;
kugellagerauflagebreite=2.5;
wanddicke=2;
rand=10;
// Materialbeschriftung="";
// Materialbeschriftung="ABS";
Materialbeschriftung="PLA";
praegetiefe=0.5;
praegegroesse=5;

kad = (kugellageraussendurchmesser / cos(180/fn)) + wackel;
echo ("kad korrigiert nach ", kad);

// $fn = fn;

module Ring(durchmesser, hoehe, innendurchmesser)
{
	difference()
	{
		cylinder(h=hoehe, r=durchmesser/2, $fn = fn);
		translate([0,0, -tol])
		cylinder(h=hoehe + tol*2, r=innendurchmesser/2, $fn = fn);
	}
}

module Traeger(hoehe, dicke, entfernung, breite, hoehe)
{
	translate([entfernung,0,0])
	{
		rotate([90,0,0])
		{
			linear_extrude(height=dicke)
			{
				polygon(points = 
				[ 
					[0,0],
					[breite,0],[breite,-hoehe] ]);
			}
		}
	}
}

module Traegerring(dicke, aussenradius, innenradius, winkel)
{
	for(winkel = [0 : winkel : 360-winkel])
	rotate([0,0,winkel])
	{
		Traeger(hoehe, 
				dicke, 
				innenradius, 
				aussenradius-innenradius, 
				aussenradius-innenradius);
	}
}
// Der Boden:
difference()
{
	Ring(spuleninnendurchmesser + 2*rand, wanddicke, kad);
	if (Materialbeschriftung != "")
	translate([0,kad/2+wanddicke+praegegroesse/3,wanddicke-praegetiefe])
	{
		linear_extrude(height=praegetiefe+tol)
		{
			text(text=Materialbeschriftung, halign="center", font="Arial", size=praegegroesse);
		}
	}
}

// Die Halterung für die Spule:
Ring(spuleninnendurchmesser, kugellagerdicke*2, spuleninnendurchmesser - wanddicke*2);
// Die Halterung für das Kugellager:
Ring(kad+wanddicke*2, kugellagerdicke, kad);
// Damit es nicht nach innen rutscht:
translate([0,0,kugellagerdicke])
{
	Ring(kad+wanddicke*2, 
		wanddicke, 
		kad-kugellagerauflagebreite*2);
// Und die Unterstützung als einfach zu entfernender Support:
	Traegerring(0.5, 
			kad/2, 
			kad/2-kugellagerauflagebreite, 
			45);
}
