public class Compta{
	public static void main(String[] args) {
		compte c1 = new compte();
		compte c2= new compte(1000.0d);
		compte.virement(1000.0d,c1,c2);
		System.out.println("Richesse = "+c1.obtenirSolde()+"\nRcihesse = "+c2.obtenirSolde()+"\nNombres Comptes = "+compte.nbcomptes());
	}
}
		
