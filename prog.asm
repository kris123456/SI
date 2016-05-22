; ----------------------------------------------------------------------------
; helloworld.asm
;
; This is a Win32 console program that writes "Hello, World" on one line and
; then exits.  It needs to be linked with a C library.
; ----------------------------------------------------------------------------

    global  _main
	extern  _print_pascal_string
	extern  _print_int8
    extern  _print_uint8
	extern  _print_int16
	extern  _print_uint16
	extern  _print_int32
	extern  _print_uint32

	section .text
msg1:
	db  14, 'Hello, World!', 10
msg2:
	db  22, 'Goodbye, Cruel World!', 10
_main:
	push    msg1
	call    _print_pascal_string
	add     esp, 4
	push    msg2
	call    _print_pascal_string
	add     esp, 4
	ret
