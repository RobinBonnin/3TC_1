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
		Socket socket = connection.accept(); // On accepte le serveur
		Couleur white=Couleur.blanc();
		Couleur black=Couleur.noir();
		EnsembleDePions pions=new EnsembleDePions();
		pions.init();
		
		Arbitre unArbitre=new Arbitre();
		InputStream is = socket.getInputStream(); //Connection de la socket au flux d'entrée
		LecteurDeDeplacement lire= new LecteurDeDeplacementDeFlux(is);  //On fait un lecteur de déplacement de flux afin de lire dans la socket
		LecteurDeDeplacementDeVue lireLocal=new LecteurDeDeplacementDeVue(); // Lecteur de vue local pour la partie graphique
		VueGraphique view = new VueGraphique(pions,lireLocal, "Serveur - Noirs"); 
		pions.addVue(view);
		lireLocal.addVue(view);
		
		Joueur noir=new JoueurTransmetteur(black, pions, unArbitre, lireLocal, socket.getOutputStream());
		Joueur blanc=new Joueur(white, pions, unArbitre, lire);
		
		Thread tblanc = new Thread(blanc);
		Thread tnoir = new Thread(noir);
		Thread tview = new Thread(view);
		
		pions.addObserver(view);
		tblanc.start();
		tnoir.start();
		tview.start();
	}
	

}
