package tc.elp.java.util;
/**
 * Class that implements a stack of integers
 * by a linked list of integers. 
 */
public class StackByLinkedList {

    /** head node of the linked list */
	private LinkedListNode head =null;
		
		
    /** 
     * Check if the list is empty
     * @return 'true' if empty, 'false' otherwise
     */
	public boolean empty(){
		return head == null;
	}
    /**
     * Get the value that is on the top of the stack
     * @return the top value 
     */
    public int top() {
		return head.top;
	}

    /**
     * Add a value at the top of the stack
     * @param aValue new value
     */
    public void push (int aValue) {
		LinkedListNode newHead = new LinkedListNode(aValue, head);
		head=newHead;
	}

    /**
     * Remove the value that is on the top of the stack
     */
    public void pop() {
		if (!empty()){
			head=head.next();
		}
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
