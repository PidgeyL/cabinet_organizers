// Size settings in mm.
plate_width  =  60;  // The width of the base-plate
plate_border = 10;   // The border around the pot.
                     // Pot size will be plate_width - plate_border*2
                     
tray_height    = 10;  // The height of the pot
tray_rim       =  5;  // The rim width of the pot

holder_width     = 50;  // The width of the brush holder
holder_thickness =  5;  // The thickness of the brush holder
holder_height    = 80;  // The height of the brush holder

corner_radius =  3;  // How round we want the corners to be

// Chose here which plate you want to generate:
GENERATE = "holder";  // "base" or "pot",
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

module holder(){
    cube([holder_width, holder_thickness, holder_height]);
}
if (GENERATE == "pot")  pot();
if (GENERATE == "base") box_baseplate();

holder();
