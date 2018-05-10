
width=20; min/max: [5:100]

lenght=20; min/max: [5:100]

height=30; min/max: [10:250]


module box (width,lenght,height) {
    difference () {
        cube ([width,lenght,height]);
        translate ([width/width,lenght/lenght,height/8])                       
            cube ([width-2,lenght-2,height]);
    }
}
