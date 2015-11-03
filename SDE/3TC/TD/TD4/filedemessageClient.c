#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <sys/msg.h>


int main(){
int key=123;
int id=msgget(key,0666);
if (id==-1){
perror("message queue opening error");
exit(EXIT_FAILURE);
}
int note =0;
struct msgbuf{long mtype; char mtext[10];}
	message;
for(;;) {
msgrcv(id,&message,10,1,0);
note=atoi(message.mtext);
if(note>=0)
printf("%d\n",note);
else 
break;
}
return(0);
}
