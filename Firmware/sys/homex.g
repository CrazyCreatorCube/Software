; homex.g
; called to home the X axis
;
; generated by RepRapFirmware Configuration Tool v2.1.6 on Tue Jan 14 2020 09:54:37 GMT+0100 (Mitteleuropäische Normalzeit)
G91               ; relative positioning
G1 H2 Z5 F6000    ; lift Z relative to current position
G1 H1 X-235 F1800 ; move quickly to X axis endstop and stop there (first pass)
G1 X5 F6000       ; go back a few mm
G1 H1 X-235 F360  ; move slowly to X axis endstop once more (second pass)
G1 H2 Z-5 F6000   ; lower Z again
G90               ; absolute positioning

