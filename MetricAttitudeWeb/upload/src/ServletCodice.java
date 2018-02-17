import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import struttura.Grafo;
import struttura.NodoClasse;

@WebServlet(name = "ServletCodice", urlPatterns = { "/ServletCodice" })

public class ServletCodice extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		

		response.setContentType("text");
		
		HttpSession sessione = request.getSession(false);
		Grafo grafo=(Grafo)sessione.getAttribute( "grafo" );
		String nomeProgetto=request.getParameter("name");
	    String nomeFile=request.getParameter("nome");
	    
	    NodoClasse nodoClasse=grafo.cercaNodoClasse(nomeFile); 
	    nomeFile=nomeFile+".java";
	    String pacchetto=nodoClasse.getPackage();
	    int i=pacchetto.indexOf("."); 
	   
	    System.out.println(pacchetto);
	    
	    if(i==-1){
	    	pacchetto=pacchetto+File.separator;
	    }
	    else{
	     	String[] list=pacchetto.split("\\.");
	    	pacchetto="";
	    	for(String s:list)
	    		pacchetto=pacchetto+s+File.separator;

	    }
	    
		
	
		//String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload"+File.separatorChar;
		String filePath = Path.getPath()+File.separatorChar;
		
		filePath=filePath+nomeProgetto+File.separator+"src"+File.separator;
		filePath=filePath+pacchetto+nomeFile;

	    
		 BufferedReader reader = new BufferedReader(new FileReader(filePath));
		 String codice=""; 
	     String line = reader.readLine();
	     codice=codice+line+"\n";
	     while(line!=null) {
	            System.out.println(line);
	            line = reader.readLine();
	            codice=codice+line+"\n";
	     }
	    
	     reader.close();
	     
	
	
		response.getWriter().write(codice);		
	}
	
	
	private static final long serialVersionUID = 1L;
    
    public ServletCodice() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}	

}
