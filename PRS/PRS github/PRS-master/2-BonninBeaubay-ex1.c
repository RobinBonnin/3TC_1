#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/select.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <pthread.h>

#define RCVSIZE 1024

//Fonction de création de la socket

void initSocket( int *descSocket ,int port, struct sockaddr_in Socket){

  int valid=1;
  *descSocket= socket(AF_INET, SOCK_DGRAM, 0);
  if (*descSocket< 0) {
    perror("cannot create socket \n");
    exit(1);
  }

  setsockopt(*descSocket, SOL_SOCKET, SO_REUSEADDR, &valid, sizeof(int));

  Socket.sin_family= AF_INET;
  Socket.sin_port= htons(port);
  Socket.sin_addr.s_addr= htonl(INADDR_ANY);

  if (bind(*descSocket, (struct sockaddr*) &Socket, sizeof(Socket)) == -1 ) {
    perror("Bind fail \n");
    close(*descSocket);
    exit(1);
  }


}

//Fonction d'initialisation de connexion

void initConnexion (int descConnect, int portData,struct sockaddr* Client){

  char bufferConnect[RCVSIZE];
  char synack[] ="SYN-ACK";
  sprintf(synack+7,"%4d",portData);
  socklen_t adrsize= sizeof(Client);


  recvfrom(descConnect,bufferConnect,RCVSIZE,0,Client,&adrsize);

  if (strcmp(bufferConnect,"SYN") ==0){
    printf("Réception synchronisation : %s\n", bufferConnect);
    memset(bufferConnect,0,RCVSIZE);
  }
  else{
    exit(1);
  }
  sendto(descConnect,synack,strlen(synack)+1,0,Client,adrsize);
  recvfrom(descConnect,bufferConnect,RCVSIZE,0, Client,&adrsize);

  if (strcmp(bufferConnect,"ACK") ==0){
    printf("Réception acquittement : %s\n", bufferConnect);
    memset(bufferConnect,0,RCVSIZE);

  }
  else{
    exit(1);
  }

}
//Fonction d'ouverture du fichier
FILE* openFich(int descData,struct sockaddr* Client,socklen_t adrsize){

  char bufferInit [RCVSIZE];
  recvfrom(descData,bufferInit,RCVSIZE,0,Client,&adrsize);
  char fichToOpen [RCVSIZE];
  strncpy(fichToOpen,bufferInit,RCVSIZE);

  //phase d'envoi avec acquittement
  FILE* fichier = NULL;
  fichier =fopen(fichToOpen,"rb");

  if(fichier!= NULL){
    printf("Ouverture du fichier avec succès\n");
  }
  else{
    printf("Erreur lors de l'ouverture du fichier\n");
  }
  return fichier;

}


//fonction envoi
int envoi(int descData, int numSeg,FILE* fichier, struct sockaddr* Client,socklen_t adrsize){

  //Envoi normal
  char bufferData [RCVSIZE+6];
  memset(bufferData,0,RCVSIZE+6);
  int sntSize=0;
  char message[RCVSIZE];
  memset(message,0,RCVSIZE);
  char StringSeg[6];
  memset(StringSeg,0,6);
  sprintf(StringSeg, "%06d",numSeg);
  memcpy(bufferData,StringSeg,6);
  //char ack [9]="ACK";
  //strncpy(ack+3,StringSeg,6);
  fseek(fichier,RCVSIZE*(numSeg-1),SEEK_SET);
  sntSize=fread(message,1,RCVSIZE,fichier);
  memcpy(bufferData+6,message,sntSize);
  sendto(descData,bufferData,sntSize+6,0,Client,adrsize);
	  
}
int finFichier(int numSeg,FILE* fichier){
	char message[RCVSIZE];
	fseek(fichier,RCVSIZE*(numSeg-1),SEEK_SET);
	int sentSize=fread(message,1,RCVSIZE,fichier);
	if(sentSize>0){
		return 1;
		
	}else{
		printf(" Envoi Fin du fichier\n");
		return 0;	
	}
	
	
}



int main (int argc, char *argv[]) {

  struct sockaddr_in Connect,Data,Client;
  int descData,descConnect;
  int portData=8080;
  int portConnect;
  int numSeg=1;
  socklen_t adrsize=sizeof(Client);



  //Initialisation du port de connexion

  if(argc ==2){
    portConnect = atoi(argv[1]);
    printf("Le port de Connection est :%d\n",portConnect);
  }
  else {
    printf("Pas le bon nombre d'arguments en entrée\n");
    return 0;
  }
  
  initSocket(&descConnect,portConnect,Connect); 
  initConnexion(descConnect,portData,(struct sockaddr*) &Client);
  //printf("Data %d %d\n", ntohl(Data.sin_addr.s_addr), ntohs(Data.sin_port));
  initSocket(&descData, portData, Data);

  FILE* fichier=openFich(descData,(struct sockaddr*) &Client,adrsize);

  fd_set readset;
  struct timeval tv;
  int val=0;
  int segtmp=0;
  char bufferData[RCVSIZE];
  char segack [6];
  int i=0;

  while(1){

    FD_ZERO(&readset);
    FD_CLR(0, &readset);
    FD_SET(descData, &readset);
	if(finFichier(numSeg,fichier)!=0){
		envoi(descData,numSeg,fichier,(struct sockaddr*) &Client,adrsize);
		numSeg++;
		usleep(6000);
	}else{
		envoi(descData,numSeg,fichier,(struct sockaddr*) &Client,adrsize);
		if(segtmp==numSeg-1){
			memset(bufferData,0,RCVSIZE);
			memcpy(bufferData,"FIN",3);
			sendto(descData,bufferData,sizeof(bufferData),0,(struct sockaddr*) &Client,sizeof(Client));
			exit(1);
		}
	}
	tv.tv_sec=0;
	tv.tv_usec=5000;
    if(select(descData+1, &readset, NULL, NULL,&tv)<0){
      perror("Erreur création select");
    }
    if (FD_ISSET(descData,&readset)) {
      memset(segack,0,6);
      memset(bufferData,0,9);
      recvfrom(descData,bufferData,RCVSIZE,0, (struct sockaddr*) &Client,&adrsize);
      memcpy(segack,bufferData+3,6);
      memset(bufferData,0,RCVSIZE);
      if(segtmp==atoi(segack)){
		  i++;
		  if(i>=2){
			  printf("Numéro message dropped:%d\n",atoi(segack));
			  envoi(descData,segtmp+1,fichier,(struct sockaddr*) &Client,adrsize);
			  i=0;
		  }
      }
      else{
		  segtmp=atoi(segack);
		 
	  }
      
    }
}
}	        
