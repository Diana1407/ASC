.data
	sir: .space 101
	formatScanf: .asciz "%300[^\n]"
	delim: .asciz " "
	res: .space 4
	formatPrintf: .asciz "%d\n"
.text

.global main

//2 10 mul 5 div 7 6 sub add
main:
	pushl $sir
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $delim
	pushl $sir
	call strtok 
	popl %ebx
	popl %ebx
	
	push %eax
	call atoi
	pop %ebx
	push %eax
	
et_for:
	pushl $delim
	pushl $0
	call strtok
	popl %ebx
	popl %ebx 
	
	cmp $0, %eax
	je et_exit
	
	movl %eax, res
	mov res, %esi
	push res
	call atoi
	pop %ebx
	cmp $0, %eax 
	je et_operatie
	jmp et_numar
	
et_numar:
	push res
	call atoi
	pop %ebx
	push %eax
	jmp et_for
	
et_operatie:
	xorl %ecx, %ecx
	movl res, %esi
	movb (%esi, %ecx, 1), %al
	//a-97 d-100 s-115 m-109
	cmp $97, %al
	je et_add
	
	cmp $100, %al
	je et_div
	
	cmp $109, %al
	je et_mul
	
	cmp $115, %al
	je et_sub
	
et_add:
	pop %eax
	pop %ebx
	add %eax, %ebx
	pushl %ebx
	jmp et_for
		
et_div:
	pop %ebx
	pop %eax
	xorl %edx, %edx
	div %ebx
	pushl %eax
	jmp et_for
	
et_mul:
	pop %eax
	pop %ebx
	xorl %edx, %edx
	mul %ebx 
	pushl %eax
	jmp et_for
	
et_sub:
	pop %eax
	pop %ebx
	sub %eax, %ebx
	push %ebx
	jmp et_for

et_exit:
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80

