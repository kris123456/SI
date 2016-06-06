; ----------------------------------------------------------------------------
; helloworld.asm
;
; This is a Win32 console program that writes "Hello, World" on one line and
; then exits.  It needs to be linked with a C library.
; ----------------------------------------------------------------------------

    global  _main
	extern  _print_pascal_string
	extern  _println_pascal_string
	extern  _print_int8
	extern  _println_int8
    extern  _print_uint8
    extern  _println_uint8
	extern  _print_int16
	extern  _println_int16
	extern  _print_uint16
	extern  _println_uint16
	extern  _print_int32
	extern  _println_int32
	extern  _print_uint32
	extern  _println_uint32
	extern  _read_pascal_string
	extern  _read_int8
    extern  _read_uint8
	extern  _read_int16
	extern  _read_uint16
	extern  _read_int32
	extern  _read_uint32
	
; Section with 0-initialized variables
	section .bss
	
str_var:
	resb 256
byte_var:
	resb 1
word_var:
	resw 1
double_var:
	resd 1

i:
	resd 1
j:
	resd 1

; Section with constants and program instructions
	section .text

; Constants
helloWorldMsg:
	db  14, 'Hello, World!', 10
goodbyeWordlMsg:
	db  22, 'Goodbye, Cruel World!', 10
constByte:
	dd	14

_pWriteHelloWorld:
	push    helloWorldMsg
	call    _print_pascal_string
	add     esp, 4
	ret

_pRunLoops:
	; Do a loopty loop (x3)
	mov		ecx, 1
	.outerLoopBegin:
	mov		[i], ecx
	; Write second messsage to console
	push    goodbyeWordlMsg
	call    _print_pascal_string
	add     esp, 4
	; Do a backward loopty loop (x2)
	mov		ecx, 2
	.innerLoopBegin:
	mov		[j], ecx
	; Write loop counter to console
	push    dword [j]
	call    _println_uint32
	add     esp, 4
	; End of the inner loop
	mov		ecx, [j]
	dec		ecx
	cmp		ecx, 1
	jge		.innerLoopBegin
	; End of the outer loop
	mov		ecx, [i]
	inc		ecx
	cmp		ecx, 3
	jle		.outerLoopBegin
	; Return
	ret

_pReadUserVariables:
	; Read user string
	push	str_var
	call	_read_pascal_string
	add		esp, 4
	; Read user byte
	call	_read_uint8
	mov		[byte_var], al
	; Read user word
	call	_read_uint16
	mov		[word_var], ax
	; Read user double
	call	_read_uint32
	mov		[double_var], eax
	; Return
	ret

_pWriteUserVariables:
	; Write user string
	push    str_var
	call    _println_pascal_string
	add     esp, 4
	; Write user byte
	push	dword [byte_var]
	call	_println_uint8
	add		esp, 4
	; Write user double
	push	dword [word_var]
	call	_println_uint16
	add		esp, 4
	; Write user double
	push	dword [double_var]
	call	_println_uint32
	add		esp, 4
	; Return
	ret

_pDoMath:
	; word_var -= byte_var
	mov		eax, [word_var]
	sub		al, [byte_var]
	mov		[word_var], eax
	; --byte_var
	mov		eax, [byte_var]
	dec		eax
	mov		[byte_var], eax
	; Return
	ret

; Main function
_main:
	; Write const byte
	push	dword [constByte]
	call	_println_uint8
	add		esp, 4
	
	call	_pWriteHelloWorld
	call	_pReadUserVariables
	call	_pDoMath
	call	_pRunLoops
	call	_pWriteUserVariables
	
	; Return
	ret
