.include "SNES-ROMTEST\header.asm"
.include "SNES-ROMTEST\snes.asm"

Main:

	xce
	
	rep #$10 ;x et y en 16 bit
	
	SNES_INIT

	SNES_INIDISP $8F

	SNES_BGMODE $00
	SNES_BG1SC $10
	SNES_BGNBA $00 $00
	
	SNES_OBJSEL $A3
	
	SNES_TM $11
	
	SNES_VMAINC $80
	
	
	SNES_DMA0 $00
	SNES_DMA1 $00
	
	SNES_DMA0_BADD $22
	SNES_DMA1_BADD $22
	
	SNES_CGADD $00
	
	SNES_DMA0_ADD Palette1 $0008
	SNES_DMA1_ADD Palette2 $0008
	
	SNES_MDMAEN $03
	
	SNES_CGADD $80
	SNES_DMA0_ADD pallette_perso $0020
	SNES_MDMAEN $01
	
	
	SNES_DMA0 $01
	SNES_DMA0_BADD $18
	
	SNES_VMADD $0000
	
	SNES_DMA0_ADD Data $0020
	
	SNES_MDMAEN $01
	
	SNES_VMADD $6000
	
	SNES_DMA0_ADD Sprite $0800
	
	SNES_MDMAEN $01
	
	SNES_VMADD $1000
	
	SNES_DMA0_ADD Tileset $0020
	
	SNES_MDMAEN $01
	

	SNES_INIDISP $0F
	
	SNES_NMITIMEN $81
	
	;x sprite 1
    lda #0 
    sta 0 
    
    ;y sprite 1
    lda #100 
    sta 1
	
	
	Game:
		wai
		
		lda STDCONTROL1H
		and #$01
		cmp #$01
		bne +
		
			inc 0
			
		+:
		lda STDCONTROL1H
		and #$02
		cmp #$02
		bne +
		
			dec 0
			
		+:
		lda STDCONTROL1H
		and #$04
		cmp #$04
		bne +
		
			inc 1
		
		+:
		lda STDCONTROL1H
		and #$08
		cmp #$08
		bne +
		
			dec 1
			
		+:
		
	jmp Game
	
VBlank:
	;on balance l'oam ici, tous ce qui doit etre mis à jour en temps réel à l'écran en fait
	lda #00
	sta OAMADDL
	
	lda 0
	sta OAMDATA
	
	lda 1
	sta OAMDATA
	
	lda #0
	sta OAMDATA
	
	lda #$20
	sta OAMDATA
	
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
	
Sprite:
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0c, $00, $1e, $00, $1a, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0c, $00, $1e, $00, $1a, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $1a, $00, $0c, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $ff, $ff
    .db $1a, $00, $0c, $00, $00, $00, $00, $01, $00, $01, $00, $01, $00, $00, $ff, $ff
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $80, $80
    .db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $80, $80, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $00, $00, $ff, $ff, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .db $80, $80, $80, $80, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


pallette_perso:
    .dw $3c05, $ff7f, $5d05, $1d04