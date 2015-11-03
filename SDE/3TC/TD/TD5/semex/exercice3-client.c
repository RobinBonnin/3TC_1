
#include <stdio.h>
#include <stdlib.h>

#include "shmem.h"
#include "semaphore.h"


int main()
{
	int key = 123 ;
	int memsize = sizeof(int) ;	
	
	int shmemId = open_shmem(key, memsize) ;
	if (shmemId == -1) {
		perror("shared segment opening error") ;
		exit(EXIT_FAILURE) ;
	}
	
	int* buffer = (int*) attach_shmem(shmemId) ;
	*buffer = 0 ;
	
	int emptySemKey = 100 ;
	int emptySemId = open_semaphore(emptySemKey) ;
	
	int fullSemKey = 101 ;
	int fullSemId = open_semaphore(fullSemKey) ;
	
	if ((emptySemId == -1) || (fullSemId == -1)) {
		perror("semaphore opening error") ;
		exit(EXIT_FAILURE) ;
	}
	
	while (*buffer >= 0) {
		down(fullSemId) ;
		if (*buffer >= 0)
			printf("%d\n", *buffer) ;
		up(emptySemId) ;
	}
	
	detach_shmem(buffer) ;
}
