//Baza 16 - Baza 2
//0 - 0000
//1 - 0001
//2 - 0010
//3 - 0011
//4 - 0100
//5 - 0101
//6 - 0110
//7 - 0111
//8 - 1000
//9 - 1001
//A - 1010
//B - 1011
//C - 1100
//D - 1101
//E - 1110
//F - 1111
// in codul ASCII, caracterul 0 are codul 48 
// 1 are codul 49 ...
// A are codul 65 ...
// a are codul 97 ...

// A78801C00A7890EC04
.data
	sirb16: .space 101
	formatScanf: .asciz "%s"
	printintregpoz: .asciz "%d "
	printintregneg: .asciz "-%d "
	printcarac: .asciz "%s "
	let: .asciz "let "
	add: .asciz "add "
	sub: .asciz "sub "
	mul: .asciz "mul "
	div: .asciz "div "
	rez: .space 4
	lit: .asciz "z"
	final: .asciz "\n"
	x: .long 16
	
.text

.global main

main:
	// scanf("%s", &sirb16)
	pushl $sirb16
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	movl $sirb16, %esi 
	xorl %ecx, %ecx
	
et_parcg:
	xorl %eax, %eax
	movb (%esi, %ecx, 1), %al
	cmp $0, %al
	je et_exit
	
	movl %eax, rez
	incl %ecx
	movb (%esi, %ecx, 1), %al
	cmp $58, %al
	jg et_lit
	jl et_cif
et_cont:
	movl $0, %ebx
	incl %ecx
	movb (%esi, %ecx, 1), %bl
	cmp $58, %bl
	jg et_lit2
	jl et_cif2
	
et_lit:
	subb $55, %al
	mull x
	jmp et_cont

et_cif:
	subb $48, %al
	mull x
	jmp et_cont


et_lit2:
	subb $55, %bl
	addb %al, %bl
	jmp et_cont2

et_cif2:
	subb $48, %bl
	addb %al, %bl
	jmp et_cont2

et_cont2:	
	//incl %ecx
	//movb (%edi, %ecx, 1), %al
	movl rez, %edx
	cmp $56, %edx
	je et_poz
	cmp $57, %edx
	je et_neg
	cmp $65, %edx
	je et_var
	cmp $67, %edx
	je et_operatie

et_poz:
	pushl %ecx
	pushl %ebx
	pushl $printintregpoz
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg

et_neg:
	pushl %ecx
	pushl %ebx
	pushl $printintregneg
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg
	
et_var:
	movl $lit, %edi
	pushl %ecx
	xorl %ecx, %ecx
	movb %bl, (%edi, %ecx, 1)
	pushl $lit
	pushl $printcarac
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg

et_operatie:
	cmp $0, %ebx
	je et_let
	
	cmp $1, %ebx
	je et_add
	
	cmp $2, %ebx
	je et_sub
	
	cmp $3, %ebx
	je et_mul
	
	cmp $4, %ebx
	je et_div
	
et_let:
	pushl %ecx
	pushl $let
	call printf
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg
	
et_add:
	pushl %ecx
	pushl $add
	call printf
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg
	
et_sub:
	pushl %ecx
	pushl $sub
	call printf
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg
	
et_mul:
	pushl %ecx
	pushl $mul
	call printf
	popl %ebx
	popl %ecx
	incl %ecx	
	jmp et_parcg
	
et_div:
	pushl %ecx
	pushl $div
	call printf
	popl %ebx
	popl %ecx
	incl %ecx
	jmp et_parcg
	
et_exit:
	pushl $final
	call printf
	popl %ebx
	 
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80 
	
	
	
	
	
	
	
	
	
	
	
	
