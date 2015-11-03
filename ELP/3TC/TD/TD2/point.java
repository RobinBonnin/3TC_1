public class Point {
	public double x;
	public double y;
	
	public double distanceori(){
		double distance = Math.sqrt((x)*x+(y)*y);
		return(distance);
	}
	public void coord(double x1,double y1){
		x=x1;
		y=y1;
	}
	public static double distancepoint(point p1, point p2){
		double distance = Math.sqrt(((p1.x)*(p1.x)-(p2.x)*(p2.x))+((p1.y)*(p1.y)-(p2.y)*(p2.y)));
		return(distance);
	}
}
		
		
