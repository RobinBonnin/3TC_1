//Client/Barber


#include <stdio.h>
#include <signal.h>

Semaphore barber =0
Semaphore client = 0
Semaphore seats = 1
int free_seats=N


Barber ()
 while 1 :
	down(client)
	down(seats)
	free_seats +=1
	up(seats)
	up(barber)
	cut_hair()


Customer ()
	while 1:
	down(seats)
	if free_seats>0:
		free_seats-=1
		up(client)
		up(seats)
		down(barber)
		get_haircut()
	else 
	up(seats)
	leave()
	
	
int barberSem;
int clientSem;
int* freeSeats;
