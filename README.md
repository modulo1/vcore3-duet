# vcore3-duet

Current configuration has stabilized into the following:

- Duet 3 Mini 5 + 
- CannedERCF-SAMMYC21 Expansion Board for 8-Channel ERCFv2
- Mellow Fly SHT36Max V3 Expansion Board
- Orbiter v2.5
- Rapido 2HF

- SuperLight Fast-Swap carriage by MFBS
- servo-controlled nozzle-wiper

- enclosure 2.0 



Moved back to a more monolithic-style config.g now that the printer is less in a state of flux.

Several config include-stubs were moved out of /sys and into /macros/config.  These are options I've found
that I was frequently updating (SZP touch options especially).  Moving them to the macros folder allows me to run them in DWC with a click
rather than restarting or using M98.

I've also made significant progress on my ERCFv2 macros, though they're on pause for now.  Rather than going with twenty-four numbered toolchange 
macros (8 channels, three macros for toolchange; tfree1.g, tpost5.g, etc.) I went with generic, un-numbered macros.  
I was up 4 successful filament changes before I put the project on pause.

I also had an idea on how they could be modified to support the servo-less ERCFv3, but I haven't had a change to upgrade to v3.
