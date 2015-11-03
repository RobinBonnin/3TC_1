/** Classe modelisant un interrupteur à bascule. */
public class ex2 {
    /** booleen indiquant l'etat de l'interrupteur */
    private boolean monEstEnMarche = false; 
    /**
     * Methode indiquant si l'interrupteur est en état de marche
     * @return 'true' si en marche
     */
    public boolean estEnMarche() {
	return monEstEnMarche; 
    }
    /** Methode basculant l'état de l'interrupteur. */
    public void basculer() {
	monEstEnMarche = (!monEstEnMarche); 
    }
}
