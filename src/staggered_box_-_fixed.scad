// Size settings in mm
plate_width  =  60;  // The width of the base-plate
plate_border =  2;   // The border around the pot
                     // Ideally a couple of mm to avoid friction
                     // Pot size will be plate_width - plate_border*2
pot_back_height  = 60;  // The height of the back of the staggered pot
pot_front_height = 30;  // The height of the front of the staggered pot
pot_rim          =  4;  // The rim width of the pot
corner_radius    =  3;  // How round we want the corners to be

// Modify the base plate:
ROTATE   = false;  // Rotate the baseplate to move the feet on the other side
NO_FEET  = false;  // Remove the connector feet

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module box_baseplate(){
    pot_width = plate_width - plate_border*2;
    pot_depth = BASE_DEFAULT_DEPTH  - plate_border*2;

    baseplate(plate_width, rotate=ROTATE, no_feet=NO_FEET);
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
    translate([plate_border, pot_depth/2 - pot_rim/2, 2]){
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
box_baseplate();
