
public class DynamicArray {

  protected int mySize;
  protected int[] myArray;

  public DynamicArray() {
    this(16);
  }

  public DynamicArray(int initialCapacity) {
    myArray = new int[initialCapacity];
  }

  public int get(int index) {
    return myArray[index];
  }

  public int size() {
    return mySize;
  }

  public int capacity() {
    return myArray.length;
  }

  public void push(int aValue) {
    if (size() == capacity()) {
      int[] newArray = new int[myArray.length * 2];
      for (int i = 0; i < myArray.length; i++) {
        newArray[i] = myArray[i];
      }
      myArray = newArray;
    }
    myArray[mySize] = aValue;
    mySize = mySize + 1;
  }

  public void display() {
    String str = "[";
    for (int i = 0; i < size(); i++) {
      str = str + myArray[i];
      if (i < size() - 1) {
        str = str + ", ";
      }
    }
    str = str + "]";
    System.out.println(str);
  }

  public static void main(String[] args) {
    DynamicArray array = new DynamicArray();
    for (int i = 0; i < 65; i++) {
      array.push(i);
    }
    System.out.println("@10: " + array.get(10));
    System.out.println("capacity: " + array.capacity());
    System.out.println("size: " + array.size());
    System.out.println("display():");
    array.display();
  }
}
