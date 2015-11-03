public class Coordonnees {
	public static void main(String[] args){
		
		Point p1 = new Point();
		p1.coord(10.0d,5.0d);
		
		Point p2 = new Point();
		p2.coord(10.0d,5.0d);
		System.out.println("Coord1 = "+"("p1.x+";"p1.y+")\nCoord2 = "+p2.x+p2.y+"\nDist1 = "+p1.distanceori()+"\nDist2 = "+p2.distanceori()+
		"\nDist point = "+point.distancepoint(p1,p2));
	}
}
