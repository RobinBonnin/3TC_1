package fr.insalyon.telecom.ELP.Entree; 
import fr.insalyon.telecom.ELP.Sortie.VueGraphique;
import fr.insalyon.telecom.ELP.Noyau.Position; 
import fr.insalyon.telecom.ELP.Noyau.Deplacement; 
import fr.insalyon.telecom.ELP.Entree.LecteurDeDeplacement; 
import java.io.InputStream; 
import java.io.InputStreamReader;
import java.io.BufferedReader;

public class LecteurDeDeplacementDeVue implements LecteurDeDeplacement{

    /** deplacement */
    private Deplacement monDeplacement = null; 
    /** boolean indiquant si le deplacement est complet */
    public boolean estComplet = false; 
    private boolean estEntame=false;
    private Position cur=null;
    private VueGraphique v;

    /**
     * Constructeur 
     * @param unFlux flux d'entree
     */
    public LecteurDeDeplacementDeVue() {
    }

    /**
     * Lit un deplacement a partir du flux, puis renvoie vrai
     * @return vrai
     */
    @Override
    public boolean estComplet() {
	try{ 
		monDeplacement=new Deplacement();
		while(!estEntame){
			Thread.sleep(10);
		}
		monDeplacement.add(cur);
		estEntame=false;
		while(!estEntame){
			Thread.sleep(10);
		}	
		monDeplacement.add(cur);
		estEntame=false;
		estComplet=true;
		v.deselect();
		return estComplet;

	}catch (Exception e) {
	    estComplet = false; 
	    return estComplet; 
	}
    } 

    /**
     * Retourne le deplacement lu, 
     * puis remet a zero le deplacement
     * @return deplacement lu
     */
    @Override
    public Deplacement obtenir() {
		//System.out.println("coucou");
	Deplacement res = monDeplacement; 
	estComplet = false; 
	monDeplacement = null; 
	
	return res; 
    }
    
    public void setPosition(Position p){
		
		
		cur=p;
		estEntame=true;
	}
	public void addVue(VueGraphique vue){
		v=vue;
	}


}
