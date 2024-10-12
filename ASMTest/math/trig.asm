.data
tempvar real4 0.0

pi4 real4 3.14159265358979323846264338327
half_pi4 real4 1.57079632679489661923132169163

a3_sin real4 -0.166666570965047014582412
a5_sin real4 0.00833301729156221812798629161
a7_sin real4 -0.0001980661520135080504411629
a9_sin real4 0.00000260005476789036127712325

.code
; value in xmm0
float_sine PROC
	; CONVERT XMM0 to RADIANS
	divss xmm0, __float__(180.0)
	mulss xmm0, pi4

	; FAST SINE FORMULA. Decent precision.
	movss xmm1, a3_sin
	movss xmm2, a5_sin
	movss xmm3, a7_sin
	movss xmm4, a9_sin
	
	movss xmm5, xmm0
	mulss xmm5, xmm0
	mulss xmm5, xmm4
	addss xmm5, xmm3

	movss xmm4, xmm0
	mulss xmm4, xmm0
	mulss xmm4, xmm5
	addss xmm4, xmm2

	movss xmm3, xmm0
	mulss xmm3, xmm0
	mulss xmm3, xmm4
	addss xmm3, xmm1

	movss xmm2, xmm0
	mulss xmm2, xmm0
	mulss xmm2, xmm0
	mulss xmm2, xmm3
	addss xmm2, xmm0

	movss xmm0, xmm2
	ret
float_sine ENDP

float_cosine PROC
	movss xmm1, __float__(90.0)
	subss xmm1, xmm0
	movss xmm0, xmm1
	call float_sine
	ret
float_cosine ENDP

float_tangent PROC
	movss xmm6, xmm0
	call float_sine
	movss tempvar, xmm0
	movss xmm0, xmm6
	call float_cosine
	movss xmm1, tempvar
	divss xmm1, xmm0
	movss xmm0, xmm1
	ret
float_tangent ENDP