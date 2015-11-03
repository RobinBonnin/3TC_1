#include <stdio.h>
#include <stdlib.h>

//0 :penser 1 : faim 2 : manger
Semaphore mutex=1
Semaphore sem[N]={0}
int state[N]

//Pseudo Code
philosopher(id)
while 1:
think()
down(mutex)
state[id]=HUNGRY
if [(state(id+N-1)%N]!= EATING && state(id+1)%N)!=EATING):
state[id]=EATING
up(sem[id]) 
eat(()
down(mutex)
state(id)=THINKING
if(state[(id+N-1)%N]==HUNGRY && state[(id+N-2)%N] !=EATING):
state(id+N-1)]=EATING
up(sem(id+N-1)%N])
if state([id+N-1)%N]==HUNGRY && state[(id+2)%N]!=EATING):
state[(id+1)%N)]=EATING


