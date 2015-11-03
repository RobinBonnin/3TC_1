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

void quitter_tube(){ //Fermer le tube nommé
	close(descripteur);
}

void finfile(){ //Suppression file de message
  int id;
	msgctl(id,IPC_RMID,NULL);
	exit(0);
}

int numerophrase (){ // Génération du numéro aléatoire de la phrase
	int numero_phrase;
	srand(time(NULL));
	numero_phrase=rand()%250;
	return(numero_phrase);
}

int creerfile (key_t cle) { //Création de la file de message
    int id;
	struct msgbuf{ long mtype; char mtext[10]}	message;
	int pid=getpid();
	signal(SIGUSR1,finfile);
	if(id=msgget(cle,0666|IPC_CREAT)==-1){
			exit(1);
			}
			return(id);
}

int getvalsem(int idsem){ //Récupérer valeur sémaphore
	int valeurphrase=0;
	if((semctl(idsem,0,GETVAL))==-1){
		valeurphrase=printf("erreur init\n");
		exit(1);
		}
	else
		return(semctl(idsem,0,GETVAL));
}

int main (){

	char phrase[64];int i; char lettre_code=NULL;int numero_phrase; int idsem; int idsemcode; int idsemchoix; int idfile=0;
	idfile=creerfile(40);
	descripteur=open("saisie_code",O_RDONLY); //Ouverture du tube nommé en lecture
	read(descripteur,&phrase,65*sizeof(char)); //On récupère la phrase
	printf("%s",phrase);
	printf("\n");
	quitter_tube();
	idsem=creersem(20); //Sémaphore de communication
	idsemcode=creersem(22); //Sémaphore de syncronisaton pour code
	valeursem(idsemcode,0);
	numero_phrase=numerophrase();
	valeursem(idsem,numero_phrase);
	idsemchoix=semget(21,1,0666); //Sémaphore de syncronisation pour choix
	printf("avant down\n");
	up(idsemchoix);
	down(idsemcode);
	lettre_code=getvalsem(idsem);
	printf("%c %d\n",lettre_code, numero_phrase);
	sleep(1);
	for(i=0;i<strlen(phrase)-1;i++){
		phrase[i]=(int)phrase[i]+(int)lettre_code-(int)'a';
		printf("%c",phrase[i]);
	}
	msgsnd(idfile,numero_phrase,sizeof(int),0);
	msgsnd(idfile,phrase,strlen(phrase),0);
	up(idsemchoix);
    return(0);

}





