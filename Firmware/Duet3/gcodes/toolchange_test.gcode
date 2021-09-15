G28			            	; home
G91			            	; relative positioning
G1 H0 Z10 F5000		    	; lift Z 3mm
G90			            	; absolute positioning

T-1			            	; Deselect any Tool
T0							; Select Tool 0
G4 S1						; pause 1 second
G1 X100.000 Y100.000 F50000	; Dancing the Tool 0 
G1 X200.000 Y100.000 F50000	; a little bit
G1 X200.000 Y200.000 F50000	; over the Bed
G1 X100.000 Y200.000 F50000	; But just for
G1 X100.000 Y100.000 F50000	; Fun
T1							; Select Tool 1			
G4 S1						; pause 1 second
G1 X100.000 Y100.000 F50000
G1 X200.000 Y200.000 F50000
G1 X100.000 Y200.000 F50000
G1 X200.000 Y100.000 F50000
G1 X100.000 Y100.000 F50000 
T2							; Select Tool 2
G4 S1						; pause 1 second
G1 X50.000 Y50.000 F50000
G1 X250.000 Y50.000 F50000
G1 X50.000 Y100.000 F50000
G1 X250.000 Y100.000 F50000
G1 X50.000 Y150.000 F50000
G1 X250.000 Y150.000 F50000
T3							; Select Tool 3
G4 S1						; pause 1 second
G1 X50.000 Y250.000 F50000
G1 X100.000 Y50.000 F50000
G1 X100.000 Y250.000 F50000
G1 X150.000 Y50.000 F50000
G1 X150.000 Y250.000 F50000
G1 X200.000 Y50.000 F50000
G1 X200.000 Y250.000 F50000 
T-1			            	; Deselect Tools

G1 X150 Y0 F50000			; park the head
