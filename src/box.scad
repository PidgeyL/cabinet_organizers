// Size settings
plate_width  =  60;  // The width of the base-plate
plate_border = 10;   // The border around the pot.
                     // Pot size will be plate_width - plate_border
pot_height    = 60;  // The height of the pot
pot_rim       =  5;  // The rim width of the pot
corner_radius =  3;  // How round we want the corners to be

// Chose here which plate you want to generate:
GENERATE = "base";  // "base" or "pot",
DEVIDER  = true;

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module box_baseplate(){
    depth = BASE_DEFAULT_HEIGHT / 2;
    difference() {
        baseplate(plate_width);
        // Indent with 1 mm wiggle-room
        translate([plate_border-1, plate_border-1, BASE_DEFAULT_HEIGHT]){
            roundedcube([plate_width - plate_border*2 + 2,
                         BASE_DEFAULT_DEPTH - plate_border*2 + 2, depth],
                        false, corner_radius);
        }
    }
}

module pot(){
    pot_width = plate_width - plate_border*2;
    pot_depth = BASE_DEFAULT_DEPTH - plate_border*2;
    translate([plate_border, plate_border, 2]){
        difference(){
            roundedcube([pot_width, pot_depth, pot_height],
                        false, corner_radius);
            translate([pot_rim, pot_rim, pot_rim]){
                roundedcube([pot_width - pot_rim*2,
                             pot_depth - pot_rim*2, pot_height],
                            false, corner_radius);
            }
        }
        if (DEVIDER){
            translate([pot_rim-2, pot_depth/2, pot_rim]){
                roundedcube([plate_width - plate_border*2 - pot_rim,
                             3, pot_height-pot_rim-10],
                            false, 1);
            }
        }
    }
}
if (GENERATE == "pot")  pot();
if (GENERATE == "base") box_baseplate();