# vcore3-duet
collecting the configuration files for my rat rig v-core 3 


I recently started building a Rat Rig V-Core 3 (300mm^3) and noticed that a lot of configuration boards are incomplete due to current offerings, or obsolete due to changes in RepRapFirmware.  So as I was building my VC3, I decided to make a concerted effort to document as much as the configuration as possible.  Doing that for my setup would allow others to get a head start when they started work on theirs.

Plan on finding:

config.g ✔️

bed.g ✔️

homex.g ✔️

homey.g ✔️

homez.g ✔️

homeall.g ✔️

pause.g ✔️

resume.g ✔️

and working filament gcode for PETG and PLA, since you'll need those as well for filament loading and unloading

The end goal is a configuration bundle for a working printer that others will be able to use.

![image](https://user-images.githubusercontent.com/30335181/154629055-50f9e716-568a-4af6-9796-2cd94b6b67b1.png)


A couple of caveats: 

This is a working configuration for me; I am quite happy with the prints I'm getting with it.  
It's also not the fastest configuration.  It won't win any Speed Benchy competitions.
There is a lot of room for improvement with this configuration.

There are two lines in the configuration that are commented out that are necessary for safe operation.  They are the result of the PID tuning you would get after running ```M303```.  I am including them so you know what they look like, but you should use the results you get from running ```M303``` yourself.

Other things that are commented out include the configuration for the Paneldue 7i, and the working configuration for a BLTouch, which has been supersceded by the SuperPINDA.  There's also a configuration block for adding MCU temperature to the graph along side the extruder and bed temp.
