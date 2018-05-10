//Hardhat accessory slot tab
//Updated 2/1/17: Tylon pointed out an error with the abandoned geometry net size. Fixed it.
//Updated 9/9/16: Thanks to Lagger for the suggestion to make the clip and bottom a dynamic variable too. I have some new ideas for the orphan dots problem if I'm motivated to tackle that sometime.
//Writen by Dan Koss 1/2016. (Updated 1/23/16, 1/26/16)
//Thanks to MC Geisler (thing:714444) for the font list. I'm still figuring out text and will trim don the list as I learn.
//Choose to import STL or Use custom text

// preview[view:south, tilt:top]
/* [Tab Options] */
//Clip Size: Modifies the part that grips the hardhat
tabZ = 3.5; //[2.8:0.1:5]
//Tab thickness: Modifies the thickness of the part the Clip is attached to.
tabThick = 1.5; //[1:0.1:2.5]

/* [Add Text] */
//Text Line 4
line4 = "";
//Text Line 3
line3 = "";
//Text Line 2
line2 = "Custom";
//Text Line 1
line1 = "Thing";

//Font name, e.g. "Libration Sans", "Aldo", depends on what is available on the platform. In the customizer,choose from about 700 Google Fonts. For an overview please refer: http://www.google.com/fonts
FontName="Bree Serif"; //[ABeeZee,Abel,Abril Fatface,Aclonica,Acme,Actor,Adamina,Advent Pro,Aguafina Script,Akronim,Aladin,Aldrich,Alef,Alegreya,Alegreya Sans,Alegreya Sans SC,Alegreya SC,Alex Brush,Alfa Slab One,Alice,Alike,Alike Angular,Allan,Allerta,Allerta Stencil,Allura,Almendra,Almendra Display,Almendra SC,Amarante,Amaranth,Amatic SC,Amethysta,Amiri,Anaheim,Andada,Andika,Angkor,Annie Use Your Telescope,Anonymous Pro,Antic,Antic Didone,Antic Slab,Anton,Arapey,Arbutus,Arbutus Slab,Architects Daughter,Archivo Black,Archivo Narrow,Arimo,Arizonia,Armata,Artifika,Arvo,Asap,Asset,Astloch,Asul,Atomic Age,Aubrey,Audiowide,Autour One,Average,Average Sans,Averia Gruesa Libre,Averia Libre,Averia Sans Libre,Averia Serif Libre,Bad Script,Balthazar,Bangers,Basic,Battambang,Baumans,Bayon,Belgrano,Belleza,BenchNine,Bentham,Berkshire Swash,Bevan,Bigelow Rules,Bigshot One,Bilbo,Bilbo Swash Caps,Bitter,Black Ops One,Bokor,Bonbon,Boogaloo,Bowlby One,Bowlby One SC,Brawler,Bree Serif,Bubblegum Sans,Bubbler One,Buda,Buenard,Butcherman,Butterfly Kids,Cabin,Cabin Condensed,Cabin Sketch,Caesar Dressing,Cagliostro,Calligraffitti,Cambay,Cambo,Candal,Cantarell,Cantata One,Cantora One,Capriola,Cardo,Carme,Carrois Gothic,Carrois Gothic SC,Carter One,Caudex,Cedarville Cursive,Ceviche One,Changa One,Chango,Chau Philomene One,Chela One,Chelsea Market,Chenla,Cherry Cream Soda,Cherry Swash,Chewy,Chicle,Chivo,Cinzel,Cinzel Decorative,Clicker Script,Coda,Coda Caption,Codystar,Combo,Comfortaa,Coming Soon,Concert One,Condiment,Content,Contrail One,Convergence,Cookie,Copse,Corben,Courgette,Cousine,Coustard,Covered By Your Grace,Crafty Girls,Creepster,Crete Round,Crimson Text,Croissant One,Crushed,Cuprum,Cutive,Cutive Mono,Damion,Dancing Script,Dangrek,Dawning of a New Day,Days One,Dekko,Delius,Delius Swash Caps,Delius Unicase,Della Respira,Denk One,Devonshire,Dhurjati,Didact Gothic,Diplomata,Diplomata SC,Domine,Donegal One,Doppio One,Dorsa,Dosis,Dr Sugiyama,Droid Sans,Droid Sans Mono,Droid Serif,Duru Sans,Dynalight,Eagle Lake,Eater,EB Garamond,Economica,Ek Mukta,Electrolize,Elsie,Elsie Swash Caps,Emblema One,Emilys Candy,Engagement,Englebert,Enriqueta,Erica One,Esteban,Euphoria Script,Ewert,Exo,Exo 2,Expletus Sans,Fanwood Text,Fascinate,Fascinate Inline,Faster One,Fasthand,Fauna One,Federant,Federo,Felipa,Fenix,Finger Paint,Fira Mono,Fira Sans,Fjalla One,Fjord One,Flamenco,Flavors,Fondamento,Fontdiner Swanky,Forum,Francois One,Freckle Face,Fredericka the Great,Fredoka One,Freehand,Fresca,Frijole,Fruktur,Fugaz One,Gabriela,Gafata,Galdeano,Galindo,Gentium Basic,Gentium Book Basic,Geo,Geostar,Geostar Fill,Germania One,GFS Didot,GFS Neohellenic,Gidugu,Gilda Display,Give You Glory,Glass Antiqua,Glegoo,Gloria Hallelujah,Goblin One,Gochi Hand,Gorditas,Goudy Bookletter 1911,Graduate,Grand Hotel,Gravitas One,Great Vibes,Griffy,Gruppo,Gudea,Gurajada,Habibi,Halant,Hammersmith One,Hanalei,Hanalei Fill,Handlee,Hanuman,Happy Monkey,Headland One,Henny Penny,Herr Von Muellerhoff,Hind,Holtwood One SC,Homemade Apple,Homenaje,Iceberg,Iceland,IM Fell Double Pica,IM Fell Double Pica SC,IM Fell DW Pica,IM Fell DW Pica SC,IM Fell English,IM Fell English SC,IM Fell French Canon,IM Fell French Canon SC,IM Fell Great Primer,IM Fell Great Primer SC,Imprima,Inconsolata,Inder,Indie Flower,Inika,Irish Grover,Istok Web,Italiana,Italianno,Jacques Francois,Jacques Francois Shadow,Jim Nightshade,Jockey One,Jolly Lodger,Josefin Sans,Josefin Slab,Joti One,Judson,Julee,Julius Sans One,Junge,Jura,Just Another Hand,Just Me Again Down Here,Kalam,Kameron,Kantumruy,Karla,Karma,Kaushan Script,Kavoon,Kdam Thmor,Keania One,Kelly Slab,Kenia,Khand,Khmer,Khula,Kite One,Knewave,Kotta One,Koulen,Kranky,Kreon,Kristi,Krona One,La Belle Aurore,Laila,Lakki Reddy,Lancelot,Lateef,Lato,League Script,Leckerli One,Ledger,Lekton,Lemon,Liberation Sans,Libre Baskerville,Life Savers,Lilita One,Lily Script One,Limelight,Linden Hill,Lobster,Lobster Two,Londrina Outline,Londrina Shadow,Londrina Sketch,Londrina Solid,Lora,Love Ya Like A Sister,Loved by the King,Lovers Quarrel,Luckiest Guy,Lusitana,Lustria,Macondo,Macondo Swash Caps,Magra,Maiden Orange,Mako,Mallanna,Mandali,Marcellus,Marcellus SC,Marck Script,Margarine,Marko One,Marmelad,Martel Sans,Marvel,Mate,Mate SC,Maven Pro,McLaren,Meddon,MedievalSharp,Medula One,Megrim,Meie Script,Merienda,Merienda One,Merriweather,Merriweather Sans,Metal,Metal Mania,Metamorphous,Metrophobic,Michroma,Milonga,Miltonian,Miltonian Tattoo,Miniver,Miss Fajardose,Modak,Modern Antiqua,Molengo,Molle,Monda,Monofett,Monoton,Monsieur La Doulaise,Montaga,Montez,Montserrat,Montserrat Alternates,Montserrat Subrayada,Moul,Moulpali,Mountains of Christmas,Mouse Memoirs,Mr Bedfort,Mr Dafoe,Mr De Haviland,Mrs Saint Delafield,Mrs Sheppards,Muli,Mystery Quest,Neucha,Neuton,New Rocker,News Cycle,Niconne,Nixie One,Nobile,Nokora,Norican,Nosifer,Nothing You Could Do,Noticia Text,Noto Sans,Noto Serif,Nova Cut,Nova Flat,Nova Mono,Nova Oval,Nova Round,Nova Script,Nova Slim,Nova Square,NTR,Numans,Nunito,Odor Mean Chey,Offside,Old Standard TT,Oldenburg,Oleo Script,Oleo Script Swash Caps,Open Sans,Open Sans Condensed,Oranienbaum,Orbitron,Oregano,Orienta,Original Surfer,Oswald,Over the Rainbow,Overlock,Overlock SC,Ovo,Oxygen,Oxygen Mono,Pacifico,Paprika,Parisienne,Passero One,Passion One,Pathway Gothic One,Patrick Hand,Patrick Hand SC,Patua One,Paytone One,Peddana,Peralta,Permanent Marker,Petit Formal Script,Petrona,Philosopher,Piedra,Pinyon Script,Pirata One,Plaster,Play,Playball,Playfair Display,Playfair Display SC,Podkova,Poiret One,Poller One,Poly,Pompiere,Pontano Sans,Port Lligat Sans,Port Lligat Slab,Prata,Preahvihear,Press Start 2P,Princess Sofia,Prociono,Prosto One,PT Mono,PT Sans,PT Sans Caption,PT Sans Narrow,PT Serif,PT Serif Caption,Puritan,Purple Purse,Quando,Quantico,Quattrocento,Quattrocento Sans,Questrial,Quicksand,Quintessential,Qwigley,Racing Sans One,Radley,Rajdhani,Raleway,Raleway Dots,Ramabhadra,Ramaraja,Rambla,Rammetto One,Ranchers,Rancho,Ranga,Rationale,Ravi Prakash,Redressed,Reenie Beanie,Revalia,Ribeye,Ribeye Marrow,Righteous,Risque,Roboto,Roboto Condensed,Roboto Slab,Rochester,Rock Salt,Rokkitt,Romanesco,Ropa Sans,Rosario,Rosarivo,Rouge Script,Rozha One,Rubik Mono One,Rubik One,Ruda,Rufina,Ruge Boogie,Ruluko,Rum Raisin,Ruslan Display,Russo One,Ruthie,Rye,Sacramento,Sail,Salsa,Sanchez,Sancreek,Sansita One,Sarina,Sarpanch,Satisfy,Scada,Scheherazade,Schoolbell,Seaweed Script,Sevillana,Seymour One,Shadows Into Light,Shadows Into Light Two,Shanti,Share,Share Tech,Share Tech Mono,Shojumaru,Short Stack,Siemreap,Sigmar One,Signika,Signika Negative,Simonetta,Sintony,Sirin Stencil,Six Caps,Skranji,Slabo 13px,Slabo 27px,Slackey,Smokum,Smythe,Sniglet,Snippet,Snowburst One,Sofadi One,Sofia,Sonsie One,Sorts Mill Goudy,Source Code Pro,Source Sans Pro,Source Serif Pro,Special Elite,Spicy Rice,Spinnaker,Spirax,Squada One,Sree Krushnadevaraya,Stalemate,Stalinist One,Stardos Stencil,Stint Ultra Condensed,Stint Ultra Expanded,Stoke,Strait,Sue Ellen Francisco,Sunshiney,Supermercado One,Suranna,Suravaram,Suwannaphum,Swanky and Moo Moo,Syncopate,Tangerine,Taprom,Tauri,Teko,Telex,Tenali Ramakrishna,Tenor Sans,Text Me One,The Girl Next Door,Tienne,Timmana,Tinos,Titan One,Titillium Web,Trade Winds,Trocchi,Trochut,Trykker,Tulpen One,Ubuntu,Ubuntu Condensed,Ubuntu Mono,Ultra,Uncial Antiqua,Underdog,Unica One,UnifrakturCook,UnifrakturMaguntia,Unkempt,Unlock,Unna,Vampiro One,Varela,Varela Round,Vast Shadow,Vesper Libre,Vibur,Vidaloka,Viga,Voces,Volkhov,Vollkorn,Voltaire,VT323,Waiting for the Sunrise,Wallpoet,Walter Turncoat,Warnes,Wellfleet,Wendy One,Wire One,Yanone Kaffeesatz,Yellowtail,Yeseva One,Yesteryear,Zeyada]
//Font Size
FontSize = 17; //[1:.5:30]
//Font Spacing
FontSpace = 1.1; //[0:.1:2]
//Font Extrusion;
FontExtrude = 3.5; //[1:.1:10]
//Line Spacing
LineSpace = 1.1; //[0:.1:2]
//Use this to shift the multi-Line support post. Added to the displacement from the center.
PostShift = 2; //[0:.1:5]

/* [BETA: Catching Abandoned Geometry] */
//How many lost geometries do you have? ("i", "j", "!", "?", etc)
CatchThemAll = 1;
//Use the following options to change the coordinates and size of each "net". Line up the red box with the lost geometry. Don't bother filling out anything beyond the number of lost geometries.
//First net X
XT1 = -2;
//Fist net Y
YT1 = 10;
//First net X size
XS1 = 3.5;
//First net Y size
YS1 = 5;
//Second net
XT2 = 0;
YT2 = 0;
XS2 = 0;
YS2 = 0;
//Third net
XT3 = 0;
YT3 = 0;
XS3 = 0;
YS3 = 0;
//Fourth net
XT4 = 0;
YT4 = 0;
XS4 = 0;
YS4 = 0;
//Fifth net
XT5 = 0;
YT5 = 0;
XS5 = 0;
YS5 = 0;
//Sixth net
XT6 = 0;
YT6 = 0;
XS6 = 0;
YS6 = 0;
//Seventh net
XT7 = 0;
YT7 = 0;
XS7 = 0;
YS7 = 0;
//Eighth net
XT8 = 0;
YT8 = 0;
XS8 = 0;
YS8 = 0;
//Ninth net
XT9 = 0;
YT9 = 0;
XS9 = 0;
YS9 = 0;
//Tenth net
XT10 = 0;
YT10 = 0;
XS10 = 0;
YS10 = 0;

/* [Hidden] */
OrphanSizes = [
    [XS1,YS1],
    [XS2,YS2],
    [XS3,YS3],
    [XS4,YS4],
    [XS5,YS5],
    [XS6,YS6],
    [XS7,YS7],
    [XS8,YS8],
    [XS9,YS9],
    [XS10,YS10]
];
OrphanTrans = [
    [XT1,YT1],
    [XT2,YT2],
    [XT3,YT3],
    [XT4,YT4],
    [XT5,YT5],
    [XT6,YT6],
    [XT7,YT7],
    [XT8,YT8],
    [XT9,YT9],
    [XT10,YT10]
];
//$vpr = [0,0,0];
stlortext = "text";

//The following is to import an STL File. Change "stlortext" to ="stl"
//and copy the STL file to the same folder as your .scad file
stlfile = "fni.stl";
//Shift STL [x,y,z]
stlshift = [-3.5,8.0,0];
//Scale STL [x,y,z] axis
stlscale = [0.35,0.35,0.08];
//Rotate STL about [x,y,z] axis
stlrotate = [0,0,0];

/* [Hidden] */
//Referenced constants for the TAB.
//Tshiftx = 15;
tabX = 28;
tabY = 16;

tabHead = 1;
tabClip = 2;
rad=tabClip/2;





if (stlortext == "stl") {
    union(){
        translate([stlshift[0],stlshift[1],stlshift[2]]) scale([stlscale[0],stlscale[1],stlscale[2]]) rotate([stlrotate[0],stlrotate[1],stlrotate[2]]) import(stlfile);
        TAB();
    }
}
else if (stlortext == "text") {
    render(convexity=50)union(){
        TextClip();
        for(i=[0:CatchThemAll]){
            hull()intersection(){
                TextClip();
                #translate([OrphanTrans[i][0],OrphanTrans[i][1],0])cube([OrphanSizes[i][0],OrphanSizes[i][1],FontExtrude/3]);
            }
        }
        TAB();
    }
}
else echo("error");


//
//Add Text. Line 4 at bottom and Line 1 at the Top
module TextClip (){
    union(){
        //TAB();
        WriteText(line1);
        //HomesForOrphans(line1);
        BaseBar(line1,1);
        if (line2 != "") {
            translate([0,1*FontSize*LineSpace,0]){
                WriteText(line2);
                //HomesForOrphans(line2);
                BaseBar(line2,2,line1);
            }
        }
        
        if (line3 != "") {
            translate([0,2*FontSize*LineSpace,0]){
                WriteText(line3);
                //HomesForOrphans(line3);
                BaseBar(line3,3,line2);
            }
        }
        
        if (line4 != "") {
            translate([0,3*FontSize*LineSpace,0]){
                WriteText(line4);
                //HomesForOrphans(line4);
                BaseBar(line4,4,line3);
            }
        }
    }
}


module WriteText (textstring){ //Write text, centered at 0,0, and correct i/j dots.
    linear_extrude(height=FontExtrude, convexity=10)
    text(textstring,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
}
//
module HomesForOrphans(textstring){
    //Fix orphaned dots
    intersection(){
        //connect the dots by offsetting EVERYTHING
        linear_extrude(height=1,convexity=10)offset(delta=-OrphanSize)offset(delta=OrphanSize)text(textstring,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
        
        //connect only vertical parts by shifting
        linear_extrude(height=1,convexity=10){
            translate([0,OrphanSize,0])text(textstring,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
        translate([0,-OrphanSize,0]) text(textstring,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
        }
    }
}
//
module BaseBar(linetext,linenum,lowertext=""){ //Pass the text for line 1 and autogenerate bar
    hull(){ 
        intersection(){
            linear_extrude(height=FontExtrude, convexity=10)
            text(linetext,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
            translate([-(len(linetext)/2)*FontSize*FontSpace*1.25,0,0]) cube([len(linetext)*FontSize*FontSpace*1.5,1,1]);
        }
    }
    if(linenum>1){
        hull() {
            intersection(){ //Top of left post
                //recreate current text line
                translate([-(len(linetext)/2)*FontSize*FontSpace*1.25,0,0]) cube([len(linetext)*FontSize*FontSpace*1.5,1,1]);
                //create verticle lines.
                translate([-(PostShift+FontSize*FontSpace/2),-(FontSize*LineSpace),0]) cube([1,FontSize*(LineSpace)*2,1]);
            }
            intersection(){ //Bottom of left post
                //create verticle lines
                translate([-(PostShift+FontSize*FontSpace/2),-(FontSize*LineSpace),0]) cube([1,FontSize*(LineSpace)*2,1]);
                //recreate lower text
                translate([0,-1*(FontSize*LineSpace),0])linear_extrude(height=FontExtrude, convexity=10)
                text(lowertext,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
                //bound box to skip the lower edges of characters
                translate([-FontSize*FontSpace,-(FontSize*LineSpace)/2,0])cube([FontSize*FontSpace*3,FontSize*LineSpace*.5,1]);
            }
        }
        hull(){
            intersection(){ //Top of right post
                //recreate current text line
                translate([-(len(linetext)/2)*FontSize*FontSpace*1.25,0,0]) cube([len(linetext)*FontSize*FontSpace*1.5,1,1]);
                //create verticle lines.
                translate([(PostShift+FontSize*FontSpace/2),-(FontSize*LineSpace),0]) cube([1,FontSize*(LineSpace)*2,1]);
            }
            intersection(){//Bottom of right post
                translate([(PostShift+FontSize*FontSpace/2),-(FontSize*LineSpace),0]) cube([1,FontSize*(LineSpace)*2,1]);
                //recreate lower text
                translate([0,-1*(FontSize*LineSpace),0])linear_extrude(height=FontExtrude, convexity=10)
                text(lowertext,size=FontSize,font=FontName,halign="center",valign="baseline",spacing=FontSpace);
                //bound box to skip the lower edges of characters
                translate([-FontSize*FontSpace,-(FontSize*LineSpace)/2,0])cube([FontSize*FontSpace*3,FontSize*LineSpace*.5,1]);
            }
        }
    }
}
//
//Draw the tab.
module TAB (){
    rotate([0,0,180]) difference(){
        hull(){ //outer shell
            translate([-tabX/2,0,0]) cube([tabX,tabY,tabZ]);
            translate([-tabX/2,-tabHead,0]) cube([tabX,tabHead,tabZ]);
            translate([-((tabX/2)-rad),tabY+tabClip-rad,0]) cylinder(h=tabZ, r=rad, $fn=25);
            translate([((tabX/2)-rad),tabY+tabClip-rad,0]) cylinder(h=tabZ, r=rad, $fn=25);
        }
        translate([-(tabX*1.1)/2,-tabHead-.1,tabThick]) cube(size=[tabX*1.1,tabY+tabHead+.1,tabZ]);
        translate([-(tabX*1.1)/2,tabY+(0.3*tabClip),tabZ]) rotate([-40,0,0]) cube([tabX*1.1,10,5]);
    }
}