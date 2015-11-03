all: tp

tp: saisie.o decode.o code1.o reception.o choix.o
	gcc saisie.o -o saisie
	gcc code1.o -o code1
	gcc decode.o -o decode
	gcc	reception.o -o reception
	gcc choix.o -o choix
	
saisie: saisie.o
	gcc saisie.o -o saisie
code1: code1.o
	gcc code1.o -o code1
decode: decode.o
	gcc decode.o -o decode
reception: reception.o
	gcc	reception.o -o reception
choix: choix.o
	gcc choix.o -o choix

choix.o : choix.c
	gcc -c choix.c

code1.o: code1.c
	gcc -c code1.c

decode.o: decode.c
	gcc -c decode.c
	
reception.o: reception.c
	gcc -c reception.c

clean:
	rm -rf *.o decode reception code1 saisie
