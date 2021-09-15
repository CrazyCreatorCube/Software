; CrazyCreatorCube CoreXY ToolChanging Printer - Config File
; This file intended for Duet 3 hardware, main board plus one expansion boards and a Raspi 

; Name and network
; This is configured from the connected Raspberry Pi or here if in stand alone mode
;-------------------------------------------------------------------------------
; Networking
;M550 P"CCC"				; Name used in ui and for mDNS  http://ccc.local
;M552 P192.168.1.32 S1		; Use Ethernet with a static IP, 0.0.0.0 for dhcp
;M553 P255.255.255.0		; Netmask
;M554 192.168.1.1			; Gateway

; General setup
;-------------------------------------------------------------------------------
M111 S0                    	; Debug off 
M929 P"eventlog.txt" S1    	; Start logging to file eventlog.txt

; General Preferences
M555 P2                    	; Set Marlin-style output
G21                        	; Set dimensions to millimetres
G90                        	; Send absolute coordinates...
M83                        	; ...but relative extruder moves

; Stepper mapping
;-------------------------------------------------------------------------------
; Connected to the MB6HC as the table below.
; Note: first row is numbered left to right and second row right to left
; _______________________________________
; | Y(Left) 0 | X(Right)  1 | E(T0) 2 |
; | E(T3)  	 5 | EZ(T2)	  4 | E(T1) 3 |
M584 X0 Y1                	; X and Y for CoreXY
M584 E2:3:4:5             	; E has 4 drivers for 4 Tools

; Connected to the EXP_MB3HC as the table below.
; | Z(Right) 0 | Z(Back) 1 | Z(Left) 2 |
; |-––-––-––-––-––-––-––-––-––-––-––--–|
M584 Z1.0:1.1:1.2			; Z has 3 Drivers for Kinematic bed	

; M569: Set motor driver direction, enable polarity and step pulse timing
M569 P0 S0                ; Drive 0 | X stepper
M569 P1 S0                ; Drive 1 | Y Stepper
M569 P2 S0 D2             ; Drive 2 | Extruder T0 1400mA Spreadcycle Mode
M569 P3 S0 D2             ; Drive 3 | Extruder T1 1400mA Spreadcycle Mode
M569 P4 S0 D2             ; Drive 4 | Extruder T2 1400mA Spreadcycle Mode
M569 P5 S0 D2             ; Drive 5 | Extruder T3 1400mA Spreadcycle Mode

M569 P1.0 S0                	; Drive 1.0 | Front Right Z
M569 P1.1 S0                	; Drive 1.1 | Back Z
M569 P1.2 S0                	; Drive 1.2 | Front Left Z

; M906: Set motor currents
M906 X{0.9*sqrt(2)*2000}  		; LDO XY 2000mA RMS LDO 0.9° Stepper Motor| LDO-42STH60-MAC the TMC5160 driver on duet3 generates a sinusoidal
M906 Y{0.9*sqrt(2)*2000}  		; coil current so we can multiply by sqrt(2) to get peak used for M906. Do not exceed 90% without heatsinking the XY steppers.
M906 E1400                		; {0.7*sqrt(2)*1400} 70% of 1400mA E don't support expressions in 3.2.0-beta4
M906 Z{0.7*sqrt(2)*1680} I30    ; 70% of 1680mA RMS. Note that the idle will be shared for all drivers - LDO 0.9° Stepper Motor | LDO-42STH48-MAC 

; Kinematics
;-------------------------------------------------------------------------------
M669 K1                   ; CoreXY mode

; Kinematic bed ball locations.
; Locations are extracted from CrazyCreatorCube-CAD model assuming lower left build plate corner
; is (0, 0) on a 350x350mm plate. This mean the Kinematic Bed Ball Connectors.
M671 X361:171:-19 Y5.5:358.5:-5.5 S100     		; Front Right: (X361, Y5.5)		0
                                           		; Back Middle: (X171, Y358.5)	1
												; Front Left: (X-19, Y-5.5)		2
                                           		; Up to 100mm correction												
; __________________________________________
; |Y|									 |X|									
; ------------------------------------------
; |||   |E0|  |E1|   |Z1|   |E2|  |E3|   |||  
; |||									 |||
; |||									 |||
; |||									 |||
; |||									 |||
; |||									 |||
; |||									 |||
; |||									 |||
; |||									 |||
; |||Z2|							  |Z0|||
												

; Axis and motor configuration 
;-------------------------------------------------------------------------------

M350 X1 Y1 Z1 E1:1:1:1  ; Disable microstepping to simplify calculations
M92 X{1/(0.9*20/180)}  	; step angle * tooth count / 180
M92 Y{1/(0.9*20/180)}  	; The 2mm tooth spacing cancel out with diam to radius
M92 Z{360/0.9/4}       	; 0.9 deg stepper / lead (4mm) of screw 
M92 E51.875            	; Extruder - BMG 0.9 deg/step

; Enable microstepping all step per unit will be multiplied by the new step def
M350 X16 Y16 I1        	; 16x microstepping for CoreXY axes. Use interpolation.
M350 Z16 I1            	; 16x microstepping for Z axes. Use interpolation.
M350 E16:16:16:16 I1   	; 16x microstepping for Extruder axes. Use interpolation.

; Acceleration, Speed and Jerk
;-------------------------------------------------------------------------------
; Acceleration - (mm/s^2) / TitanAero: E5000.00 / Orbiter:E600
M201 X1100 Y1100                        	; Accelerations (mm/s^2)
M201 Z100                               	; LDO ZZZ Acceleration
M201 E1300                              	; Extruder
; Speed
M203 X18000 Y18000 Z800 E8000            	; Maximum axis speeds (mm/min)
; Jerk - Set maximum instantaneous speed changes (mm/min)
M566 X500 Y500 Z500 E3000                	; Maximum jerk speeds (mm/min)

; Endstops and probes 
;-------------------------------------------------------------------------------
; Connected to the MB6HC as the table below.
; |   |  |
; | X |  |
; | Y |  |

; Endstops
M574 X1 S1 P"io1.in"                ; Configure active-high endstop for low end on X via pin io1.in+GND
M574 Y1 S1 P"io2.in"                ; configure active-high endstop for low end on Y via pin io2.in
M574 Z1 S2                          ; configure Z-probe endstop for low end on Z

; Z-Probe
M558 P8 C"^1.io1.in" H5 F800 T10000		; set Z probe type to switch and the dive height + speeds
G31 P500 X0 Y0 Z2.5                 	; set Z probe trigger value, offset and trigger height

; Set axis software limits and min/max switch-triggering positions.
; Must be adjusted so that X=0 and Y=0 coordinates are at the left front corner of the print bed

; Axis Minima:Maxima
M208 X-23:374 Y-13:371 Z0:310
; Define Mesh Grid and Probing Points distance
M557 X35:360 Y15:330 S65:63			; define mesh grid

; Heaters and temperature sensors
;-------------------------------------------------------------------------------

; Bed
M308 S0 P"1.temp0" Y"thermistor" T100000 B4138 A"Heizbett"                      ; configure sensor 0 as thermistor on pin 1.temp0
M950 H0 C"1.out0" T0                                                            ; create bed heater output on 1.out0 and map it to sensor 0
M307 H0 B0 S1.00                                                                ; disable bang-bang mode for the bed heater and set PWM limit
M140 H0                                                                         ; map heated bed to heater 0
M143 H0 S140 																	; set temperature limit for heater 0 to 140C


; Tools
; Heaters and sensors must be wired to main board for PID tuning (3.2.0-beta4)
; Nozzle Heater Config
M308 S1 P"temp0" Y"thermistor" T100000 B4725 C7.06e-8                           ; configure sensor 1 as thermistor on pin temp0
M950 H1 C"out0" T1                                                              ; create nozzle heater output on out0 and map it to sensor 1
M307 H1 B0 S1.00                                                                ; disable bang-bang mode for heater  and set PWM limit
M143 H1 S280                                                                    ; set temperature limit for heater 1 to 280C
M308 S2 P"temp1" Y"thermistor" T100000 B4725 C7.06e-8                           ; configure sensor 2 as thermistor on pin temp1
M950 H2 C"out1" T2                                                              ; create nozzle heater output on out1 and map it to sensor 2
M307 H2 B0 S1.00                                                                ; disable bang-bang mode for heater  and set PWM limit
M143 H2 S280                                                                    ; set temperature limit for heater 2 to 280C
M308 S3 P"temp2" Y"thermistor" T100000 B4725 C7.06e-8                           ; configure sensor 3 as thermistor on pin temp2
M950 H3 C"out2" T3                                                              ; create nozzle heater output on out2 and map it to sensor 3
M307 H3 B0 S1.00                                                                ; disable bang-bang mode for heater  and set PWM limit
M143 H3 S280                                                                    ; set temperature limit for heater 3 to 280C
M308 S4 P"temp3" Y"thermistor" T100000 B4725 C7.06e-8                           ; configure sensor 4 as thermistor on pin temp3
M950 H4 C"out3" T4                                                              ; create nozzle heater output on out3 and map it to sensor 4
M307 H4 B0 S1.00                                                                ; disable bang-bang mode for heater  and set PWM limit
M143 H4 S280                                                                    ; set temperature limit for heater 4 to 280C

; System Temperature Sensors
M308 S10 Y"mcu-temp" A"MCU"														; MCU Temp
M308 S11 Y"drivers" A"Steppers"													; Stepper Driver Temp


; Fans
;-------------------------------------------------------------------------------
; Layer Fan - One combined Fan for all Tool's
M950 F0 C"out5" Q500                                                            ; create fan 0 on pin out5 and set its frequency
M106 P0 C"LayerFan" L0.35 S0 H-1                                                ; set fan 0 value. Thermostatic control is turned off L0.35 = MinimumSpeed 35%
; Hotend Fans
M950 F1 C"out6" Q500                                                            ; create fan 1 on pin out6 and set its frequency
M106 P1 S1 H1 T45                                                               ; set fan 1 value. Thermostatic control is turned on
M950 F2 C"out7" Q500                                                            ; create fan 2 on pin out7 and set its frequency
M106 P2 S1 H2 T45                                                               ; set fan 2 value. Thermostatic control is turned on
M950 F3 C"out8" Q500                                                            ; create fan 3 on pin out8 and set its frequency
M106 P3 S1 H3 T45                                                               ; set fan 3 value. Thermostatic control is turned on
M950 F4 C"out9" Q500                                                            ; create fan 4 on pin out9 and set its frequency
M106 P4 S1 H4 T45                                                               ; set fan 4 value. Thermostatic control is turned on
; Electronic Fan
M950 F5 C"1.out3" Q500                                                          ; create fan 5 on pin out3 on MB3HC Board and set its frequency
M106 P5 C"MCU-Fan" L0.10 S0.5 H-1												; set fan 5 value. Thermostatic control is turned on
;M106 P5 C"MCU-Fan" T35:50 H10												; set fan 5 value. Thermostatic control is turned on


; Tool definitions
;-------------------------------------------------------------------------------
;M563 P0 S"Tool 0" D0 H1 F5  	; Px = Tool number / Dx = Drive Number / H1 = Heater Number / Fx = Fan number print cooling fan
;G10  P0 R0 S0              	; Set tool 0 operating and standby temperatures / (-273 = "off")


M563 P0 S"Tool0" D0 H1 F0                                                       ; define tool 0
G10 P0 R0 S0                                                                    ; set initial tool 0 active and standby temperatures to 0C

M563 P1 S"Tool1" D1 H2 F0                                                       ; define tool 1
G10 P1 R0 S0                                                                    ; set initial tool 1 active and standby temperatures to 0C

M563 P2 S"Tool2" D2 H3 F0                                                       ; define tool 2
G10 P2 R0 S0                                                                    ; set initial tool 2 active and standby temperatures to 0C

M563 P3 S"Tool3" D3 H4 F0                                                       ; define tool 3
G10 P3 R0 S0     																; set initial tool 3 active and standby temperatures to 0C

; Set extruder pressure advance
;M572 D0 S0.085              													; Set extruder 0 Pressure Advance to 0.085 seconds
;M572 D1 S0.085              													; Set extruder 1 Pressure Advance to 0.085 seconds
;M572 D2 S0.085              													; Set extruder 2 Pressure Advance to 0.085 seconds
;M572 D3 S0.085              													; Set extruder 3 Pressure Advance to 0.085 seconds

; Tool XYZ Offsets for each Tool
M98  P"/sys/Toffsets.g"     													; Set tool offsets from the bed

; Miscellaneous
;-------------------------------------------------------------------------------
M575 P1 S1 B57600                                                               ; enable support for PanelDue
M501                                                                            ; load saved parameters from non-volatile memory
M911 S10 R11 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000"                              ; set voltage thresholds and actions to run on power loss
