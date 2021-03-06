org 0x7C00
bits 16

%define ENDL,0X0a

start:
	jmp main

;print a string on screen
;params:
	;ds:si points to string

puts:
	push si
	push ax

.loop:
	lodsB				;load next character in al
	or al,al
	jz .done

	mov ah,0x0e
	int 0x10
	
	jmp .loop

.done:
	pop ax
	pop si
	ret

main:
	; setup data segment
	mov ax,0
	mov ds,ax
	mov es,ax

	;setup stack segment

	mov ss,ax
	mov sp,0x7C00
	
	mov si,msg
	call puts

	hlt
	
.halt:
	jmp .halt

msg: db 'Hello world...'ENDL,0

times 510-($-$$) db 0
dw 0AA55h
