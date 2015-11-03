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
#include "semaphore.h"

int creersem(key_t cle) {
	int idsem;
	if((idsem=semget(cle,1,0666|IPC_CREAT))==-1){
		printf("erreur ouverture\n");
		return(-1);
	}
	return(idsem);
}

void quitter(){
}

void valeursem(int idsem, int val){
	if((semctl(idsem,0,SETVAL,val))==-1){
		printf("erreur init\n");
		exit(1);
	}
}

int getvalsem(int idsem){
	int valeurphrase=0;
	if((semctl(idsem,0,GETVAL))==-1){
		valeurphrase=printf("erreur init\n");
		exit(1);
		return(-1);
	}
	else
		return(valeurphrase);
}

int attacherfile (){
	key_t cle=40; int id; struct msgbuf {long mtype; char mtext[10]}
	message;
	int pid=getpid();
	
	if((id=msgget(cle,0666))==-1) exit(1);
	message.mtype=1;
	sprintf(message.mtext,"%d",pid);
	msgsnd(id,&message,sizeof(message.mtext),0);
	msgrcv(id,&message,100,pid,0);
	printf("client reçu message %s de type %d \n",message.mtext,message.mtype);
	return(0);
}
int main (){
	int idsem, idsemchoix, idsemcode, numero_phrase, lettre_code;
	//srand(time(NULL));
	signal(SIGINT, quitter);
	idsemchoix=creersem(21);
	valeursem(idsemchoix,0);
	
	printf("avant down");
	
	down(idsemchoix);
	idsem=semget(20,1,0666);
	idsemcode=semget(22,1,0666);
	numero_phrase=getvalsem(idsem);
	lettre_code=(rand()%123) +65;
	valeursem(idsem,(int)lettre_code);
	up(idsemcode);
	down(idsemchoix);	
	printf("%c\n",lettre_code);
	return(0);
}	
