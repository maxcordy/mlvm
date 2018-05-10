$fa=5;
$fs=0.5;

//pipe diameter
pd=22;
//clip thickness
ct=2.2;
//end clip cylinders factor.  
eccf=1.1;
//clip heigth
ch=20;
//clip apperture
ca=120;

//Soap bar < 55 x 80

//Soap length
sl=80;
//Soap width
sw=60;
//Holder thickness
ht=3;
//hodler height (two parts because minkowski)
hh1=5;
hh2=2;
//thickness of bottom plate's (voronoi grid)
bottom_height=1;

w1=4*(pd/4+ct);


difference() {//toplevel diff => make room for pipe
	union() {
	//--------- clip tuyau -------------------------------------------------------
	difference() { 	cylinder(h=ch,d=pd+ct*2);
		//emporte piece pour trou ouverture//emporte piece pour trou ouverture
		translate([0,0,-1]) linear_extrude(height = ch+2)      
			polygon(points=[    [0,0],[-w1*cos(90+ca/2),-w1*sin(90+ca/2)],[w1,-w1],[-w1,-w1],[-w1*cos(90-ca/2),-w1*sin(90-ca/2)]   ]);

		}
	//cylindres au bout du clip
	rotate([0,0,-(180-ca)/2])       translate([(pd+ct)/2,0,0])  cylinder(h=ch,d=ct*eccf);
	rotate([0,0,180+(180-ca)/2])    translate([(pd+ct)/2,0,0])  cylinder(h=ch,d=ct*eccf);

	translate([0,(pd+sl)/2,hh1/2+hh2]) 	minkowski()	{
			cube([sw,sl,hh1],center=true);
			sphere(r=hh2);
			}
		
    }

	translate([0,0,-100]) cylinder(h=200,d=pd);	
	translate([0,sl/2+pd/2+ct,0]) cube([sw,sl-ct*2,50],center=true);
}
	

//fond
translate([0,sl/2+pd/2+ct/3,0]) scale([sw/100,sl/100,1]) voronoi(bottom_height);





// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.
fudge = 0.1;

module poly_path9331(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-11.849662,-1.586600],[-12.076862,-1.563716],[-19.078030,-0.152821],[-19.665415,0.158122],[-19.988738,0.738775],[-23.329892,15.622888],[-23.276053,16.308021],[-22.846856,16.844775],[-16.891957,20.905626],[-16.310755,21.105881],[-15.708240,20.983916],[-1.797552,13.986709],[-1.416119,13.681836],[-1.192314,13.247848],[-0.424806,10.405059],[-0.422324,9.803717],[-0.718823,9.280542],[-11.009606,-1.235322],[-11.394063,-1.496027],[-11.849662,-1.586621]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-12.237235,0.857185],[-2.859077,10.439437],[-3.315384,12.132897],[-16.143540,18.584076],[-20.872717,15.359445],[-17.871399,1.991247],[-12.237235,0.857185]]);
    }
  }
}

module poly_path9323(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[7.666534,3.825979],[7.133854,3.971075],[-2.120205,9.074371],[-2.476045,9.376721],[-2.685334,9.794132],[-3.452853,12.636920],[-3.374563,13.455979],[2.822824,26.163595],[3.168602,26.583208],[3.666694,26.801262],[7.634084,27.519126],[8.121264,27.504112],[8.560069,27.291936],[17.814127,20.101897],[18.205030,19.551184],[18.226522,18.876186],[14.904448,6.390038],[14.606183,5.869559],[14.089203,5.565259],[8.014019,3.869892],[7.666544,3.826032],[7.666534,3.825979]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[7.846008,6.252570],[12.815744,7.638654],[15.765501,18.729172],[7.536704,25.123078],[4.667133,24.603779],[-1.077771,12.824033],[-0.554636,10.884282],[7.846008,6.252570]]);
    }
  }
}

module poly_path9281(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[31.709528,17.220906],[31.083292,17.423274],[25.735528,21.064124],[25.365219,21.473596],[25.223856,22.007270],[24.987110,33.387991],[25.086315,33.884701],[25.386136,34.292957],[30.537253,38.815847],[31.073472,39.082379],[31.671337,39.048768],[49.192395,33.334533],[49.776951,32.909151],[50.000002,32.221479],[50.000002,21.358140],[49.725355,20.604690],[49.030105,20.204988],[31.942449,17.238100],[31.709528,17.220938]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[32.009277,19.624603],[47.659276,22.343293],[47.659276,31.371878],[31.579698,36.616446],[27.339288,32.893503],[27.551222,22.660224],[32.009277,19.624603]]);
    }
  }
}

module poly_path9273(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[35.743735,-50.000026],[35.219111,-49.876137],[34.805684,-49.530228],[34.591179,-49.035700],[34.621115,-48.497488],[34.783394,-47.949548],[34.964775,-47.586800],[37.626247,-43.978417],[38.178006,-43.569849],[48.440154,-39.955739],[48.990925,-39.900118],[49.505637,-40.103867],[49.869108,-40.521389],[50.000002,-41.059254],[50.000002,-48.829689],[49.910950,-49.277582],[49.657250,-49.657287],[49.277535,-49.910980],[48.829634,-50.000026],[35.743735,-50.000026]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[37.819069,-47.659351],[47.659276,-47.659351],[47.659276,-42.712619],[39.294917,-45.656602],[37.819069,-47.659351]]);
    }
  }
}

module poly_path9325(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-2.303493,11.772064],[-2.847625,11.898070],[-16.758313,18.893369],[-17.280702,19.417179],[-17.384538,20.149623],[-15.565040,30.130901],[-15.284968,30.701551],[-14.747878,31.041587],[-4.877139,33.989395],[-4.299501,34.012607],[-3.781237,33.756474],[4.636580,26.537788],[5.020867,25.886649],[4.926783,25.136448],[-1.270593,12.428821],[-1.694327,11.954631],[-2.303493,11.772064],[-2.303493,11.772064]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-2.855253,14.519400],[2.425685,25.350279],[-4.819857,31.564711],[-13.390419,29.004477],[-14.925445,20.590654],[-2.855253,14.519400]]);
    }
  }
}

module poly_path9311(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[1.308785,-41.152805],[0.579447,-40.921792],[-5.778302,-36.202253],[-6.190115,-35.635209],[-6.204066,-34.934547],[-3.407033,-25.361829],[-3.087400,-24.839711],[-2.547866,-24.550430],[7.399235,-22.257473],[8.037354,-22.288887],[8.563872,-22.650767],[16.788856,-32.565238],[17.052086,-33.198862],[16.914872,-33.871126],[16.903324,-33.892102],[16.361131,-34.398042],[1.761215,-41.047778],[1.308732,-41.152786],[1.308785,-41.152805]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[1.419524,-38.630756],[14.018562,-32.893623],[7.223586,-24.699340],[-1.352697,-26.677262],[-3.729686,-34.808541],[1.419524,-38.630756]]);
    }
  }
}

module poly_path9265(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-31.753441,-50.000026],[-32.261270,-49.884437],[-32.668649,-49.559952],[-32.894884,-49.090846],[-32.895162,-48.570037],[-29.622732,-34.155597],[-29.333086,-33.611961],[-28.807487,-33.290730],[-19.624069,-30.621674],[-19.051238,-30.601889],[-18.537723,-30.856501],[-11.313168,-37.017487],[-10.953554,-37.565158],[-10.944685,-38.220277],[-13.976557,-49.142797],[-14.396229,-49.761620],[-15.104919,-50.000026],[-31.753441,-50.000026]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-30.287149,-47.659351],[-15.994619,-47.659351],[-13.399964,-38.313828],[-19.576343,-33.046346],[-27.492033,-35.346931],[-30.287149,-47.659351]]);
    }
  }
}

module poly_path9303(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-43.478055,-8.243959],[-43.596423,-8.238662],[-48.942280,-7.723187],[-49.360606,-7.601522],[-49.696060,-7.345146],[-49.919054,-6.986637],[-50.000002,-6.558572],[-50.000002,13.482273],[-49.897580,13.961433],[-49.607946,14.356652],[-49.181880,14.598641],[-48.694083,14.644971],[-37.761808,13.368228],[-37.115114,13.076713],[-36.755637,12.465191],[-33.729508,-0.857199],[-33.780015,-1.540952],[-34.204895,-2.079054],[-42.817463,-8.035744],[-43.478055,-8.243843]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-43.796894,-5.867013],[-36.186684,-0.605261],[-38.855793,11.140118],[-47.659276,12.167265],[-47.659276,-5.494716],[-43.796894,-5.867013]]);
    }
  }
}

module poly_path9257(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-48.829644,-50.000026],[-49.277543,-49.910977],[-49.657254,-49.657283],[-49.910951,-49.277579],[-50.000002,-48.829689],[-50.000002,-43.804681],[-49.876857,-43.281322],[-49.532677,-42.868268],[-49.040117,-42.652714],[-48.503156,-42.680163],[-44.163470,-43.940234],[-43.598330,-44.306800],[-40.392726,-48.071736],[-40.124734,-48.671383],[-40.222004,-49.320946],[-40.653894,-49.815792],[-41.284343,-50.000026],[-48.829644,-50.000026]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-47.659276,-47.659351],[-43.815995,-47.659351],[-45.152457,-46.089989],[-47.659276,-45.362586],[-47.659276,-47.659351]]);
    }
  }
}

module poly_path9269(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[2.610869,-50.000026],[2.197845,-49.924788],[1.847414,-49.716445],[1.589463,-49.400743],[1.453881,-49.003425],[0.119326,-40.156204],[0.247853,-39.424128],[0.791382,-38.917134],[15.391298,-32.267397],[15.966115,-32.165465],[16.518648,-32.353906],[16.911390,-32.785822],[17.046598,-33.353722],[16.758313,-48.850690],[16.660403,-49.299531],[16.408222,-49.664744],[16.038495,-49.910264],[15.587945,-50.000026],[2.610869,-50.000026],[2.610869,-50.000026]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[3.617040,-47.659351],[14.438585,-47.659351],[14.671516,-35.167468],[2.565060,-40.681233],[3.617040,-47.659351]]);
    }
  }
}

module poly_path9295(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-34.812041,30.652118],[-35.106058,30.690362],[-37.181391,31.224939],[-37.563966,31.401558],[-37.859178,31.702233],[-46.847856,45.015077],[-47.046941,45.612964],[-46.907077,46.227408],[-45.198308,49.387128],[-44.768123,49.835191],[-44.169233,49.999984],[-28.244307,49.999984],[-27.698582,49.865279],[-27.278626,49.491657],[-27.081335,48.965323],[-27.152229,48.407718],[-33.721902,31.400556],[-34.151145,30.857609],[-34.812083,30.652150],[-34.812041,30.652118]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-35.529905,33.216155],[-29.951126,47.659248],[-43.472334,47.659248],[-44.510955,45.736691],[-36.167593,33.380363],[-35.529905,33.216155]]);
    }
  }
}

module poly_path9335(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-2.253849,-26.860550],[-2.727888,-26.772913],[-3.126376,-26.501623],[-10.923688,-18.404721],[-11.229799,-17.817418],[-11.168072,-17.158012],[-8.038841,-9.341758],[-7.659466,-8.844977],[-7.078489,-8.614349],[5.245622,-7.289360],[5.778061,-7.355409],[6.225064,-7.652122],[11.259710,-13.018871],[11.543405,-13.544402],[11.530823,-14.141481],[8.787248,-23.719920],[8.468027,-24.245773],[7.926194,-24.537061],[-2.020928,-26.830007],[-2.253849,-26.860518],[-2.253849,-26.860550]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-1.900643,-24.401510],[6.727180,-22.412125],[9.098459,-14.135750],[4.917238,-9.677770],[-6.127694,-10.865290],[-8.714699,-17.326024],[-1.900643,-24.401510]]);
    }
  }
}

module poly_path9329(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-26.470586,-5.183526],[-26.829523,-5.120598],[-35.251165,-2.224341],[-35.742230,-1.899503],[-36.012952,-1.376657],[-39.039081,11.945732],[-39.013722,12.558358],[-38.682051,13.074063],[-32.543863,18.616462],[-32.072700,18.874725],[-31.535786,18.895212],[-21.964795,17.028020],[-21.372463,16.718117],[-21.046449,16.134507],[-17.705295,1.250405],[-17.762158,0.556040],[-18.203607,0.017055],[-25.806180,-4.990767],[-26.470586,-5.183600]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-26.613775,-2.718755],[-20.166295,1.527302],[-23.161892,14.876420],[-31.409780,16.485869],[-36.604810,11.796886],[-33.874604,-0.221513],[-26.613775,-2.718755]]);
    }
  }
}

module poly_path9287(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[26.182290,32.242477],[25.788985,32.301697],[13.930727,36.234636],[13.471378,36.517976],[13.188041,36.977322],[9.375303,48.461144],[9.329304,49.007484],[9.537212,49.514808],[9.953388,49.871750],[10.486471,49.999952],[30.506711,49.999952],[30.941195,49.916335],[31.302938,49.686814],[31.558201,49.342755],[31.673244,48.915523],[32.475129,38.021652],[32.391200,37.492123],[32.079918,37.055601],[26.928800,32.532701],[26.182290,32.242508]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[25.890180,34.733987],[30.098129,38.430181],[29.420364,47.659248],[12.109322,47.659248],[15.225183,38.271725],[25.890180,34.733987]]);
    }
  }
}

module poly_path9279(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[40.915861,-3.322055],[40.514918,-3.228509],[28.637569,1.867148],[28.071860,2.383256],[27.946423,3.138668],[30.588804,18.587889],[30.913315,19.217383],[31.541517,19.544406],[48.629173,22.511293],[49.134634,22.488212],[49.583101,22.253905],[49.890728,21.852179],[50.000002,21.358140],[50.000002,-0.990927],[49.924512,-1.404333],[49.715691,-1.754933],[49.399389,-2.012775],[49.001459,-2.147905],[41.148782,-3.310603],[40.915861,-3.322150]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[41.133505,-0.947015],[47.659276,0.019036],[47.659276,19.966335],[32.755776,17.379372],[30.409330,3.654154],[41.133505,-0.947015]]);
    }
  }
}

module poly_path9291(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-14.425226,28.750548],[-14.851725,28.835989],[-15.217555,29.071293],[-18.946293,32.595683],[-19.203820,32.953080],[-19.310962,33.380363],[-20.166295,48.764674],[-20.096757,49.232075],[-19.848029,49.633866],[-19.460669,49.904526],[-18.997844,49.999921],[-1.033858,49.999921],[-0.527728,49.885245],[-0.120958,49.562982],[0.106453,49.096512],[0.109781,48.577573],[-3.399395,32.616669],[-3.685789,32.072036],[-4.208908,31.747999],[-14.079647,28.800191],[-14.425226,28.750611]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-14.100655,31.236327],[-5.537742,33.792748],[-2.490605,47.659248],[-17.760659,47.659248],[-17.000790,33.976036],[-14.100655,31.236327]]);
    }
  }
}

module poly_path9313(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[15.822783,-34.480157],[15.360598,-34.356504],[14.986531,-34.058217],[6.761558,-24.143767],[6.517470,-23.636852],[6.538171,-23.074614],[9.281736,-13.496165],[9.615742,-12.955746],[10.182909,-12.669490],[20.532870,-10.664829],[21.083989,-10.690841],[21.561935,-10.966474],[31.022207,-19.962620],[31.335325,-20.470467],[31.829813,-22.095194],[31.831335,-22.770544],[31.459413,-23.334264],[19.175411,-33.577109],[18.709548,-33.813844],[16.170268,-34.447707],[15.822783,-34.480125]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[16.317282,-31.998202],[17.882840,-31.606815],[29.364978,-22.034108],[29.187422,-21.446074],[20.387763,-13.078050],[11.334176,-14.830699],[8.957166,-23.126165],[16.317282,-31.998202]]);
    }
  }
}

module poly_path9309(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-12.118867,-39.075598],[-12.832928,-38.796855],[-20.057472,-32.635880],[-20.393120,-32.156406],[-20.454591,-31.574366],[-18.692364,-19.752614],[-18.424432,-19.163982],[-17.884758,-18.807560],[-10.431096,-16.476433],[-9.792059,-16.460038],[-9.239752,-16.781892],[-1.442429,-24.878804],[-1.148844,-25.410965],[-1.161771,-26.018597],[-3.958804,-35.591315],[-4.222950,-36.057387],[-4.667123,-36.356905],[-11.658746,-39.001139],[-12.118867,-39.075594]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-11.840116,-36.568818],[-6.041776,-34.375149],[-3.597960,-26.012866],[-10.423468,-18.925928],[-16.487200,-20.821766],[-18.045141,-31.276524],[-11.840116,-36.568818]]);
    }
  }
}

module poly_path9263(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-28.502018,-35.585583],[-28.950721,-35.486770],[-29.326797,-35.222832],[-38.493042,-25.629117],[-38.798824,-25.024557],[-38.718325,-24.351866],[-37.794268,-22.247928],[-37.322684,-21.713352],[-25.743166,-14.813515],[-25.168912,-14.648582],[-24.588085,-14.788619],[-16.979782,-18.895300],[-16.489639,-19.400872],[-16.378368,-20.096179],[-18.140594,-31.917941],[-18.416174,-32.516051],[-18.971115,-32.870633],[-28.154533,-35.539690],[-28.502018,-35.585562],[-28.502018,-35.585583]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-28.125897,-33.094073],[-20.343862,-30.831680],[-18.814556,-20.564013],[-25.115023,-17.163733],[-35.802935,-23.530911],[-36.263056,-24.577159],[-28.125897,-33.094073]]);
    }
  }
}

module poly_path9271(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[15.587945,-50.000026],[15.135140,-49.909012],[14.752819,-49.649892],[14.500535,-49.263029],[14.417587,-48.808686],[14.705873,-33.311738],[14.849062,-32.773338],[14.860610,-32.752361],[15.172349,-32.385863],[15.605213,-32.175780],[18.144503,-31.541916],[18.707942,-31.542008],[19.206028,-31.805390],[36.685081,-47.409224],[37.031696,-47.961717],[37.028731,-48.613927],[36.866451,-49.161867],[36.444423,-49.767494],[35.743820,-50.000004],[15.588030,-50.000004]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[16.781217,-47.659351],[33.452664,-47.659351],[18.110041,-33.962764],[17.029415,-34.231959],[16.781217,-47.659351]]);
    }
  }
}

module poly_path9293(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-34.722299,30.562386],[-35.177907,30.652971],[-35.562376,30.913674],[-35.650200,31.003512],[-35.960616,31.586379],[-35.906036,32.244490],[-29.336364,49.251620],[-28.906333,49.795106],[-28.244275,50.000026],[-18.997844,50.000026],[-18.558067,49.914523],[-18.193587,49.679888],[-17.939123,49.328968],[-17.829393,48.894611],[-16.974061,33.510289],[-17.035653,33.063965],[-17.251899,32.685612],[-17.591267,32.412216],[-18.022226,32.280764],[-34.605838,30.568213],[-34.722299,30.561856]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-33.072719,33.080615],[-19.372047,34.495335],[-20.105199,47.659248],[-27.442390,47.659248],[-33.072719,33.080615]]);
    }
  }
}

module poly_path9337(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[10.396739,-14.989165],[9.936802,-14.890539],[9.552859,-14.618775],[4.518213,-9.252026],[4.250537,-8.787112],[4.218454,-8.251608],[6.545810,5.196787],[6.831019,5.780933],[7.383958,6.122750],[13.459153,7.818117],[13.916798,7.853047],[14.352678,7.709285],[24.360885,2.029428],[24.854849,1.479171],[24.920294,0.742631],[21.894154,-12.083363],[21.566587,-12.658186],[20.979632,-12.963496],[10.629660,-14.968157],[10.396739,-14.989239],[10.396739,-14.989165]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[10.816762,-12.547298],[19.790174,-10.809925],[22.442100,0.427606],[13.619526,5.433522],[8.726162,4.068456],[6.624089,-8.075959],[10.816762,-12.547298]]);
    }
  }
}

module poly_path9319(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[23.721290,-0.156603],[23.205794,-0.005775],[13.197586,5.674081],[12.695641,6.239239],[12.643909,6.993338],[15.965973,19.479496],[16.253657,19.989736],[16.752581,20.296637],[26.050553,23.150878],[26.568904,23.189620],[27.052899,23.000050],[32.400663,19.359211],[32.818884,18.849501],[32.895162,18.194606],[30.252782,2.745375],[29.997452,2.192184],[29.498633,1.842326],[24.181411,-0.087879],[23.721290,-0.156635]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[23.891208,2.296706],[28.060977,3.808806],[30.462798,17.847132],[26.199473,20.749109],[18.060407,18.249971],[15.137369,7.264451],[23.891208,2.296706]]);
    }
  }
}

module poly_path9285(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[48.795277,41.022875],[48.294497,41.151313],[47.897928,41.482986],[42.842263,48.121265],[42.608745,48.718310],[42.724853,49.348795],[43.155740,49.823489],[43.772083,49.999921],[48.829634,49.999921],[49.277535,49.910874],[49.657249,49.657181],[49.910950,49.277477],[50.000002,48.829584],[50.000002,42.191305],[49.907226,41.735920],[49.644511,41.352560],[49.253293,41.101688],[48.795277,41.022875],[48.795277,41.022875]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[47.659276,45.656505],[47.659276,47.659248],[46.133795,47.659248],[47.659276,45.656505]]);
    }
  }
}

module poly_path9277(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[34.153345,-25.547024],[33.563404,-25.394289],[30.134404,-23.452631],[29.798134,-23.165883],[29.592189,-22.774877],[29.097690,-21.150140],[29.054442,-20.677234],[29.202677,-20.226084],[39.963127,-1.569405],[40.318544,-1.186642],[40.805100,-0.996648],[48.657777,0.166050],[49.155363,0.132548],[49.593813,-0.105094],[49.893495,-0.503715],[49.999980,-0.990917],[49.999980,-22.721408],[49.920871,-23.144827],[49.702494,-23.500911],[49.373202,-23.757921],[48.961349,-23.884117],[34.271701,-25.539386],[34.153323,-25.546802]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[34.386266,-23.171984],[47.659276,-21.675171],[47.659276,-2.346448],[41.708191,-3.228509],[31.484224,-20.955400],[31.694262,-21.646535],[34.386266,-23.171984]]);
    }
  }
}

module poly_path9315(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[35.829653,-49.450177],[35.127066,-49.154252],[17.648013,-33.550380],[17.355421,-33.146529],[17.257559,-32.657524],[17.372200,-32.172178],[17.678523,-31.778640],[29.962526,-21.535806],[30.606573,-21.270031],[31.287535,-21.417428],[34.716525,-23.359086],[35.081836,-23.682410],[35.283572,-24.126583],[39.711094,-44.423260],[39.712030,-44.917655],[39.508716,-45.368313],[36.847234,-48.976695],[36.398893,-49.343397],[35.829611,-49.450177]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[35.726467,-46.553925],[37.311126,-44.406078],[33.108897,-25.136547],[30.838824,-23.851657],[20.217750,-32.708428],[35.726467,-46.553925]]);
    }
  }
}

module poly_path9301(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-37.973732,11.037016],[-38.032847,11.042313],[-48.965121,12.319565],[-49.375768,12.446701],[-49.703868,12.703932],[-49.921296,13.059656],[-49.999927,13.482273],[-49.999927,28.068534],[-49.786749,28.742053],[-49.224771,29.170147],[-37.284419,33.458209],[-36.597097,33.488719],[-34.521764,32.954143],[-33.977621,32.641036],[-33.889796,32.551304],[-33.580503,31.974722],[-30.613552,17.989855],[-30.645385,17.386024],[-30.974396,16.878697],[-37.112594,11.336298],[-37.512729,11.099106],[-37.973658,11.036529]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-38.288757,13.429250],[-33.044083,18.164063],[-35.736108,30.850672],[-36.832010,31.133226],[-47.659276,27.246107],[-47.659276,14.523214],[-38.288757,13.429250]]);
    }
  }
}

module poly_path9307(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-17.531552,-21.094775],[-18.090950,-20.953493],[-25.699264,-16.846812],[-26.113762,-16.470979],[-26.306389,-15.945671],[-27.612318,-4.141103],[-27.508315,-3.515266],[-27.092998,-3.035676],[-19.490425,1.972146],[-19.070014,2.143559],[-18.616002,2.142064],[-11.614834,0.731179],[-11.143501,0.519736],[-10.809134,0.125962],[-5.915760,-9.234843],[-5.783861,-9.718162],[-5.866179,-10.212346],[-8.995421,-18.028611],[-9.287108,-18.452429],[-9.732386,-18.710180],[-17.186037,-21.041318],[-17.531605,-21.094712],[-17.531552,-21.094775]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-17.413174,-18.660547],[-10.961879,-16.642527],[-8.239312,-9.841967],[-12.624818,-1.452956],[-18.606457,-0.248242],[-25.208579,-4.595493],[-24.047767,-15.080803],[-17.413174,-18.660547]]);
    }
  }
}

module poly_path9261(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-42.006032,-28.007971],[-42.116772,-27.994622],[-49.011014,-26.912111],[-49.718691,-26.517106],[-50.000002,-25.757051],[-50.000002,-6.558158],[-49.899760,-6.084432],[-49.616314,-5.691842],[-49.198196,-5.447610],[-48.716997,-5.393554],[-43.371140,-5.909029],[-42.794266,-6.127878],[-42.408882,-6.609699],[-35.648283,-22.253681],[-35.553264,-22.720917],[-35.652520,-23.187271],[-36.576587,-25.291209],[-37.149355,-25.881150],[-41.437502,-27.899170],[-42.006445,-28.007982]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-42.111019,-25.629117],[-38.542665,-23.949027],[-37.998522,-22.713770],[-44.283733,-8.171422],[-47.659255,-7.846852],[-47.659255,-24.756622],[-42.111019,-25.629117]]);
    }
  }
}

module poly_path9299(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-48.894554,26.900550],[-49.328921,27.010273],[-49.679850,27.264730],[-49.914493,27.629201],[-50.000002,28.068968],[-50.000002,44.636985],[-49.783480,45.313765],[-49.215310,45.740505],[-46.263636,46.773383],[-45.509491,46.779756],[-44.908073,46.324714],[-35.919395,33.011881],[-35.730196,32.518952],[-35.776935,31.993035],[-36.050096,31.541195],[-36.494070,31.255418],[-48.434422,26.967356],[-48.894554,26.900613],[-48.894554,26.900550]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-47.659276,29.731875],[-38.701152,32.948889],[-46.343822,44.266607],[-47.659276,43.806485],[-47.659276,29.731875]]);
    }
  }
}

module poly_path9289(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[3.849971,24.479669],[3.113006,24.762245],[-5.304811,31.980909],[-5.653280,32.498034],[-5.686663,33.120714],[-2.177476,49.081606],[-1.767389,49.742155],[-1.033858,49.999921],[10.486471,49.999921],[11.171704,49.778641],[11.597650,49.198067],[15.410378,37.714234],[15.462970,37.221961],[15.307298,36.751997],[8.850219,25.774115],[8.511060,25.408087],[8.050240,25.216634],[4.082850,24.498770],[3.849929,24.479701]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[4.214629,26.900550],[7.105218,27.423663],[13.021926,37.481313],[9.640673,47.659248],[-0.092597,47.659248],[-3.250474,33.302084],[4.214629,26.900550]]);
    }
  }
}

module poly_path9327(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-22.190078,14.708409],[-22.411557,14.729385],[-31.982548,16.598495],[-32.580303,16.912957],[-32.904708,17.505367],[-35.871659,31.490235],[-35.871393,31.977458],[-35.672731,32.422341],[-35.310112,32.747762],[-34.846397,32.897306],[-18.262786,34.609846],[-17.766327,34.553312],[-17.338708,34.294843],[-13.609992,30.770464],[-13.301917,30.284717],[-13.262506,29.710867],[-15.081994,19.729579],[-15.252481,19.302162],[-15.574586,18.973524],[-21.529496,14.912673],[-22.190078,14.708387]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-22.444007,17.121640],[-17.296724,20.630731],[-15.679594,29.506593],[-18.556803,32.227200],[-33.311382,30.701751],[-30.775916,18.748273],[-22.444007,17.121640]]);
    }
  }
}

module poly_path9317(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[30.155412,-21.978733],[29.410808,-21.657987],[19.950557,-12.661851],[19.635548,-12.147701],[19.618349,-11.544973],[22.644478,1.281021],[22.909004,1.789603],[23.383350,2.111521],[28.700582,4.041727],[29.133483,4.111389],[29.561636,4.016831],[41.438985,-1.078826],[41.838610,-1.362314],[42.087139,-1.784565],[42.141001,-2.271554],[41.990755,-2.737909],[31.230306,-21.394555],[30.775284,-21.838310],[30.155412,-21.978765]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[29.945395,-18.939297],[39.306380,-2.709210],[29.063334,1.683861],[24.775187,0.127869],[22.048806,-11.428512],[29.945395,-18.939297]]);
    }
  }
}

module poly_path9283(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[48.795277,31.051132],[48.466872,31.108446],[30.945834,36.822680],[30.387573,37.213893],[30.142052,37.849827],[29.340167,48.743698],[29.402971,49.217115],[29.649688,49.626017],[30.039227,49.902302],[30.506711,49.999952],[43.772083,49.999952],[44.292074,49.878126],[44.703777,49.537935],[49.759442,42.899644],[50.000002,42.191336],[50.000002,32.221511],[49.907786,31.765534],[49.645198,31.381517],[49.253740,31.130151],[48.795277,31.051164]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[47.659276,33.834753],[47.659276,41.796104],[43.191666,47.659248],[31.764882,47.659248],[32.417858,38.804394],[47.659276,33.834753]]);
    }
  }
}

module poly_path9275(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[38.494949,-45.841795],[37.805449,-45.562195],[37.423868,-44.923470],[32.996346,-24.626792],[32.993383,-24.140736],[33.188170,-23.695407],[33.547101,-23.367637],[34.008248,-23.213979],[48.697896,-21.558710],[49.184520,-21.606316],[49.609214,-21.848600],[49.897837,-22.243264],[50.000002,-22.721408],[50.000002,-41.059254],[49.785030,-41.735178],[49.219114,-42.162770],[38.956977,-45.776882],[38.494949,-45.841792],[38.494949,-45.841795]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[39.428572,-43.128824],[47.659276,-40.230663],[47.659276,-24.031120],[35.560447,-25.394289],[39.428572,-43.128824]]);
    }
  }
}

module poly_path9333(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-6.944835,-10.947394],[-7.555234,-10.780005],[-7.989186,-10.319261],[-12.882561,-0.958467],[-13.003539,-0.245259],[-12.682090,0.402795],[-2.391317,10.918649],[-1.725367,11.257851],[-0.989935,11.124841],[8.264123,6.021556],[8.754393,5.502853],[8.852168,4.795855],[6.524801,-8.652540],[6.172051,-9.305335],[5.497633,-9.614767],[-6.826467,-10.939745],[-6.944835,-10.947161]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-6.284253,-8.528431],[4.369281,-7.382917],[6.404527,4.373915],[-1.341245,8.644804],[-10.415840,-0.628176],[-6.284253,-8.528431]]);
    }
  }
}

module poly_path9321(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[17.094325,18.007504],[16.378368,18.253785],[7.124309,25.443813],[6.840989,25.762002],[6.693024,26.148015],[6.688151,26.561385],[6.834106,26.961645],[13.291142,37.939517],[13.887991,38.441448],[14.667692,38.456909],[26.525961,34.523960],[27.099381,34.108111],[27.327836,33.437635],[27.564581,22.056914],[27.343003,21.346482],[26.737874,20.913307],[17.439913,18.059045],[17.094325,18.007451],[17.094325,18.007504]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[17.334884,20.474183],[25.204765,22.891217],[25.004294,32.563212],[14.828065,35.936784],[9.371478,26.661887],[17.334884,20.474183]]);
    }
  }
}

module poly_path9267(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-15.104919,-50.000026],[-15.625181,-49.878435],[-16.037169,-49.538259],[-16.255001,-49.050410],[-16.233271,-48.516580],[-13.201400,-37.594060],[-12.937679,-37.118319],[-12.487360,-36.813202],[-5.495737,-34.168957],[-4.920406,-34.104445],[-4.384558,-34.323609],[1.973191,-39.043141],[2.279179,-39.380306],[2.433323,-39.808729],[3.767878,-48.655951],[3.735037,-49.154115],[3.497540,-49.593254],[3.098613,-49.893438],[2.610869,-50.000026],[-15.104919,-50.000026]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-13.564162,-47.659351],[1.251503,-47.659351],[0.191874,-40.633503],[-5.264712,-36.584095],[-11.105069,-38.791128],[-13.564162,-47.659351]]);
    }
  }
}

module poly_path9305(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-36.795725,-23.886024],[-37.396469,-23.675433],[-37.798082,-23.181530],[-44.558681,-7.537558],[-44.609279,-6.751461],[-44.150111,-6.111396],[-35.537543,-0.154696],[-35.031716,0.042612],[-34.491284,-0.009600],[-26.069654,-2.905857],[-25.536021,-3.281882],[-25.286869,-3.885267],[-23.980940,-15.689835],[-24.096462,-16.338539],[-24.544173,-16.821990],[-36.123681,-23.721827],[-36.795725,-23.886024]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-36.177149,-21.029866],[-26.390400,-15.197264],[-27.530214,-4.878047],[-34.691756,-2.415182],[-42.028947,-7.489832],[-36.177149,-21.029866]]);
    }
  }
}

module poly_rect9152(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-41.284343,-50.000026],[-41.775521,-49.891922],[-42.175961,-49.587640],[-45.381564,-45.822702],[-45.613730,-45.391200],[-45.648863,-44.902468],[-43.094296,-26.677262],[-42.877657,-26.144933],[-42.433703,-25.779945],[-38.145557,-23.761925],[-37.432863,-23.671169],[-36.801457,-24.013937],[-27.635223,-33.607651],[-27.353001,-34.104049],[-27.339288,-34.674897],[-30.611719,-49.089340],[-31.023076,-49.744644],[-31.753441,-50.000026],[-41.284343,-50.000026],[-41.284343,-50.000026]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-40.744036,-47.659351],[-32.687063,-47.659351],[-29.762118,-34.768453],[-37.910729,-26.238149],[-40.864310,-27.628057],[-43.258493,-44.705822],[-40.744036,-47.659351]]);
    }
  }
}

module poly_path9259(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-44.453673,-46.235090],[-44.816424,-46.189260],[-49.156121,-44.929189],[-49.765768,-44.507787],[-50.000002,-43.804673],[-50.000002,-25.757025],[-49.892368,-25.267775],[-49.590004,-24.868364],[-49.148321,-24.631988],[-48.648263,-24.601965],[-41.754010,-25.684477],[-41.322859,-25.843177],[-40.995771,-26.143197],[-40.803420,-26.543194],[-40.776485,-27.001827],[-43.331041,-45.227028],[-43.708199,-45.936137],[-44.453673,-46.235084]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-45.461750,-43.564121],[-43.254679,-27.817055],[-47.659276,-27.124013],[-47.659276,-42.926449],[-45.461750,-43.564121]]);
    }
  }
}

module poly_path9297(h)
{
  scale([1, -1, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-48.904099,43.468556],[-49.335431,43.580813],[-49.683327,43.835859],[-49.915584,44.199360],[-50.000002,44.636985],[-50.000002,48.829584],[-49.910951,49.277474],[-49.657253,49.657178],[-49.277543,49.910871],[-48.829644,49.999921],[-44.169190,49.999921],[-43.590821,49.847154],[-43.163520,49.428516],[-42.998950,48.853404],[-43.140115,48.272104],[-44.848895,45.112373],[-45.119661,44.779345],[-45.492293,44.566344],[-48.443967,43.533466],[-48.904099,43.468524]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-47.659276,46.284616],[-46.691297,46.624463],[-46.131888,47.659248],[-47.659276,47.659248],[-47.659276,46.284616]]);
    }
  }
}


module voronoi(bot_h) {
poly_path9331(bot_h);
poly_path9323(bot_h);
poly_path9281(bot_h);
poly_path9273(bot_h);
poly_path9325(bot_h);
poly_path9311(bot_h);
poly_path9265(bot_h);
poly_path9303(bot_h);
poly_path9257(bot_h);
poly_path9269(bot_h);
poly_path9295(bot_h);
poly_path9335(bot_h);
poly_path9329(bot_h);
poly_path9287(bot_h);
poly_path9279(bot_h);
poly_path9291(bot_h);
poly_path9313(bot_h);
poly_path9309(bot_h);
poly_path9263(bot_h);
poly_path9271(bot_h);
poly_path9293(bot_h);
poly_path9337(bot_h);
poly_path9319(bot_h);
poly_path9285(bot_h);
poly_path9277(bot_h);
poly_path9315(bot_h);
poly_path9301(bot_h);
poly_path9307(bot_h);
poly_path9261(bot_h);
poly_path9299(bot_h);
poly_path9289(bot_h);
poly_path9327(bot_h);
poly_path9317(bot_h);
poly_path9283(bot_h);
poly_path9275(bot_h);
poly_path9333(bot_h);
poly_path9321(bot_h);
poly_path9267(bot_h);
poly_path9305(bot_h);
poly_rect9152(bot_h);
poly_path9259(bot_h);
poly_path9297(bot_h);
};

	

