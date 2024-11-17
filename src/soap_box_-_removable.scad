// Size settings in mm
plate_width  = 140;  // The width of the base-plate
plate_border =  10;  // The border around the pot.
                     // Pot size will be plate_width - plate_border
tray_height     = 15;  // The height of the tray
tray_rim        =  3;  // The width of the soap tray
grill_thickness =  3;  // The thickness of the grill holding the soap
grill_rim       =  3;
corner_radius   =  3;  // How round we want the corners to be

grill_max_gap   = 5;   // Width of each slot
grill_rod_width = 3;   // Maximum gap between the slots

// Modify the base plate:
NO_FEET  = false;  // Remove the connector feet

// Choose here which item you want to generate:
GENERATE = "base";  // "base" or "tray", "grill"

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

include <lib/roundedcube.scad>;
include <lib/baseplate.scad>;

module tray_baseplate(){
    depth = BASE_DEFAULT_HEIGHT / 2;
    difference() {
        baseplate(plate_width, no_feet=NO_FEET);
        // Indent with 1 mm wiggle-room
        translate([plate_border-1, plate_border-1, depth + corner_radius]){
            roundedcube([plate_width - plate_border*2 + 2,
                         BASE_DEFAULT_DEPTH - plate_border*2 + 2, depth],
                         false, corner_radius);
        }
    }
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
                      tray_depth - tray_rim*2, tray_height]);
            }
        }
        translate([tray_rim, tray_rim, 0]){
            difference(){
                cube([tray_width - tray_rim*2, tray_depth - tray_rim*2,
                      tray_height - grill_thickness - 1]);
                // 2mm border for the grill
                translate([2, 2, 0]){
                    cube([tray_width - tray_rim*2 - 4,
                          tray_depth - tray_rim*2 - 4, tray_height]);
                }
            }
        }
    }
}

module grill(){
    tray_width  = plate_width - plate_border*2;
    tray_depth  = BASE_DEFAULT_DEPTH - plate_border*2;
    grill_width = tray_width - tray_rim*2 - 1;
    grill_depth = tray_depth - tray_rim*2 - 1;
    
    height_offset = BASE_DEFAULT_HEIGHT / 2 + tray_height - grill_thickness - 1;

    usable_width = tray_width - tray_rim*2 - 1;
    num_slots_x  = floor(usable_width / (grill_max_gap + grill_rod_width));
    total_gap_x  = usable_width - num_slots_x * grill_max_gap;
    gap_x        = total_gap_x / (num_slots_x + 1);

    translate([plate_border + tray_rim + 0.5,
               plate_border  + tray_rim  + 0.5, height_offset]){
        difference(){
            roundedcube([grill_width, grill_depth, grill_thickness], false, 1);
            for (i = [0:num_slots_x-1]) {
                x_pos = tray_rim + (i * (grill_max_gap + gap_x));
                translate([x_pos, grill_rim, -1])
                    cube([grill_max_gap, grill_depth - grill_rim*2,
                          grill_thickness + 2], false);
            }
        }
    }
}


if (GENERATE == "base")  tray_baseplate();
if (GENERATE == "tray")  tray();
if (GENERATE == "grill") grill();
