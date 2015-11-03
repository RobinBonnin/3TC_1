#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <time.h>

int attacherfile(){
	key_t cle=40; int id; struct msgbuf {long mtype; char mtext[10]}
	message;
	int pid=getpid();
	if((id=msgget(cle,0666))==-1) exit(1);
	message.mtype=1;
	sprintf(message.mtext,"%d",pid);
	msgsnd(id,&message,sizeof(message.mtext),0);
	msgrcv(id,&message,100,pid,0);
	printf("client reçu message %s de type %d \n",message.mtext,message.mtype);
}

int main (){
	
	
	return(0);
}
