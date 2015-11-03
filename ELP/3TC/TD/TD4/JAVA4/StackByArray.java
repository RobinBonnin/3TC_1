public class StackByArray extends DynamicArray implements Stack {
	public boolean empty(){
		return(mySize == 0);
	}
	
	public int top(){
		return(get(mySize - 1));
	}
	
	public void pop(){
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
