#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int main(){	
	int s;
	s = socket(AF_INET, SOCK_STREAM, 0);
	if(s < 0 ) {
		fprintf(stderr,"Erreur dans la création de la socket\n");
		return s;
	}
	else {
		
		printf("La socket a bien été créee, son descripeur : %d\n", s);
	}
	int reuse=1;
	
	setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(reuse));
	
	struct sockaddr_in my_addr;
	memset((char*)&my_addr,0,sizeof(my_addr)); // Structure adresse serveur
	
	
	
	
	my_addr.sin_family = AF_INET; // Initialisation du domaine 	
	my_addr.sin_port = htons(8080);  // Initialisation du port
	my_addr.sin_addr.s_addr=htonl(INADDR_ANY); // On initialise l'adresse IP du serveur
	
	
	
	int b = bind(s,(struct sockaddr*)(&my_addr),sizeof(my_addr));
	printf("Valeur bind:%d\n",b);
	listen(s, 5); // En attente de connection
	
	struct sockaddr_in client_addr;
	int size = sizeof(client_addr);
	char buffer[64];
	while(1){
		
		int addr_rep = accept(s,(struct sockaddr*)(&client_addr),&size);
		printf("Valeur accept : %d\n", addr_rep);
		printf("Numéro de port : %d\n", client_addr.sin_port);
		printf("Adresse Client : %x\n", client_addr.sin_addr.s_addr);
		
		while(1){
			
			int n= read(addr_rep,buffer,sizeof(buffer));
			
			fputs(buffer,stdout);
			n= write(addr_rep,buffer,sizeof(buffer));
		if(buffer == 'STOP'){
			close(addr_rep);
			close(s);
			break;	
		}
		
	}
}
	
	
	
		
	
	
	//printf("%d %d \n",INADDR_LOOPBACK, INADDR_ANY);
	//printf("%x %x \n",INADDR_LOOPBACK, INADDR_ANY);
	
	
	return 0;
	
}

