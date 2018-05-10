/*---------------------------------------------------------\
|     From: Ekobots Innovation Ltda - www.ekobots.com      |
|       by: Lauro Sirgado and Juan Sirgado y Antico        |
|                   www.jsya.com.br                        |
|----------------------------------------------------------|
|         Program Le Penseur Base Pharse - 2015/06/20      |
|                All rights reserved 2015                  |
|                Revision V1.000                           |
|---------------------------------------------------------*/

// Le Penseur Base Pharse Customizable.

//Caution this utility model is very dangerous for children, see below

//Warning: Small parts kill children if aspirated, see below

// This model is not a toy, it is inappropriate for children, the
// parts are small and fragile, very easy to be broken and can cause
// fatal injuries if aspirated by children. Please look into:
// http://en.wikipedia.org/wiki/Toy_safety
// http://en.wikipedia.org/wiki/Home_Safety_Council

//---------------------------------------------------------|

// Le Penseur Base Pharse Customizable.

// This small disk read thoughts, seeking the deepest thinker's mind dilemmas

// All parameters

/* [Central text] */

//01 - central text, select here
listtextcentral="central text example"; //[long-term thinking, Show me, Be curious, I'm a simple person, Never give up, Never stop dreaming, Life is to short, Life is to short, H.O.P.E., keep your head up]
//02 - central text, use your text if modify this phrase (use spaces to displace the text), string; 
yourtextcentral="place your text here";

usertextcentral=(yourtextcentral=="place your text here")?listtextcentral:yourtextcentral;

//03 - central font name, string
fontnamecentral="Antic"; //[ABeeZee, Abel, Abril Fatface, Aclonica, Acme, Actor, Adamina, Advent Pro, Aguafina Script, Akronim, Aladin, Aldrich, Alef, Alegreya, Alegreya SC, Alegreya Sans, Alegreya Sans SC, Alex Brush, Alfa Slab One, Alice, Alike, Alike Angular, Allan, Allerta, Allerta Stencil, Allura, Almendra, Almendra Display, Almendra SC, Amarante, Amaranth, Amatic SC, Amethysta, Amiri, Amita, Anaheim, Andada, Andika, Angkor, Annie Use Your Telescope, Anonymous Pro, Antic, Antic Didone, Antic Slab, Anton, Arapey, Arbutus, Arbutus Slab, Architects Daughter, Archivo Black, Archivo Narrow, Arimo, Arizonia, Armata, Artifika, Arvo, Arya, Asap, Asset, Astloch, Asul, Atomic Age, Aubrey, Audiowide, Autour One, Average, Average Sans, Averia Gruesa Libre, Averia Libre, Averia Sans Libre, Averia Serif Libre, Bad Script, Balthazar, Bangers, Basic, Battambang, Baumans, Bayon, Belgrano, Belleza, BenchNine, Bentham, Berkshire Swash, Bevan, Bigelow Rules, Bigshot One, Bilbo, Bilbo Swash Caps, Biryani, Bitter, Black Ops One, Bokor, Bonbon, Boogaloo, Bowlby One, Bowlby One SC, Brawler, Bree Serif, Bubblegum Sans, Bubbler One, Buda, Buenard, Butcherman, Butterfly Kids, Cabin, Cabin Condensed, Cabin Sketch, Caesar Dressing, Cagliostro, Calligraffitti, Cambay, Cambo, Candal, Cantarell, Cantata One, Cantora One, Capriola, Cardo, Carme, Carrois Gothic, Carrois Gothic SC, Carter One, Caudex, Cedarville Cursive, Ceviche One, Changa One, Chango, Chau Philomene One, Chela One, Chelsea Market, Chenla, Cherry Cream Soda, Cherry Swash, Chewy, Chicle, Chivo, Cinzel, Cinzel Decorative, Clicker Script, Coda, Coda Caption, Codystar, Combo, Comfortaa, Coming Soon, Concert One, Condiment, Content, Contrail One, Convergence, Cookie, Copse, Corben, Courgette, Cousine, Coustard, Covered By Your Grace, Crafty Girls, Creepster, Crete Round, Crimson Text, Croissant One, Crushed, Cuprum, Cutive, Cutive Mono, Damion, Dancing Script, Dangrek, Dawning of a New Day, Days One, Dekko, Delius, Delius Swash Caps, Delius Unicase, Della Respira, Denk One, Devonshire, Dhurjati, Didact Gothic, Diplomata, Diplomata SC, Domine, Donegal One, Doppio One, Dorsa, Dosis, Dr Sugiyama, Droid Sans, Droid Sans Mono, Droid Serif, Duru Sans, Dynalight, EB Garamond, Eagle Lake, Eater, Economica, Ek Mukta, Electrolize, Elsie, Elsie Swash Caps, Emblema One, Emilys Candy, Engagement, Englebert, Enriqueta, Erica One, Esteban, Euphoria Script, Ewert, Exo, Exo 2, Expletus Sans, Fanwood Text, Fascinate, Fascinate Inline, Faster One, Fasthand, Fauna One, Federant, Federo, Felipa, Fenix, Finger Paint, Fira Mono, Fira Sans, Fjalla One, Fjord One, Flamenco, Flavors, Fondamento, Fontdiner Swanky, Forum, Francois One, Freckle Face, Fredericka the Great, Fredoka One, Freehand, Fresca, Frijole, Fruktur, Fugaz One, GFS Didot, GFS Neohellenic, Gabriela, Gafata, Galdeano, Galindo, Gentium Basic, Gentium Book Basic, Geo, Geostar, Geostar Fill, Germania One, Gidugu, Gilda Display, Give You Glory, Glass Antiqua, Glegoo, Gloria Hallelujah, Goblin One, Gochi Hand, Gorditas, Goudy Bookletter 1911, Graduate, Grand Hotel, Gravitas One, Great Vibes, Griffy, Gruppo, Gudea, Gurajada, Habibi, Halant, Hammersmith One, Hanalei, Hanalei Fill, Handlee, Hanuman, Happy Monkey, Headland One, Henny Penny, Herr Von Muellerhoff, Hind, Holtwood One SC, Homemade Apple, Homenaje, IM Fell DW Pica, IM Fell DW Pica SC, IM Fell Double Pica, IM Fell Double Pica SC, IM Fell English, IM Fell English SC, IM Fell French Canon, IM Fell French Canon SC, IM Fell Great Primer, IM Fell Great Primer SC, Iceberg, Iceland, Imprima, Inconsolata, Inder, Indie Flower, Inika, Irish Grover, Istok Web, Italiana, Italianno, Jacques Francois, Jacques Francois Shadow, Jaldi, Jim Nightshade, Jockey One, Jolly Lodger, Josefin Sans, Josefin Slab, Joti One, Judson, Julee, Julius Sans One, Junge, Jura, Just Another Hand, Just Me Again Down Here, Kalam, Kameron, Kantumruy, Karla, Karma, Kaushan Script, Kavoon, Kdam Thmor, Keania One, Kelly Slab, Kenia, Khand, Khmer, Khula, Kite One, Knewave, Kotta One, Koulen, Kranky, Kreon, Kristi, Krona One, Kurale, La Belle Aurore, Laila, Lakki Reddy, Lancelot, Lateef, Lato, League Script, Leckerli One, Ledger, Lekton, Lemon, Libre Baskerville, Life Savers, Lilita One, Lily Script One, Limelight, Linden Hill, Lobster, Lobster Two, Londrina Outline, Londrina Shadow, Londrina Sketch, Londrina Solid, Lora, Love Ya Like A Sister, Loved by the King, Lovers Quarrel, Luckiest Guy, Lusitana, Lustria, Macondo, Macondo Swash Caps, Magra, Maiden Orange, Mako, Mallanna, Mandali, Marcellus, Marcellus SC, Marck Script, Margarine, Marko One, Marmelad, Martel, Martel Sans, Marvel, Mate, Mate SC, Maven Pro, McLaren, Meddon, MedievalSharp, Medula One, Megrim, Meie Script, Merienda, Merienda One, Merriweather, Merriweather Sans, Metal, Metal Mania, Metamorphous, Metrophobic, Michroma, Milonga, Miltonian, Miltonian Tattoo, Miniver, Miss Fajardose, Modak, Modern Antiqua, Molengo, Molle, Monda, Monofett, Monoton, Monsieur La Doulaise, Montaga, Montez, Montserrat, Montserrat Alternates, Montserrat Subrayada, Moul, Moulpali, Mountains of Christmas, Mouse Memoirs, Mr Bedfort, Mr Dafoe, Mr De Haviland, Mrs Saint Delafield, Mrs Sheppards, Muli, Mystery Quest, NTR, Neucha, Neuton, New Rocker, News Cycle, Niconne, Nixie One, Nobile, Nokora, Norican, Nosifer, Nothing You Could Do, Noticia Text, Noto Sans, Noto Serif, Nova Cut, Nova Flat, Nova Mono, Nova Oval, Nova Round, Nova Script, Nova Slim, Nova Square, Numans, Nunito, Odor Mean Chey, Offside, Old Standard TT, Oldenburg, Oleo Script, Oleo Script Swash Caps, Open Sans, Open Sans Condensed, Oranienbaum, Orbitron, Oregano, Orienta, Original Surfer, Oswald, Over the Rainbow, Overlock, Overlock SC, Ovo, Oxygen, Oxygen Mono, PT Mono, PT Sans, PT Sans Caption, PT Sans Narrow, PT Serif, PT Serif Caption, Pacifico, Palanquin, Palanquin Dark, Paprika, Parisienne, Passero One, Passion One, Pathway Gothic One, Patrick Hand, Patrick Hand SC, Patua One, Paytone One, Peddana, Peralta, Permanent Marker, Petit Formal Script, Petrona, Philosopher, Piedra, Pinyon Script, Pirata One, Plaster, Play, Playball, Playfair Display, Playfair Display SC, Podkova, Poiret One, Poller One, Poly, Pompiere, Pontano Sans, Port Lligat Sans, Port Lligat Slab, Pragati Narrow, Prata, Preahvihear, Press Start 2P, Princess Sofia, Prociono, Prosto One, Puritan, Purple Purse, Quando, Quantico, Quattrocento, Quattrocento Sans, Questrial, Quicksand, Quintessential, Qwigley, Racing Sans One, Radley, Rajdhani, Raleway, Raleway Dots, Ramabhadra, Ramaraja, Rambla, Rammetto One, Ranchers, Rancho, Ranga, Rationale, Ravi Prakash, Redressed, Reenie Beanie, Revalia, Ribeye, Ribeye Marrow, Righteous, Risque, Roboto, Roboto Condensed, Roboto Mono, Roboto Slab, Rochester, Rock Salt, Rokkitt, Romanesco, Ropa Sans, Rosario, Rosarivo, Rouge Script, Rozha One, Rubik Mono One, Rubik One, Ruda, Rufina, Ruge Boogie, Ruluko, Rum Raisin, Ruslan Display, Russo One, Ruthie, Rye, Sacramento, Sail, Salsa, Sanchez, Sancreek, Sansita One, Sarina, Sarpanch, Satisfy, Scada, Scheherazade, Schoolbell, Seaweed Script, Sevillana, Seymour One, Shadows Into Light, Shadows Into Light Two, Shanti, Share, Share Tech, Share Tech Mono, Shojumaru, Short Stack, Siemreap, Sigmar One, Signika, Signika Negative, Simonetta, Sintony, Sirin Stencil, Six Caps, Skranji, Slabo 13px, Slabo 27px, Slackey, Smokum, Smythe, Sniglet, Snippet, Snowburst One, Sofadi One, Sofia, Sonsie One, Sorts Mill Goudy, Source Code Pro, Source Sans Pro, Source Serif Pro, Special Elite, Spicy Rice, Spinnaker, Spirax, Squada One, Sree Krushnadevaraya, Stalemate, Stalinist One, Stardos Stencil, Stint Ultra Condensed, Stint Ultra Expanded, Stoke, Strait, Sue Ellen Francisco, Sumana, Sunshiney, Supermercado One, Suranna, Suravaram, Suwannaphum, Swanky and Moo Moo, Syncopate, Tangerine, Taprom, Tauri, Teko, Telex, Tenali Ramakrishna, Tenor Sans, Text Me One, The Girl Next Door, Tienne, Timmana, Tinos, Titan One, Titillium Web, Trade Winds, Trocchi, Trochut, Trykker, Tulpen One, Ubuntu, Ubuntu Condensed, Ubuntu Mono, Ultra, Uncial Antiqua, Underdog, Unica One, UnifrakturCook, UnifrakturMaguntia, Unkempt, Unlock, Unna, VT323, Vampiro One, Varela, Varela Round, Vast Shadow, Vesper Libre, Vibur, Vidaloka, Viga, Voces, Volkhov, Vollkorn, Voltaire, Waiting for the Sunrise, Wallpoet, Walter Turncoat, Warnes, Wellfleet, Wendy One, Wire One, Yanone Kaffeesatz, Yellowtail, Yeseva One, Yesteryear, Zeyada]
//04 - central font size (adjust for fit), near mm, use zero for no text
fontsizecentral=2.3; //[0: 0.5: 50]

/* [Border text] */

//05 - border text, select here
listtextborder="border text example"; //[indispensable, don´t tell me, not judgmental, with a complex mind, if necessary reborn, but remain awake, to wait for me go, buy the ties, Hold on pain ends, keep your heart strong]
//06 - border text, use your text if modify this phrase (use spaces to displace the text), string; 
yourtextborder="place your text here";

usertextborder=(yourtextborder=="place your text here")?listtextborder:yourtextborder;

//07 - border font name, string
fontnameborder="Antic"; //[ABeeZee, Abel, Abril Fatface, Aclonica, Acme, Actor, Adamina, Advent Pro, Aguafina Script, Akronim, Aladin, Aldrich, Alef, Alegreya, Alegreya SC, Alegreya Sans, Alegreya Sans SC, Alex Brush, Alfa Slab One, Alice, Alike, Alike Angular, Allan, Allerta, Allerta Stencil, Allura, Almendra, Almendra Display, Almendra SC, Amarante, Amaranth, Amatic SC, Amethysta, Amiri, Amita, Anaheim, Andada, Andika, Angkor, Annie Use Your Telescope, Anonymous Pro, Antic, Antic Didone, Antic Slab, Anton, Arapey, Arbutus, Arbutus Slab, Architects Daughter, Archivo Black, Archivo Narrow, Arimo, Arizonia, Armata, Artifika, Arvo, Arya, Asap, Asset, Astloch, Asul, Atomic Age, Aubrey, Audiowide, Autour One, Average, Average Sans, Averia Gruesa Libre, Averia Libre, Averia Sans Libre, Averia Serif Libre, Bad Script, Balthazar, Bangers, Basic, Battambang, Baumans, Bayon, Belgrano, Belleza, BenchNine, Bentham, Berkshire Swash, Bevan, Bigelow Rules, Bigshot One, Bilbo, Bilbo Swash Caps, Biryani, Bitter, Black Ops One, Bokor, Bonbon, Boogaloo, Bowlby One, Bowlby One SC, Brawler, Bree Serif, Bubblegum Sans, Bubbler One, Buda, Buenard, Butcherman, Butterfly Kids, Cabin, Cabin Condensed, Cabin Sketch, Caesar Dressing, Cagliostro, Calligraffitti, Cambay, Cambo, Candal, Cantarell, Cantata One, Cantora One, Capriola, Cardo, Carme, Carrois Gothic, Carrois Gothic SC, Carter One, Caudex, Cedarville Cursive, Ceviche One, Changa One, Chango, Chau Philomene One, Chela One, Chelsea Market, Chenla, Cherry Cream Soda, Cherry Swash, Chewy, Chicle, Chivo, Cinzel, Cinzel Decorative, Clicker Script, Coda, Coda Caption, Codystar, Combo, Comfortaa, Coming Soon, Concert One, Condiment, Content, Contrail One, Convergence, Cookie, Copse, Corben, Courgette, Cousine, Coustard, Covered By Your Grace, Crafty Girls, Creepster, Crete Round, Crimson Text, Croissant One, Crushed, Cuprum, Cutive, Cutive Mono, Damion, Dancing Script, Dangrek, Dawning of a New Day, Days One, Dekko, Delius, Delius Swash Caps, Delius Unicase, Della Respira, Denk One, Devonshire, Dhurjati, Didact Gothic, Diplomata, Diplomata SC, Domine, Donegal One, Doppio One, Dorsa, Dosis, Dr Sugiyama, Droid Sans, Droid Sans Mono, Droid Serif, Duru Sans, Dynalight, EB Garamond, Eagle Lake, Eater, Economica, Ek Mukta, Electrolize, Elsie, Elsie Swash Caps, Emblema One, Emilys Candy, Engagement, Englebert, Enriqueta, Erica One, Esteban, Euphoria Script, Ewert, Exo, Exo 2, Expletus Sans, Fanwood Text, Fascinate, Fascinate Inline, Faster One, Fasthand, Fauna One, Federant, Federo, Felipa, Fenix, Finger Paint, Fira Mono, Fira Sans, Fjalla One, Fjord One, Flamenco, Flavors, Fondamento, Fontdiner Swanky, Forum, Francois One, Freckle Face, Fredericka the Great, Fredoka One, Freehand, Fresca, Frijole, Fruktur, Fugaz One, GFS Didot, GFS Neohellenic, Gabriela, Gafata, Galdeano, Galindo, Gentium Basic, Gentium Book Basic, Geo, Geostar, Geostar Fill, Germania One, Gidugu, Gilda Display, Give You Glory, Glass Antiqua, Glegoo, Gloria Hallelujah, Goblin One, Gochi Hand, Gorditas, Goudy Bookletter 1911, Graduate, Grand Hotel, Gravitas One, Great Vibes, Griffy, Gruppo, Gudea, Gurajada, Habibi, Halant, Hammersmith One, Hanalei, Hanalei Fill, Handlee, Hanuman, Happy Monkey, Headland One, Henny Penny, Herr Von Muellerhoff, Hind, Holtwood One SC, Homemade Apple, Homenaje, IM Fell DW Pica, IM Fell DW Pica SC, IM Fell Double Pica, IM Fell Double Pica SC, IM Fell English, IM Fell English SC, IM Fell French Canon, IM Fell French Canon SC, IM Fell Great Primer, IM Fell Great Primer SC, Iceberg, Iceland, Imprima, Inconsolata, Inder, Indie Flower, Inika, Irish Grover, Istok Web, Italiana, Italianno, Jacques Francois, Jacques Francois Shadow, Jaldi, Jim Nightshade, Jockey One, Jolly Lodger, Josefin Sans, Josefin Slab, Joti One, Judson, Julee, Julius Sans One, Junge, Jura, Just Another Hand, Just Me Again Down Here, Kalam, Kameron, Kantumruy, Karla, Karma, Kaushan Script, Kavoon, Kdam Thmor, Keania One, Kelly Slab, Kenia, Khand, Khmer, Khula, Kite One, Knewave, Kotta One, Koulen, Kranky, Kreon, Kristi, Krona One, Kurale, La Belle Aurore, Laila, Lakki Reddy, Lancelot, Lateef, Lato, League Script, Leckerli One, Ledger, Lekton, Lemon, Libre Baskerville, Life Savers, Lilita One, Lily Script One, Limelight, Linden Hill, Lobster, Lobster Two, Londrina Outline, Londrina Shadow, Londrina Sketch, Londrina Solid, Lora, Love Ya Like A Sister, Loved by the King, Lovers Quarrel, Luckiest Guy, Lusitana, Lustria, Macondo, Macondo Swash Caps, Magra, Maiden Orange, Mako, Mallanna, Mandali, Marcellus, Marcellus SC, Marck Script, Margarine, Marko One, Marmelad, Martel, Martel Sans, Marvel, Mate, Mate SC, Maven Pro, McLaren, Meddon, MedievalSharp, Medula One, Megrim, Meie Script, Merienda, Merienda One, Merriweather, Merriweather Sans, Metal, Metal Mania, Metamorphous, Metrophobic, Michroma, Milonga, Miltonian, Miltonian Tattoo, Miniver, Miss Fajardose, Modak, Modern Antiqua, Molengo, Molle, Monda, Monofett, Monoton, Monsieur La Doulaise, Montaga, Montez, Montserrat, Montserrat Alternates, Montserrat Subrayada, Moul, Moulpali, Mountains of Christmas, Mouse Memoirs, Mr Bedfort, Mr Dafoe, Mr De Haviland, Mrs Saint Delafield, Mrs Sheppards, Muli, Mystery Quest, NTR, Neucha, Neuton, New Rocker, News Cycle, Niconne, Nixie One, Nobile, Nokora, Norican, Nosifer, Nothing You Could Do, Noticia Text, Noto Sans, Noto Serif, Nova Cut, Nova Flat, Nova Mono, Nova Oval, Nova Round, Nova Script, Nova Slim, Nova Square, Numans, Nunito, Odor Mean Chey, Offside, Old Standard TT, Oldenburg, Oleo Script, Oleo Script Swash Caps, Open Sans, Open Sans Condensed, Oranienbaum, Orbitron, Oregano, Orienta, Original Surfer, Oswald, Over the Rainbow, Overlock, Overlock SC, Ovo, Oxygen, Oxygen Mono, PT Mono, PT Sans, PT Sans Caption, PT Sans Narrow, PT Serif, PT Serif Caption, Pacifico, Palanquin, Palanquin Dark, Paprika, Parisienne, Passero One, Passion One, Pathway Gothic One, Patrick Hand, Patrick Hand SC, Patua One, Paytone One, Peddana, Peralta, Permanent Marker, Petit Formal Script, Petrona, Philosopher, Piedra, Pinyon Script, Pirata One, Plaster, Play, Playball, Playfair Display, Playfair Display SC, Podkova, Poiret One, Poller One, Poly, Pompiere, Pontano Sans, Port Lligat Sans, Port Lligat Slab, Pragati Narrow, Prata, Preahvihear, Press Start 2P, Princess Sofia, Prociono, Prosto One, Puritan, Purple Purse, Quando, Quantico, Quattrocento, Quattrocento Sans, Questrial, Quicksand, Quintessential, Qwigley, Racing Sans One, Radley, Rajdhani, Raleway, Raleway Dots, Ramabhadra, Ramaraja, Rambla, Rammetto One, Ranchers, Rancho, Ranga, Rationale, Ravi Prakash, Redressed, Reenie Beanie, Revalia, Ribeye, Ribeye Marrow, Righteous, Risque, Roboto, Roboto Condensed, Roboto Mono, Roboto Slab, Rochester, Rock Salt, Rokkitt, Romanesco, Ropa Sans, Rosario, Rosarivo, Rouge Script, Rozha One, Rubik Mono One, Rubik One, Ruda, Rufina, Ruge Boogie, Ruluko, Rum Raisin, Ruslan Display, Russo One, Ruthie, Rye, Sacramento, Sail, Salsa, Sanchez, Sancreek, Sansita One, Sarina, Sarpanch, Satisfy, Scada, Scheherazade, Schoolbell, Seaweed Script, Sevillana, Seymour One, Shadows Into Light, Shadows Into Light Two, Shanti, Share, Share Tech, Share Tech Mono, Shojumaru, Short Stack, Siemreap, Sigmar One, Signika, Signika Negative, Simonetta, Sintony, Sirin Stencil, Six Caps, Skranji, Slabo 13px, Slabo 27px, Slackey, Smokum, Smythe, Sniglet, Snippet, Snowburst One, Sofadi One, Sofia, Sonsie One, Sorts Mill Goudy, Source Code Pro, Source Sans Pro, Source Serif Pro, Special Elite, Spicy Rice, Spinnaker, Spirax, Squada One, Sree Krushnadevaraya, Stalemate, Stalinist One, Stardos Stencil, Stint Ultra Condensed, Stint Ultra Expanded, Stoke, Strait, Sue Ellen Francisco, Sumana, Sunshiney, Supermercado One, Suranna, Suravaram, Suwannaphum, Swanky and Moo Moo, Syncopate, Tangerine, Taprom, Tauri, Teko, Telex, Tenali Ramakrishna, Tenor Sans, Text Me One, The Girl Next Door, Tienne, Timmana, Tinos, Titan One, Titillium Web, Trade Winds, Trocchi, Trochut, Trykker, Tulpen One, Ubuntu, Ubuntu Condensed, Ubuntu Mono, Ultra, Uncial Antiqua, Underdog, Unica One, UnifrakturCook, UnifrakturMaguntia, Unkempt, Unlock, Unna, VT323, Vampiro One, Varela, Varela Round, Vast Shadow, Vesper Libre, Vibur, Vidaloka, Viga, Voces, Volkhov, Vollkorn, Voltaire, Waiting for the Sunrise, Wallpoet, Walter Turncoat, Warnes, Wellfleet, Wendy One, Wire One, Yanone Kaffeesatz, Yellowtail, Yeseva One, Yesteryear, Zeyada]
//08 - border font size (adjust for fit), near mm, use zero for no text
fontsizeborder=2.3; //[0: 0.5: 50]

/* [Heated Bed] */

//09 - Heated Bed length, mm
df_lengthheatedBed=210; // [100: 1: 600]
//10 - Heated Bed width, mm
df_widthheatedBed=210; // [100: 1: 600]

/* [Advanced - Caution or crash run] */

//11 - Number of object faces, #
S_fn=200; //[20: 1: 300]
//12 - gap of base to Le Penseur, mm
pit=1; //[0.1: 0.1: 4]

/* [Hidden] */

//----------------------------------------------------|
//Text examples
//----------------------------------------------------|
//use spaces to displace the text to align
//and adjust the text size to fit
//----------------------------------------------------|
// long-term thinking, indispensable
// Show me, don´t tell me
// Be curious, not judgmental
// I'm a simple person with a complex mind
// Never give up, if necessary reborn
// Never stop dreaming, but remain awake
// Life is to short to wait for me, go
// Life is to short buy the ties
// H.O.P.E. Hold on, pain ends
// keep your head up, keep your heart strong

//----------------------------------------------------|
//Modules call section
//----------------------------------------------------|

%heatedBed();
maketheBaseText();
basetextcentral();
basetextborder();

//----------------------------------------------------|
//Modules library section
//----------------------------------------------------|

module heatedBed()
{
for (i=[0: 10: 200])
{
    for (j=[0: 10: 200])
    {
    color("brown", 0.1)
    translate([i-200/2, j-200/2, -2/2])
        {
        square([9, 9], center=true);
        }
    }
}
}

//---------------------------------------------------------|

module basetextborder()
{
rotate([0, 0, 150])
translate([0, 0, 3/2])
for ( i = [0: 1: len(usertextborder)-1] )
{
    rotate( 6+i*(360-120)/len(usertextborder)-1, [0, 0, 1])
    translate([0, -17, 0])
    rotate([20, 0, 0])
    linear_extrude(height = 1, center = true, twist=-0.15, convexity = 10, slices = 20)
    text(text=usertextborder[i], size=fontsizeborder, font=fontnameborder, spacing=1, $fn=200);
}
}

module basetextcentral()
{
rotate([0, 0, 150])
translate([0, 0, 5/2])
for ( i = [0: 1: len(usertextcentral)-1] )
{
    rotate( 6+i*(360-120)/len(usertextcentral)-1, [0, 0, 1])
    translate([0, -13, 0])
    rotate([20, 0, 0])
    linear_extrude(height = 1, center = true, twist=-0.15, convexity = 10, slices = 20)
    text(text=usertextcentral[i], size=fontsizecentral, font=fontnamecentral, spacing=1, $fn=200);
}
}

module maketheBasePensevr()
{
translate([0, 0, 3/2])
cylinder(h=3+0.3*pit, r1=11+0.15*pit, r2=10, $fn=S_fn, center=true);
translate([8, 0, 8/2])
cylinder(h=8+0.3*pit, r1=10+0.15*pit, r2=7, $fn=S_fn, center=true);
}

module maketheBaseText()
{
difference()
{
union()
{
translate([0, 0, 1/8])
cylinder(h=0.25, r1=20, r2=19.5, $fn=S_fn, center=true);
translate([0, 0, 3/2])
cylinder(h=3, r1=20, r2=10, $fn=S_fn, center=true);
translate([8, 0, 8/2])
cylinder(h=8, r1=10, r2=7, $fn=S_fn, center=true);
};
translate([0, 0, -0.0004])
scale([1.0001, 1.0001, 1.0004])
maketheBasePensevr();
}
}
