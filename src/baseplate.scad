// To modify the depth and height of a base-plate, please edit _settings.scad
// By default, the depth is 12 cm, and the height is 4 mm.

// Size settings
baseplate_width  = 140;

// Chose here which plate you want to generate:
GENERATE = "base";  // "left", "base" or "right",

// CODE. DO NOT EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING

// Include settings
include <lib/baseplate.scad>;

module right_end(){
    difference() {
        cube([feet_depth+feet_lock_depth+2,baseplate_depth,baseplate_height]);
        foot(0, feet_border, 0, 1);
        foot(0, baseplate_depth - feet_border, 0, 1);
    }
}

module left_end(){
        translate([-2,0,0]){
            cube([2,baseplate_depth,baseplate_height]);
        }
        foot(0, feet_border, 0, 0);
        foot(0, baseplate_depth - feet_border, 0, 0);
}

if (GENERATE == "base")  baseplate(baseplate_width, rotate=false);
if (GENERATE == "left")  left_end();
if (GENERATE == "right") right_end();
