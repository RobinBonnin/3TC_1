

all: adder

adder: adder.tab.o lex.yy.o 
	gcc adder.tab.o lex.yy.o  -o adder
	./adder	

adder.tab.c: adder.y
	bison -d adder.y 

lex.yy.c: adder.l 
	flex adder.l

clean:
	\rm -rf *~ adder.c adder.tab.* lex.yy.c a.out *.o adder
