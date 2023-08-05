  .globl main

  .section .data
two:     .double 2.0 
argserr: .asciz  "Incorrect number of args.\nUsage: sqrt [radicand] [iterations]\n"
default: .asciz  "Using default of 5 iterations...\n"
format:  .asciz  "sqrt(%.2f) = %.4f\n"

  .section .text

_iterroot_helper:
  endbr64

.L1:
  test %edi, %edi
  je .R
  
  movsd %xmm0, %xmm2
  divsd %xmm1, %xmm2
  addsd %xmm2, %xmm1
  movsd two, %xmm2
  divsd %xmm2, %xmm1
  sub $1, %edi
  jmp .L1

.R:
  movsd  %xmm1, %xmm0
  ret

iterroot:
  endbr64

  movsd %xmm0, %xmm1
  movsd two, %xmm2
  divsd %xmm2, %xmm1
  call _iterroot_helper
  
  ret

main:
  endbr64
  push %rbx

  cmp $2, %edi
  jge .M
  
  mov $argserr, %rdi
  call printf 

  mov $1, %eax
  jmp .E

.M:
  sub $8, %rsp
  mov $5, %ebx
  cmp $3, %edi
  jl .A
  
  mov 16(%rsi), %rdi
  push %rsi
  call atoi
  pop %rsi

  cmp $0, %eax
  jle .A

  mov %eax, %ebx
  jmp .B

.A:
  mov $default, %rdi
  push %rsi
  call printf
  pop %rsi

.B:  
  mov 8(%rsi), %rdi
  push %rsi
  call atof
  pop %rsi

  mov %ebx, %edi
  movsd %xmm0, %xmm3
  call iterroot
  
  movsd %xmm0, %xmm1
  movsd %xmm3, %xmm0
  mov $format, %rdi
  mov $2, %eax
  sub $8, %rsp
  call printf
  add $16, %rsp

  mov $0, %eax

.E:
  pop %rbx
  ret
