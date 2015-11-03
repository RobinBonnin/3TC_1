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
#include "semaphore.h"
#define TAILLE 100
int creermemoire(key_t cle) {
	int idmem;
	cle=40;
	idmem=shmget(cle ,TAILLE,0777|IPC_CREAT);
	return(idmem);
}

int creersem(key_t cle) { //Créatoin sémaphore
	int idsem;
	if((idsem=semget(cle,1,0666|IPC_CREAT))==-1){
		printf("erreur ouverture\n");
		return(-1);
	}
	return(idsem);
}

void valeursem(int idsem, int val){ //Mettre dans un semaphore la valeur souhaitée
	if((semctl(idsem,0,SETVAL,val))==-1){
		printf("erreur init\n");
		exit(1);
	}
}

void finfile(int id){ //Suppression file de message
	if(msgctl(id,IPC_RMID,NULL)==-1){
		printf("erreur suppression\n");
	}
	exit(0);
}

void finsem(int id){
	if(semctl(id, IPC_RMID, NULL)==-1){
		printf("Erreur fermeture\n");
	}
	exit(0);
}

int main () {
	int idfile=0;
	int idmem=0;
	int idsemrec=0;
	int idsemcode=0;
	char phrasecodee[64];
	char numero_phrase[100];
	idsemrec=creersem(23);
	idmem=creermemoire(60);
	valeursem(idsemrec,0);
	down(idsemrec);
  	idfile=msgget(40,0666);
	idsemcode=semget(22,1,0666);
	if(msgrcv(idfile,&message,200,2,0)==-1){ //Réception message type 2 : numero_phrase
		printf("Erreur réception type 2");
	}
	strcpy(numero_phrase,message.mtext);
	printf("%s\n", numero_phrase);
	if(msgrcv(idfile,&message,200,1,0)==-1){ //Réception message type 1 : phrasecodee
		printf("Erreur réception type 1\n");
	}
	strcpy(phrasecodee,message.mtext);
	printf("%s",phrasecodee);
	up(idsemcode);
	//Mettre dans mem partagée numero_prase et phrasecodee;
	finsem(idsemrec);
	return(0);
}

