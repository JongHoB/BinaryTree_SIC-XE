	LDA	#CALLSTK
	STA	stackp
	
LOOP	JSUB	CMINPUT	.LOOP
	LDA	CMDLEN
	COMP	#7
	JEQ	INPUT
	COMP	#8
	JEQ	DELETE
	COMP	#4
	JEQ	LIST
	COMP	#6
	JEQ	FIND
	J	LOOP

	
CMINPUT	LDX	#0	.COMMAND INPUT
	LDT	#1
	LDA	#0
CLOOP	TD	INDEV
	JEQ	CLOOP
	RD	INDEV
	COMP	EOL
	JEQ	ENDIN
	STCH	COMMAND,X
	STA	DATA	
	ADDR	T,X
	J	CLOOP
ENDIN	STX	CMDLEN
	STL	TMP_L
	RSUB

INPUT	LDA	NODE	.INPUT	OPERATION
	COMP	#15
	JEQ	INEND
	LDA	#Tree
	STA	TreeP
	LDX	#0
INLP	LDA	@TreeP
	COMP	#0
	JEQ	INSERT
	JSUB	NEXTP
	TIX	#15
	JLT	INLP
	J	LOOP
		
INSERT	LDA	DATA
	STA	@TreeP
	LDA	NODE
	ADD	#1
	STA	NODE
	J	LOOP

NEXTP	LDA	TreeP
	ADD	#3
	STA	TreeP
	RSUB

INEND	LDX	#0
IELP	TD	OUTDEV
	JEQ	IELP
	LDCH	FULL,X
	WD	OUTDEV
	TIX	#4
	JLT	IELP
	LDCH	NEWLINE
	WD	OUTDEV
	J	LOOP


LIST	LDA	#0
	STA	LSIDX
	JSUB	LLOOP
	J	LOOP
LLOOP	STA	LSIDX
	COMP	MAXIDX
	JGT	EXIT
	LDS	#Tree
	MUL	#3
	ADDR	A,S
	STS	TMP_S
	LDA	@TMP_S
	COMP	#0
	JEQ	EXIT

	LDA	LSIDX
	STL	TMP_L
	STA	TMP_A
	JSUB	push
	LDA	TMP_L
	JSUB	push
	LDA	TMP_A
	MUL	#2
	ADD	#1
	JSUB	LLOOP
	
	
	JSUB	pop
	STA	TMP_L
	JSUB	pop
	
	STA	TMP_A
	
	JSUB	push
	LDA	TMP_L
	JSUB	push
	LDA	TMP_A
	MUL	#2
	ADD	#2
	JSUB	LLOOP

	JSUB	pop
	STA	TMP_L
	JSUB	pop

	LDL	TMP_L
	
	LDS	#Tree
	MUL	#3
	ADDR	A,S
	STS	TMP_S
	LDA	@TMP_S
	COMP	#0
	JEQ	EXIT
PRLIST	TD	OUTDEV
	JEQ	PRLIST
	WD	OUTDEV
	LDCH	NEWLINE
	WD	OUTDEV
	CLEAR	A
	RSUB
		
DELETE	LDA	#0	.DELETE OPERATION
	STA	CHK
	STA	TMP_CHK
	JSUB	DELNODE
	LDA	CHK
	COMP	#0
	JEQ	NO
	J	LOOP
DELNODE	STA	DELIDX
	COMP	MAXIDX
	JGT	EXIT
	LDS	#Tree
	MUL	#3	. DELIDX*3
	ADDR	A,S
	STS	TMP_S
	LDA	@TMP_S
	COMP	#0
	JEQ	EXIT
	COMP	DATA
	JEQ	DNFIND
	LDA	TMP_CHK
	COMP	#1
	JEQ	DNFIND
	J	STKDEL
DNFIND	LDA	#0
	STA	@TMP_S
	LDA	#1
	STA	CHK
	STA	TMP_CHK
	LDA	NODE
	SUB	#1
	STA	NODE	
STKDEL	LDA	DELIDX
	STL	TMP_L
	STA	TMP_A
	JSUB	push
	LDA	TMP_CHK
	JSUB	push
	LDA	TMP_L
	JSUB	push
	LDA	TMP_A
	MUL	#2
	ADD	#1
	JSUB	DELNODE
	
	JSUB	pop
	STA	TMP_L
	JSUB	pop
	STA	TMP_CHK
	JSUB	pop
	
	STA	TMP_A
	JSUB	push
	LDA	TMP_CHK
	JSUB	push
	LDA	TMP_L
	JSUB	push
	LDA	TMP_A
	MUL	#2
	ADD	#2
	JSUB	DELNODE
	
	JSUB	pop
	STA	TMP_L
	JSUB	pop
	STA	TMP_CHK
	JSUB	pop
	LDL	TMP_L
	RSUB
			
EXIT	RSUB	
	
	
FIND	LDA	#0
	STA	FCNT
	STA	CHK
	JSUB	FNODE
	LDA	CHK
	COMP	#0
	JEQ	NO
	J	PCNT
FNODE	STA	FIDX
	COMP	MAXIDX
	JGT	EXIT
	LDS	#Tree
	MUL	#3
	ADDR	A,S
	STS	TMP_S
	LDA	@TMP_S
	COMP	#0
	JEQ	EXIT
	
	LDA	FIDX
	STL	TMP_L
	STA	TMP_A
	JSUB 	push
	LDA	TMP_L
	JSUB	push
	LDA	TMP_A
	MUL	#2
	ADD	#1
	JSUB	FNODE
	
	JSUB	pop
	STA	TMP_L
	JSUB	pop
	STA	TMP_A
	
	LDA	FCNT
	ADD	#1
	STA	FCNT
	
	LDA	TMP_A
	LDS	#Tree
	MUL	#3
	ADDR	A,S
	STS	TMP_S
	LDA	@TMP_S
FPRINT	TD	OUTDEV
	JEQ	FPRINT
	WD	OUTDEV
	LDCH	NEWLINE
	WD	OUTDEV		
	
	LDL	TMP_L
	LDA	@TMP_S
	COMP	DATA
	JGT	FN
	JLT	FN
	LDA	#1
	STA	CHK
	JEQ	EXIT
	
FN	LDA	TMP_A
	JSUB	push
	LDA	TMP_L
	JSUB	push
	LDA	TMP_A
	MUL	#2
	ADD	#2
	JSUB	FNODE

	JSUB	pop
	STA	TMP_L
	JSUB	pop
	LDL	TMP_L
	RSUB	



PCNT	LDX	#0
PCLP	TD	OUTDEV
	JEQ	PCLP
	LDA	FCNT
	COMP	#9
	JGT	PRLN
	ADD	#48
	WD	OUTDEV
	LDCH	NEWLINE
	WD	OUTDEV
	J	LOOP
PRLN	LDA	#49
	WD	OUTDEV
	LDA	FCNT
	SUB	#10
	ADD	#48
	WD	OUTDEV
	LDCH	NEWLINE
	WD	OUTDEV
	J	LOOP

NO	LDX	#0
NOLP	TD	OUTDEV
	JEQ	NOLP
	LDCH	NONE,X
	WD	OUTDEV
	TIX	#4
	JLT	NOLP
	LDCH	NEWLINE
	WD	OUTDEV
	J	LOOP

push    STA @stackp
        LDA stackp
        ADD #3
        STA stackp
        RSUB
pop     LDA stackp
        SUB #3
        STA stackp
        LDA @stackp
        RSUB

stackp	RESW	1
CALLSTK	RESW	100

NEWLINE	BYTE	X'0A'


FIDX	WORD	0
FCNT	WORD	0

LSIDX	WORD	0

CHK	WORD	0
DELIDX	WORD	0

TMP_L	RESW	1
TMP_A	RESW	1
TMP_S	RESW	1
TMP_CHK	RESW	1

DATA	RESW	1

INDEV	BYTE	0
OUTDEV	BYTE	1

COMMAND	RESB	8

EOL	WORD	10
CMDLEN	RESW	1

IDX	WORD	0

MAXIDX	WORD	14

FULL	BYTE	C'FULL'
NONE	BYTE	C'NONE'
NODE	WORD	0
Tree	RESW	15
TreeP	RESW	1
