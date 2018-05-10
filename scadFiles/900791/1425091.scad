scale_factor = 1; //[.5:.25:5]
inner_section = 1; //[1:On,2:Off]
inner_height = 4; //[2:1:20]
middle_section = 1; //[1:On,2:Off]
middle_height = 3; //[2:1:20]
outer_section = 1; //[1:On,2:Off]
outer_height = 2; //[2:1:20]
//What layer height will you be printing at? This is useful for determining your Z-pause height.
layer_height = .2; //[.1:.05:.3]
//Only works at scale factors of 2 or below
keychain = 1; //[1:On,2:Off]
keychain_ring_height = 2; //[2:1:20]

/*[Hidden]*/

e = .001; //epsilon

scale(scale_factor){
    if(inner_section == 1){
        color("limegreen"){
            linear_extrude(height = inner_height / scale_factor){
                Logo_Full();
            }
        }
    }
    if(middle_section == 1){
        color("black"){
            linear_extrude(height = (middle_height / scale_factor) - (layer_height / scale_factor)){
                offset(r = .75){
                    Logo_Full();
                }
            }
        }
    }
    if(outer_section == 1){
        color("white"){
            linear_extrude(height = (outer_height / scale_factor) - (layer_height / scale_factor)){
                offset(r = 1.5){
                    Logo_Full();
                }
            }
        }
    }
}
if(keychain == 1){
    color("white"){
        translate([(25 * scale_factor) + 3.5,0,0]){
            difference(){
                cylinder(r = 5, h = keychain_ring_height - layer_height, $fn = 30);
                translate([0,0,-(e/2)]){
                    cylinder(r = 3, h = keychain_ring_height + e - layer_height + 2, $fn = 30);
                }
            }
        }
    }
}

module Logo_Full() {
    Logo_T();
    Logo_I_Body();
    Logo_I_Dot();
    Logo_C();
    Logo_K();
    Logo_L();
    difference(){
        Logo_D_Out();
        Logo_D_In();
    }
}
module Logo_D_In() {
    polygon(points = Logo_D_In_points(), paths = Logo_D_In_paths());
};
module Logo_D_Out() {
    polygon(points = Logo_D_Out_points(), paths = Logo_D_Out_paths());
};
module Logo_L() {
    polygon(points = Logo_L_points(), paths = Logo_L_paths());
};
module Logo_K() {
    polygon(points = Logo_K_points(), paths = Logo_K_paths());
};
module Logo_C() {
    polygon(points = Logo_C_points(), paths = Logo_C_paths());
};
module Logo_I_Dot() {
    polygon(points = Logo_I_Dot_points(), paths = Logo_I_Dot_paths());
};
module Logo_I_Body() {
    polygon(points = Logo_I_Body_points(), paths = Logo_I_Body_paths());
};
module Logo_T() {
    polygon(points = Logo_T_points(), paths = Logo_T_paths());
};

function Logo_T_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191]];
function Logo_T_points() = [
[-21.119503,-4.223990],[-21.260651,-4.074934],[-21.377155,-3.905875],[-21.470793,-3.714783],[-21.543339,-3.499631],[-21.596563,-3.258392],[-21.632246,-2.989041],[-21.652155,-2.689547],[-21.660196,-2.479688],[-21.667398,-2.269672],[-21.673594,-2.059539],[-21.678591,-1.849328],[-21.682215,-1.639075],[-21.684282,-1.428820],[-21.684618,-1.218601],[-21.683035,-1.008456],[-21.679354,-0.798420],[-21.673399,-0.588534],[-21.664984,-0.378836],[-21.653934,-0.169363],[-21.633612,0.090892],[-21.601900,0.344609],[-21.555937,0.589834],[-21.492868,0.824612],[-21.409826,1.046987],[-21.303957,1.255005],[-21.172394,1.446710],[-21.012281,1.620148],[-20.820757,1.773364],[-20.594963,1.904401],[-20.332035,2.011306],[-20.029119,2.092122],[-19.936357,2.114691],[-19.846367,2.143672],[-19.760233,2.179493],[-19.679037,2.222578],[-19.603868,2.273355],[-19.535810,2.332250],[-19.475946,2.399690],[-19.425360,2.476103],[-19.385136,2.561913],[-19.356361,2.657548],[-19.340115,2.763436],[-19.337490,2.880002],[-19.345179,2.977336],[-19.360731,3.067926],[-19.384058,3.151784],[-19.415058,3.228924],[-19.453642,3.299358],[-19.499710,3.363098],[-19.553171,3.420158],[-19.613932,3.470550],[-19.681894,3.514287],[-19.756966,3.551383],[-19.839052,3.581849],[-19.928057,3.605698],[-20.199759,3.679030],[-20.445963,3.772183],[-20.667555,3.884544],[-20.865419,4.015501],[-21.040438,4.164442],[-21.193487,4.330755],[-21.325460,4.513827],[-21.437233,4.713048],[-21.529690,4.927804],[-21.603716,5.157483],[-21.660185,5.401472],[-21.699993,5.659161],[-21.724154,5.796833],[-21.761091,5.917808],[-21.810240,6.022961],[-21.871027,6.113162],[-21.942881,6.189285],[-22.025225,6.252200],[-22.117493,6.302782],[-22.219109,6.341900],[-22.329498,6.370428],[-22.448095,6.389238],[-22.574324,6.399203],[-22.707611,6.401193],[-22.895082,6.392891],[-23.065111,6.371893],[-23.218737,6.336741],[-23.357002,6.285975],[-23.480947,6.218136],[-23.591608,6.131766],[-23.690025,6.025406],[-23.777243,5.897595],[-23.854294,5.746878],[-23.922220,5.571792],[-23.982063,5.370880],[-24.034864,5.142682],[-24.068773,4.976779],[-24.103523,4.814149],[-24.141481,4.655397],[-24.185022,4.501126],[-24.236526,4.351937],[-24.298363,4.208435],[-24.372908,4.071220],[-24.462538,3.940898],[-24.569618,3.818070],[-24.696539,3.703339],[-24.845661,3.597307],[-25.019367,3.500579],[-25.220207,3.391781],[-25.386206,3.280217],[-25.517311,3.165884],[-25.613478,3.048780],[-25.674658,2.928902],[-25.700796,2.806247],[-25.691849,2.680813],[-25.647762,2.552597],[-25.568493,2.421596],[-25.453983,2.287807],[-25.304190,2.151229],[-25.119062,2.011857],[-24.965347,1.896069],[-24.830875,1.775962],[-24.714462,1.651335],[-24.614922,1.521983],[-24.531069,1.387705],[-24.461725,1.248296],[-24.405703,1.103554],[-24.361816,0.953275],[-24.328878,0.797255],[-24.305712,0.635293],[-24.291130,0.467184],[-24.283945,0.292727],[-24.277380,-0.094411],[-24.273615,-0.481580],[-24.271204,-0.868757],[-24.268686,-1.255922],[-24.264610,-1.643058],[-24.257517,-2.030141],[-24.245958,-2.417153],[-24.228476,-2.804072],[-24.203611,-3.190880],[-24.169914,-3.577556],[-24.125931,-3.964078],[-24.070200,-4.350428],[-23.993666,-4.722181],[-23.888014,-5.064286],[-23.752937,-5.376172],[-23.588121,-5.657269],[-23.393255,-5.907012],[-23.168028,-6.124831],[-22.912125,-6.310156],[-22.625235,-6.462417],[-22.307051,-6.581048],[-21.957249,-6.665478],[-21.575525,-6.715139],[-21.161566,-6.729459],[-21.061621,-6.753503],[-20.960001,-6.763197],[-20.856827,-6.760342],[-20.752214,-6.746746],[-20.646278,-6.724212],[-20.539139,-6.694546],[-20.430914,-6.659552],[-20.321716,-6.621031],[-20.211666,-6.580792],[-20.100880,-6.540637],[-19.989475,-6.502369],[-19.877565,-6.467795],[-19.761532,-6.430060],[-19.651159,-6.384709],[-19.547470,-6.331478],[-19.451485,-6.270094],[-19.364227,-6.200290],[-19.286724,-6.121800],[-19.219990,-6.034355],[-19.165054,-5.937685],[-19.122936,-5.831522],[-19.094658,-5.715597],[-19.081244,-5.589644],[-19.083715,-5.453392],[-19.101583,-5.325886],[-19.133509,-5.217168],[-19.178383,-5.125313],[-19.235096,-5.048398],[-19.302542,-4.984498],[-19.379612,-4.931692],[-19.465195,-4.888056],[-19.558187,-4.851667],[-19.657476,-4.820603],[-19.761957,-4.792939],[-19.870518,-4.766753],[-19.982054,-4.740123],[-20.273020,-4.660691],[-20.530474,-4.571390],[-20.756189,-4.470190],[-20.951941,-4.355065]];
function Logo_I_Body_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107]];
function Logo_I_Body_points() = [
[-14.390816,-2.423389],[-14.397816,-2.029156],[-14.399473,-1.638112],[-14.399067,-1.250840],[-14.399879,-0.867932],[-14.405182,-0.489973],[-14.405228,-0.291563],[-14.405346,-0.098117],[-14.405510,0.090818],[-14.405695,0.275690],[-14.405872,0.456950],[-14.406016,0.635048],[-14.406097,0.810434],[-14.406094,0.983560],[-14.405975,1.154874],[-14.405716,1.324829],[-14.405289,1.493873],[-14.404665,1.662458],[-14.400822,2.135113],[-14.399647,2.525427],[-14.410070,2.840992],[-14.441019,3.089400],[-14.501423,3.278240],[-14.600207,3.415103],[-14.746300,3.507581],[-14.948631,3.563264],[-15.216128,3.589743],[-15.557717,3.594609],[-15.982326,3.585451],[-16.498884,3.569861],[-16.742477,3.555149],[-16.953875,3.525238],[-17.133835,3.479164],[-17.283125,3.415964],[-17.402506,3.334676],[-17.492743,3.234333],[-17.554598,3.113975],[-17.588833,2.972636],[-17.596214,2.809355],[-17.577501,2.623166],[-17.533463,2.413107],[-17.464853,2.178215],[-17.420603,2.049123],[-17.373171,1.920840],[-17.323929,1.793038],[-17.274246,1.665389],[-17.225491,1.537563],[-17.179033,1.409233],[-17.136244,1.280070],[-17.098488,1.149747],[-17.067141,1.017933],[-17.043568,0.884302],[-17.029137,0.748525],[-17.025221,0.610274],[-17.026005,0.108265],[-17.018881,-0.394222],[-17.008663,-0.896862],[-17.000164,-1.399331],[-16.998196,-1.901304],[-17.007568,-2.402452],[-17.033096,-2.902452],[-17.079592,-3.400980],[-17.151867,-3.897709],[-17.254730,-4.392313],[-17.393000,-4.884468],[-17.571484,-5.373849],[-17.631042,-5.543981],[-17.665499,-5.701862],[-17.675415,-5.847255],[-17.661362,-5.979926],[-17.623901,-6.099643],[-17.563606,-6.206172],[-17.481041,-6.299277],[-17.376772,-6.378727],[-17.251369,-6.444287],[-17.105398,-6.495721],[-16.939428,-6.532797],[-16.754023,-6.555284],[-16.613062,-6.564969],[-16.471855,-6.572336],[-16.330435,-6.577598],[-16.188843,-6.580968],[-16.047113,-6.582657],[-15.905284,-6.582879],[-15.763391,-6.581847],[-15.621473,-6.579772],[-15.479566,-6.576866],[-15.337707,-6.573343],[-15.195933,-6.569415],[-15.054282,-6.565292],[-14.821071,-6.548945],[-14.609478,-6.514350],[-14.420568,-6.461771],[-14.255408,-6.391470],[-14.115062,-6.303715],[-14.000594,-6.198770],[-13.913074,-6.076896],[-13.853565,-5.938361],[-13.823134,-5.783427],[-13.822847,-5.612360],[-13.853766,-5.425423],[-13.916964,-5.222881],[-14.053123,-4.822797],[-14.160995,-4.421785],[-14.243862,-4.020435],[-14.304999,-3.619331],[-14.347686,-3.219064],[-14.375198,-2.820222]];
function Logo_I_Dot_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47]];
function Logo_I_Dot_points() = [
[-14.446308,5.814731],[-14.346392,5.951746],[-14.268054,6.108377],[-14.210868,6.284973],[-14.174398,6.481879],[-14.158213,6.699440],[-14.162566,6.925189],[-14.188563,7.130022],[-14.236495,7.314197],[-14.306646,7.477972],[-14.399302,7.621605],[-14.514755,7.745355],[-14.653289,7.849480],[-14.815191,7.934237],[-15.000751,7.999886],[-15.210257,8.046683],[-15.443995,8.074890],[-15.702250,8.084762],[-15.970926,8.077719],[-16.211683,8.054370],[-16.425432,8.013942],[-16.613096,7.955667],[-16.775585,7.878769],[-16.913822,7.782481],[-17.028721,7.666028],[-17.121201,7.528639],[-17.192177,7.369545],[-17.242567,7.187972],[-17.273289,6.983149],[-17.285259,6.754304],[-17.280529,6.505296],[-17.258959,6.285285],[-17.219042,6.092888],[-17.159279,5.926722],[-17.078165,5.785405],[-16.974197,5.667554],[-16.845873,5.571787],[-16.691687,5.496720],[-16.510138,5.440971],[-16.299723,5.403158],[-16.058935,5.381897],[-15.786275,5.375807],[-15.523199,5.385202],[-15.284727,5.411789],[-15.070427,5.455915],[-14.879866,5.517926],[-14.712615,5.598168],[-14.568240,5.696988]];
function Logo_C_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167]];
function Logo_C_points() = [
[-3.660010,2.046960],[-3.667507,1.939656],[-3.688710,1.832287],[-3.723535,1.725016],[-3.771896,1.618007],[-3.833708,1.511422],[-3.908887,1.405426],[-3.986659,1.314191],[-4.068859,1.235437],[-4.155200,1.168965],[-4.245392,1.114575],[-4.339150,1.072065],[-4.436185,1.041237],[-4.536209,1.021890],[-4.638934,1.013823],[-4.744070,1.016838],[-4.851332,1.030734],[-4.960431,1.055310],[-5.071078,1.090369],[-5.161613,1.124325],[-5.251512,1.160256],[-5.340779,1.198024],[-5.429418,1.237490],[-5.517436,1.278518],[-5.604836,1.320968],[-5.691624,1.364704],[-5.777803,1.409587],[-5.863380,1.455479],[-5.948358,1.502242],[-6.032742,1.549740],[-6.116537,1.597832],[-6.574803,1.818581],[-7.012182,1.944045],[-7.425961,1.982705],[-7.813429,1.943042],[-8.171872,1.833540],[-8.498580,1.662681],[-8.790838,1.438948],[-9.045936,1.170821],[-9.261158,0.866785],[-9.433795,0.535320],[-9.561132,0.184910],[-9.640458,-0.175963],[-9.666424,-0.362208],[-9.688736,-0.550066],[-9.707098,-0.739175],[-9.721217,-0.929173],[-9.730797,-1.119699],[-9.735542,-1.310395],[-9.735161,-1.500900],[-9.729355,-1.690852],[-9.717831,-1.879890],[-9.700294,-2.067655],[-9.676448,-2.253785],[-9.646000,-2.437921],[-9.547384,-2.845119],[-9.406440,-3.227857],[-9.223658,-3.580975],[-8.999523,-3.899314],[-8.734526,-4.177717],[-8.429151,-4.411023],[-8.083889,-4.594077],[-7.699225,-4.721719],[-7.275649,-4.788792],[-6.813647,-4.790137],[-6.313707,-4.720597],[-5.776316,-4.575010],[-5.612845,-4.518827],[-5.450228,-4.461281],[-5.287841,-4.404847],[-5.125060,-4.351998],[-4.961260,-4.305204],[-4.795818,-4.266936],[-4.628109,-4.239668],[-4.457510,-4.225870],[-4.283395,-4.228014],[-4.105143,-4.248570],[-3.922127,-4.290013],[-3.733725,-4.354812],[-3.686154,-4.516919],[-3.659636,-4.667737],[-3.652827,-4.808047],[-3.664384,-4.938625],[-3.692961,-5.060257],[-3.737214,-5.173722],[-3.795800,-5.279801],[-3.867373,-5.379274],[-3.950591,-5.472923],[-4.044107,-5.561530],[-4.146578,-5.645873],[-4.256660,-5.726733],[-4.726150,-6.022457],[-5.211094,-6.265858],[-5.708529,-6.457677],[-6.215495,-6.598649],[-6.729025,-6.689511],[-7.246156,-6.731002],[-7.763927,-6.723861],[-8.279374,-6.668827],[-8.789534,-6.566635],[-9.291442,-6.418022],[-9.782137,-6.223728],[-10.258657,-5.984489],[-10.632267,-5.733269],[-10.981147,-5.416095],[-11.302067,-5.043380],[-11.591800,-4.625534],[-11.847121,-4.172968],[-12.064800,-3.696095],[-12.241611,-3.205329],[-12.374325,-2.711080],[-12.459717,-2.223763],[-12.494557,-1.753787],[-12.475621,-1.311565],[-12.399680,-0.907510],[-12.341144,-0.684823],[-12.286819,-0.461191],[-12.234375,-0.237354],[-12.181477,-0.014054],[-12.125793,0.207970],[-12.064986,0.427975],[-11.996730,0.645223],[-11.918685,0.858971],[-11.828521,1.068478],[-11.723905,1.273005],[-11.602504,1.471809],[-11.461984,1.664151],[-11.264603,1.898490],[-11.057994,2.118583],[-10.841928,2.324095],[-10.616172,2.514688],[-10.380500,2.690029],[-10.134679,2.849779],[-9.878477,2.993602],[-9.611668,3.121163],[-9.334018,3.232124],[-9.045299,3.326151],[-8.745279,3.402905],[-8.433729,3.462053],[-8.131131,3.506757],[-7.829192,3.544337],[-7.527851,3.573929],[-7.227053,3.594669],[-6.926737,3.605692],[-6.626848,3.606134],[-6.327325,3.595131],[-6.028113,3.571818],[-5.729154,3.535331],[-5.430388,3.484806],[-5.131758,3.419377],[-4.833207,3.338181],[-4.734621,3.305453],[-4.640887,3.267907],[-4.551719,3.225782],[-4.466832,3.179318],[-4.385941,3.128758],[-4.308760,3.074339],[-4.235004,3.016304],[-4.164389,2.954891],[-4.096628,2.890342],[-4.031438,2.822895],[-3.968532,2.752793],[-3.907624,2.680274],[-3.831098,2.576789],[-3.768787,2.472259],[-3.720608,2.366848],[-3.686476,2.260719],[-3.666305,2.154035]];
function Logo_K_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287]];
function Logo_K_points() = [
[1.870089,0.222585],[1.948366,0.291616],[2.022209,0.366371],[2.092899,0.444717],[2.161710,0.524519],[2.229922,0.603643],[2.298813,0.679955],[2.385203,0.773620],[2.470075,0.868705],[2.553550,0.965076],[2.635749,1.062601],[2.716794,1.161144],[2.796803,1.260574],[2.875897,1.360754],[2.954197,1.461551],[3.031824,1.562832],[3.108898,1.664462],[3.185541,1.766308],[3.261872,1.868237],[3.502872,2.170585],[3.745370,2.431525],[3.992431,2.651406],[4.247120,2.830581],[4.512505,2.969401],[4.791650,3.068218],[5.087619,3.127383],[5.403480,3.147247],[5.742296,3.128162],[6.107133,3.070479],[6.501060,2.974551],[6.927137,2.840729],[6.943399,2.832183],[6.957996,2.818923],[6.970755,2.801771],[6.981506,2.781553],[6.990075,2.759088],[6.996293,2.735202],[6.999986,2.710716],[7.000983,2.686454],[6.999115,2.663239],[6.994208,2.641894],[6.986091,2.623240],[6.974588,2.608103],[6.827081,2.462069],[6.682652,2.318087],[6.540813,2.176210],[6.401070,2.036488],[6.262928,1.898970],[6.125894,1.763707],[5.989475,1.630751],[5.853176,1.500152],[5.716508,1.371960],[5.578973,1.246226],[5.440080,1.123001],[5.299334,1.002334],[5.218079,0.930127],[5.141800,0.855316],[5.069780,0.778285],[5.001307,0.699416],[4.935665,0.619093],[4.872142,0.537701],[4.810022,0.455625],[4.748593,0.373247],[4.687138,0.290951],[4.624946,0.209121],[4.561299,0.128141],[4.495485,0.048396],[4.397091,-0.079438],[4.320011,-0.205566],[4.262999,-0.330376],[4.224816,-0.454257],[4.204217,-0.577596],[4.199962,-0.700781],[4.210809,-0.824201],[4.235511,-0.948242],[4.272831,-1.073294],[4.321523,-1.199742],[4.380347,-1.327976],[4.448059,-1.458381],[4.642599,-1.799896],[4.848614,-2.133416],[5.064701,-2.459920],[5.289452,-2.780384],[5.521464,-3.095784],[5.759328,-3.407099],[6.001640,-3.715305],[6.246997,-4.021379],[6.493989,-4.326299],[6.741214,-4.631041],[6.987263,-4.936582],[7.230734,-5.243900],[7.296332,-5.326840],[7.362219,-5.409870],[7.427763,-5.493951],[7.492330,-5.580047],[7.555282,-5.669123],[7.615988,-5.762135],[7.673812,-5.860049],[7.728124,-5.963829],[7.778282,-6.074434],[7.823656,-6.192830],[7.863613,-6.319975],[7.897516,-6.456837],[7.672497,-6.491797],[7.448627,-6.521151],[7.225804,-6.544446],[7.003921,-6.561223],[6.782878,-6.571033],[6.562569,-6.573420],[6.342891,-6.567926],[6.123741,-6.554099],[5.905014,-6.531483],[5.686607,-6.499625],[5.468417,-6.458069],[5.250336,-6.406359],[5.083206,-6.353154],[4.930385,-6.285550],[4.790785,-6.204761],[4.663320,-6.112007],[4.546898,-6.008502],[4.440436,-5.895463],[4.342842,-5.774108],[4.253030,-5.645653],[4.169911,-5.511315],[4.092399,-5.372309],[4.019405,-5.229854],[3.949841,-5.085165],[3.808822,-4.805012],[3.641765,-4.507092],[3.454873,-4.199242],[3.254350,-3.889300],[3.046400,-3.585104],[2.837226,-3.294491],[2.633030,-3.025301],[2.440015,-2.785372],[2.264388,-2.582542],[2.112348,-2.424648],[1.990100,-2.319529],[1.903846,-2.275024],[1.800802,-2.297758],[1.710480,-2.327531],[1.632112,-2.363931],[1.564928,-2.406548],[1.508160,-2.454973],[1.461037,-2.508792],[1.422790,-2.567594],[1.392649,-2.630969],[1.369846,-2.698506],[1.353610,-2.769792],[1.343173,-2.844421],[1.337765,-2.921974],[1.334394,-3.058171],[1.335116,-3.193711],[1.339711,-3.328702],[1.347962,-3.463251],[1.359647,-3.597463],[1.374548,-3.731447],[1.392445,-3.865308],[1.413121,-3.999155],[1.436355,-4.133091],[1.461928,-4.267224],[1.489621,-4.401663],[1.519216,-4.536511],[1.560221,-4.766464],[1.575082,-4.976079],[1.563963,-5.165746],[1.527028,-5.335850],[1.464443,-5.486783],[1.376371,-5.618930],[1.262978,-5.732683],[1.124428,-5.828432],[0.960884,-5.906560],[0.772513,-5.967461],[0.559479,-6.011521],[0.321947,-6.039128],[0.300293,-6.040688],[0.278611,-6.041990],[0.256905,-6.043073],[0.235176,-6.043972],[0.213429,-6.044722],[0.191667,-6.045361],[0.169894,-6.045926],[0.148114,-6.046451],[0.126328,-6.046975],[0.104543,-6.047532],[0.082760,-6.048157],[0.060981,-6.048890],[-0.420305,-6.064658],[-0.818730,-6.070828],[-1.141723,-6.060734],[-1.396711,-6.027713],[-1.591123,-5.965101],[-1.732386,-5.866236],[-1.827926,-5.724454],[-1.885174,-5.533092],[-1.911554,-5.285487],[-1.914497,-4.974974],[-1.901428,-4.594890],[-1.879776,-4.138572],[-1.846143,-3.340104],[-1.820086,-2.541459],[-1.801053,-1.742663],[-1.788489,-0.943743],[-1.781841,-0.144726],[-1.780558,0.654365],[-1.784086,1.453498],[-1.791873,2.252651],[-1.803364,3.051797],[-1.818009,3.850909],[-1.835253,4.649960],[-1.854543,5.448924],[-1.861152,5.582005],[-1.874016,5.715253],[-1.892537,5.848565],[-1.916114,5.981833],[-1.944146,6.114951],[-1.976033,6.247815],[-2.011175,6.380318],[-2.048971,6.512354],[-2.088820,6.643819],[-2.130123,6.774606],[-2.172279,6.904610],[-2.214688,7.033724],[-2.240847,7.117249],[-2.263720,7.199724],[-2.282989,7.281561],[-2.298330,7.363172],[-2.309423,7.444969],[-2.315949,7.527366],[-2.317584,7.610773],[-2.314009,7.695602],[-2.304902,7.782267],[-2.289943,7.871179],[-2.268811,7.962750],[-2.241184,8.057392],[-2.113955,8.083397],[-1.987121,8.111014],[-1.860611,8.139644],[-1.734360,8.168684],[-1.608297,8.197536],[-1.482355,8.225595],[-1.356465,8.252264],[-1.230561,8.276938],[-1.104572,8.299019],[-0.978431,8.317905],[-0.852070,8.332994],[-0.725420,8.343686],[-0.453426,8.353866],[-0.213202,8.346004],[-0.003161,8.318836],[0.178284,8.271095],[0.332721,8.201517],[0.461736,8.108835],[0.566917,7.991782],[0.649850,7.849094],[0.712124,7.679504],[0.755325,7.481747],[0.781041,7.254556],[0.790859,6.996666],[0.794381,6.555107],[0.797201,6.113537],[0.799441,5.671961],[0.801221,5.230377],[0.802661,4.788787],[0.803881,4.347191],[0.805001,3.905591],[0.806141,3.463987],[0.807422,3.022379],[0.808963,2.580770],[0.810885,2.139159],[0.813308,1.697547],[0.814226,1.551897],[0.816349,1.406380],[0.821185,1.261404],[0.830244,1.117376],[0.845036,0.974703],[0.867067,0.833792],[0.897848,0.695051],[0.938887,0.558888],[0.991693,0.425708],[1.057775,0.295920],[1.138641,0.169931],[1.235802,0.048146],[1.367503,0.038008],[1.487106,0.046400],[1.595889,0.071187],[1.695128,0.110237],[1.786102,0.161414]];
function Logo_L_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143]];
function Logo_L_points() = [
[9.608809,5.249835],[9.590940,5.401834],[9.564368,5.553781],[9.530385,5.705651],[9.490273,5.857424],[9.445323,6.009078],[9.396816,6.160589],[9.346044,6.311935],[9.294289,6.463096],[9.242839,6.614047],[9.192981,6.764766],[9.146000,6.915232],[9.080555,7.158296],[9.038931,7.374766],[9.022264,7.565888],[9.031690,7.732907],[9.068342,7.877068],[9.133360,7.999616],[9.227880,8.101797],[9.353039,8.184856],[9.509971,8.250039],[9.699814,8.298592],[9.923703,8.331758],[10.182776,8.350783],[10.322276,8.357852],[10.462016,8.366097],[10.601785,8.374555],[10.741370,8.382255],[10.880561,8.388230],[11.019142,8.391514],[11.156903,8.391139],[11.293633,8.386138],[11.429119,8.375544],[11.563148,8.358389],[11.695511,8.333706],[11.825992,8.300528],[11.937584,8.197120],[12.028246,8.089475],[12.100124,7.978037],[12.155367,7.863252],[12.196125,7.745565],[12.224543,7.625422],[12.242773,7.503266],[12.252963,7.379545],[12.257262,7.254703],[12.257816,7.129184],[12.256779,7.003435],[12.256293,6.877901],[12.259081,6.268270],[12.262388,5.658640],[12.266025,5.049010],[12.269798,4.439382],[12.273517,3.829753],[12.276987,3.220125],[12.280012,2.610496],[12.282404,2.000868],[12.283972,1.391239],[12.284517,0.781610],[12.283854,0.171980],[12.281786,-0.437651],[12.284479,-0.806361],[12.296123,-1.173398],[12.316965,-1.538787],[12.347248,-1.902553],[12.387220,-2.264721],[12.437126,-2.625315],[12.497211,-2.984360],[12.567718,-3.341882],[12.648897,-3.697901],[12.740992,-4.052446],[12.844244,-4.405540],[12.958903,-4.757208],[12.981813,-4.826228],[13.003403,-4.896045],[13.023571,-4.966557],[13.042215,-5.037657],[13.059237,-5.109242],[13.074533,-5.181209],[13.088007,-5.253448],[13.099552,-5.325857],[13.109074,-5.398331],[13.116470,-5.470765],[13.121638,-5.543053],[13.124477,-5.615092],[13.123764,-5.776967],[13.112776,-5.920850],[13.090526,-6.047654],[13.056032,-6.158299],[13.008315,-6.253697],[12.946388,-6.334763],[12.869276,-6.402412],[12.775989,-6.457560],[12.665549,-6.501122],[12.536970,-6.534015],[12.389274,-6.557150],[12.221473,-6.571445],[12.058806,-6.579971],[11.895905,-6.586891],[11.732819,-6.592193],[11.569597,-6.595864],[11.406287,-6.597894],[11.242940,-6.598269],[11.079604,-6.596977],[10.916328,-6.594010],[10.753162,-6.589351],[10.590156,-6.582991],[10.427357,-6.574918],[10.264813,-6.565122],[10.099177,-6.549794],[9.953101,-6.526364],[9.825678,-6.493706],[9.715993,-6.450696],[9.623134,-6.396208],[9.546189,-6.329117],[9.484244,-6.248303],[9.436390,-6.152637],[9.401711,-6.040997],[9.379297,-5.912256],[9.368234,-5.765291],[9.367608,-5.598978],[9.375689,-5.389938],[9.389024,-5.180826],[9.406597,-4.971704],[9.427386,-4.762630],[9.450367,-4.553666],[9.474522,-4.344870],[9.498830,-4.136304],[9.522269,-3.928026],[9.543818,-3.720100],[9.562459,-3.512582],[9.577167,-3.305533],[9.586923,-3.099015],[9.607610,-2.416380],[9.624054,-1.733579],[9.636538,-1.050638],[9.645336,-0.367584],[9.650732,0.315557],[9.653005,0.998760],[9.652432,1.681999],[9.649297,2.365246],[9.643875,3.048477],[9.636448,3.731665],[9.627293,4.414783],[9.616692,5.097806]];
function Logo_D_Out_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179]];
function Logo_D_Out_points() = [
[21.407976,8.067101],[21.281233,8.002928],[21.176733,7.934561],[21.093462,7.859941],[21.030411,7.777011],[20.986557,7.683712],[20.960894,7.577985],[20.952398,7.457773],[20.960060,7.321018],[20.982870,7.165661],[21.019806,6.989644],[21.052351,6.857522],[21.087677,6.725902],[21.125053,6.594666],[21.163750,6.463699],[21.203035,6.332880],[21.242182,6.202094],[21.280458,6.071221],[21.317131,5.940144],[21.351471,5.808746],[21.382746,5.676908],[21.410225,5.544513],[21.433176,5.411444],[21.465387,5.148435],[21.476290,4.913301],[21.464685,4.704190],[21.429375,4.519245],[21.369154,4.356613],[21.282824,4.214439],[21.169184,4.090869],[21.027037,3.984049],[20.855179,3.892125],[20.652411,3.813242],[20.417526,3.745546],[20.149328,3.687182],[20.075235,3.673561],[20.000757,3.660904],[19.925947,3.649267],[19.850863,3.638710],[19.775564,3.629292],[19.700106,3.621070],[19.624540,3.614101],[19.548925,3.608446],[19.473318,3.604162],[19.397772,3.601308],[19.322346,3.599941],[19.247095,3.600119],[18.919935,3.591289],[18.607897,3.556492],[18.310421,3.496629],[18.026943,3.412596],[17.756912,3.305292],[17.499762,3.175616],[17.254938,3.024466],[17.021877,2.852739],[16.800022,2.661335],[16.588820,2.451151],[16.387701,2.223086],[16.196110,1.978038],[15.907908,1.556086],[15.659650,1.126351],[15.449910,0.689140],[15.277263,0.244758],[15.140290,-0.206490],[15.037566,-0.664296],[14.967665,-1.128359],[14.929160,-1.598370],[14.920634,-2.074024],[14.940660,-2.555017],[14.987814,-3.041040],[15.060672,-3.531794],[15.100126,-3.739193],[15.146724,-3.944583],[15.200898,-4.147487],[15.263083,-4.347425],[15.333711,-4.543923],[15.413215,-4.736506],[15.502034,-4.924692],[15.600593,-5.108008],[15.709331,-5.285975],[15.828685,-5.458117],[15.959081,-5.623956],[16.100952,-5.783017],[16.378010,-6.047869],[16.668715,-6.274160],[16.972288,-6.461926],[17.287956,-6.611205],[17.614948,-6.722033],[17.952486,-6.794448],[18.299799,-6.828486],[18.656111,-6.824186],[19.020647,-6.781584],[19.392635,-6.700717],[19.771303,-6.581623],[20.155874,-6.424338],[20.322462,-6.351875],[20.481932,-6.290250],[20.635460,-6.239940],[20.784220,-6.201420],[20.929390,-6.175167],[21.072145,-6.161657],[21.213669,-6.161364],[21.355133,-6.174766],[21.497717,-6.202337],[21.642593,-6.244555],[21.790945,-6.301893],[21.943945,-6.374830],[22.055113,-6.426333],[22.168549,-6.467025],[22.283905,-6.497746],[22.400841,-6.519343],[22.519005,-6.532657],[22.638052,-6.538534],[22.757635,-6.537815],[22.877403,-6.531342],[22.997017,-6.519962],[23.116125,-6.504517],[23.234381,-6.485851],[23.351431,-6.464808],[23.549881,-6.420545],[23.724241,-6.366574],[23.874851,-6.302068],[24.002060,-6.226199],[24.106213,-6.138142],[24.187658,-6.037066],[24.246742,-5.922148],[24.283810,-5.792560],[24.299206,-5.647476],[24.293278,-5.486064],[24.266373,-5.307503],[24.218842,-5.110964],[24.186241,-4.985839],[24.158455,-4.860985],[24.135098,-4.736348],[24.115780,-4.611872],[24.100113,-4.487504],[24.087711,-4.363192],[24.078186,-4.238878],[24.071148,-4.114511],[24.066212,-3.990035],[24.062984,-3.865396],[24.061085,-3.740542],[24.060120,-3.615418],[24.060001,-3.087127],[24.063391,-2.368223],[24.069504,-1.495949],[24.077566,-0.507557],[24.086796,0.559711],[24.096411,1.668606],[24.105629,2.781882],[24.113670,3.862290],[24.119755,4.872586],[24.123108,5.775522],[24.122938,6.533851],[24.118475,7.110328],[24.108124,7.341120],[24.083380,7.543360],[24.042908,7.718707],[23.985382,7.868814],[23.909466,7.995339],[23.813820,8.099937],[23.697124,8.184266],[23.558029,8.249981],[23.395216,8.298738],[23.207344,8.332192],[22.993080,8.352003],[22.751093,8.359823],[22.663256,8.359358],[22.576220,8.356274],[22.489904,8.350614],[22.404234,8.342423],[22.319120,8.331746],[22.234488,8.318626],[22.150253,8.303108],[22.066338,8.285237],[21.982660,8.265057],[21.899141,8.242611],[21.815704,8.217944],[21.732260,8.191100],[21.557981,8.129140]];
function Logo_D_In_paths() = [[
0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95]];
function Logo_D_In_points() = [
[17.707863,0.407343],[17.754715,0.533683],[17.806540,0.658849],[17.862656,0.783037],[17.922384,0.906446],[17.985052,1.029271],[18.049978,1.151709],[18.116482,1.273959],[18.216436,1.439295],[18.323936,1.585181],[18.439081,1.712233],[18.561972,1.821068],[18.692707,1.912302],[18.831390,1.986551],[18.978113,2.044432],[19.132984,2.086560],[19.296101,2.113553],[19.467558,2.126026],[19.647463,2.124595],[19.835913,2.109879],[20.017241,2.080601],[20.182306,2.035051],[20.332277,1.974296],[20.468309,1.899397],[20.591570,1.811417],[20.703222,1.711422],[20.804426,1.600474],[20.896345,1.479635],[20.980146,1.349971],[21.056986,1.212544],[21.128035,1.068419],[21.194452,0.918658],[21.259737,0.747340],[21.311953,0.574752],[21.352549,0.401032],[21.382980,0.226321],[21.404699,0.050759],[21.419157,-0.125511],[21.427803,-0.302351],[21.432093,-0.479620],[21.433477,-0.657176],[21.433411,-0.834881],[21.433340,-1.012593],[21.434721,-1.190167],[21.440168,-1.389965],[21.442564,-1.589440],[21.441420,-1.788551],[21.436251,-1.987262],[21.426573,-2.185529],[21.411898,-2.383314],[21.391739,-2.580579],[21.365610,-2.777283],[21.333023,-2.973386],[21.293495,-3.168848],[21.246538,-3.363630],[21.191668,-3.557692],[21.114225,-3.780109],[21.022551,-3.985974],[20.917320,-4.174688],[20.799215,-4.345647],[20.668913,-4.498252],[20.527088,-4.631901],[20.374422,-4.745990],[20.211596,-4.839920],[20.039286,-4.913089],[19.858171,-4.964894],[19.668930,-4.994735],[19.472237,-5.002010],[19.278294,-4.986447],[19.092531,-4.948424],[18.915464,-4.888682],[18.747616,-4.807971],[18.589497,-4.707035],[18.441626,-4.586616],[18.304514,-4.447464],[18.178682,-4.290318],[18.064648,-4.115928],[17.962925,-3.925035],[17.874027,-3.718388],[17.798473,-3.496729],[17.725330,-3.228735],[17.665901,-2.960043],[17.619036,-2.690717],[17.583572,-2.420820],[17.558357,-2.150417],[17.542240,-1.879575],[17.534061,-1.608356],[17.532669,-1.336825],[17.536903,-1.065048],[17.545612,-0.793088],[17.557644,-0.521010],[17.571842,-0.248880],[17.583687,-0.113710],[17.603891,0.019301],[17.631771,0.150349],[17.666655,0.279630]];