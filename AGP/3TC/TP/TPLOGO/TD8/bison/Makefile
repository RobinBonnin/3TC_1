

all: expr

expr: expr.tab.o lex.yy.o node.o
	gcc expr.tab.o lex.yy.o node.o -o expr
	./expr <expr1.expr	

expr.tab.c: expr.y
	bison -d expr.y 

lex.yy.c: expr.l 
	flex expr.l

clean:
	\rm -rf *~ expr.c expr.tab.* lex.yy.c a.out *.o expr
