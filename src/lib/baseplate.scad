// Include settings
include <../_settings.scad>;
include <roundedcube.scad>;

module baseplate_indent(width,
                        depth   = BASE_DEFAULT_DEPTH,
                        height  = BASE_DEFAULT_HEIGHT,
                        rotate  = false,
                        no_feet = false,
                        plate_border  = BASE_DEFAULT_BORDER,
                        corner_radius = DEFAULT_RADIUS){
    indent = height / 2 + corner_radius / 2;
    difference(){
        baseplate(width, depth, height, rotate, no_feet);
        // Indent with 1 mm wiggle-room
        translate([plate_border-1, plate_border-1, indent]){
            roundedcube([width - plate_border*2 + 2,
                         depth - plate_border*2 + 2, height],
                        false, corner_radius);
        }
    }
}

module baseplate(width, depth = BASE_DEFAULT_DEPTH,
                 height = BASE_DEFAULT_HEIGHT,
                 rotate=false, no_feet=false){
    if (rotate == true){
        rotate([0,0,180]){
            translate([-width, -depth, 0]){
                _baseplate(width, depth, height, no_feet);
            }
        }
    } else {
        _baseplate(width, depth, height, no_feet);
    }
}

module _baseplate(x, y, z, no_feet=false){
    if (no_feet == false) {
        foot(x, feet_border, 0, 0);
        foot(x, y - feet_border - feet_width, 0, 0);
    }
    difference() {
        cube([x,y,z]);
        foot(0, feet_border, 0, 1);
        foot(0, y - feet_border - feet_width, 0, 1);
    }
}