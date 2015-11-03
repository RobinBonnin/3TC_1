#########################################################
# Makefile 
#########################################################
CC            =g++ 
OPT           = -Wall
MAIN          = BigInt
TEST          = testBigInteger
DEMO          = factorial

all: $(MAIN) $(TEST) $(DEMO)

$(MAIN): $(MAIN).h
	$(CC) $(OPT) -c $(MAIN).cpp -o $(MAIN).o

$(TEST): $(TEST).cpp $(MAIN).o 
	$(CC) $(OPT) $< $(MAIN).o -o $@ 

$(DEMO): $(DEMO).cpp $(MAIN).o
	$(CC) $(OPT) $< $(MAIN).o -o $@

run: 
	./$(TEST)

clean:
	-rm -f *~ *.out *.o $(TEST) $(DEMO)

