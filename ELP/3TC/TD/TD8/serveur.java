import java.net.*;
import java.io.*;

public class serveur {
	
	public static void main (String[] arg) throws IOException {
		ServerSocket connection = new ServerSocket(8080);
		Socket socket = connection.accept();
		
		InputStream is = socket.getInputStream();
		BufferedReader in = new BufferedReader( new InputStreamReader(is));
		String line = in.readLine();
		while(line != null){
		System.out.println("Robin dit : " + line);
		line=in.readLine();
		}
		
	}
	
}

