import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import struttura.*;
import java.util.*;

@WebServlet(name = "ServletPackageNavigation", urlPatterns = { "/ServletPackageNavigation" })

public class ServletPackageNavigation extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		

		response.setContentType("text");
		String path=request.getParameter("path");
		
		HttpSession sessione = request.getSession(false);
		Grafo grafo=(Grafo)sessione.getAttribute( "grafo" );
		
		
		//PRENDO I PACCHETTI CONTENUTI
		ArrayList<NodoPackage> nodoPa=grafo.getNodiPackage();
		ArrayList<String> list = new ArrayList<>();		
		for(NodoPackage x: nodoPa)
			if(x.getParentPackage().equals(path))
				list.add(x.getId()+"+"+x.getNome()+"+"+x.getMetricaLinee()+"+"+x.getMetricaClassi()+"+"+x.getMetricaAstrattezza()+"+"+x.getMetricaInstabilità());
	
			
		if(list.size()==0)
			response.getWriter().write("---!!---");
		else{
			String a1=String.join(";-;", list);
			response.getWriter().write(a1);		
		}
	}		

	
	
	private static final long serialVersionUID = 1L;
    
    public ServletPackageNavigation() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}	

}
