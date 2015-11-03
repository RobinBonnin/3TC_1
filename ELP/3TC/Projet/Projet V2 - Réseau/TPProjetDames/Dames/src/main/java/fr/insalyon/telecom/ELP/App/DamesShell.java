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
		
		EnsembleDePions pions=new EnsembleDePions();
		pions.init();
		Arbitre unArbitre=new Arbitre();
		LecteurDeDeplacement lire=new LecteurDeDeplacementDeFlux(System.in);
		Joueur blanc=new Joueur(white, pions, unArbitre, lire);
		Joueur noir=new Joueur(black, pions, unArbitre, lire);
		VueShell view = new VueShell();
		Thread tblanc = new Thread(blanc);
		Thread tnoir = new Thread(noir);
		Thread tview = new Thread(view);
		
		pions.addObserver(view);
		tblanc.start();
		tnoir.start();
		tview.start();
		
		
		
	}
}
