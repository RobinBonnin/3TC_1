
#include <stdio.h>
#include <stdlib.h>

#include "shmem.h"
#include "semaphore.h"


void processGreet()
{
	printf("Hello, this is process pid = %d, child of process pid = %d\n", getpid(), getppid()) ;
}


int main()
{
	int key = 123 ;
	int memsize = sizeof(int) ;	
	
	int shmemId = create_shmem(key, memsize) ;
	if (shmemId == -1) {
		perror("shared segment creation error") ;
		exit(EXIT_FAILURE) ;
	}
	
	int* buffer = (int*) attach_shmem(shmemId) ;
	*buffer = 0 ;
	
	int semId = create_semaphore(key) ;
	if (semId == -1) {
		perror("semaphore creation error") ;
		exit(EXIT_FAILURE) ;
	}
	
	init_semaphore(semId, 1) ;
	
	int pid = fork() ;
	
	down(semId) ;
	processGreet() ;
	if (*buffer == 0)
		*buffer = getpid() ;
	else
		printf("%d\n", *buffer) ;
	up(semId) ;
	 
	if (pid) {
		int status ;
		wait(&status) ;
		remove_semaphore(semId) ;
		detach_shmem(buffer) ;		
		remove_shmem(shmemId) ;
	}
}

	