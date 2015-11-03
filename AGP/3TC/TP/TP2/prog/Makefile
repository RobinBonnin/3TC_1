CFLAGS = -g -Wall -DDEBUG
LDLAGS = -g -Wall -DDEBUG

all: lireSudoku #resoudreSudoku 

utilSudoku.o: utilSuDoku.c 
	gcc ${CFLAGS} -c utilSuDoku.c  -o utilSuDoku.o


main.o:	main.c
	gcc ${CFLAGS} -c main.c -o main.o

lireSudoku: main.o utilSuDoku.o
	gcc ${LDFLAGS} main.o utilSuDoku.o -o lireSudoku

resoudreSudoku: sudoku.o utilSuDoku.o
	gcc ${LDFLAGS} sudoku.o   utilSuDoku.o -o resoudreSudoku

tar-sol: 
	cd ..; tar cvf  TP2-code.tar prog/main.c prog/utilSuDoku.c prog/utilSuDoku.h prog/Makefile prog/sudokuInit.txt  prog/sudoku1.txt prog/sudoku.c

tar: 
	cd ..; tar cvf  TP2.tar prog/main.c prog/utilSuDoku.c prog/utilSuDoku.h prog/Makefile prog/sudokuInit.txt  prog/sudoku1.txt 

clean: 
	\rm -rf *.o sudoku solution *~