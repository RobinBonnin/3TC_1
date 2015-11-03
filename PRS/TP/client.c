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
		printf("Valeur descripteur:%d\n", s);
	}
	struct sockaddr_in my_addr;
	memset((char*)&my_addr,0,sizeof(my_addr));
	
	my_addr.sin_family = AF_INET; // Initialisation du domaine 	
	my_addr.sin_port = htons(8080);  // Initialisation du port
	
	int adresse = inet_aton("127.0.0.1",&my_addr.sin_addr); // On initialise l'adresse IP du serveur
	printf("Valeur inet_aton:%d\n",adresse);
	

	connect(s,(struct sockaddr*)(&my_addr),sizeof(my_addr));
	printf("Numéro de port : %d\n", my_addr.sin_port);
	printf("Adresse Client : %x", my_addr.sin_addr.s_addr);
	
	char buffer[64];
	while(1){
		
		fgets(buffer,64,stdin);
		write(s,buffer,sizeof(buffer));
		memset((char*)&buffer,0,sizeof(my_addr));
		read(s,buffer,sizeof(buffer));
		fputs(buffer,stdout);
		
		if(buffer == 'STOP'){
			break;	
		}		
	}
	return 0;
}
