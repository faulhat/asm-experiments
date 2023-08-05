.text

.global sumRec

sumRec:
  endbr64
  
  test %esi, %esi
  je .L2
  
  lea (%rdi, %rsi, 4), %rsi
  
.L1:
  add (%rdi), %edx
  add $4, %rdi
  cmp %rdi, %rsi
  jne .L1

.L2:
  mov %edx, %eax
  ret
