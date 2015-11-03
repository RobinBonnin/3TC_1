#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#define effacer "saisie_code"


int descripteur;
void quitter_tube () {
	close(descripteur);
	remove(effacer);
	exit(1);
 }

 int main (int argc, char *argv[]) {
	char phrase[64];
	if(mkfifo("saisie_code",0666)!=0){
		fprintf(stderr, "Err: creation tube nomme\n");
		return 0;
	}
		signal(SIGINT,quitter_tube);
		printf("tube créé\n");
		descripteur=open("saisie_code", O_WRONLY); //Ouverture du tube nommé en écriture
		if (descripteur ==-1) {
			fprintf(stderr,"Err: ouverture tube \n");
			return 0;
		}
		fgets(phrase,64,stdin);
		write(descripteur,&phrase,65*sizeof(char));
		quitter_tube();

		return(0);
	}


