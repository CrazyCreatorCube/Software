; Home X Axis

; In case homex.g is called in isolation, ensure 
; (1) Y axis is homed (to prevent collisions with the tool posts)
; (2) Y axis is in a safe position (see 2)
; Ask for user-intervention if either case fails.

G90                     ; Set absolute mode

if !move.axes[1].homed
  M291 R"Cannot Home X" P"Y axis must be homed before x to prevent damage to tool. Press OK to home Y or Cancel to abort" S3
  M98 P"homey.g"
  
if move.axes[1].userPosition >= 305
  G0 Y305 F20000       ; Rapid to safe y position so that the toolchanger does not collide with the tooldock

G91                     ; Relative mode
G1 H2 Z5 F5000          ; Lower the bed
G1 X-400 F6000 H1      	; Big negative move to search for endstop
G1 X4 F6000             ; Back off the endstop
G1 X-10 F360 H1         ; Find endstop again slowly
G1 H2 Z-5 F5000         ; Raise the bed
G90                     ; Set absolute mode
