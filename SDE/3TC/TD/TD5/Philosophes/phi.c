#include <stdio.h>
#include <stdlib.h>

#define N 5
Semaphore mutex [N]={1};

philosopher(int id) {
	while(TRUE) {
		penser();
		down(mutex[id]);
		prendre_baguette(min(id;(id-1+N)%N));
		prendre baguette((id-1+N)%N);
		manger();
		poser_baguette(i);
		poser_baguette((i-1+N)% N);
		
	}
}
