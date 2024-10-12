.data?
align 16
xmm0_var DB 16 DUP (?)
xmm1_var DB 16 DUP (?)
xmm2_var DB 16 DUP (?)

.code
; VEC3
VEC3 STRUCT
	x REAL4 0.0
	y REAL4 0.0
	z REAL4 0.0
VEC3 ENDS

; xmm0 as X, xmm1 as Y, xmm2 as Z || returns on xmm0
vec3_magnitude PROC
	call vec3_magnitude_squared
	sqrtss xmm0, xmm0
	ret
vec3_magnitude ENDP

; xmm0 as X, xmm1 as Y, xmm2 as Z || returns on xmm0
vec3_magnitude_squared PROC
	mulss xmm0, xmm0
	mulss xmm1, xmm1
	mulss xmm2, xmm2

	addss xmm0, xmm1
	addss xmm0, xmm2
	ret
vec3_magnitude_squared ENDP

; xmm0 as X, xmm1 as Y, xmm2 as Z
vec3_normalize PROC
	; SAVE ORIGINAL VALUES
	movdqa oword ptr xmm0_var, xmm0
	movdqa oword ptr xmm1_var, xmm1
	movdqa oword ptr xmm2_var, xmm2

	; CALL MAGNITUDE AND SAVE IT TO Xmm3
	call vec3_magnitude
	movss xmm3, xmm0

	; LOAD ORIGINAL VALUES
	movdqa xmm0, oword ptr xmm0_var
	movdqa xmm1, oword ptr xmm1_var
	movdqa xmm2, oword ptr xmm2_var

	divss xmm0, xmm3
	divss xmm1, xmm3
	divss xmm2, xmm3
	ret
vec3_normalize ENDP