extern glVertex3f: PROC
; its a square rn bc im lazy
drawCube PROC
	; FRONT FACE
    movss xmm0, __float__(1.0)
	movss xmm1, __float__(1.0)
	movss xmm2, __float__(1.0)
	call glVertex3f

	movss xmm0, __float__(-1.0)
	movss xmm1, __float__(1.0)
	movss xmm2, __float__(1.0)
	call glVertex3f

	movss xmm0, __float__(-1.0)
	movss xmm1, __float__(-1.0)
	movss xmm2, __float__(1.0)
	call glVertex3f

	movss xmm0, __float__(1.0)
	movss xmm1, __float__(-1.0)
	movss xmm2, __float__(1.0)
	call glVertex3f
	ret
drawCube ENDP