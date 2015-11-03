#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void message();
int main () {
  signal(SIGINT,message);
  pause();

	 }

  void message(){
    fprintf(stdout,"\nBla\n");
  }
