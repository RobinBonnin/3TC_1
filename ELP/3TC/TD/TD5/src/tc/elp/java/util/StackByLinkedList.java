package tc.elp.java.util;



/**
 * Class that implements a stack of integers
 * by a linked list of integers. 
 */
public class StackByLinkedList implements Stack {

    /** head node of the linked list */
    private LinkedListNode head;

    /** 
     * Check if the list is empty
     * @return 'true' if empty, 'false' otherwise
     */
    public boolean empty(){
		return(head == null);
	}

    /**
     * Get the value that is on the top of the stack
     * @return the top value 
     */
    public int top(){
		return head.value();
	}

    /**
     * Add a value at the top of the stack
     * @param aValue new value
     */
    public void push(int aValue){
		LinkedListNode newNode = new LinkedListNode(aValue, head);
		head= newNode;
	}
		

    /**
     * Remove the value that is on the top of the stack
     */
    public void pop(){
		head=head.next();
	}
	
	@Override
	public String toString(){
		LinkedListNode node=head;
		String res = new String("[");
		
		while(node!=null){
			res = res + node.value();
			if(node.next() != null){
				res = res + ", ";
			}
			node = node.next();
		}
		
		res = res + "]";
		
		return res;
	}

    /**
     * Simple tests
     */
    public static void main(String args[]) {
	int nb = 0; 
	int nbok = 0; 

	StackByLinkedList s = new StackByLinkedList(); 
	if (s.empty()) 
	    nbok++; 
	nb++; 

	int n = 10; 
	for (int i = n; i >= 1; i--)
	    s.push(i);

	if (!s.empty()) 
	    nbok++; 
	nb++; 
	System.out.println(s.toString());
	for (int i = 1; i <= n; i++)
	    {
		if (s.top() == i) 
		    nbok++; 
		nb++; 
		s.pop(); 
	    }

	String res = (nb == nbok)? "OK": "KO"; 
	System.out.println(res); 
	
    }

}
