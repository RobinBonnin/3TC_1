package fr.insalyon.telecom.ELP.Entree; 


import fr.insalyon.telecom.ELP.Noyau.*;


import fr.insalyon.telecom.ELP.Entree.*; 
import java.net.*;
import java.io.*;
import java.util.*;

public class JoueurTransmetteur extends Joueur{
	protected PrintWriter os;
	
	public JoueurTransmetteur(Couleur uneCouleur, EnsembleDePions uneConfiguration, Arbitre unArbitre, LecteurDeDeplacement unLecteur, OutputStream out)throws IOException{
		super(uneCouleur, uneConfiguration, unArbitre, unLecteur);
		os=new PrintWriter(new OutputStreamWriter(out),true);
	}
	
	@Override
	protected boolean jouer() {
		Deplacement dep=monLecteur.obtenir();
		Deplacement toSend=dep;
		os.println(toSend);
		return (maConfiguration.realiser(dep, maCouleur));	     
    }
}
