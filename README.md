# vcore3-duet

spent a lot of time updating this after upgrading my V-Core 3.1 to enclosure 2.0 in preparation of adding 
an 8-channel ERCFv2.

I'm still working on the appropriate configuration, macros, and toolchange files for that, but this is my 
current config, and it works pretty well.

* config.g is a little less novice-friendly, but more concise.  Important commands are still documented, 
  where necessary, but there's less focus on explicitly defining every single little command and 
  argument definition the last config.g had.

  Things, like input shaping (see setInputShaping.g), are explicitly defined (with examples)
  to ease configuration.

* the beginning of config.g has a reference section that reflects my current setup, the idea being
  to minimize back-and-forths trying to keep different pin and servo definitions separate in my 
  brain when writing macros.

* there are 8 separate configuration files (ten with the ERCFv2) referenced in config.g,
  holding the configuration for things that may need frequent changing.  The files are generally
  short, and don't need as much scrolling to navigate.  Things like jerk/accel/speed, toolhead
  definition (see gizmo0.g), input shaping, and mesh probe points are configured outside config.g
  so they can be changed and loaded without necessarily having to parse config.g again

* everything toolhead related (extruder, hotend, fans, LEDs, accelerometer) gets moved into a file
  called gizmoN.g and loaded in config.g near the end with M98.  For example, if you want to try
  out new hotend/extruder combo, copy gizmo0.g to gizmo1.g, make the necessary changes, and 
  change the appropriate M98 command in config.g.

  Extruder port assignments are handled in config.g, but the appropriate M201/M203/M205 commands
  are loaded with gizmoN.g.  Likewise, X/Y motor assignments are in config.g and X/Y M201/M203/M205
  commands are handled by setMaxSpeed.g.

The result is a config.g that comes in under 170 lines and despite the numerous includes, 
appears to load faster than my old monolithic config.g.
