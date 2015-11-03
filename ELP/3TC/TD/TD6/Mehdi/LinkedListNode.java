
public class LinkedListNode {

  private int myValue; 
  private LinkedListNode myNext; 

  public LinkedListNode(int aValue) {
    myValue = aValue; 
    myNext = null; 
  }

  public LinkedListNode(int aValue, LinkedListNode aNode) {
    myValue = aValue; 
    myNext = aNode; 
  }

  public int value () {
    return myValue;
  }

  public LinkedListNode next () {
    return myNext;
  }
}
