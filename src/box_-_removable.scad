// Size settings in mm
plate_width  =  60;  // The width of the base-plate
plate_border =  10;  // The border around the box.
                     // Pot size will be plate_width - plate_border*2
box_height    = 60;  // The height of the box
box_rim       =  5;  // The rim width of the box
corner_radius =  3;  // How round we want the corners to be

// Choose other modifications
DIVIDER  = true;   // Add a divider in the box
NO_FEET  = false;  // Remove the connector feet

// Choose here which item you want to generate:
GENERATE = "base";  // "base" or "box",

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module box_baseplate(){
    baseplate_indent(plate_width, no_feet=NO_FEET,
                     plate_border=plate_border,
                     corner_radius=corner_radius);
}

module box(){
    box_width = plate_width - plate_border*2;
    box_depth = BASE_DEFAULT_DEPTH - plate_border*2;
    translate([plate_border, plate_border, 2]){
        difference(){
            roundedcube([box_width, box_depth, box_height],
                        false, corner_radius);
            translate([box_rim, box_rim, box_rim]){
                roundedcube([box_width - box_rim*2,
                             box_depth - box_rim*2, box_height],
                            false, corner_radius);
            }
        }
        if (DIVIDER){
            translate([box_rim-2, box_depth/2, box_rim]){
                roundedcube([plate_width - plate_border*2 - box_rim,
                             3, box_height-box_rim-10],
                            false, 1);
            }
        }
    }
}
if (GENERATE == "box")  box();
if (GENERATE == "base") box_baseplate();