/** Classe testant l'interrupteur à bascule. */
public class InterrupteurTest {
    public static void main(String[] args) {
	Interrupteur i = new Interrupteur(); 
	if(!(i.estEnMarche())){
		System.out.println("OK");
    }else{
		System.out.println("ERROR");
	}
	
	i.basculer();
	
	if(i.estEnMarche()){
		System.out.println("OK");
    }else{
		System.out.println("ERROR");
	}
}
}
