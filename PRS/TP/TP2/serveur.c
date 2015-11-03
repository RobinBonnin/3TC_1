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

  struct sockaddr_in adresse1, adresse2, client;
  int valid= 1;
  int port1;
  int port2;
  socklen_t alen;
  char buffer[RCVSIZE];


  if(argc == 3 ) {
    port1 = atoi(argv[1]);
    port2 = atoi(argv[2]);
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

  adresse1.sin_family= AF_INET;
  adresse1.sin_port= htons(port1);
  adresse1.sin_addr.s_addr= htonl(INADDR_ANY);

  adresse2.sin_family= AF_INET;
  adresse2.sin_port= htons(port2);
  adresse2.sin_addr.s_addr= htonl(INADDR_ANY);

  if (bind(desc1, (struct sockaddr*) &adresse1, sizeof(adresse1)) == -1 || bind(desc2, (struct sockaddr*) &adresse2, sizeof(adresse2))) {
    perror("Bind fail\n");
    close(desc1);
    close(desc2);
    return -1;
  }


  if (listen(desc1, 5) < 0) {
    printf("Listen1 failed\n");
    return -1;
  }

  fd_set tabdesc;
  
  while (1){
	  
	  FD_ZERO(&tabdesc);
	  FD_SET(desc1, &tabdesc);
	  FD_SET(desc2, &tabdesc);
	  select(6,&tabdesc,NULL, NULL, NULL);
	  if(FD_ISSET(desc1, &tabdesc)){
		  	  
		int rqst= accept(desc1, (struct sockaddr*)&client, &alen);
		printf("Accept : %d\n", rqst);
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
		else if(FD_ISSET(desc2, &tabdesc)){
			int rqst= accept(desc2, (struct sockaddr*)&client, &alen);
		printf("Accept : %d\n", rqst);
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
	  else{
			printf("Bit pas activé\n");
			return 0;
		}	
	
  close(desc1);
  close(desc2);
  return 0;
}
}


