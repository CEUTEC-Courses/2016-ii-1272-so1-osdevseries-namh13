; ****************************************************
; 	Boot1.asm
; 		- A Simple Bootloader
;
; 	Operating Systems Develpment Tutorial
; ****************************************************

bits 	16		; Todavia estamos en 16 bits en modo real

org 	0x7C00		; Estamos cargados por la BIOS en 0x7C00



start:	jmp loader	; jump over OEM block

;*****************************************************;
;	OEM Parameter block
;*****************************************************;

TIMES oBh-$+start DB 0

bpbBytesPerSector:	DW 512
bpbSectorsPerCluster:	DB 1
bpbReservedSectors:	Dw 1
bpbNumberOfFATs:		DB 2
bpbRootEntries:			DW 224
bpbTotalSectors:		DW 2880
bpbMedia:			DB 0xF0
bpbSectorsPerFAT:		DW 9
bpbSectorsPerTrack:	DW 18
bpbHeadsPerCylinder:	DW 2
bpbHiddenSectors:		DD 0
bpbTotalSectorsBig:	DD 0
bsDriveNumber:		DB 0
bsUnused:			DB 0
bsExtBootSignature:	DB 0x29
bsSerialNumber:		DD 0xa0a1a2a3
bsVolumeLabel:		DB "MOS FLOPPY "
bsFileSystem:		DB "FAT12  "

msg	db	"Welcome to My Operating System!", 0		; the string to print

;**************************************
;	Prints a string
;	DS=>SI: 0 terminated string
;**************************************

Print:
			lodsb					; load next byte from string from SI to AL
			or			al, al		; Does AL=0?
			jz			PrintDone	; Yep, null terminator found-bail out
			mov			ah, 	0eh	; Nope-Print the character
			int			10h
			jmp			Print		; Repeat until null terminator found
PrintDone:
			ret					; we are done, so return


;****************************************************;
;	Bootloader Entry Point
;****************************************************;

loader:

	xor	ax, ax		; Setup segements to insure they are 0. Remember that
	mov	ds, ax		; We have ORG 0x7c00. This means all add addresses are based
	mov	es, ax		; from 0x7c00:0. Because the data segment are within the same
				; code segment, null em.

	mov	si, msg						; our message to print 
	call	Print						; call our print function

	xor	ax, ax						; clear ax
	int	0x12						; get the amount of KB from the BIOS

	cli							; Clear all Interrupts
	hlt							; halt the system


times 510 - ($-$$) db 0						; We have to be 512 bytes. Clear the rest of the bytes with 0

dw 0xAA55							; Signiture arranque

