public class Compta{
	public static void main(String[] args) {
		compte c1 = new compte(10000.0d);
		c1.debit(100.0d);
		c1.credit(200.0d);
		System.out.println("Richesse="+c1.obtenirSolde());
	}
}
		
