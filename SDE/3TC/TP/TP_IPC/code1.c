#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/sem.h>
#include <time.h>
#include "semaphore.h"

int descripteur; int id;

int creersem(key_t cle) {
	int idsem;
	if((idsem=semget(cle,1,0666|IPC_CREAT))==-1){
		printf("erreur ouverture\n");
		return(-1);
	}
	return(idsem);
}

void valeursem(int idsem, int val){
	if((semctl(idsem,0,SETVAL,val))==-1){
		printf("erreur init\n");
		exit(1);
	}
}

void quitter_tube(){
	close(descripteur);
}

void fin(){ 
	msgctl(id,IPC_RMID,NULL); 
	exit(0);
}

int numerophrase (){
	int numero_phrase;
	srand(time(NULL));
	numero_phrase=rand()%250;
	return(numero_phrase);
}

void creerfile () {
	key_t cle=40;
	struct msgbuf{ long mtype; char mtext[10]}	message;
	int pid=getpid();
	signal(SIGUSR1,fin);
	if(id=msgget(cle,0666|IPC_CREAT)==-1){
			exit(1);
			msgsnd(id,&message,sizeof(message.mtext),0);
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

int main (){
	creerfile();
	char phrase[64]; int i; char lettre_code=NULL;int numero_phrase; int idsem; int idsemcode; int idsemchoix;
	descripteur=open("saisie_code",O_RDONLY);
	read(descripteur,&phrase,65*sizeof(char));
	printf("%s",phrase);
	sleep(1);
	for(i=0;i<strlen(phrase)-1;i++){
		phrase[i]=(int)phrase[i]+(int)lettre_code-(int)'a';
		printf("%c",phrase[i]);
	}
	printf("\n");	
	quitter_tube();
	idsem=creersem(20);
	idsemcode=creersem(22);
	valeursem(idsemcode,0);
	numero_phrase=numerophrase();
	valeursem(idsem,numero_phrase);
	idsemchoix=semget(21,1,0666);
	up(idsemchoix);
	down(getvalsem(idsemcode));
	lettre_code=getvalsem(idsem);
	printf("%c",lettre_code);
	
	return(0);
	
}


	
	

