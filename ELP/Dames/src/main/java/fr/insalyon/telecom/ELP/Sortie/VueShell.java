package fr.insalyon.telecom.ELP.Sortie; 

import fr.insalyon.telecom.ELP.Noyau.Constantes; 
import fr.insalyon.telecom.ELP.Noyau.Couleur;
import fr.insalyon.telecom.ELP.Noyau.Pion;  
import fr.insalyon.telecom.ELP.Noyau.Position; 
import java.util.Observer;
import java.util.Observable;
import fr.insalyon.telecom.ELP.Noyau.EnsembleDePions; 

/**
 * Classe modelisant la vue sur la sortie standard. 
 * Cette classe observe le modele et l'affiche a 
 * l'ecran apres chaque modification.
 */
public class VueShell implements Observer, Runnable {
	

    /**
     * Methode affichant sur la sortie standard la
     * representation textuelle du damier: 
     * O pour une case blanche, 
     * X pour une case noir inoccupee, 
     * N pour un pion noir,
     * B pour un pion blanc. 
     */
    private void affichage(EnsembleDePions e) {
    	System.out.println("  0 1 2 3 4 5 6 7 8 9 "); 
    	for (int j = 0; j < Constantes.N; j++) {
    	    System.out.print(j + " "); 
    	    for (int i = 0; i < Constantes.N; i++) {
		Position pos = new Position(i,j); 
		if ( pos.estValide() ) {
		    //TODO
		    if(e.obtenirPion(pos)==null){
			System.out.print("X ");
		    }else{
			Pion p=e.obtenirPion(pos);
			Couleur b=Couleur.blanc();
			if(p.aMemeCouleur(b)){
			    System.out.print("B ");
			}else{
			    System.out.print("N ");
			}
			
		    }
		} else {
		    System.out.print("O "); 
		} 
    	    }
    	    System.out.println(); 
    	}
    	System.out.println(); 
    }
    
    /**
     * Methode executee au demarrage d'un thread.  
     */
    @Override
    public void run() {
		
		while (true) {
	    //A ecrire
		}
    }
    
    public void update(Observable o, Object arg){
		affichage((EnsembleDePions) o);
	}
	

   
}
