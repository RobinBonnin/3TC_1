#include <stdio.h>
#include <math.h>
int isPrime(int n) {
  int i=0,compte=0;
  /*scanf("%d",&n);*/
  for(i=2;i<n;i++) {
    if(n%i==0) {
      /*printf("%d n'est pas premier et est divisible par %d \n",n,i);*/

    }
    else {
      compte=compte+1;
    }
  }
  if(compte==n-2) {
    /* printf("%d est un nombre premier\n",n);*/
    return(1);
  }
  else {
    return(0);
  }
}

int main () {
  int n;
  printf("Donner un entier \n");
  scanf("%d",&n);
  if(isPrime(n)==0) {
    printf("%d n'est pas un nombre premier\n",n);
    }
    else if (isPrime(n)==1) {
      printf("%d est un nombre premier\n",n);
    }
else {
      printf("Tu es nul\n");
    }
}
