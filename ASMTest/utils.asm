includelib ucrt.lib

extern ExitProcess: PROC
extern printf: PROC

.code
print_line_concat MACRO str_pointer_left, str_pointer_right
	lea rcx, str_pointer_left
	lea rdx, str_pointer_right
	print_line_concat_rcx_rdx
ENDM

print_line_concat_rcx_rdx MACRO
	lea rdi, err_msg
	call str_concat
	
	lea rcx, err_msg
	print_line_rcx
ENDM

print_line_rcx MACRO
	lea rdx, str_new_line
	lea rdi, err_msg
	call str_concat
	lea rcx, err_msg
	call printf
ENDM

print_line MACRO str_pointer
    lea rcx, str_pointer
	print_line_rcx
ENDM

load_gl_func MACRO func_variable, func_name_pointer
	lea rcx, func_name_pointer                                 ; Assign function name string to rcx. Variable cant be named identical to the function for whatever reason
	call wglGetProcAddress                                     ; equal to wglGetProcAddress("glCreateShader");   Store pointer for function in rax.
	mov [func_variable], rax                                   ; Store pointer in rax to variable glCreateShader
	test rax, rax                                              ; Check to see if the pointer is valid, aka if it even exists
	lea rcx, func_name_pointer                                 ; Load the error message for if its invalid
	jz gl_func_err                                             ; Jump to error handler with assigned message if test fails
	print_line_concat gl_func_info_pre, func_name_pointer      ; If test is a success, print the init message.
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

exitProgram PROC
	call ExitProcess
exitProgram ENDP

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
	mov al, [rdx]
	inc rdx
	mov [rdi], al
	inc rdi
	cmp al, 0
	jne str_concat_2
	ret
str_concat_2 ENDP
