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
#define TAILLE 100

int creersem(key_t cle) { //Créatoin sémaphore
	int idsem;
	if((idsem=semget(cle,1,0666|IPC_CREAT))==-1){
		printf("erreur ouverture\n");
		return(-1);
	}
	return(idsem);
}


int main (){
	int idfile=0;
	int idsemdecode;
	char numero_phrase[10];
	char lettre_code[10];
	int idmem;
	idsemdecode=creersem(24);
	down(idsemdecode);
	idfile=msgget(40,0666);
	if(msgrcv(idfile,&message,200,4,0)==-1){ //Réception du message de type 4 : numero_phrase
		printf("Erreur reception\n");
	}
	strcpy(numero_phrase,message.mtext);
	printf("%s\n",numero_phrase);
	if(msgrcv(idfile,&message,200,3,0)==-1){// Réception du message de type 3 : lettre_code
		printf("erreur réception\n");
	}
	strcpy(lettre_code,message.mtext); 
	printf("%c\n",lettre_code);
	idmem=shmget(60,TAILLE,0777);
	/* Prendre valeur numéro phrase et comparer
	if numero_phrase = numero_phrase_reception
		lettre=lettre_code+phrase[i]-(int)'a';
		mettre dans fichier : Secret defense;*/

	return(0);
}
