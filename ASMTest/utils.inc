includelib ucrt.lib

extern printf: PROC

print_line MACRO str_pointer
    lea rcx, str_pointer
	lea rbx, str_new_line
	lea rdi, err_msg
	call str_concat
	lea rcx, err_msg
	call printf
ENDM

cdecl_begin MACRO
	push rbp
	mov rbp, rsp
ENDM

cdecl_end MACRO
	mov rsp, rbp
	pop rbp
ENDM

__float__ MACRO value
 LOCAL vname
 .const
 align 4
 vname REAL4 value
 .code
 EXITM <vname>
ENDM

.code
; rcx = 1, rdx = 2, rdi = source
str_concat PROC
	; Append bytes for first, ignore 0 terminator
	mov al, [rcx]
	inc rcx
	mov [rdi], al
	inc rdi
	cmp al, 0
	jne str_concat

	; Now to remove the 0 terminator
	dec rdi
	call str_concat_2
	ret
str_concat ENDP

; Do the loop again for the other string but keep the 0 terminator
str_concat_2 PROC
	mov al, [rbx]
	inc rbx
	mov [rdi], al
	inc rdi
	cmp al, 0
	jne str_concat_2
	ret
str_concat_2 ENDP

exitProgram PROC
	call ExitProcess
exitProgram ENDP