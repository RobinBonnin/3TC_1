public class EvenCounterTest {
	
	public static void main (String args[]) {
		EvenCounter even = new EvenCounter();
		
		Thread t1 = new Thread(even);
		Thread t2 = new Thread(even);
		Thread t3 = new Thread(even);
		Thread t4 = new Thread(even);
		Thread t5 = new Thread(even);
		Thread t6 = new Thread(even);
		Thread t7 = new Thread(even);
		Thread t8 = new Thread(even);
		Thread t9 = new Thread(even);
		Thread t10 = new Thread(even);
		Thread t11 = new Thread(even);
		Thread t12 = new Thread(even);
		Thread t13 = new Thread(even);
		Thread t14= new Thread(even);
		Thread t15 = new Thread(even);
		Thread t16 = new Thread(even);
		
		
		
		t1.start();
		t2.start();
		t3.start();
		t4.start();	
		t5.start();	
		t6.start();			
		t7.start();	
		t8.start();			
		t9.start();			
		t10.start();			
		t11.start();
		t12.start();			
		t13.start();			
		t14.start();			
		t15.start();			
		t16.start();				
			
	}
}

