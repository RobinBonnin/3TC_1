public class compte {
	private double monSolde;
	
	public compte( double init) {
		monSolde=init;
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
	
