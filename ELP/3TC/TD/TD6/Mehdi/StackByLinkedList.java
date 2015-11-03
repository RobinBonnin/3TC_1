
public class StackByLinkedList implements Stack {

  /** head node of the linked list */
  private LinkedListNode head = null;

  /** 
   * Check if the list is empty
   * @return 'true' if empty, 'false' otherwise
   */
  public boolean empty() {
    return head == null;
  }

  /**
   * Get the value that is on the top of the stack
   * @return the top value 
   */
  public int top() throws EmptyStackException {
	  
	if(head == null) throw new EmptyStackException();
    return head.value();
  }

  /**
   * Add a value at the top of the stack
   * @param aValue new value
   */
  public void push(int aValue) {
    head = new LinkedListNode(aValue, head);
  }

  /**
   * Remove the value that is on the top of the stack
   */
  public void pop() throws EmptyStackException {
	  
	if(head == null) throw new EmptyStackException();
	  
	head = head.next();
 
  }
  
  
  
  

  public static void main(String args[]) throws EmptyStackException{
    int nb = 0; 
    int nbok = 0; 

    StackByLinkedList s = new StackByLinkedList(); 
    if (s.empty()) {
      nbok++; 
    }
  	nb++; 

	  int n = 10; 
  	for (int i = n; i >= 1; i--) {
	    s.push(i);
    }

  	if (!s.empty()) {
	    nbok++; 
    }
  	nb++; 

  	for (int i = 1; i <= n; i++) {
		  if (s.top() == i) {
		    nbok++; 
      }
  		nb++; 
	  	s.pop(); 
	  }

  	String res = (nb == nbok) ? "OK" : "KO"; 
	  System.out.println(res); 
  }
}
