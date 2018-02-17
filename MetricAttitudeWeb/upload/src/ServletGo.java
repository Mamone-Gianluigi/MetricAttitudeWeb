import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import struttura.*;
import java.util.*;

@WebServlet(name = "ServletGo", urlPatterns = { "/ServletGo" })

public class ServletGo extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		

		response.setContentType("text");
		String path=request.getParameter("path");
		int id= Integer.parseInt(request.getParameter("id"));
		boolean esterne= Boolean.parseBoolean(request.getParameter("esterne"));
		
		HttpSession sessione = request.getSession(false);
		Grafo grafo=(Grafo)sessione.getAttribute( "grafo" );
		
		NodoClasse nodoClasse=grafo.getNodoClasse(id);
		//E' UNA CLASSE
		if(nodoClasse!=null){
			 	String nomeFile=nodoClasse.getNome()+".java";
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
				String nomeProgetto=request.getParameter("name");
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
			     
			
			
				response.getWriter().write("acf12345"+codice);		
		}
		else{
			//PRENDO I PACCHETTI CONTENUTI
			ArrayList<NodoPackage> nodoPa=grafo.getNodiPackage();
			ArrayList<String> list = new ArrayList<>();		
			for(NodoPackage x: nodoPa)
				if(x.getParentPackage().equals(path))
					list.add(x.getId()+"+"+x.getNome()+"+"+x.getMetricaLinee()+"+"+x.getMetricaClassi()+"+"+x.getMetricaAstrattezza()+"+"+x.getMetricaInstabilità());
			
			
			ArrayList<NodoClasse> nodoCl=grafo.getNodiClasse();
			ArrayList<String> list1 = new ArrayList<>();
			ArrayList<NodoClasseExternal> nodoCl2=grafo.getNodiClasseExternal();
			ArrayList<String> list2 = new ArrayList<>();
			if(!path.equals("")){
				for(NodoClasse classe: nodoCl)
					if(classe.getPackage().equals(path))
						list1.add(classe.getId()+"+"+classe.getNome()+"+"+
								classe.getMetricaAccoppiamentoClassi()+"+"+classe.getMetricaCiclomatica()+"+"+
								classe.getMetricaDistanzaRadice()+"+"+classe.getMetricaFI()+"+"+
								classe.getMetricaNumeroSottoclassi()+"+"+classe.getMetricaNumeroLineeCodice()+
								"+"+classe.getMetricaNumeroMedoti()+"+"+classe.getMetricaMetodiPotenziali()+"+"+
								classe.getMetricaNumeroCommenti()+"+"+classe.getMetricaNumeroMessaggi());
				
			}
					
				
			
			if(list.size()==0 && list1.size()==0)
				response.getWriter().write("---!!---");
			else{
				String a1=String.join(";-;", list);
				String a2=String.join(":-:", list1);
				response.getWriter().write(a1+"!!"+a2);
			
			}
		}
		
	}
	
	
	private static final long serialVersionUID = 1L;
    
    public ServletGo() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}	

}
