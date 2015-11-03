/**
 * Class that implements a recursive solution
 * to the Tower of Hanoi.
 */
public class Hanoi {
    /** 
     * Take the upper element from @a src
     * and place it on top of @a dest
     * @param src source stack
     * @param dest destination stack
     */
    private static void oneMove(Stack src, Stack dest) {
	dest.push( src.top() ); 
	src.pop(); 
    }
    /** 
     * Move the whole stack @a src to position @a dest
     * @param src source stack
     * @param dest destination stack
     * @param tmp middle stack
     * @pre src the source stack must not be empty 
     */
    public static void move(Stack src, Stack dest, Stack tmp) {
	oneMove(src, tmp); 
	if ( !src.empty() ) 
	    move(src, dest, tmp); //recursive call
	oneMove(tmp, dest);
    }

    /** Small test where stack @a a is moved to stack @a b 
     * @param a first stack
     * @param b second stack
     * @param c third stack
     * @pre a, b, c are empty
     */
    public static void test(Stack a, Stack b, Stack c) {

	//fill a with values ranging from max to 1
	int max = 5; 
	for (int i = max; (i >= 1); i--)
	    a.push(i); 
	//leave b and c empty
	
	//MAIN CALL
	Hanoi.move(a, b, c); 

	//tests
	int nb = 0; 
	int nbok = 0; 

	if (a.empty())
	    nbok++; 
	nb++; 
	System.out.println(nbok + "/" + nb); 

	if (c.empty())
	    nbok++; 
	nb++; 
	System.out.println(nbok + "/" + nb); 
	
	int counter = 1;
	System.out.println( " Stack b " ); 
	while ( !b.empty() )
	    {
		System.out.println( "=> " + b.top()); 
		if (b.top() == counter)
		    nbok++;
		nb++; 
		b.pop(); 
		counter++; 
	    }

	System.out.println(nbok + "/" + nb); 

	String res = (nb == nbok) ? "OK" : "KO"; 
	System.out.println(res); 
	
    }

    public static void main(String[] args) {
		Stack s1 = new StackByLinkedList();
		Stack s2 = new StackByLinkedList();
		Stack s3 = new StackByLinkedList();
		
		test(s1, s2, s3);
		
		Stack s4 = new StackByArray();
		Stack s5 = new StackByArray();
		Stack s6 = new StackByArray();
		
		test(s4, s5, s6);
    }

}
