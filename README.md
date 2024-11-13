# OpenSCAD cabinet organizers

This repository contains a series of modular cabinet organizer models.
You can modify the parameters at the beginning of each file to customize these organizers to your requirements.

## Usage

All models are stored in the `src` directory. 

### Setting default sizes

Most cabinets have a uniorm depth, and I'm assuming most people want a uniform height of baseplate.
Therefor, you can set these variables once, in the `src/_settings.scad` file.

**BASE_DEFAULT_HEIGHT** sets the height of your baseplates. <br>
**BASE_DEFAULT_DEPTH** sets the depth of your baseplates.
I suggest setting this to the depth of your cabinet, minus at least 1 cm (10 mm).

These settings are set in milimeters (mm).

If you wish to modify the connector pieces, you can do so in the `_settings.scad` file as well.

### Modifying a model

Using `src/baseplate.scad` as an example, most model files contain multiple pieces.
The baseplate model contains 3 pieces: the main "baseplate", a left connector end, and a right connector end.
Note, the left end is optional, as the connector holes are not visible from the top.

Choosing what to generate can be done by modifying the `GENERATE` variable.

### Creating custom models

To create your own model, you can `include <lib/baseplate.scad>;`, to generate a starting point.
You can then use `baseplate(width, depth, height, rotate)` to generate a baseplate.
Only the width parameter is required. Depth and height are taken from `_settings.scad` if omitted.
`rotate` rotates the base-plate by 180°.
This can be useful, if you want to minimize the gap on the right side, rather than the left side.
