GL_VERTEX_SHADER equ 8B31h
GL_FRAGMENT_SHADER equ 8B30h

.data
	shader_vert db "#version 330 core\nlayout (location = 0) in vec3 aPos;\nvoid main() {\ngl_Position = vec4(aPos.x,aPos.y,aPos.z,1.0f);\n}\0", 0
	shader_frag db "#version 330 core\nout vec4 FragColor;\nvoid main() {\nFragColor = vec4(1.0f, 0.0f, 0.0f, 1.0f)\n}\0",0 

.code
create_shader_program MACRO
	mov rcx, GL_VERTEX_SHADER
	call glCreateShader
	mov rcx, r8
	mov rdx, 1
	lea r8, shader_vert
	mov r9, 0
	call glShaderSource
ENDM