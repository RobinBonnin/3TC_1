package fr.insalyon.telecom.ELP.App; 

import java.util.*; 
import fr.insalyon.telecom.ELP.Noyau.*; 
import fr.insalyon.telecom.ELP.Entree.*; 
import fr.insalyon.telecom.ELP.Sortie.*; 
import java.io.*;
import java.lang.Thread;
import  java.net.*;
public class DamesShellServeur{


	
	public static void main(String[] args) throws IOException {
		ServerSocket connection=new ServerSocket(8080);
		Socket socket = connection.accept();
		Couleur white=Couleur.blanc();
		Couleur black=Couleur.noir();
		EnsembleDePions pions=new EnsembleDePions();
		pions.init();
		Arbitre unArbitre=new Arbitre();
		InputStream is=socket.getInputStream();
		LecteurDeDeplacement lire=new LecteurDeDeplacementDeFlux(is);
		LecteurDeDeplacement lireLocal=new LecteurDeDeplacementDeFlux(System.in);
		Joueur noir=new JoueurTransmetteur(black, pions, unArbitre, lireLocal, socket.getOutputStream());
		Joueur blanc=new Joueur(white, pions, unArbitre, lire);
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
