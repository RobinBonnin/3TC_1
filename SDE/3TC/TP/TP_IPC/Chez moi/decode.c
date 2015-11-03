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


int main (){
    //down(decode)
	int idfile=0;
	int numero_phrase;
	int lettre_code;
  int idmem;
	idfile=msgget(40,0666);
	numero_phrase=msgrcv(idfile,sizeof(int),0,0777);
	lettre_code=msgrcv(idfile,sizeof(int),0,0777);
	idmem=shmget(60,TAILLE,0777);
	/* Prendre valeur numéro phrase et comparer
	if numero_phrase = numero_phrase_reception
        lettre=lettre_code+phrase[i]-(int)'a';
        mettre dans fichier;*/

	return(0);
}
