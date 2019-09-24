	.segment "RS232NMI"
nmi	sei             ;no irq's allowed...
	jmp (nminv)     ;...could mess up cassettes
nnmi	pha
	txa
	pha
	tya
	pha
;
; check for stop key down
;
	jsr ud60        ;no .y
	jsr stop        ;no .y
	bne prend       ;no stop key...
;
; timb - where system goes on a brk instruction
;
timb	jsr restor      ;restore system indirects
	jsr ioinit      ;restore i/o for basic
	jsr cint        ;restore screen for basic
.ifdef C64
	jmp ($a002)     ;...no, so basic warm start
.else
	jmp ($c002)     ;...no, so basic warm start
.endif

prend	pla             ;because of missing screen editor
	tay
	pla
	tax
	pla
	rti
