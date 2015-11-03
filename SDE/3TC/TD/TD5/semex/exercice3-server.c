
#include <stdio.h>
#include <stdlib.h>

#include "shmem.h"
#include "semaphore.h"


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
	
	int emptySemKey = 100 ;
	int emptySemId = create_semaphore(emptySemKey) ;
	
	int fullSemKey = 101 ;
	int fullSemId = create_semaphore(fullSemKey) ;
	
	if ((emptySemId == -1) || (fullSemId == -1)) {
		perror("semaphore creation error") ;
		exit(EXIT_FAILURE) ;
	}
	
	init_semaphore(fullSemId, 0) ;
	init_semaphore(emptySemId, 1) ;
	
	while (*buffer >= 0) {
		down(emptySemId) ;
		if (!scanf("%d", buffer))
			*buffer = -1 ;
		up(fullSemId) ;
	}

	remove_semaphore(fullSemId) ;
	remove_semaphore(emptySemId) ;
	detach_shmem(buffer) ;
	remove_shmem(shmemId) ;	
}
