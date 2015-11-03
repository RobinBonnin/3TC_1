
# création de l'exécutable main

all: logo
	./logo < test.logo

#le -lm sert  à inclure la bibliothèque de math.h
main : main.o fonctions_logo.o 
	@echo "*************** Compilation *****************"
	gcc -Wall -lm main.o fonctions_logo.o -o main 
	@echo "*************** Execution *******************"
	./main 
	@echo "*********** Lancement du fichier ************"
	@echo "*************** Nettoyage *******************"
	make clean

main.o : main.c fonctions_logo.c
	gcc -c main.c -o main.o
	gcc -c fonctions_logo.c -o fonctions_logo.o 

fonctions_logo.o : fonctions_logo.c
	gcc -c fonctions_logo.c -o fonctions_logo.o 


#partie logo

logo: tplogo.tab.c lex.yy.c fonctions_logo.c
	gcc tplogo.tab.c lex.yy.c fonctions_logo.c  -o logo
	

tplogo.tab.c: tplogo.y
	bison -d tplogo.y 

lex.yy.c: tplogo.l 
	flex tplogo.l

clean : 
	@rm -rf *.o rm -rf *.bak rm -rf *.gch rm main rm logo rm -rf lex.yy.c rm -rf *.tab.c rm -rf *.tab.h
