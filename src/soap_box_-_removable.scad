// Size settings in mm
plate_width  =  80;  // The width of the base-plate
plate_border =  10;  // The border around the pot.
                     // Pot size will be plate_width - plate_border
holder_base_depth =  20;  // Width of the holder base
holder_depth      =  10;  // Width of the holder
holder_width      =  50;  // Width of the holder
holder_height     = 160;  // Height of the holder
tray_height       =  15;  // The height of the tray
tray_rim          =   3;  // The width of the soap tray
corner_radius     =   3;  // How round we want the corners to be

// Modify the base plate:
NO_FEET  = false;  // Remove the connector feet

// Choose here which item you want to generate:
GENERATE = "base";  // "base" or "tray", "grill"

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module tray_baseplate(){
    baseplate_indent(plate_width, no_feet=NO_FEET,
                     plate_border=plate_border,
                     corner_radius=corner_radius);
}

module tray(){
    tray_width = plate_width - plate_border*2;
    tray_depth = BASE_DEFAULT_DEPTH - plate_border*2;
    height_offset = BASE_DEFAULT_HEIGHT / 2;

    translate([plate_border, plate_border, height_offset]){
        difference(){
            roundedcube([tray_width, tray_depth, tray_height],
                        false, corner_radius);
            translate([tray_rim, tray_rim, tray_rim]){
                cube([tray_width - tray_rim*2,
                      tray_depth - tray_rim*2 - holder_base_depth,
                      tray_height]);
            }
        }
    }
}

module holder(){
    holder_depth_pos = BASE_DEFAULT_DEPTH - holder_depth -
                       plate_border -
                (holder_base_depth-holder_depth)/2;


    translate([(plate_width - holder_width)/2,
                holder_depth_pos, 0]){
        cube([holder_width, holder_depth, holder_height]);
    }
}


if (GENERATE == "base")  tray_baseplate();
if (GENERATE == "tray")  tray();