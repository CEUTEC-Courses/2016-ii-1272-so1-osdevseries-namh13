; ****************************************************
; Boot1.asm
; - Un cargador de arranque simple
;
; Sistemas Tutorial de Desarrollo de Operacion
; ****************************************************

org 0x7C00; Estamos cargados por la BIOS en 0x7C00

los bits 16; Todavia estamos en 16 bits en modo real

Comienzo:

	cli; Despejar todas las interrupciones
	Equipo de Alto Nivel; detener el sistema

510 veces - ($ - $$) db 0; Tenemos que ser de 512 bytes. Desactive el resto de los bytes con 0

dw 0xAA55; Signiture arranque