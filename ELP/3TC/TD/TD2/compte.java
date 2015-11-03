public class compte {
	
	private double monSolde=10000.0d;
	
	private static int nbcompte=0;
	
	public static int nbcomptes() {
		return(nbcompte);		
	}
	
	public static final double decouvert = -300.0d;
		
	public static void virement(double montant,compte c1,compte c2){
		if(c1.obtenirSolde()-montant<decouvert){
			System.out.println("Oups plus de sous !");
		}
		else{		
		c1.debit(montant);
		c2.credit(montant);
		}
	}
		
	public compte() {
		nbcompte=nbcompte+1;
		}
		
	public compte(double montant){
		monSolde=montant;
		nbcompte=nbcompte+1;
	}		
		
	public double obtenirSolde(){
		return(monSolde);
	}
	public void debit (double unMontant){
		monSolde=monSolde-unMontant;
	}
	public void credit (double unMontant){
		monSolde=monSolde+unMontant;
	}
}
	
