public class StackByArray extends DynamicArray
						  implements Stack {
	public boolean empty(){
		return(mySize == 0);
	}
	
	public int top() throws EmptyStackException {
		if(mySize == 0) {
			throw new EmptyStackException();
		}
		return(get(mySize - 1));
		
	}
	
	public void pop() throws EmptyStackException{
		if (mySize == 0){
			throw new EmptyStackException();
		}
		mySize--;
	}
	
	public String toString(){
		String res = new String("[");
		
		for(int i = (mySize - 1) ; i>0 ; i--){
			res = res+get(i)+", ";
		}
		
		res = res+get(0)+"]";
		
		return res; 
	}
		
	 public static void main(String args[]) {
		 StackByArray s = new StackByArray();
		 
		s.push(2);
		s.push(5);
		s.push(6);
		s.push(4);
		s.push(12);
		s.push(25);
		s.push(14);
		
		System.out.println(s.toString());
	}
}
