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

#define RCVSIZE 1400

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
  if(sntSize!=0){
    sendto(descData,bufferData,sntSize+6,0,Client,adrsize);
  }
  return sntSize;

}
// fonction pour detection fin de fichier
int finFichier(int numSeg,FILE* fichier){

  char message[RCVSIZE];
  fseek(fichier,RCVSIZE*(numSeg-1),SEEK_SET);
  int sentSize=fread(message,1,RCVSIZE,fichier);
  if(sentSize>0){
    return 1;

  }else{
    return 0;	
  }


}



int main (int argc, char *argv[]) {

  struct sockaddr_in Connect,Data,Client;
  int descData,descConnect;
  int portData=8080;
  int portConnect;
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
  //struct timeval tmpEnvoi;
  //struct timeval tmpRecep;
  struct timeval RTT;
  RTT.tv_sec=0;
  RTT.tv_usec=5000;




  char bufferData[RCVSIZE];
  char segack [6];
  int cwnd=70;
  int numSeg=1;
  int segtmp=1;
  int numsegFin=-1;
  int segAttendu=0;
  int segRecep=0;
  int repeatACK=0;
  int taille=0;
  int j=0;
  


  while(1){
    usleep(4000);
    FD_ZERO(&readset);
    FD_CLR(0, &readset);
    FD_SET(descData, &readset);

    if(segRecep==segAttendu){

      //taille=envoi(descData,numSeg,fichier,(struct sockaddr*) &Client,adrsize);
      //gettimeofday (&tmpEnvoi, NULL);
      //j=1;

      for(j=0;j<cwnd;j++){

        taille=envoi(descData,numSeg,fichier,(struct sockaddr*) &Client,adrsize);
	usleep(1000);

        if(taille!=0){
          numSeg++; 
        }
        else{
          numsegFin=numSeg;
        }

      } 

      segAttendu+=cwnd;
    }

    if(segRecep+1==numsegFin){

      memset(bufferData,0,RCVSIZE);
      memcpy(bufferData,"FIN",3);
      sendto(descData,bufferData,RCVSIZE,0,(struct sockaddr*) &Client,sizeof(Client));
      printf("C'est la fin\n");
      exit(1);

    } 
       
    RTT.tv_sec=0;
    RTT.tv_usec=4000;


    if(select(descData+1, &readset, NULL, NULL,&RTT)<0){

      perror("Erreur création select\n");

    } 

    if (FD_ISSET(descData, &readset)) {

      memset(segack,0,6);
      memset(bufferData,0,RCVSIZE);
      recvfrom(descData,bufferData,RCVSIZE,0, (struct sockaddr*) &Client,&adrsize);


      //if(j==1){
      //gettimeofday(&tmpRecep, NULL);
      //timersub(&tmpRecep,&tmpEnvoi,&RTT);
      //printf("Voici la valeur du RTT:%ld\n",RTT.tv_usec);
      //j++
      //}

      memcpy(segack,bufferData+3,6);
      memset(bufferData,0,RCVSIZE);
      segtmp=atoi(segack);

      if(segtmp>segRecep){
        //cwnd++;
        //printf("Voici la nouvelle valeur de cwnd:%d\n",cwnd);
        segRecep=segtmp;
        //printf("Voici la valeur segRecep:%d\n",segRecep);
      }
      if(segtmp==segRecep){
        repeatACK++;
   
        
        if(repeatACK>1){
          printf("message dropped:%d\n",segRecep);
         
			   
          envoi(descData,segRecep+1,fichier,(struct sockaddr*) &Client,adrsize);  
          repeatACK=0;
          
        }
      }

    }


    else{
      //printf("Numéro message dropped:%d\n",segRecep+1);
      envoi(descData,segRecep+1,fichier,(struct sockaddr*) &Client,adrsize);

    }







  }
}	        
