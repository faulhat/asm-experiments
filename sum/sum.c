#include <stdio.h>

extern int sumRec(int *a, unsigned l, int acc);

int main() {
  int a[] = {1, 1, 2, 3, 5};
  printf("%d\n", sumRec(a, 5, 0));

  return 0;
}
