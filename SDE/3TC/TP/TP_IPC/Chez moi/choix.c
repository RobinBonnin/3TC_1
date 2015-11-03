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

int creersem(key_t cle) { //Créer sémaphore
	int idsem;
	if((idsem=semget(cle,1,0666|IPC_CREAT))==-1){
		printf("erreur ouverture\n");
		return(-1);
	}
	return(idsem);
}

void quitter(){
}

void valeursem(int idsem, int val){ //Insérer valeur dans sémaphore
	if((semctl(idsem,0,SETVAL,val))==-1){
		printf("erreur init\n");
		exit(1);
	}
}

int getvalsem(int idsem){ //Récupérer valeur de sémaphore
	int valeurphrase=0;
	if((semctl(idsem,0,GETVAL))==-1){
		valeurphrase=printf("erreur init\n");
		exit(1);
		return(-1);
	}
	else
		return(semctl(idsem,0,GETVAL));
}
int creerfile (key_t cle) { //Création de la file de message
    int id;
	struct msgbuf{ long mtype; char mtext[10]}	message;
	int pid=getpid();
	signal(SIGUSR1,quitter);
	if(id=msgget(cle,0666|IPC_CREAT)==-1){
			exit(1);
			}
			return(id);
}

int main (){
	int idsem, idsemchoix, idsemcode, numero_phrase, lettre_code, idfile;
	srand(time(NULL));
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
	printf("\n%c\n",lettre_code);
	down(idsemchoix);
	printf("%d\n",numero_phrase);
	idfile=msgget(40,0666);
	msgsnd(idfile,&numero_phrase,sizeof(int),0);
	msgsnd();
	//envoyerfile(numero_phrase,lettre_code);
	return(0);
}
