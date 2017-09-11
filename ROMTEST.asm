.include "soft\header.asm"
.include "soft\snes.asm"

Main:

	xce
	
	rep #$10 ;x et y en 16 bit
	
	SNES_INIT

	SNES_INIDISP $8F

	SNES_BGMODE $00
	SNES_BG1SC $10
	SNES_BGNBA $00 $00
	
	SNES_TM $01
	
	SNES_VMAINC $80
	
	
	SNES_DMA0 $00
	SNES_DMA1 $00
	
	SNES_DMA0_BADD $22
	SNES_DMA1_BADD $22
	
	SNES_CGADD $00
	
	SNES_DMA0_ADD Palette1 $0008
	SNES_DMA1_ADD Palette2 $0008
	
	SNES_MDMAEN $03
	
	SNES_DMA0 $01
	SNES_DMA0_BADD $18
	
	SNES_VMADD $0000
	
	SNES_DMA0_ADD Data $0020
	
	SNES_MDMAEN $01
	
	SNES_VMADD $1000
	
	SNES_DMA0_ADD Tileset $0020
	
	SNES_MDMAEN $01
	

	SNES_INIDISP $0F
	
	SNES_NMITIMEN $81
	
	
	Game:
		wai
		
	jmp Game
	
VBlank:
	
	rti
		
		
		
		
		
.bank 1 slot 0
.org 0

Palette1:
	.dw %0000000000000000, %0001111100000000, %1110000000000011, %0000000011111000
	
Palette2:
	.dw %1111111110000000, %0101010101010001, %1101011010111000, %0000111101011011
	
Data: 
    .dw $00FF , $00FF , $FF00 , $FF00 , $FFFF , $FFFF  , $0000 , $0000
    .dw $00FF , $00FF , $00FF , $00FF , $00FF , $00FF  , $00FF , $00FF
	
Tileset: 
    .dw $0000 , $0001 , $0001 , $0001 , $0001 , $0001  , $0001 , $0001  
    .dw $0401 , $0401 , $0401 , $0401 , $0401 , $0401  , $0401 , $0401		