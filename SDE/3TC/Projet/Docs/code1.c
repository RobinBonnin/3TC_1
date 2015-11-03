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

int descripteur;

int creersem(key_t cle) { //Cr�atoin s�maphore
	int idsem;
	if((idsem=semget(cle,1,0666|IPC_CREAT))==-1){
		printf("erreur ouverture\n");
		return(-1);
	}
	return(idsem);
}

void valeursem(int idsem, int val){ //Mettre dans un semaphore la valeur souhait�e
	if((semctl(idsem,0,SETVAL,val))==-1){
		printf("erreur initkfr\n");
		exit(1);
	}
}

void quitter_tube(){ //Fermer le tube nomm�
	close(descripteur);
}

void finfile(){ //Suppression file de message
	int id;
	msgctl(id,IPC_RMID,NULL);
	exit(0);
}



int numerophrase (){ // G�n�ration du num�ro al�atoire de la phrase
	int numero_phrase;
	srand(time(NULL));
	numero_phrase=rand()%250;
	return(numero_phrase);
}

int creerfile (key_t cle) { //Cr�ation de la file de message
	int id;
	signal(SIGUSR1,finfile);
	if(id=msgget(cle,0666|IPC_CREAT)==-1){
		printf("erreur\n");
		exit(1);
	}
	return(id);
}

int getvalsem(int idsem){ //R�cup�rer valeur s�maphore
	int valeurphrase=0;
	if((semctl(idsem,0,GETVAL))==-1){
		valeurphrase=printf("erreur init\n");
		exit(1);
	}
	else
	return(semctl(idsem,0,GETVAL));
}

void finsem(int id){
	if(semctl(id, IPC_RMID, NULL)==-1){
		printf("Erreur fermeture\n");
	}
	exit(0);
}

int main (){

	struct msgbuf{ long mtype; char mtext[100];}message;
	char phrase[64];
	int i=0;
	char lettre_code=NULL;
	int numero_phrase=0;
	int idsem=0;
	int idsemcode=0;
	int idsemchoix=0;
	int idfile=0;
	int idsemrec=0;
	creerfile(40);
	idfile=msgget(40,0666); //On r�cup�re l'identifiant de la file
	descripteur=open("saisie_code",O_RDONLY); //Ouverture du tube nomm� en lecture
	read(descripteur,&phrase,65*sizeof(char)); //On r�cup�re la phrase
	printf("%s",phrase);
	printf("\n");
	quitter_tube();
	idsemrec=semget(23,1,0666);
	idsem=creersem(20); //S�maphore de communication
	idsemcode=creersem(22); //S�maphore de syncronisaton pour code
	valeursem(idsemcode,0);
	numero_phrase=numerophrase();
	valeursem(idsem,numero_phrase); //On met numero_phrase dans le s�maphore
	idsemchoix=semget(21,1,0666); //S�maphore de syncronisation pour choix
	up(idsemchoix);
	down(idsemcode);
	lettre_code=getvalsem(idsem);
	sleep(1);
	for(i=0;i<strlen(phrase)-1;i++){
		phrase[i]=((int)phrase[i]+(int)lettre_code)%60+65;
		printf("%c",phrase[i]);
	}
	printf("\n %c %d\n",lettre_code,numero_phrase);


	message.mtype=1;
	strcpy(message.mtext,phrase);
	if(msgsnd(idfile,&message,200,0)==-1){ //Envoi du message de type 1 : phrase
		printf("erreur");
	}
	message.mtype=2;
	sprintf(phrase,"%d\0",numero_phrase); 
	strcpy(message.mtext,phrase);
	msgsnd(idfile,&message,200,0); //Envoi du message de type 2 : numero_phrase
	up(idsemrec);
	up(idsemchoix);
	down(idsemcode);
	finsem(idsemcode);
	finsem(idsem);
	finfile(idfile);
	return(0);

}





