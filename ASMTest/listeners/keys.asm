extern glfwGetKey: PROC

GLFW_KEY_ESCAPE equ 256
GLFW_PRESS equ 1

; RCX CONTAINS WINDOW ID
handleKeyInputs PROC
	; Check esc key
	mov rcx, [window_id]
	mov rdx, GLFW_KEY_ESCAPE
	call glfwGetKey
	cmp rax, GLFW_PRESS
	je exitProgram
	ret
handleKeyInputs ENDP