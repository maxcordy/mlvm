// Kopfspiel
spiel = 0.05;
// Höhe des Zahnkopfes über der Wälzgeraden
modul = 1;
// Laenge der Zahnstange
laenge = 32;
// Höhe der Zahnstange bis zur Wälzgeraden
hoehe = 3;
// Breite der Zähne
breite = 5;
// Eingriffswinkel, Standardwert = 20° gemäß DIN 867. Sollte nicht größer als 45° sein.
eingriffswinkel = 20;
// Schrägungswinkel zur Zahnstangen-Querachse; 0° = Geradverzahnung
schraegungswinkel = 0;

/* Bibliothek für Zahnstange für Thingiverse Customizer

Enthält die Module
zahnstange(modul, laenge, hoehe, breite, eingriffswinkel = 20, schraegungswinkel = 0)

Autor:		Dr Jörg Janssen
Stand:		6. Januar 2017
Version:	2.0
Lizenz:		Creative Commons - Attribution, Non Commercial, Share Alike

Erlaubte Module nach DIN 780:
0.05 0.06 0.08 0.10 0.12 0.16
0.20 0.25 0.3  0.4  0.5  0.6
0.7  0.8  0.9  1    1.25 1.5
2    2.5  3    4    5    6
8    10   12   16   20   25
32   40   50   60

*/


/* [Hidden] */
pi = 3.14159;
rad = 57.29578;
$fn = 96;

/*	Kopiert und dreht einen Körper */
module kopiere(vect, zahl, abstand, winkel){
	for(i = [0:zahl-1]){
		translate(v=vect*abstand*i)
			rotate(a=i*winkel, v = [0,0,1])
				children(0);
	}
}

/*  Zahnstange
    modul = Höhe des Zahnkopfes über der Wälzgeraden
    laenge = Laenge der Zahnstange
    hoehe = Höhe der Zahnstange bis zur Wälzgeraden
    breite = Breite der Zähne
    eingriffswinkel = Eingriffswinkel, Standardwert = 20° gemäß DIN 867. Sollte nicht größer als 45° sein.
    schraegungswinkel = Schrägungswinkel zur Zahnstangen-Querachse; 0° = Geradverzahnung */
module zahnstange(modul, laenge, hoehe, breite, eingriffswinkel = 20, schraegungswinkel = 0) {

	// Dimensions-Berechnungen
	c = modul / 6;												// Kopfspiel
	mx = modul/cos(schraegungswinkel);							// Durch Schrägungswinkel verzerrtes modul in x-Richtung
	a = 2*mx*tan(eingriffswinkel)+c*tan(eingriffswinkel);		// Flankenbreite
	b = pi*mx/2-2*mx*tan(eingriffswinkel);						// Kopfbreite
	x = breite*tan(schraegungswinkel);							// Verschiebung der Oberseite in x-Richtung durch Schrägungswinkel
	nz = ceil((laenge+abs(2*x))/(pi*mx));						// Anzahl der Zähne
	
	translate([-pi*mx*(floor(nz/2)-1)-a-b/2,-modul,0]){
		intersection(){
			kopiere([1,0,0], nz, pi*mx, 0){
				polyhedron(
					points=[[0,-c,0], [a,2*modul,0], [a+b,2*modul,0], [2*a+b,-c,0], [pi*mx,-c,0], [pi*mx,modul-hoehe,0], [0,modul-hoehe,0],	// Unterseite
						[0+x,-c,breite], [a+x,2*modul,breite], [a+b+x,2*modul,breite], [2*a+b+x,-c,breite], [pi*mx+x,-c,breite], [pi*mx+x,modul-hoehe,breite], [0+x,modul-hoehe,breite]],	// Oberseite
					faces=[[6,5,4,3,2,1,0],						// Unterseite
						[1,8,7,0],
						[9,8,1,2],
						[10,9,2,3],
						[11,10,3,4],
						[12,11,4,5],
						[13,12,5,6],
						[7,13,6,0],
						[7,8,9,10,11,12,13],					// Oberseite
					]
				);
			};
			translate([abs(x),-hoehe+modul-0.5,-0.5]){
				cube([laenge,hoehe+modul+1,breite+1]);
			}	
		};
	};	
}

zahnstange(modul, laenge, hoehe, breite, eingriffswinkel, schraegungswinkel);