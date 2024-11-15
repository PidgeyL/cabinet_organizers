// Size settings in mm
plate_width  =  60;  // The width of the base-plate
plate_border =  2;   // The border around the pot
                     // Ideally a couple of mm to avoid friction
                     // Pot size will be plate_width - plate_border*2
pot_height    = 60;  // The height of the pot
pot_rim       =  5;  // The rim width of the pot
corner_radius =  3;  // How round we want the corners to be

// Choose modifications
DIVIDER  = true;   // Add a divider in the pot
NO_FEET  = false;  // Remove the connector feet

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module box_baseplate(){
    pot_width = plate_width - plate_border*2;
    pot_depth = BASE_DEFAULT_DEPTH  - plate_border*2;

    baseplate(plate_width, no_feet=NO_FEET);
    translate([plate_border, plate_border, 0]){
        difference(){
            roundedcube([pot_width, pot_depth, pot_height], false, corner_radius);
            translate([pot_rim, pot_rim, pot_rim]){
                roundedcube([pot_width - pot_rim*2,
                             pot_depth - pot_rim*2, pot_height],
                            false, corner_radius);
            }
        }
        if (DIVIDER){
            translate([pot_rim-2, pot_depth/2, pot_rim]){
                roundedcube([plate_width - plate_border*2 - pot_rim,
                             3, pot_height-pot_rim-10],
                             false, 1);
            }
        }
    }
}
box_baseplate();
