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
#define TAILLE 1000



/*int id	;
void fin();
void reveil();
	int main(){
	key_t cle=100;
	int pid, i, *pint, nbelem;
	for (i=0; i<NSIG;i++) {
		signal(i, fin);
if ((id=shmget(cle, TAILLE, 0777|IPC_CREAT))==­1){

	exit(1);

	signal (SIGUSR1, reveil);
pint=(int*)shmat(id, 0, 0);
	nbelem=TAILLE/sizeof(int);}
if ((pid=fork())==0) {
//je suis le fils
for(i=0;i<nbelem;i++){
pause();
printf("lu %d dans case %d\n", pint[i], i);
kill(getppid(), SIGUSR1);
	}
		}
	else{
//je suis le père
for(i=0;i<nbelem;i++){
	pint[i]=i*2;
	printf("pere a écrit %d dans case %d\n", pint[i], i);
	kill(pid, SIGUSR1);
	pause();
	}
		}}
void reveil() {
	signal(SIGUSR1, reveil);
}
void quiterreception(){
	shmdt((char*)pint));              //détachement
	shmctl(id, IPC_RMID, 0);    // destruction du segment
	exit(1);
}
*/
int creermemoire(key_t cle) {
    int idmem;
    int cle=40;
    int TAILLE=200;
    idmem=shmget( key_t cle ,TAILLE,0777|IPC_CREAT);
    return(idmem);
}

int main () {
    int idfile=0;
    int idmem;
    int phrasecodee[64];
	int numero_phrase;
	idmem=creermemoire(60);
	idfile=msgget(idfile,0666);
	numero_phrase=msgrcv(idfile,sizeof(int),0);
	phrasecodee[64]=msgrcv(idfile,sizeof(),0);
	/* Mettre dans mem partagée numero_prase et phrasecodee;*/
	return(0);
}

