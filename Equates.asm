; VDP stuff
VdpCtrl:    equ $C00004  ; VDP control port
VdpData:    equ $C00000  ; VDP data port
HvCounter:  equ $C00008  ; H/V counter

VDPREG_MODE1:	  equ $8000  ; Mode register #1
VDPREG_MODE2:	  equ $8100  ; Mode register #2
VDPREG_MODE3:	  equ $8B00  ; Mode register #3
VDPREG_MODE4:	  equ $8C00  ; Mode register #4

VDPREG_PLANEA:	  equ $8200  ; Plane A table address
VDPREG_PLANEB:	  equ $8400  ; Plane B table address
VDPREG_SPRITE:	  equ $8500  ; Sprite table address
VDPREG_WINDOW:	  equ $8300  ; Window table address
VDPREG_HSCROLL:   equ $8D00  ; HScroll table address

VDPREG_SIZE:	  equ $9000  ; Plane A and B size
VDPREG_WINX:	  equ $9100  ; Window X split position
VDPREG_WINY:	  equ $9200  ; Window Y split position
VDPREG_INCR:	  equ $8F00  ; Autoincrement
VDPREG_BGCOL:	  equ $8700  ; Background color
VDPREG_HRATE:	  equ $8A00  ; HBlank interrupt rate

VDPREG_DMALEN_L:  equ $9300  ; DMA length (low)
VDPREG_DMALEN_H:  equ $9400  ; DMA length (high)
VDPREG_DMASRC_L:  equ $9500  ; DMA source (low)
VDPREG_DMASRC_M:  equ $9600  ; DMA source (mid)
VDPREG_DMASRC_H:  equ $9700  ; DMA source (high)

VRAM_ADDR_CMD:	equ $40000000
CRAM_ADDR_CMD:	equ $C0000000
VSRAM_ADDR_CMD: equ $40000010

VRAM_DMA_CMD:	equ $40000080
CRAM_DMA_CMD:	equ $C0000080
VSRAM_DMA_CMD:	equ $40000090

VRAM_SIZE:    	equ 65536
CRAM_SIZE:    	equ 128
VSRAM_SIZE:   	equ 80

GFXMODE_256x224:      equ %00000000
GFXMODE_320x224:      equ %10000001
GFXMODE_256x448:      equ %00000110
GFXMODE_320x448:      equ %10000111
GFXMODE_256x224_SH:   equ %00001000
GFXMODE_320x224_SH:   equ %10001001
GFXMODE_256x448_SH:   equ %00001110
GFXMODE_320x448_SH:   equ %10001111

; Sprite equates
NOFLIP: equ $0000  ; Don't flip (default)
HFLIP:	equ $0800  ; Flip horizontally
VFLIP:	equ $1000  ; Flip vertically
HVFLIP: equ $1800  ; Flip both ways
PAL0:	equ $0000  ; Use palette 0 (default)
PAL1:	equ $2000  ; Use palette 1
PAL2:	equ $4000  ; Use palette 2
PAL3:	equ $6000  ; Use palette 3
LOPRI:	equ $0000  ; Low priority (default)
HIPRI:	equ $8000  ; High priority

; Z80 stuff
Z80Ram:    	equ $A00000  ; Where Z80 RAM starts
Z80BusReq:  	equ $A11100  ; Z80 bus request line
Z80Reset:   	equ $A11200  ; Z80 reset line
Z80Version:	equ $A10001
Z80_DAC3Pitch:	equ $A000EA
Z80_DACStatus:	equ $A01FFD
Z80_DACSample:	equ $A01FFF
YM2612_a0:	equ $A04000
YM2612_d0:	equ $A04001
YM2612_a1:	equ $A04002
YM2612_d1:	equ $A04003
PSGinput:	equ $C00011

; Controller stuff
IoCtrl1:      	equ $A10009  ; I/O control port 1P
IoCtrl2:      	equ $A1000B  ; I/O control port 2P
IoCtrlExt:    	equ $A1000D  ; I/O control port modem
IoData1:      	equ $A10003  ; I/O data port 1P
IoData2:      	equ $A10005  ; I/O data port 2P
IoDataExt:    	equ $A10007  ; I/O data port modem

; VRAM data
vram_fg:	equ $C000	; foreground namespace
vram_bg:	equ $E000	; background namespace
vram_sonic:	equ $F000	; Sonic graphics
vram_sprites:	equ $F800	; sprite table
vram_hscroll:	equ $FC00	; horizontal scroll table

Size_of_SegaPCM:		equ $6978

; ---------------------------------------------------------------------------
; Object Status Table offsets (for everything between Object_RAM and Primary_Collision)
; ---------------------------------------------------------------------------
id =			  0 ; object ID
render_flags =		  1 ; bitfield ; bit 7 = onscreen flag, bit 0 = x mirror, bit 1 = y mirror, bit 2 = coordinate system
art_tile =		  2 ; and 3 ; start of sprite's art
mappings =		  4 ; and 5 and 6 and 7
x_pos =			  8 ; and 9 ... some objects use $A and $B as well when extra precision is required (see ObjectMove) ... for screen-space objects this is called x_pixel instead
x_sub =			 x_pos+2
y_pos =			 $C ; and $D ... some objects use $E and $F as well when extra precision is required ... screen-space objects use y_pixel instead
y_sub =			 y_pos+2
priority =		$18 ; 0 = front
width_pixels =		$19
mapping_frame =		$1A
; ---------------------------------------------------------------------------
; conventions followed by most objects:
x_vel  = 		$10 ; and $11 ; horizontal velocity
y_vel  = 		$12 ; and $13 ; vertical velocity
y_radius  = 		$16 ; collision width / 2
x_radius  = 		$17 ; collision height / 2
anim_frame  = 		$1B
anim  = 		$1C
next_anim  = 		$1D
anim_frame_duration  = 	$1E
anim_delay =		$1F
status	= 		$22 ; note: exact meaning depends on the object... for sonic/tails: bit 0: leftfacing. bit 1: inair. bit 2: spinning. bit 3: onobject. bit 4: rolljumping. bit 5: pushing. bit 6: underwater.
routine  = 		$24
routine_secondary  = 	$25
angle  = 		$26 ; angle about the z = 0 axis (360 degrees  =  256)
; ---------------------------------------------------------------------------
; conventions followed by many objects but NOT sonic/tails:
collision_flags  = 	$20
collision_property  = 	$21
respawn_index  = 	$23
subtype  = 		$28
; ---------------------------------------------------------------------------
; conventions specific to sonic/tails (Obj01, Obj02, and ObjDB):
; note: $1F, $20, and $21 are unused and available
inertia  = 		$14 ; and $15 ; directionless representation of speed... not updated in the air
flip_angle  = 		$27 ; angle about the x = 0 axis (360 degrees  =  256) (twist/tumble)
air_left  = 		$28
flip_turned  = 		$29 ; 0 for normal, 1 to invert flipping (it's a 180 degree rotation about the axis of Sonic's spine, so he stays in the same position but looks turned around)
obj_control  = 		$2A ; 0 for normal, 1 for hanging or for resting on a flipper, $81 for going through CNZ/OOZ/MTZ tubes or stopped in CNZ cages or stoppers or flying if Tails
status_secondary  = 	$2B
flips_remaining  = 	$2C ; number of flip revolutions remaining
flip_speed  = 		$2D ; number of flip revolutions per frame / 256
move_lock  = 		$2E ; and $2F ; horizontal control lock, counts down to 0
invulnerable_time  = 	$30 ; and $31 ; time remaining until you stop blinking
invincibility_time  = 	$32 ; and $33 ; remaining
speedshoes_time  = 	$34 ; and $35 ; remaining
next_tilt  = 		$36 ; angle on ground in front of sprite
tilt  = 		$37 ; angle on ground
stick_to_convex  = 	$38 ; 0 for normal, 1 to make Sonic stick to convex surfaces like the rotating discs in Sonic 1 and 3 (unused in Sonic 2 but fully functional)
spindash_flag  = 	$39 ; 0 for normal, 1 for charging a spindash or forced rolling
spindash_counter  = 	$3A ; and $3B
jumping  = 		$3C
interact  = 		$3D ; RAM address of the last object Sonic stood on, minus $FFFFB000 and divided by $40
layer  = 		$3E ; collision plane, track switching...
layer_plus  = 		$3F ; always same as layer+1 ?? used for collision somehow
; ---------------------------------------------------------------------------
; conventions followed by several objects but NOT sonic/tails:
y_pixel =		2+x_pos ; and 3+x_pos ; y coordinate for objects using screen-space coordinate system
x_pixel =		x_pos ; and 1+x_pos ; x coordinate for objects using screen-space coordinate system
parent =		$3E ; and $3F ; address of object that owns or spawned this one, if applicable
; ---------------------------------------------------------------------------
; unknown or inconsistently used offsets that are not applicable to sonic/tails:
; (provided because rearrangement of the above values sometimes requires making space in here too)
objoff_A =		2+x_pos ; note: x_pos can be 4 bytes, but sometimes the last 2 bytes of x_pos are used for other unrelated things
objoff_B =		3+x_pos ; unused
objoff_E =		2+y_pos	; unused
objoff_F =		3+y_pos ; unused
objoff_10 =		$10
objoff_14 =		$14
objoff_15 =		$15
objoff_1F =		$1F
objoff_27 =		$27
objoff_28  = 		$28 ; overlaps subtype, but a few objects use it for other things anyway
objoff_29  =  $29
objoff_2A  =  $2A
objoff_2B = $2B
objoff_2C = $2C
objoff_2D = $2D
objoff_2E = $2E
objoff_2F = $2F
objoff_30 = $30
objoff_31 = $31
objoff_32 = $32
objoff_33 = $33
objoff_34 = $34
objoff_35 = $35
objoff_36 = $36
objoff_37 = $37
objoff_38 = $38
objoff_39 = $39
objoff_3A = $3A
objoff_3B = $3B
objoff_3C = $3C
objoff_3D = $3D
objoff_3E = $3E
objoff_3F = $3F
objoff_40 = $40
; ---------------------------------------------------------------------------
; property of all objects:
object_size  = 		$40 ; the size of an object
next_object =		object_size
objectslot2 =		object_size*2
objectslot3 =		object_size*3
objectslot4 =		object_size*4
objectslot5 =		object_size*5
objectslot6 =		object_size*6
objectslot7 =		object_size*7
objectslot8 =		object_size*8
objectslot9 =		object_size*9
objectslotA =		object_size*10
objectslotB =		object_size*11
objectslotC =		object_size*12
objectslotD =		object_size*13
objectslotE =		object_size*14
objectslotF =		object_size*15
; Other sizes
palette_line_size =	$10*2	; 16 word entries
; ---------------------------------------------------------------------------
; Bits 3-6 of an object's status after a SolidObject call is a
; bitfield with the following meaning:
p1_standing_bit   = 3
p2_standing_bit   = p1_standing_bit + 1
p1_standing	  = 1<<p1_standing_bit
p2_standing	  = 1<<p2_standing_bit
pushing_bit_delta = 2
p1_pushing_bit	  = p1_standing_bit + pushing_bit_delta
p2_pushing_bit	  = p1_pushing_bit + 1
p1_pushing	  = 1<<p1_pushing_bit
p2_pushing	  = 1<<p2_pushing_bit
standing_mask	  = p1_standing|p2_standing
pushing_mask	  = p1_pushing|p2_pushing
; ---------------------------------------------------------------------------
; The high word of d6 after a SolidObject call is a bitfield
; with the following meaning:
p1_touch_side_bit   = 0
p2_touch_side_bit   = p1_touch_side_bit + 1
p1_touch_side	    = 1<<p1_touch_side_bit
p2_touch_side	    = 1<<p2_touch_side_bit
touch_side_mask     = p1_touch_side|p2_touch_side
p1_touch_bottom_bit = p1_touch_side_bit + pushing_bit_delta
p2_touch_bottom_bit = p1_touch_bottom_bit + 1
p1_touch_bottom     = 1<<p1_touch_bottom_bit
p2_touch_bottom     = 1<<p2_touch_bottom_bit
touch_bottom_mask   = p1_touch_bottom|p2_touch_bottom
p1_touch_top_bit   = p1_touch_bottom_bit + pushing_bit_delta
p2_touch_top_bit   = p1_touch_top_bit + 1
p1_touch_top	   = 1<<p1_touch_top_bit
p2_touch_top	   = 1<<p2_touch_top_bit
touch_top_mask	   = p1_touch_top|p2_touch_top
; ---------------------------------------------------------------------------
; Controller Buttons;
; Buttons bit numbers
button_up:			EQU	0
button_down:			EQU	1
button_left:			EQU	2
button_right:			EQU	3
button_B:			EQU	4
button_C:			EQU	5
button_A:			EQU	6
button_start:			EQU	7
; Buttons masks (1 << x == pow(2, x))
button_up_mask:			EQU	1<<button_up	; $01
button_down_mask:		EQU	1<<button_down	; $02
button_left_mask:		EQU	1<<button_left	; $04
button_right_mask:		EQU	1<<button_right	; $08
button_B_mask:			EQU	1<<button_B	; $10
button_C_mask:			EQU	1<<button_C	; $20
button_A_mask:			EQU	1<<button_A	; $40
button_start_mask:		EQU	1<<button_start	; $80
; ---------------------------------------------------------------------------
; status_secondary bitfield variables;
; status_secondary variable bit numbers
status_sec_hasShield:		EQU	0
status_sec_isInvincible:	EQU	1
status_sec_hasSpeedShoes:	EQU	2
status_sec_isSliding:		EQU	7
; status_secondary variable masks (1 << x == pow(2, x))
status_sec_hasShield_mask:	EQU	1<<status_sec_hasShield		; $01
status_sec_isInvincible_mask:	EQU	1<<status_sec_isInvincible	; $02
status_sec_hasSpeedShoes_mask:	EQU	1<<status_sec_hasSpeedShoes	; $04
status_sec_isSliding_mask:	EQU	1<<status_sec_isSliding		; $80
; ---------------------------------------------------------------------------
; RAM Adresses
RAM_Start =			$FFFF0000	; 4 bytes ; start of RAM
Chunk_Table  = 			RAM_Start
Level_Layout =			$FFFF8000
Block_Table  = 			$FFFF9000
Sprite_Table_Input  =  		$FFFFAC00 ; in custom format before being converted and stored in Sprite_Table/Sprite_Table_2
Object_RAM  = 			$FFFFB000 ; through $FFFFD5FF
Sprite_Table_2  = 		$FFFFDD00 ; Sprite attribute table buffer for the bottom split screen in 2-player mode
Horiz_Scroll_Buf  = 		$FFFFE000
Sonic_Stat_Record_Buf  = 	$FFFFE400
Sonic_Pos_Record_Buf  = 	$FFFFE500
Tails_Pos_Record_Buf  = 	$FFFFE600
Ring_Positions  = 		$FFFFE800
Camera_RAM  = 			$FFFFEE00
Camera_X_pos  = 		$FFFFEE00
Camera_Y_pos  = 		$FFFFEE04
Camera_Max_Y_pos  = 		$FFFFEEC6
Camera_Min_X_pos  = 		$FFFFEEC8
Camera_Max_X_pos  = 		$FFFFEECA
Camera_Min_Y_pos  = 		$FFFFEECC
Camera_Max_Y_pos_now  = 	$FFFFEECE ; was "Camera_max_scroll_spd"...
Dynamic_Resize_Routine  = 	$FFFFEEDF
MainCharacter  = 		Object_RAM ; first object (usually Sonic except in a Tails Alone game)
Sidekick  = 			Object_RAM+next_object ; second object (Tails in a Sonic and Tails game)
Tails_Tails  = 			Object_RAM+objectslot7 ; address of the Tail's Tails object
Game_Mode =			$FFFFF600
Ctrl_1_Logical =		$FFFFF602		; 2 bytes
Ctrl_1_Held_Logical =		Ctrl_1_Logical		; 1 byte
Ctrl_1_Press_Logical =		Ctrl_1_Held_Logical+1	; 1 byte
Ctrl_1 =			Ctrl_1_Press_Logical+1	; 2 bytes
Ctrl_1_Held =			Ctrl_1			; 1 byte
Ctrl_1_Press =			Ctrl_1_Held+1		; 1 byte
VDP_Reg1_val =			$FFFFF60C
Demo_Time_left =		$FFFFF614
Vscroll_Factor =		$FFFFF616		; 2 bytes
Vscroll_Factor_BG =		Vscroll_Factor+2	; 2 bytes
Hscroll_Factor =		Vscroll_Factor_BG+2	; 4 bytes (written as a word once)
Hscroll_Factor_BG =		Hscroll_Factor+2	; 2 bytes
Vscroll_Factor_BG2 =		Hscroll_Factor_BG+2	; 2 bytes
Hscroll_Factor_BG2 =		Vscroll_Factor_BG2+2	; 2 bytes
Hint_counter_reserve =		$FFFFF624		; Must contain a VDP command word, preferably a write to register $0A. Executed every V-INT.
Palette_fade_start =		$FFFFF626		; Offset from the start of the palette to tell what range of the palette will be affected in the palette fading routines
Palette_fade_length =		Palette_fade_start+1	; Number of entries to change in the palette fading routines
VIntSubE_RunCount =		$FFFFF628
Vint_routine =			$FFFFF62A		; routine counter for V-int
PalCycle_Frame =		$FFFFF632		; ColorID loaded in PalCycle
PalCycle_Timer =		PalCycle_Frame+2	; number of frames until next PalCycle call
RNG_seed =			$FFFFF636		; used for random number generation
Game_paused =			$FFFFF63A
DMA_data_thunk =		$FFFFF640		; Used as a RAM holder for the final DMA command word. Data will NOT be preserved across V-INTs, so consider this space reserved.
Hint_flag =			$FFFFF644		; unless this is 1, H-int won't run
SonicTails_top_speed =		$FFFFF760
SonicTails_acceleration =	SonicTails_top_speed+2
SonicTails_deceleration =	SonicTails_acceleration+2
Sonic_LastLoadedDPLC =		$FFFFF766	; mapping frame number when Sonic last had his tiles requested to be transferred from ROM to VRAM. can be set to a dummy value like -1 to force a refresh DMA.
Obj_placement_routine  = 	$FFFFF76C
Obj_load_addr_0  = 		$FFFFF770
Obj_load_addr_1  = 		$FFFFF774
Obj_load_addr_2  = 		$FFFFF778
Obj_load_addr_3  = 		$FFFFF77C
Demo_button_index  = 		$FFFFF790 ; index into button press demo data, for player 1
Demo_press_counter  = 		Demo_button_index+2 ; frames remaining until next button press, for player 1
Collision_addr  = 		$FFFFF796
Current_Boss_ID  = 		$FFFFF7AA
Control_Locked  = 		$FFFFF7CC
Chain_Bonus_counter  = 		$FFFFF7D0 ; counts up when you destroy things that give points, resets when you touch the ground
Bonus_Countdown_1  = 		$FFFFF7D2 ; level results time bonus or special stage sonic ring bonus
Bonus_Countdown_2  = 		$FFFFF7D4 ; level results ring bonus or special stage tails ring bonus
Update_Bonus_score  = 		$FFFFF7D6
Camera_X_pos_coarse  = 		$FFFFF7DA ; (Camera_X_pos - 128) / 256
Error_message_ID =		$FFFFFC44
Debug_object =			$FFFFFE06
Debug_placement_mode =		Debug_object+2
Debug_Accel_Timer =		Debug_placement_mode+2
Debug_Speed =			Debug_Accel_Timer+1
Current_ZoneAndAct =		$FFFFFE10	; 2 bytes
Current_Zone =			Current_ZoneAndAct
Current_Act =			Current_Zone+1
Life_count =			$FFFFFE12
Air_left =			$FFFFFE14
Current_Special_Stage =		$FFFFFE16
Continue_count =		$FFFFFE18
Time_Over_flag =		$FFFFFE1A
Extra_life_flags =		$FFFFFE1B
Update_HUD_lives =		$FFFFFE1C
Update_HUD_rings =		Update_HUD_lives+1
Update_HUD_timer =		Update_HUD_rings+1
Update_HUD_score =		Update_HUD_timer+1
Ring_count =			$FFFFFE20	; 2 bytes
Timer =				$FFFFFE22	; 4 bytes
Timer_minute = 			Timer+1
Timer_second = 			Timer_minute+1
Timer_frame = 			Timer_second+1
Score =				$FFFFFE26	; 4 bytes
Oscillation_Control =		$FFFFFE5E
Oscillating_Data =		Oscillation_Control+2
Logspike_anim_counter =		$FFFFFEC0
Logspike_anim_frame =		Logspike_anim_counter+1
Rings_anim_counter =		Logspike_anim_frame+1
Rings_anim_frame =		Rings_anim_counter+1
Unknown_anim_counter =		Rings_anim_frame+1
Unknown_anim_frame =		Unknown_anim_counter+1
Ring_spill_anim_counter =	Unknown_anim_frame+1
Ring_spill_anim_frame =		Ring_spill_anim_counter+1
Ring_spill_anim_accum =		Ring_spill_anim_frame+1
LevSel_HoldTimer =		$FFFFFF80
Level_select_zone =		$FFFFFF82
Sound_test_sound =		$FFFFFF84
Demo_mode_flag =		$FFFFFFF0	; 1 if a demo is playing (2 bytes)
Demo_number =			$FFFFFFF2	; which demo will play next (2 bytes)
Ending_demo_number =		$FFFFFFF4	; zone for the ending demos (2 bytes)
Graphics_Flags =		$FFFFFFF8	; misc. bitfield
Debug_mode_flag =		$FFFFFFFA	; (2 bytes)
Checksum_fourcc =		$FFFFFFFC	; (4 bytes)
RAM_End =			$FFFFFFFF