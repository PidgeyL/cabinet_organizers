// Include settings
include <../_settings.scad>;

module baseplate(width, depth = BASE_DEFAULT_DEPTH, height = BASE_DEFAULT_HEIGHT,
                 rotate=false){
    echo("=================");
    echo(width, depth, height);
    if (rotate == true){
        rotate([0,0,180]){
            translate([-width, -depth, 0]){
                _baseplate(width, depth, height);
            }
        }
    } else {
        _baseplate(width, depth, height);
    }
}

module _baseplate(x, y, z){
    foot(x, feet_border, 0, 0);
    foot(x, y - feet_border, 0, 0);

    difference() {
        cube([x,y,z]);
        foot(0, feet_border, 0, 1);
        foot(0, y - feet_border, 0, 1);
    }
}
