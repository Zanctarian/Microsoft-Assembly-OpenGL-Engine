includelib legacy_stdio_definitions.lib
includelib ucrt.lib
includelib vcruntime.lib

includelib glfw3.lib
includelib glew32s.lib
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
extern glLoadMatrixf: PROC
extern glGetIntegerv: PROC

extern SetPixelFormat: PROC

extern glewInit: PROC

include utils.asm
include keys.asm
include draw_objects.asm
include vec.asm
include mat4.asm
include trig.asm
include shader_program.asm

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
	info_startup db "Starting up [tempname] game engine...", 0
	window_name db "Test Window", 0
	info_init db "Initialized GLFW...", 0
	err_init db "GLFW failed to initialize!", 0
	info_window db "Successfully created GLFW window!", 0
	err_window db "GLFW failed to create the window", 0

	str_new_line db 10, 0

	;pf PIXELFORMATDESCRIPTOR <>

	camera_pos VEC3<0.0, 0.0, -4.0>
	model_mat MAT4<>
	view_mat MAT4<>
	projection_mat MAT4<>

	;extern glCreateShader: PROC
;extern glShaderSource: PROC
;extern glCompileShader: PROC
;extern glCreateProgram: PROC
;extern glAttachShader: PROC
;extern glLinkProgram: PROC
;extern glDeleteShader: PROC

;extern glGenVertexArrays: PROC
;extern glBindBuffer: PROC
;extern glBufferData: PROC

;extern glVertexAttribPointer: PROC
;extern glEnableVertexAttribArray: PROC
;extern glBindBuffer: PROC
;extern glBindVertexArray: PROC
	
	gl_func_err_pre db "Failed to load function ",0
	gl_func_info_pre db "Loaded function ",0

	szGlCreateShader db "glCreateShader",0
	szGlShaderSource db "glShaderSource", 0
	szGlCompileShader db "glCompileShader", 0
	szGlCreateProgram db "glCreateProgram", 0
	szGlAttachShader db "glAttachShader", 0
	szGlLinkProgram db "glLinkProgram", 0
	szGlDeleteShader db "glDeleteShader", 0
	szGlGenVertexArrays db "glGenVertexArrays", 0
	szGlBindBuffer db "glBindBuffer", 0
	szGlBufferData db "glBufferData", 0
	szGlVertexAttribPointer db "glVertexAttribPointer", 0
	szGlEnableVertexAttribArray db "glEnableVertexAttribArray", 0
	szGlBindVertexArray db "glBindVertexArray", 0

	glCreateShader dq 0
	glShaderSource dq 0
	glCompileShader dq 0
	glCreateProgram dq 0
	glAttachShader dq 0
	glLinkProgram dq 0
	glDeleteShader dq 0
	glGenVertexArrays dq 0
	glBindBuffer dq 0
	glBufferData dq 0
	glVertexAttribPointer dq 0
	glEnableVertexAttribArray dq 0
	glBindVertexArray dq 0
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

	call glewInit
	print_line info_startup
	; Check for initialization error
	test rax, rax
	mov rcx, GLFW_ERROR_INIT
	jz api_err
	print_line info_init

	; Set major and minor hints, to make sure we use the same ver as
	; the windows library
	mov rcx, GLFW_CONTEXT_VERSION_MAJOR
	mov rdx, 4
	call glfwWindowHint

	mov rcx, GLFW_CONTEXT_VERSION_MINOR
	mov rdx, 3
	call glfwWindowHint

	mov rcx, GLFW_OPENGL_PROFILE
	mov rdx, GLFW_OPENGL_CORE_PROFILE
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
	print_line info_window

	; HAVE to do it right here. Cant even use another proc or else I get access violations WTF

	; --- LOAD SHADER FUNCTIONS ---
	; LOAD glCreateShader FUNCTION
	


	; load_func MACRO func_name_pointer, func_variable, func_load_str_pointer, func_err_str_pointer

	load_gl_func glCreateShader, szGlCreateShader
	load_gl_func glShaderSource, szGlShaderSource
	load_gl_func glCompileShader, szGlCompileShader
	load_gl_func glCreateProgram, szGlCreateProgram
	load_gl_func glAttachShader, szGlAttachShader
	load_gl_func glLinkProgram, szGlLinkProgram
	load_gl_func glDeleteShader, szGlDeleteShader
	load_gl_func glGenVertexArrays, szGlGenVertexArrays
	load_gl_func glBindBuffer, szGlBindBuffer
	load_gl_func glBufferData, szGlBufferData
	load_gl_func glVertexAttribPointer, szGlVertexAttribPointer
	load_gl_func glEnableVertexAttribArray, szGlEnableVertexAttribArray
	load_gl_func glBindVertexArray, szGlBindVertexArray

	
	;create_shader_program
	mov rcx, GL_VERTEX_SHADER
	call glCreateShader
	mov rcx, r8
	mov rdx, 1
	lea r8, shader_vert
	mov r9, 0
	call glShaderSource
	; TODO WORK MORE ON SHADERS THEN PUT IT IN THE MACRO
	; would to proc but theres some weird voodoo I dont understand
	; about stack space :P

	; TEST
	;mov rcx, offset test_mat
	;call mat4_set_identity
	movss xmm1, __float__(1080.0)
	movss xmm0, __float__(1920.0)
	divss xmm1, xmm0
	
	movss xmm0, half_pi4
	movss xmm2, __float__(0.1)
	movss xmm3, __float__(100.0)
	mov rcx, offset projection_mat
	call mat4_perspective
	
	mov rcx, offset view_mat
	mov rdx, offset camera_pos
	call mat4_translate

	; Clear, what more you expect?
	movss xmm0, __float__(0.0)
	movss xmm1, __float__(0.0)
	movss xmm2, __float__(0.0)
	movss xmm3, __float__(1.0)
	call glClearColor


	jmp mainLoop
_start ENDP

mainLoop PROC
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

gl_func_err PROC
	cdecl_begin
	add rsp, 64
	mov rdx, rcx
	lea rcx, gl_func_err_pre
	print_line_concat_rcx_rdx

	mov rcx, [window_id]
	call glfwTerminate
	xor rcx, rcx
	call ExitProcess
	cdecl_end
gl_func_err ENDP

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