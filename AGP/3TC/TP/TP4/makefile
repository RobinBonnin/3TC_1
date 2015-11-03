all: logo
	./logo < test.logo
	eog dessin.svg


logo: logo.tab.c lex.yy.c structure.c 
	gcc -lm logo.tab.c lex.yy.c structure.c -o logo

logo.tab.c : logo.y
	bison -d logo.y

lex.yy.c : flogo.l
	flex flogo.l 

clean :
	@rm -rf *.o rm -rf *.bak rm -rf *.gch *~ rm main rm logo rm -rf lex.yy.c rm -rf *.tab.c rm -rf *.tab.h rm -rf *.svg
