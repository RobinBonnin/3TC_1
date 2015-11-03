package fr.insalyon.telecom.ELP.Sortie; 
import fr.insalyon.telecom.ELP.Entree.LecteurDeDeplacementDeVue ;
import java.awt.Graphics;
import java.awt.Color;
import javax.swing.*;
import fr.insalyon.telecom.ELP.Noyau.*;
import java.awt.event.*;
public class Case extends JPanel implements MouseListener
{
	//Vaut 0 si pas de pièces, 1 si blanc, 2 si noir.
    private int pionCase;
    private int couleurCase;
    private boolean survol;
    private boolean selected;
    private Position pos;
    private LecteurDeDeplacementDeVue flux;
    private JLabel message; 

    
    public Case(int couleur, int cas, int x, int y,LecteurDeDeplacementDeVue flux,JLabel message){
		super();
		Color brown = new Color(107,69,38);
		if(couleur==1){
			this.setBackground(Color.white);
		}else{
			this.setBackground(brown);
		}
		couleurCase=couleur;
		pionCase=cas;
		pos=new Position(x,y);
		survol=false;
		this.flux=flux;
		this.message=message;
		selected=false;
		addMouseListener(this);
	}
     
    protected void paintComponent(Graphics g){
        super.paintComponent(g);

        if(pionCase==1){
				g.setColor(Color.white);
				g.fillOval(this.getWidth()/10, this.getHeight()/10, 8*this.getWidth()/10, 8*this.getHeight()/10);

		}else if(pionCase==2){
				g.setColor(Color.black);
				g.fillOval(this.getWidth()/10, this.getHeight()/10, 8*this.getWidth()/10, 8*this.getHeight()/10);		
		}
		if(survol || selected){
			this.setBackground(Color.red);
		}else{
			if(couleurCase==1){
				this.setBackground(Color.white);
			}else{
				Color brown = new Color(107,69,38);
				this.setBackground(brown);
			}
		}
		
	}	
	

	
	public void setPion(int cas){
		
		pionCase=cas;
	}	
	public void mouseEntered(MouseEvent me){
		survol=true;
		repaint();
	}
	
	public void mousePressed(MouseEvent me){}
	public void mouseReleased(MouseEvent me){
	}
	public void mouseClicked(MouseEvent me){
		selected=true;
		System.out.println(pos);
		flux.setPosition(pos);
		}
	public void mouseExited(MouseEvent me){
		survol=false;
		repaint();
	}
	public void deselect(){
		selected=false;
	}
}
