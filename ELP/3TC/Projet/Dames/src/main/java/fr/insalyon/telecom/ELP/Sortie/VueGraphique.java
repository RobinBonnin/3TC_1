package fr.insalyon.telecom.ELP.Sortie; 
import fr.insalyon.telecom.ELP.Entree.LecteurDeDeplacementDeVue;
import fr.insalyon.telecom.ELP.Entree.LecteurDeDeplacement;
import fr.insalyon.telecom.ELP.Noyau.*;
import java.util.Observer;
import java.util.Observable;
import fr.insalyon.telecom.ELP.Noyau.EnsembleDePions; 
import javax.swing.*;  
import java.awt.GridLayout;
import javax.swing.JFrame;
import java.awt.Dimension;

public class VueGraphique implements Observer, Runnable{
	private DamesFrame f;
	private EnsembleDePions e;
	private LecteurDeDeplacementDeVue flux;
	private String name;
	public VueGraphique(EnsembleDePions e, LecteurDeDeplacementDeVue flux ,String nom){
		super();
		this.e=e;
		this.flux=flux;
		name=nom;
	}
	@Override
	public void run() {
		f = new DamesFrame(nom,flux);
		this.affichage(e);
		while (true) {
		//A ecrire
		}
    }
    
     private void affichage(EnsembleDePions e) {
		f.update(e); 
	}
    
	public void update(Observable o, Object arg){
		affichage((EnsembleDePions) o);
	}
	public void deselect(){
		f.deselect();
	}
	public void sendMessage(String m){
		f.send(m);
	
	}
}
