import java.net.*;
import java.io.*;

public class Client {
	
	public static void main (String args[]) throws IOException {
		Socket socket = new Socket ("localhost", 8080);
		PrintWriter out = new PrintWriter( new OutputStreamWriter( socket.getOutputStream() ), true );
		
		BufferedReader in = new BufferedReader( new InputStreamReader(System.in));
		String line = in.readLine();
		while(!line.equals("quit")){
		out.println(line);	
		line=in.readLine();
	}		
	}
}

