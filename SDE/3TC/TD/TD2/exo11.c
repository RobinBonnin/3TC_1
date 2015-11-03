#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
void message ();
int main() {
  int pid;
  pid=fork();
  if(pid==0){
    //on est dans le fils
    sleep(5);
    kill(getppid(),SIGUSR1);
    sleep(10);
  }
  else if (pid>0){
    //on est dans le père
    signal(SIGUSR1,message);
    pause();
    kill(pid,SIGKILL);
    printf("Luke, I kill you.\n");
  }
  else{ 
      perror("Création de processus\n");
  }
  return 0;
}

void message() {
}

  
