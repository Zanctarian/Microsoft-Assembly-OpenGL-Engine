includelib legacy_stdio_definitions.lib
includelib ucrt.lib
includelib vcruntime.lib

includelib glfw3.lib
includelib opengl32.lib

extern printf: PROC
extern glfwInit: PROC
extern glfwCreateWindow: PROC
extern glfwMakeContextCurrent: PROC
extern glfwWindowShouldClose: PROC
extern glfwSwapBuffers: PROC
extern glfwPollEvents: PROC
extern glfwTerminate: PROC
extern glfwDestroyWindow: PROC
extern glfwWindowHint: PROC
extern glfwDefaultWindowHints: PROC
extern glfwGetFramebufferSize: PROC
extern glfwGetKey: PROC

extern glClearColor: PROC
extern glClear: PROC
extern glViewport: PROC
extern glLoadIdentity: PROC
extern glBegin: PROC
extern glColor3f: PROC
extern glEnd: PROC
extern glFlush: PROC
extern glMatrixMode: PROC
extern glOrtho: PROC
extern glPushMatrix: PROC
extern glPopMatrix: PROC
extern glLineWidth: PROC
extern glLoadIdentity: PROC
extern wglGetProcAddress: PROC

include utils.asm
include keys.asm
include draw_objects.asm

GLFW_CONTEXT_VERSION_MAJOR equ 00022002h
GLFW_CONTEXT_VERSION_MINOR equ 00022003h
GLFW_OPENGL_FORWARD_COMPAT equ 22006h
GLFW_OPENGL_PROFILE equ 22008h
GLFW_OPENGL_CORE_PROFILE equ 32001h

GLFW_KEY_ESCAPE equ 256
GLFW_PRESS equ 1

GL_COLOR_BUFFER_BIT equ 4000h
GL_QUADS equ 7h
GL_PROJECTION equ 1701h
GL_MODELVIEW equ 1700h

GL_TRUE equ 1
GL_FALSE equ 0

WINDOW_WIDTH equ 1920
WINDOW_HEIGHT equ 1080

GLFW_ERROR_INIT equ 01h
GLFW_ERROR_WINDOW equ 02h

.data
	window_name db "Test Window", 0
	err_init db "GLFW failed to initialize!", 0
	err_window db "GLFW failed to create the window", 0

	str_new_line db 10, 0

.data?
	window_id dq ?
	framebuffer_width dq ?
	framebuffer_height dq ?

	err_msg dq ?

.code

_start PROC
	cdecl_begin

	; Init
	call glfwInit

	; Check for initialization error
	test rax, rax
	mov rcx, GLFW_ERROR_INIT
	jz api_err

	; Set major and minor hints, to make sure we use the same ver as
	; the windows library
	mov rcx, GLFW_CONTEXT_VERSION_MAJOR
	mov rdx, 1
	call glfwWindowHint

	mov rcx, GLFW_CONTEXT_VERSION_MINOR
	mov rdx, 1
	call glfwWindowHint

	; Create window
	mov rcx, WINDOW_WIDTH
	mov rdx, WINDOW_HEIGHT
	mov r8, offset window_name
	mov r9, 0
	mov r10, 0
	call glfwCreateWindow

	; Check if the window failed
	test rax, rax
	mov rcx, GLFW_ERROR_WINDOW
	jz api_err

	; Handle setting the context
	mov [window_id], rax
	mov rcx, [window_id]
	call glfwMakeContextCurrent

	; Clear, what more you expect?
	movss xmm0, __float__(0.0)
	movss xmm1, __float__(0.0)
	movss xmm2, __float__(0.0)
	movss xmm3, __float__(1.0)
	call glClearColor

	call mainLoop
_start ENDP

mainLoop PROC
	cdecl_begin

	; Clear the previous screen
	mov rcx, GL_COLOR_BUFFER_BIT
	call glClear

	call glLoadIdentity

	; Get the current size of the window
	mov rcx, [window_id]
	mov rdx, offset framebuffer_width
	mov r8, offset framebuffer_height
	call glfwGetFramebufferSize

	mov rcx, 0
	mov rdx, 0
	mov r8, framebuffer_width
	mov r9, framebuffer_height
	call glViewport

	; Render the triangle
	mov rcx, GL_QUADS
	call glBegin

	; square
	movss xmm0, __float__(1.0)
	movss xmm1, __float__(0.0)
	movss xmm2, __float__(0.0)
	call glColor3f

	call drawCube

	call glEnd

	call glFlush

	; Display the resulting render to the window
	mov rcx, [window_id]
	call glfwSwapBuffers

	call glfwPollEvents

	; Check esc key
	mov rcx, [window_id]
	mov rdx, GLFW_KEY_ESCAPE
	call glfwGetKey
	cmp rax, GLFW_PRESS
	je exitProgram

	call handleKeyInputs
	
	; Check for if the window is ready to close
	mov rcx, [window_id]
	call glfwWindowShouldClose

	cdecl_end
	cmp rax, 0
	je mainLoop

	; Deinitialize data and exit the program
	cdecl_begin
	call glfwDestroyWindow
	call glfwTerminate

	jmp exitProgram
	cdecl_end
mainLoop ENDP

; ERROR HANDLING ;

api_err PROC
	cdecl_begin
	add rsp, 64
	cmp rcx, GLFW_ERROR_INIT
	je api_err_init

	cmp rcx, GLFW_ERROR_WINDOW
	je api_err_window
	cdecl_end
api_err ENDP

; GLFW initialization error
api_err_init PROC
    cdecl_begin
	print_line err_init

	call ExitProcess
	cdecl_end
api_err_init ENDP

api_err_window PROC
	cdecl_begin
	print_line err_window

	call glfwTerminate
	call ExitProcess
	cdecl_end
api_err_window ENDP

END