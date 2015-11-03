#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <sys/select.h>
#include <sys/time.h>

#define RCVSIZE 1024

int main (int argc, char *argv[]) {

  struct sockaddr_in adresse, client;
  int valid= 1;
  int port1;
  int port2;
  socklen_t alen;
  char buffer[RCVSIZE];
  fd_set* tabdesc;
  FD_ZERO(tabdesc);
  
  if(argc == 2 ) {
	  port1 = atoi(argv[1]);
	  printf("Le port est :%d\n",port1);
  }
  else {
	  printf("Pas le bon nombre d'arguments en entrée\n");
	  return 0;
  }

  //create socket
  int desc1= socket(AF_INET, SOCK_STREAM, 0);
  int desc2= socket(AF_INET, SOCK_DGRAM, 0);

  // handle error
  if (desc1 < 0 || desc2 < 0) {
    perror("cannot create socket\n");
    return -1;
  }

  setsockopt(desc1, SOL_SOCKET, SO_REUSEADDR, &valid, sizeof(int));
  setsockopt(desc2, SOL_SOCKET, SO_REUSEADDR, &valid, sizeof(int));

  adresse.sin_family= AF_INET;
  adresse.sin_port= htons(port1);
  adresse.sin_addr.s_addr= htonl(INADDR_ANY);

  if (bind(desc1, (struct sockaddr*) &adresse, sizeof(adresse)) == -1) {
    perror("Bind fail\n");
    close(desc1);
    return -1;
  }


  if (listen(desc1, 5) < 0) {
    printf("Listen failed\n");
    return -1;
  }
  
  while (1) {

    int rqst= accept(desc1, (struct sockaddr*)&client, &alen);
    int pid = fork();
    if(pid == 0){
		printf("La socket en attente de connection : %d --- La socket créee par accept :  %d\n",desc, rqst);
		printf("Le port du fils est : %d\n", adresse.sin_port);
		close(desc1);

		int msgSize= recv(rqst,buffer,RCVSIZE,0);

		while (msgSize > 0) {
			send(rqst,buffer,msgSize,0);
			printf("%s",buffer);
			memset(buffer,0,RCVSIZE);
			msgSize= recv(rqst,buffer,RCVSIZE,0);
			}
			close(rqst);
			exit(0);
		}
		else {
		printf("La valeur du pid : %d\n",pid);
		close(rqst);
	}
}
close(desc);
return 0;
}
