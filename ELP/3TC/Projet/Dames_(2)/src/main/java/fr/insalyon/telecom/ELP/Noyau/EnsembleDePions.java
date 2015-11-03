package fr.insalyon.telecom.ELP.Noyau; 

import java.util.Collection; 
import java.util.Map; 
import java.util.HashMap; 
import java.util.Observable; 
import fr.insalyon.telecom.ELP.Sortie.VueGraphique;
import fr.insalyon.telecom.ELP.Noyau.Position; 
import fr.insalyon.telecom.ELP.Noyau.Couleur; 
import fr.insalyon.telecom.ELP.Noyau.Pion; 
import fr.insalyon.telecom.ELP.Noyau.Deplacement; 

/**
 * Classe modelisant un ensemble de pions, 
 * c'est-a-dire une configuration de pions sur le 
 * damier. 
 */
public class EnsembleDePions extends Observable {
	private VueGraphique v;
    /** tableau associant pion et position */
    private Map<Position, Pion> mesPions 
	= new HashMap<Position, Pion>();

    //-------------------- initialisation ---------------------------
    /**
     * Methode qui positionne les pions d'une couleur donnee. 
     * @param uneCouleur couleur des pions a positionner
     * @param unFluxDePositions chaine traduisant une liste des positions
     */
    private void init(Couleur uneCouleur, String unFluxDePositions) {
	String[] chaines = unFluxDePositions.split(" "); //separation par espace
	for (String chaine: chaines) {
	    Position position = new Position(chaine);
	    ajouterPion( new Pion(uneCouleur), position ); 
	}
    }

    /**
     * Methode qui positionne tous les pions.
     * @param pionsNoirs liste des positions dehttp://start.fedoraproject.org/s pions noirs
     * @param pionsBlancs liste des positions des pions blancs
     */
    public void init(String pionsNoirs, String pionsBlancs) {
	init(Couleur.noir(), pionsNoirs); 
	init(Couleur.blanc(), pionsBlancs); 
    }

    /**
     * Methode qui positionne tous les pions dans la configuration
     * initiale. 
     */
    public void init() {
	init("1,0 3,0 5,0 7,0 9,0 0,1 2,1 4,1 6,1 8,1 1,2 3,2 5,2 7,2 9,2 0,3 2,3 4,3 6,3 8,3", 
	     "1,6 3,6 5,6 7,6 9,6 0,7 2,7 4,7 6,7 8,7 1,8 3,8 5,8 7,8 9,8 0,9 2,9 4,9 6,9 8,9"); 
	    setChanged();
		notifyObservers();
		clearChanged();
    }


    //-------------------- services ---------------------------

    /**
     * Methode permettant d'obtenir le pion situe a une position donnee
     * @param unePosition position
     * @return null si aucun pion ne s'y trouve, le pion sinon
     */
    public Pion obtenirPion(Position unePosition) {
	return mesPions.get(unePosition); 	
    }

    /**
     * Methode calculant le nombre de pions d'une couleur donnee
     * @return le nombre de pions
     */
    public int nombrePions(Couleur uneCouleur) {
	Collection<Pion> pions = mesPions.values();
	int nb = 0;
	for (Pion p: pions) {
	    if (p.aMemeCouleur(uneCouleur))
		nb++; 
	}
	return nb; 
    }

    /**
     * Methode indiquant si une couleur n'est plus représentée, 
     * c'est-a-dire que la partie est terminee
     * @return vrai si la partie est terminee, faux sinon
     */
    public boolean estTermine() {
	return ( (nombrePions(Couleur.noir()) == 0) || 
		 (nombrePions(Couleur.blanc()) == 0) ); 
    }


    /**
     * Methode indiquant si un deplacement donne est valide ou non. 
     * @param unDeplacement deplacement a tester 
     * @param couleurJoueur couleur du joueur realisant le deplacement
     * @return vrai si valide, faux sinon
     */
    private boolean estValide(Deplacement unDeplacement, Couleur couleurJoueur) {
	boolean estOK = true; 

	//toutes les positions
	Position[] positions = unDeplacement.toArray(new Position[0]);
	Position depart = positions[0];
	Pion aDeplacer = obtenirPion(depart);
	//on teste s'il y a au moins deux positions http://start.fedoraproject.org/
	estOK = estOK && (positions.length >= 2); 
	if(aDeplacer ==null){
		return false;
	}

	if (estOK) {

	    //on teste si toutes les positions sont valides
	    for (int i = 0; ( (i < positions.length)&&(estOK) ); i++) {
		estOK = estOK && (positions[i].estValide()); 
	    }

	    //position de depart


	    //on teste s'il y a un pion de la couleur du joueur

	    estOK = estOK && (aDeplacer != null); 
	    estOK = estOK && (aDeplacer.aMemeCouleur(couleurJoueur)); 
		
		
	}
	if(estOK){
		//Les Blancs n'ont pas le droit de descendre
		if(aDeplacer.aMemeCouleur(Couleur.blanc())){
			for(int k=1;k<positions.length;k++){
				if(positions[k].j()>positions[k-1].j()){
					return false;
				}
			}
		}else{
			//On vérifie pour les noirs
			for(int k=1;k<positions.length;k++){
				if(positions[k].j()<positions[k-1].j()){
					return false;
				}
			
			}
		}
	}
	  //TODO
	if(estOK){
		if(Math.abs(positions[0].j()-positions[1].j())<2){
			for(int x=0;x<10;x++){
				for(int y=0;y<10;y++){
					Pion pion = this.obtenirPion(new Position(x,y));
					if(pion !=null){
						pion.aMemeCouleur(couleurJoueur);
						Position pos2 = new Position(x+1,y+1);
						Position pos3= new Position(x-1,y+1);
						Position pos4 = new Position(x+1,y-1);
						Position pos5 = new Position(x-1,y-1);
													
						Position voisins[]={pos2,pos3,pos4,pos5};
						for(int h=0;h<4;h++){
							if(!obtenirPion(voisins[h]).aMemeCouleur(couleurJoueur)){
								int diffi = 2*(voisins[h].i()-x);
								int diffj = 2*(voisins[h].j()-y);
								if(obtenirPion(new Position(voisins[h].i()+diffi,voisins[h].j()+diffj))==null){
									message("Mange le pion !");
									return false;
								}
							}
						}
					}
				}
			}
		}
	}
		
																			
									
									
	    if(estOK){
			
			for(int i=1;i<positions.length;i++){
				aDeplacer=obtenirPion(positions[i]);
				estOK=estOK && (aDeplacer==null);
		}
		
		//Déplacement doit être en diagonale
		Position suivant;
		for(int i=1;i<positions.length;i++){
			depart=positions[i-1];
			suivant=positions[i];
			int x=Math.abs(depart.i()-suivant.i());
			int y=Math.abs(depart.j()-suivant.j());
			estOK=estOK && (x==y);
		}
		depart = positions[0];
	}

	return estOK; 
    }

    /**
     * Methode qui realise un deplacement donne, ce qui modifie la 
     * configuration des pions.  
     * @param unDeplacement deplacement a realiser 
     * @param couleurJoueur couleur du joueur realisant le deplacement
     * @return vrai si le deplacement est valide, faux sinon
     */
    public boolean realiser(Deplacement unDeplacement, Couleur couleurJoueur) {
	
	if (estValide(unDeplacement, couleurJoueur)) {

		//toutes les positions
		Position[] positions = unDeplacement.toArray(new Position[0]); 
		//position de depart
		Position posDep = positions[0]; 

		//pion de la position de posDep
		Pion pionDep = obtenirPion(posDep);
		pionDep = mesPions.get(posDep); 

		//supprimer le pion de la position de depart
		supprimerPion(positions[0]); 
	
		//ajouter le pion a la position d'arrivee
		ajouterPion(pionDep, positions[positions.length-1]); 

		//traiter les positions intermediaires
		for (int i = 1; i < positions.length; i++) {
		    Collection<Position> c = Position.diagonale(positions[i-1], positions[i]); 
		    if (c.size() == 1) {
			for (Position pos: c) {
			    Pion aSupprimer = obtenirPion(pos); 
			    if ( (aSupprimer != null) && (!aSupprimer.aMemeCouleur(couleurJoueur)) ) {
				supprimerPion(pos);  
			    }
			}
		    }
		}
		
		setChanged();
		notifyObservers();
		clearChanged();
		return true; 
	} else {
	    v.sendMessage("Deplacement invalide");
	    return false; 
	}
	   
    }

    //--------------------- Operations internes ----------------------------

    /**
     * Methode qui supprime le pion situe a une position donnee
     * @param unePosition position du pion a supprimer
     */
    private void supprimerPion(Position unePosition) {
	mesPions.remove(unePosition); 
    }

    /**
     * Methode qui ajoute un pion donne a une position donnee
     * @param unPion pion a ajouter 
     * @param unePosition position du pion a ajouter
     */
    private void ajouterPion(Pion unPion, Position unePosition) {
	mesPions.put(unePosition, unPion); 
    }
    public void addVue(VueGraphique vue){
		v=vue;
	}
	
	public void message(String m){
		v.sendMessage(m);
	}
    
    
    //--------------Notifications/Observation------------------------------
    
    /*public void notifyObservers(){
		
	}*/


}
