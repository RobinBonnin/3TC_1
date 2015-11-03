public class ex1{
	
public static void main  (String[] args) {
	int i;
	if(args.length==0){
			System.out.println("Rien");
			}
	else{
		for(i = 0;i < args.length; i++){
			//System.out.println("%d ",args[i]); Moi
			System.out.println("@"+i+"->"+args[i]);
			}
			for(String arg : args){
				System.out.println(">>> " + arg);
			}
		}
	}
}
