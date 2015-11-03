package fr.insalyon.telecom.ELP.App; 

import java.util.*; 
import fr.insalyon.telecom.ELP.Noyau.*; 
import fr.insalyon.telecom.ELP.Entree.*; 
import fr.insalyon.telecom.ELP.Sortie.*; 
import java.io.*;
import java.lang.Thread;

public class DamesShell {
	
	public static void main(String[] args) throws IOException {
		
		Couleur white=Couleur.blanc();
		Couleur black=Couleur.noir();
		LecteurDeDeplacementDeVue lire=new LecteurDeDeplacementDeVue();
		EnsembleDePions pions=new EnsembleDePions();
		VueGraphique view = new VueGraphique(pions,lire);
		pions.init();
		pions.addVue(view);
		lire.addVue(view);
		Arbitre unArbitre=new Arbitre();
		
		Joueur blanc=new Joueur(white, pions, unArbitre, lire);
		Joueur noir=new Joueur(black, pions, unArbitre, lire);
		
		Thread tblanc = new Thread(blanc);
		Thread tnoir = new Thread(noir);
		Thread tview = new Thread(view);
		
		pions.addObserver(view);
		
		tblanc.start();
		tnoir.start();
		tview.start();
		
		
		
		
		
	}
}
