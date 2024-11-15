// Size settings in mm
plate_width  =  60;  // The width of the base-plate
plate_border =  10;  // The border around the pot.
                     // Pot size will be plate_width - plate_border
pot_back_height  = 80;  // The height of the back of the pot
pot_front_height = 40;  // The height of the front of the pot
pot_rim          =  5;  // The rim width of the pot
corner_radius    =  3;  // How round we want the corners to be

// Chose modifications
NO_FEET  = false;   // Remove the connector feet

// Choose here which item you want to generate:
GENERATE = "base";  // "base" or "pot",

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module box_baseplate(){
    depth = BASE_DEFAULT_HEIGHT / 2;
    difference() {
        baseplate(plate_width, no_feet=NO_FEET);
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
            roundedcube([pot_width, pot_depth/2, pot_front_height],
                        false, corner_radius);
            translate([pot_rim, pot_rim, pot_rim]){
                roundedcube([pot_width - pot_rim*2,
                             pot_depth/2 - pot_rim*2, pot_front_height],
                            false, corner_radius);
            }
        }
    }
    translate([plate_border, pot_depth / 2 + pot_rim, 2]){
        difference(){
            roundedcube([pot_width, pot_depth/2 + pot_rim, pot_back_height],
                        false, corner_radius);
            translate([pot_rim, pot_rim, pot_rim]){
                roundedcube([pot_width - pot_rim*2,
                             pot_depth/2 - pot_rim, pot_back_height],
                            false, corner_radius);
            }
        }
    }
}
if (GENERATE == "pot")  pot();
if (GENERATE == "base") box_baseplate();
pot();