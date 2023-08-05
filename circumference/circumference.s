  .global main

  .section .data
format: .asciz  "circumference of circle with radius 10: %.2f.\n"
pi:     .double 3.1415926535
ten:    .double 10.0

.section .text

circumference:
  movsd pi, %xmm1
  mulsd %xmm1, %xmm0
  ret

main:
  sub $8, %rsp

  movsd ten, %xmm0
  call circumference
 
  mov $format, %rdi 
  call printf

  add $8, %rsp
  mov $0, %rax
  ret
