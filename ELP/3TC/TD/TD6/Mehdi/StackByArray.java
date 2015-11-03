

public class StackByArray extends DynamicArray 
                          implements Stack {

  public boolean empty() { return mySize == 0; }
  public int top()       { return myArray[mySize - 1]; }
  public void pop() throws EmptyStackException    {
	  if(mySize == 0){
		  throw new EmptyStackException();
	  }
	   mySize = mySize - 1; 
	   
	   }

  @Override
  public String toString() {
    String str = "[";
    for (int i = mySize - 1; i >= 0; i--) {
      str = str + myArray[i];
      if (i >= 0) {
        str = str + ", ";
      }
    }
    return str + "]";
  }
}
