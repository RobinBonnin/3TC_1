package fr.insalyon.telecom.ELP.App; 

import java.util.*; 
import fr.insalyon.telecom.ELP.Noyau.*; 
import fr.insalyon.telecom.ELP.Entree.*; 
import fr.insalyon.telecom.ELP.Sortie.*; 
import java.io.*;
import java.lang.Thread;
import  java.net.*;
public class DamesShellClient{
	
	public static void main(String[] args) throws IOException {
		Socket socket = new Socket("localhost",8080);
		PrintWriter os=new PrintWriter(new OutputStreamWriter(socket.getOutputStream()),true);
		os.println("Connection acceptée");
		Couleur white=Couleur.blanc();
		Couleur black=Couleur.noir();
		EnsembleDePions pions=new EnsembleDePions();
		pions.init();
		Arbitre unArbitre=new Arbitre();
		InputStream is=socket.getInputStream();
		LecteurDeDeplacement lire=new LecteurDeDeplacementDeFlux(is);
		LecteurDeDeplacement lireLocal=new LecteurDeDeplacementDeFlux(System.in);
		Joueur noir=new Joueur(black, pions, unArbitre, lire);
		Joueur blanc=new JoueurTransmetteur(white, pions, unArbitre, lireLocal, socket.getOutputStream());
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
