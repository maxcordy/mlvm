// Spiel zwischen Zahnflanken
spiel = 0.05;
// Höhe des Zahnkopfes über dem Teilkreis
modul=1;
// Anzahl der Radzähne
zahnzahl=32;
// Höhe des Zahnrads
hoehe=5;
// Breite des Randes ab Fußkreis
randbreite=4;
// Eingriffswinkel, Standardwert = 20° gemäß DIN 867
eingriffswinkel=20;
// Schrägungswinkel zur Rotationsachse; 0° = Geradverzahnung
schraegungswinkel=15;


/* Bibliothek für Evolventen-Zahnräder

Enthält die Module
hohlrad(modul, zahnzahl, hoehe, randbreite, eingriffswinkel = 20, schraegungswinkel = 0)

Autor:		Dr Jörg Janssen
Stand:		20. Juni 2016
Version:	1.1
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

/*	Wandelt Radian in Grad um */
function grad(eingriffswinkel) =  eingriffswinkel*rad;

/*	Wandelt Grad in Radian um */
function radian(eingriffswinkel) = eingriffswinkel/rad;

/*	Wandelt 2D-Polarkoordinaten in kartesische um
    Format: radius, phi; phi = Winkel zur x-Achse auf xy-Ebene */
function pol_zu_kart(polvect) = [
	polvect[0]*cos(polvect[1]),  
	polvect[0]*sin(polvect[1])
];

/*	Kreisevolventen-Funktion:
    Gibt die Polarkoordinaten einer Kreisevolvente aus
    r = Radius des Grundkreises
    rho = Abrollwinkel in Grad */
function ev(r,rho) = [
	r/cos(rho),
	grad(tan(rho)-radian(rho))
];

/*	Hohlrad nach DIN 3993
    modul = Höhe des Zahnkopfes über dem Teilkreis
    zahnzahl = Anzahl der Radzähne
    hoehe = Höhe des Zahnrads
	randbreite = Breite des Randes ab Fußkreis
    bohrung = Durchmesser der Mittelbohrung
    eingriffswinkel = Eingriffswinkel, Standardwert = 20° gemäß DIN 867
    schraegungswinkel = Schrägungswinkel, Standardwert = 0° (Geradverzahnung) */
module hohlrad(modul, zahnzahl, hoehe, randbreite, eingriffswinkel = 20, schraegungswinkel = 0) {

	// Dimensions-Berechnungen	
	ha = (zahnzahl >= 20) ? 0.02 * atan((zahnzahl/15)/pi) : 0.6;// Verkürzungsfaktor Zahnkopfhöhe
	d = modul * zahnzahl;										// Teilkreisdurchmesser
	r = d / 2;													// Teilkreisradius
	alpha_stirn = atan(tan(eingriffswinkel)/cos(schraegungswinkel));	// Schrägungswinkel im Stirnschnitt
	db = d * cos(alpha_stirn);									// Grundkreisdurchmesser
	rb = db / 2;												// Grundkreisradius
	c = modul / 6;												// Kopfspiel
	da = (modul <1)? d + (modul+c) * 2.2 : d + (modul+c) * 2;	// Kopfkreisdurchmesser
	ra = da / 2;												// Kopfkreisradius
	df = d - 2 * modul * ha;									// Fußkreisdurchmesser
	rf = df / 2;												// Fußkreisradius
	
	rho_ra = acos(rb/ra);										// maximaler Evolventenwinkel;
																// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	rho_r = acos(rb/r);											// Evolventenwinkel am Teilkreis;
																// Evolvente beginnt auf Grundkreis und endet an Kopfkreis
	phi_r = grad(tan(rho_r)-radian(rho_r));						// Winkel zum Punkt der Evolvente auf Teilkreis

	gamma = rad*hoehe/(r*tan(90-schraegungswinkel));	// Torsionswinkel für Extrusion
	
	schritt = rho_ra/16;										// Evolvente wird in 16 Stücke geteilt
	tau = 360/zahnzahl;											// Teilungswinkel

	// Zeichnung
	rotate([0,0,-phi_r-90*(1+spiel)/zahnzahl])						// Zahn auf x-Achse zentrieren;
																	// macht Ausrichtung mit anderen Rädern einfacher
	linear_extrude(height = hoehe, twist = gamma){
		difference(){
			circle(r = ra + randbreite);							// Außenkreis
			union(){
				circle(rf);											// Fußkreis	
				for (rot = [0:tau:360]){
					rotate (rot) {									// "Zahnzahl-mal" kopieren und drehen
						polygon( concat(
							[[0,0]],
							[for (rho = [0:schritt:rho_ra])			// von null Grad (Grundkreis)
																	// bis maximaler Evolventenwinkel (Kopfkreis)
								pol_zu_kart(ev(rb,rho))],
							[pol_zu_kart(ev(rb,rho_ra))],
							[for (rho = [rho_ra:-schritt:0])		// von maximaler Evolventenwinkel (Kopfkreis)
																	// bis null Grad (Grundkreis)
								pol_zu_kart([ev(rb,rho)[0], (180*(1+spiel))/zahnzahl+2*phi_r-ev(rb,rho)[1]])]
																	// (180*(1+spiel)) statt 180,
																	// um Spiel an den Flanken zu erlauben
							)
						);
					}
				}
			}
		}
	}

	echo("Außendurchmesser Hohlrad = ", 2*(ra + randbreite));
	
}

hohlrad(modul, zahnzahl, hoehe, randbreite, eingriffswinkel, schraegungswinkel);