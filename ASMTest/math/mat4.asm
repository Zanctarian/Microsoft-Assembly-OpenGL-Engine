.data?
align 16
; Row 0
m00_var DB 16 DUP (?)
m01_var DB 16 DUP (?)
m02_var DB 16 DUP (?)
m03_var DB 16 DUP (?)

; Row 1
m10_var DB 16 DUP (?)
m11_var DB 16 DUP (?)
m12_var DB 16 DUP (?)
m13_var DB 16 DUP (?)

; Row 2
m20_var DB 16 DUP (?)
m21_var DB 16 DUP (?)
m22_var DB 16 DUP (?)
m23_var DB 16 DUP (?)

; Row 3
m30_var DB 16 DUP (?)
m31_var DB 16 DUP (?)
m32_var DB 16 DUP (?)
m33_var DB 16 DUP (?)

packed_matrix DB 16*16 DUP (?)

.code
MAT4 STRUCT
	m00 REAL4 0.0
	m01 REAL4 0.0
	m02 REAL4 0.0
	m03 REAL4 0.0

	m10 REAL4 0.0
	m11 REAL4 0.0
	m12 REAL4 0.0
	m13 REAL4 0.0

	m20 REAL4 0.0
	m21 REAL4 0.0
	m22 REAL4 0.0
	m23 REAL4 0.0

	m30 REAL4 0.0
	m31 REAL4 0.0
	m32 REAL4 0.0
	m33 REAL4 0.0
MAT4 ENDS

; PARAMS [ RCX : MAT4 ]
mat4_set_identity PROC
	mat equ [rcx].MAT4

	movss xmm0, __float__(1.0)
	movss mat.m00, xmm0
	movss mat.m11, xmm0
	movss mat.m22, xmm0
	movss mat.m33, xmm0
	ret
mat4_set_identity ENDP

; PARAMS [ RCX : MAT4 ]
mat4_set_zero PROC
	mat equ [rcx].MAT4

	movss xmm0, __float__(1.0)
	movss mat.m00, xmm0
	movss mat.m01, xmm0
	movss mat.m02, xmm0
	movss mat.m03, xmm0

	movss mat.m10, xmm0
	movss mat.m11, xmm0
	movss mat.m12, xmm0
	movss mat.m13, xmm0

	movss mat.m20, xmm0
	movss mat.m21, xmm0
	movss mat.m22, xmm0
	movss mat.m23, xmm0

	movss mat.m30, xmm0
	movss mat.m31, xmm0
	movss mat.m32, xmm0
	movss mat.m33, xmm0
	ret
mat4_set_zero ENDP

; PARAMS [ RCX (SOURCE) : MAT4 | RDX (DEST) : MAT4 ]
mat4_load PROC
	source_mat equ [rcx].MAT4
	dest_mat equ [rdx].MAT4

	movss xmm0, source_mat.m00
	movss dest_mat.m00, xmm0
	movss xmm0, source_mat.m01
	movss dest_mat.m01, xmm0
	movss xmm0, source_mat.m02
	movss dest_mat.m02, xmm0
	movss xmm0, source_mat.m03
	movss dest_mat.m03, xmm0

	movss xmm0, source_mat.m10
	movss dest_mat.m10, xmm0
	movss xmm0, source_mat.m11
	movss dest_mat.m11, xmm0
	movss xmm0, source_mat.m12
	movss dest_mat.m12, xmm0
	movss xmm0, source_mat.m13
	movss dest_mat.m13, xmm0

	movss xmm0, source_mat.m20
	movss dest_mat.m20, xmm0
	movss xmm0, source_mat.m21
	movss dest_mat.m21, xmm0
	movss xmm0, source_mat.m22
	movss dest_mat.m22, xmm0
	movss xmm0, source_mat.m23
	movss dest_mat.m23, xmm0

	movss xmm0, source_mat.m30
	movss dest_mat.m30, xmm0
	movss xmm0, source_mat.m31
	movss dest_mat.m31, xmm0
	movss xmm0, source_mat.m32
	movss dest_mat.m32, xmm0
	movss xmm0, source_mat.m33
	movss dest_mat.m33, xmm0
	ret
mat4_load ENDP

; PARAMS [ RCX (target) : MAT4 | RDX (to_add_to_target) : MAT4 ]
mat4_add PROC
	dest_mat equ [rcx].MAT4
	add_mat equ [rdx].MAT4

	movss xmm0, dest_mat.m00
	movss xmm1, add_mat.m00
	addss xmm0, xmm1
	movss dest_mat.m00, xmm0

	movss xmm0, dest_mat.m01
	movss xmm1, add_mat.m01
	addss xmm0, xmm1
	movss dest_mat.m01, xmm0

	movss xmm0, dest_mat.m02
	movss xmm1, add_mat.m02
	addss xmm0, xmm1
	movss dest_mat.m02, xmm0

	movss xmm0, dest_mat.m03
	movss xmm1, add_mat.m03
	addss xmm0, xmm1
	movss dest_mat.m03, xmm0

	; --------------

	movss xmm0, dest_mat.m10
	movss xmm1, add_mat.m10
	addss xmm0, xmm1
	movss dest_mat.m10, xmm0

	movss xmm0, dest_mat.m11
	movss xmm1, add_mat.m11
	addss xmm0, xmm1
	movss dest_mat.m11, xmm0

	movss xmm0, dest_mat.m12
	movss xmm1, add_mat.m12
	addss xmm0, xmm1
	movss dest_mat.m12, xmm0

	movss xmm0, dest_mat.m13
	movss xmm1, add_mat.m13
	addss xmm0, xmm1
	movss dest_mat.m13, xmm0

	; --------------

	movss xmm0, dest_mat.m20
	movss xmm1, add_mat.m20
	addss xmm0, xmm1
	movss dest_mat.m20, xmm0

	movss xmm0, dest_mat.m21
	movss xmm1, add_mat.m21
	addss xmm0, xmm1
	movss dest_mat.m21, xmm0

	movss xmm0, dest_mat.m22
	movss xmm1, add_mat.m22
	addss xmm0, xmm1
	movss dest_mat.m22, xmm0

	movss xmm0, dest_mat.m23
	movss xmm1, add_mat.m23
	addss xmm0, xmm1
	movss dest_mat.m23, xmm0

	; --------------

	movss xmm0, dest_mat.m30
	movss xmm1, add_mat.m30
	addss xmm0, xmm1
	movss dest_mat.m30, xmm0

	movss xmm0, dest_mat.m31
	movss xmm1, add_mat.m31
	addss xmm0, xmm1
	movss dest_mat.m31, xmm0

	movss xmm0, dest_mat.m32
	movss xmm1, add_mat.m32
	addss xmm0, xmm1
	movss dest_mat.m32, xmm0

	movss xmm0, dest_mat.m33
	movss xmm1, add_mat.m33
	addss xmm0, xmm1
	movss dest_mat.m33, xmm0
	ret
mat4_add ENDP

; PARAMS [ RCX (target) : MAT4 | RDX (to_sub_from_target) : MAT4 ]
mat4_sub PROC
	dest_mat equ [rcx].MAT4
	sub_mat equ [rdx].MAT4

	movss xmm0, dest_mat.m00
	movss xmm1, sub_mat.m00
	subss xmm0, xmm1
	movss dest_mat.m00, xmm0

	movss xmm0, dest_mat.m01
	movss xmm1, sub_mat.m01
	subss xmm0, xmm1
	movss dest_mat.m01, xmm0

	movss xmm0, dest_mat.m02
	movss xmm1, sub_mat.m02
	subss xmm0, xmm1
	movss dest_mat.m02, xmm0

	movss xmm0, dest_mat.m03
	movss xmm1, sub_mat.m03
	subss xmm0, xmm1
	movss dest_mat.m03, xmm0

	; --------------

	movss xmm0, dest_mat.m10
	movss xmm1, sub_mat.m10
	subss xmm0, xmm1
	movss dest_mat.m10, xmm0

	movss xmm0, dest_mat.m11
	movss xmm1, sub_mat.m11
	subss xmm0, xmm1
	movss dest_mat.m11, xmm0

	movss xmm0, dest_mat.m12
	movss xmm1, sub_mat.m12
	subss xmm0, xmm1
	movss dest_mat.m12, xmm0

	movss xmm0, dest_mat.m13
	movss xmm1, sub_mat.m13
	subss xmm0, xmm1
	movss dest_mat.m13, xmm0

	; --------------

	movss xmm0, dest_mat.m20
	movss xmm1, sub_mat.m20
	subss xmm0, xmm1
	movss dest_mat.m20, xmm0

	movss xmm0, dest_mat.m21
	movss xmm1, sub_mat.m21
	subss xmm0, xmm1
	movss dest_mat.m21, xmm0

	movss xmm0, dest_mat.m22
	movss xmm1, sub_mat.m22
	subss xmm0, xmm1
	movss dest_mat.m22, xmm0

	movss xmm0, dest_mat.m23
	movss xmm1, sub_mat.m23
	subss xmm0, xmm1
	movss dest_mat.m23, xmm0

	; --------------

	movss xmm0, dest_mat.m30
	movss xmm1, sub_mat.m30
	subss xmm0, xmm1
	movss dest_mat.m30, xmm0

	movss xmm0, dest_mat.m31
	movss xmm1, sub_mat.m31
	subss xmm0, xmm1
	movss dest_mat.m31, xmm0

	movss xmm0, dest_mat.m32
	movss xmm1, sub_mat.m32
	subss xmm0, xmm1
	movss dest_mat.m32, xmm0

	movss xmm0, dest_mat.m33
	movss xmm1, sub_mat.m33
	subss xmm0, xmm1
	movss dest_mat.m33, xmm0
	ret
mat4_sub ENDP

; PARAMS [ RCX (target) : MAT4 | RDX (to_mul_to_target) : MAT4 ]
mat4_mul PROC
	dest_mat equ [rcx].MAT4
	mul_mat equ [rdx].MAT4

		; m00
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m00
	movss xmm1, mul_mat.m00
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m10
	movss xmm1, mul_mat.m01
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m20
	movss xmm1, mul_mat.m02
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m30
	movss xmm1, mul_mat.m03
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m00_var, xmm3

	; m01
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m01
	movss xmm1, mul_mat.m00
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m11
	movss xmm1, mul_mat.m01
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m21
	movss xmm1, mul_mat.m02
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m31
	movss xmm1, mul_mat.m03
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m01_var, xmm3

	; m02
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m02
	movss xmm1, mul_mat.m00
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m12
	movss xmm1, mul_mat.m01
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m22
	movss xmm1, mul_mat.m02
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m32
	movss xmm1, mul_mat.m03
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m02_var, xmm3

	; m03
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m03
	movss xmm1, mul_mat.m00
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m13
	movss xmm1, mul_mat.m01
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m23
	movss xmm1, mul_mat.m02
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m33
	movss xmm1, mul_mat.m03
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m03_var, xmm3

	; m10
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m00
	movss xmm1, mul_mat.m10
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m10
	movss xmm1, mul_mat.m11
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m20
	movss xmm1, mul_mat.m12
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m30
	movss xmm1, mul_mat.m13
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m10_var, xmm3

	; m11
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m01
	movss xmm1, mul_mat.m10
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m11
	movss xmm1, mul_mat.m11
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m21
	movss xmm1, mul_mat.m12
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m31
	movss xmm1, mul_mat.m13
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m11_var, xmm3

	; m12
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m02
	movss xmm1, mul_mat.m10
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m12
	movss xmm1, mul_mat.m11
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m22
	movss xmm1, mul_mat.m12
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m32
	movss xmm1, mul_mat.m13
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m12_var, xmm3

	; m13
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m03
	movss xmm1, mul_mat.m10
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m13
	movss xmm1, mul_mat.m11
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m23
	movss xmm1, mul_mat.m12
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m33
	movss xmm1, mul_mat.m13
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m13_var, xmm3

	; m20
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m00
	movss xmm1, mul_mat.m20
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m10
	movss xmm1, mul_mat.m21
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m20
	movss xmm1, mul_mat.m22
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m30
	movss xmm1, mul_mat.m23
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m20_var, xmm3

	; m21
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m01
	movss xmm1, mul_mat.m20
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m11
	movss xmm1, mul_mat.m21
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m21
	movss xmm1, mul_mat.m22
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m31
	movss xmm1, mul_mat.m23
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m21_var, xmm3

	; m22
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m02
	movss xmm1, mul_mat.m20
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m12
	movss xmm1, mul_mat.m21
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m22
	movss xmm1, mul_mat.m22
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m32
	movss xmm1, mul_mat.m23
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m22_var, xmm3

	; m23
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m03
	movss xmm1, mul_mat.m20
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m13
	movss xmm1, mul_mat.m21
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m23
	movss xmm1, mul_mat.m22
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m33
	movss xmm1, mul_mat.m23
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m23_var, xmm3

	; m30
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m00
	movss xmm1, mul_mat.m30
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m10
	movss xmm1, mul_mat.m31
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m20
	movss xmm1, mul_mat.m32
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m30
	movss xmm1, mul_mat.m33
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m30_var, xmm3

	; m31
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m01
	movss xmm1, mul_mat.m30
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m11
	movss xmm1, mul_mat.m31
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m21
	movss xmm1, mul_mat.m32
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m31
	movss xmm1, mul_mat.m33
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m31_var, xmm3

	; m32
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m02
	movss xmm1, mul_mat.m30
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m12
	movss xmm1, mul_mat.m31
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m22
	movss xmm1, mul_mat.m32
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m32
	movss xmm1, mul_mat.m33
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m32_var, xmm3

	; m33
	movss xmm3, __float__(0.0)
	movss xmm0, dest_mat.m03
	movss xmm1, mul_mat.m30
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m13
	movss xmm1, mul_mat.m31
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m23
	movss xmm1, mul_mat.m32
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movss xmm0, dest_mat.m33
	movss xmm1, mul_mat.m33
	mulss xmm0, xmm1
	addss xmm3, xmm0
	movdqa oword ptr m33_var, xmm3

	; SET DESTINATION MAT
	; Row 0
	movdqa xmm0, oword ptr m00_var
	movss dest_mat.m00, xmm0

	movdqa xmm0, oword ptr m01_var
	movss dest_mat.m01, xmm0

	movdqa xmm0, oword ptr m02_var
	movss dest_mat.m02, xmm0

	movdqa xmm0, oword ptr m03_var
	movss dest_mat.m03, xmm0

	; Row 1
	movdqa xmm0, oword ptr m10_var
	movss dest_mat.m10, xmm0

	movdqa xmm0, oword ptr m11_var
	movss dest_mat.m11, xmm0

	movdqa xmm0, oword ptr m12_var
	movss dest_mat.m12, xmm0

	movdqa xmm0, oword ptr m13_var
	movss dest_mat.m13, xmm0

	; Row 2
	movdqa xmm0, oword ptr m20_var
	movss dest_mat.m20, xmm0

	movdqa xmm0, oword ptr m21_var
	movss dest_mat.m21, xmm0

	movdqa xmm0, oword ptr m22_var
	movss dest_mat.m22, xmm0

	movdqa xmm0, oword ptr m23_var
	movss dest_mat.m23, xmm0

	; Row 3
	movdqa xmm0, oword ptr m30_var
	movss dest_mat.m30, xmm0

	movdqa xmm0, oword ptr m31_var
	movss dest_mat.m31, xmm0

	movdqa xmm0, oword ptr m32_var
	movss dest_mat.m32, xmm0

	movdqa xmm0, oword ptr m33_var
	movss dest_mat.m33, xmm0

	ret
mat4_mul ENDP

; PARAMS [ xmm0 (FOVY) : REAL4 | xmm1 (aspect) : REAL4 | xmm2 (zNear) : REAL4 | xmm3 (zFar) : REAL4 | rcx : MAT4]
mat4_perspective PROC
	movdqa oword ptr m00_var, xmm1
	movdqa oword ptr m01_var, xmm2
	movdqa oword ptr m02_var, xmm3

	; calculate h
	mulss xmm0, __float__(0.5)
	call float_tangent

	movdqa xmm1, oword ptr m00_var
	movdqa xmm2, oword ptr m01_var
	movdqa xmm3, oword ptr m02_var

	mov rax, rcx
	call mat4_set_zero

	; calculate w
	movss xmm4, xmm0
	mulss xmm4, xmm1

	;m00
	mat equ [rax].MAT4
	movss xmm5, xmm2
	divss xmm5, xmm4
	movss mat.m00, xmm5
	
	;m11
	movss xmm5, xmm2
	divss xmm5, xmm0
	movss mat.m11, xmm5

	;m22 - discard w & h -- xmm4 & xmm0
	movss xmm5, xmm3
	addss xmm5, xmm2
	mulss xmm5, __float__(-1.0)
	movss xmm4, xmm3
	subss xmm4, xmm2
	divss xmm5, xmm4
	movss mat.m22, xmm5

	;m32
	movss xmm5, xmm3
	mulss xmm5, xmm2
	mulss xmm5, __float__(-2.0)
	divss xmm5, xmm4
	movss mat.m32, xmm5

	ret
mat4_perspective ENDP

; PARAMS [ rcx : MAT4, rdx : VEC3 ]
mat4_translate PROC
	mat equ [rcx].MAT4
	vec equ [rdx].VEC3

	movss xmm0, vec.x
	movss xmm1, mat.m30
	addss xmm0, xmm1
	movss mat.m30, xmm0

	movss xmm0, vec.y
	movss xmm1, mat.m31
	addss xmm0, xmm1
	movss mat.m31, xmm0

	movss xmm0, vec.z
	movss xmm1, mat.m32
	addss xmm0, xmm1
	movss mat.m32, xmm0
	ret
mat4_translate ENDP

; PARAMS [ rcx : MAT4 ]
prepare_matrix PROC
	mat equ [rcx].MAT4

	; TODO iterate through pointer with size 16 * 16 to pack matrix for load
	; pack in inside of rcx (todo, double check)
	mov rcx, offset packed_matrix
	movss xmm0, mat.m00
	movdqa oword ptr [rcx+16*0], xmm0
	movss xmm0, mat.m01
	movdqa oword ptr [rcx+16*1], xmm0
	movss xmm0, mat.m02
	movdqa oword ptr [rcx+16*2], xmm0
	movss xmm0, mat.m03
	movdqa oword ptr [rcx+16*3], xmm0

	movss xmm0, mat.m10
	movdqa oword ptr [rcx+16*4], xmm0
	movss xmm0, mat.m11
	movdqa oword ptr [rcx+16*5], xmm0
	movss xmm0, mat.m12
	movdqa oword ptr [rcx+16*6], xmm0
	movss xmm0, mat.m13
	movdqa oword ptr [rcx+16*7], xmm0

	movss xmm0, mat.m20
	movdqa oword ptr [rcx+16*8], xmm0
	movss xmm0, mat.m21
	movdqa oword ptr [rcx+16*9], xmm0
	movss xmm0, mat.m22
	movdqa oword ptr [rcx+16*10], xmm0
	movss xmm0, mat.m23
	movdqa oword ptr [rcx+16*11], xmm0

	movss xmm0, mat.m30
	movdqa oword ptr [rcx+16*12], xmm0
	movss xmm0, mat.m31
	movdqa oword ptr [rcx+16*13], xmm0
	movss xmm0, mat.m32
	movdqa oword ptr [rcx+16*14], xmm0
	movss xmm0, mat.m33
	movdqa oword ptr [rcx+16*15], xmm0
prepare_matrix ENDP

; reminder on how to use struct variables
;mat4_test PROC 
;	cam_x equ [rcx].VEC3.x       ; VARIABLE.      assign variable to field "x" in VEC3 struct, dereferencing the pointer.
;	movss xmm0, cam_x            ; LOAD TEST.     pass the value to register xmm0, it should override the 3
;	movss xmm0, __float__(4.0)   ; SET TEST.      change value to 4 using __float__ macro in utils. 
;	movss cam_x, xmm0            ; SET TEST (#2). Because you can't direct give it a value, pass the register value to the original field.
;	movss xmm1, cam_x            ; LOAD TEST.     Read the value on another register to confirm it set.
;	ret
;mat4_test ENDP