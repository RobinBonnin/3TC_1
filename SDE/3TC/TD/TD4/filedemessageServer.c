#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/msg.h>
int id;

int main (){
	int key=123;
	int id=msgget(key,0666|IPC_CREAT);
	if(id==-1){
		perror("Message queue creation error");
		exit(EXIT_FAILURE);
	}
	int note=0;
	struct msgbuf{long mtype; char mtext[10];} 
	message;
	message.mtype=1;
	while(note>=0){
		if(!scanf("%d",&note))
		note=-1;
		sprintf(message.mtext,"%d",note);
		msgsnd(id,&message,10,0);
	}
	msgctl(id,IPC_RMID,NULL);
	exit(EXIT_SUCCESS);
}
