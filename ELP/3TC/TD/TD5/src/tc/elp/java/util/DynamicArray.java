package tc.elp.java.util;



public class DynamicArray {
	protected int mySize;
	protected int[] myArray;
	
	public DynamicArray(){
		mySize=0;
		myArray = new int[1];
	}
	
	public int get(int aIndex){
		return myArray[aIndex];
	}
	
	public void push(int aValue){
		if(size() < capacity()){
			myArray[size()] = aValue;
			mySize++;
		}
		else {
			int[] newArray = new int[2 * capacity()];
			for(int i = 0; i < size(); i++){
				newArray[i] = myArray[i];
			}
			myArray=newArray;
			push(aValue);
		}
	}
	
	public int size(){
		return mySize;
	}
	
	public int capacity(){
		return myArray.length;
	}
	
	public void display(){
		for(int i = 0; i < mySize; i++){
			System.out.println(myArray[i]);
		}
	}
	
	public static void main(String[] args) {
		DynamicArray myDynArray = new DynamicArray();
		myDynArray.push(2);
		myDynArray.push(5);
		myDynArray.push(6);
		myDynArray.push(4);
		myDynArray.push(12);
		myDynArray.push(25);
		myDynArray.push(14);
		
		System.out.println("Capacité: " + myDynArray.capacity());
		System.out.println("Taille: " + myDynArray.size());
		System.out.println("Val à l'index 2: " + myDynArray.get(2));
		myDynArray.display();
	}
}
