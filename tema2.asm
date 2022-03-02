.data
	a: .long 3
	vec: .space 500
	aux: .space 500
	m: .space 4
	n: .space 4
	c: .space 4
	b: .space 4
	formatScanf: .asciz "%d"
	formatPrintf: .asciz "%d "
	formatEndl: .asciz "\n"
	formatMinus: .asciz "-1"
   
.text

.global main

fct_verif:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %edi
	pushl %edx
	pushl %ecx
	pushl %ebx
	movl 8(%ebp), %edx 
	movl $aux, %esi
	movl $vec, %edi
	    
	movl %edx, %ecx
	subl m, %ecx  

et_parcg1:
	cmp %ecx, %edx
	je et_parcg2
	movl (%esi, %ecx, 4), %ebx
	movl (%esi, %edx, 4), %eax
	cmp %eax, %ebx
	je et_inval 
	incl %ecx
	jmp et_parcg1

et_parcg2:
	movl (%edi, %edx, 4), %eax
	cmp $0, %eax
	je et_parcg3
	movl (%esi, %edx, 4), %ebx
	cmp %eax, %ebx
	je et_parcg3
	jne et_inval
  
et_parcg3:
	movl $1, c
	xorl %ecx, %ecx
  
et_parcg3_loop:
	cmp %ecx, %edx
	je et_parcg4
	movl (%esi, %edx, 4), %ebx
	movl (%esi, %ecx, 4), %eax
	cmp %ebx, %eax
	jne et_sunt_inegale
	je et_sunt_egale
  
et_parcg4:
	movl c, %eax
	cmp $3, %eax
	jg et_inval
	jmp et_val
  
et_sunt_inegale:
	incl %ecx
	jmp et_parcg3_loop  
  
et_sunt_egale:
	incl c
	incl %ecx
	jmp et_parcg3_loop
	
et_inval:
	xorl %eax, %eax
	jmp et_verif_stop
	
et_val:
	movl $1, %eax
  
et_verif_stop:
	popl %ebx
	popl %ecx
	popl %edx
	popl %edi
	popl %esi
	popl %ebp
	ret
  
fct_bck:
	pushl %ebp
	movl %esp, %ebp
	pushl %esi
	pushl %eax
	pushl %ebx
	pushl %ecx
	pushl %edx
	movl $1, %ecx
	movl 8(%ebp), %edx   

	movl $aux, %esi
  
et_rez_loop:
	cmp n, %ecx
	jg et_stop_bck
	movl %ecx, (%esi, %edx, 4)
   
	pushl %edx
	call fct_verif
	popl %edx
	cmp $0, %eax
	je et_cont
	cmp a, %edx
	je et_afis
	movl %edx, %eax
	incl %eax
	pushl %eax
	call fct_bck
	popl %ebx
   
et_cont:
	incl %ecx
	jmp et_rez_loop

et_stop_bck:
	popl %edx
	popl %ecx
	popl %ebx
	popl %eax
	popl %esi
	popl %ebp
	ret

main:
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	  
	pushl $m
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	  
	movl n, %eax
	mull a
	subl $1, %eax
	movl %eax, a
	  
	xorl %ecx, %ecx
	movl $vec, %edi
  
et_citire:
	cmp a, %ecx
	jg et_citire_stop
  
	pushl %ecx
	pushl $b
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popl %ecx
	movl b, %edx
	movl %edx, (%edi, %ecx, 4)
	incl %ecx
	jmp et_citire
  
et_citire_stop:
	pushl $0
	call fct_bck
	popl %ebx
  
	pushl $formatMinus
	call printf
	popl %ebx
	jmp et_exit

et_afis:
	xorl %ecx, %ecx
	movl $aux, %edi
  
et_afis_loop:
	cmp a, %ecx
	jg et_exit
	movl (%edi, %ecx, 4), %eax
	pushl %ecx
	pushl %eax
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	popl %ecx
	  
	incl %ecx
	jmp et_afis_loop
  
et_exit:
	pushl $formatEndl
	call printf
	popl %ebx
	  
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
