  .section .data
format: .asciz "The sum of your numbers is %d.\n"

  .section .text

  .global main

_sumRec:
  endbr64
  sub $8, %rsp
  push %r12
  push %r13
  push %r14
  
  mov $0, %r14d
  test %rdi, %rdi
  je .R
  
  /* put the start of the array into %r12 */
  mov %rsi, %r12

  /* put the end of the array into %r13 */
  lea (%rsi, %rdi, 8), %r13

.L:
  movq (%r12), %rdi
  call atoi

  add %eax, %r14d
  add $8, %r12
  cmp %r12, %r13
  jne .L
  jmp .R

.R:
  mov %r14d, %eax
  pop %r14
  pop %r13
  pop %r12
  add $8, %rsp
  ret

main:
  endbr64
  sub $8, %rsp

  sub $1, %rdi
  add $8, %rsi
  call _sumRec

  mov $format, %rdi
  mov %eax, %esi
  call printf

  mov $0, %eax
  add $8, %rsp
  ret
