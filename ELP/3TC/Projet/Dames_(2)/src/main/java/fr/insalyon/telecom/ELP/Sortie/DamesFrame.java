package fr.insalyon.telecom.ELP.Sortie; 

import fr.insalyon.telecom.ELP.Entree.LecteurDeDeplacementDeVue;
import fr.insalyon.telecom.ELP.Noyau.*;
import java.util.Observer;
import java.util.Observable;
import fr.insalyon.telecom.ELP.Noyau.EnsembleDePions; 
import javax.swing.*;  
import java.awt.GridLayout;
import java.awt.BorderLayout;
import javax.swing.JFrame;
import java.awt.Dimension;

public class DamesFrame extends JFrame{
	
	private Case damier[][];
	private GridLayout lay;
	private JLabel message;
	private LecteurDeDeplacementDeVue flux;
	public DamesFrame(String nom, LecteurDeDeplacementDeVue flux){
		super(nom);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		damier=new Case[10][10];
		lay=new GridLayout(10,10);
		JPanel contentPane = new JPanel(lay);
		JPanel total = new JPanel();
		total.setLayout(new BorderLayout());
		message=new JLabel("Espace messages");
		message.setMinimumSize(new Dimension(500,20));
		total.add(message, BorderLayout.SOUTH);
		
		
		for(int j=0;j<10;j++){
			for(int i=0;i<10;i++){
				if((i+j)%2 == 0){
					damier[i][j]=new Case(1,0,i,j,flux, message);
					contentPane.add(damier[i][j]);
				}else{
					damier[i][j]=new Case(2,0,i,j,flux,message);
					contentPane.add(damier[i][j]);
				}
			}
		}
		total.add(contentPane, BorderLayout.CENTER);
		this.getContentPane().add(total);
		this.setPreferredSize(new Dimension(500, 520));
		this.pack();
		this.setVisible(true);

	}
	
	public void update(EnsembleDePions e){
		
		for (int j = 0; j < Constantes.N; j++) {
    	    for (int i = 0; i < Constantes.N; i++) {
			Position pos = new Position(i,j); 
			
			if ( pos.estValide() ) {
		    //TODO
				
				if(e.obtenirPion(pos)==null){
					//System.out.print("X ");
					
					damier[i][j].setPion(0);
				}else{
					
					Pion p=e.obtenirPion(pos);
					Couleur b=Couleur.blanc();
					if(p.aMemeCouleur(b)){
						damier[i][j].setPion(1);
						
					}else{
						damier[i][j].setPion(2);
					}
			
				}
			} else {
			} 
    	  }
    	}
    	
		this.revalidate();
		this.repaint();
	}
	public JPanel[][] getDamier(){
		return damier;
	}
	
	public void deselect(){
		for(int j=0;j<10;j++){
			for(int i=0;i<10;i++){
				damier[i][j].deselect();
			}
		}
	}
	public void send(String m){
		message.setText(m);
	}
}
