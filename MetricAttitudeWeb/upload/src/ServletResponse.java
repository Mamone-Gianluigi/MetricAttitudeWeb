import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet(name = "ServletResponse", urlPatterns = { "/ServletResponse" })

public class ServletResponse extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		

		response.setContentType("text/xml");
		
		
		System.out.println("ciao");
		//String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload"+File.separatorChar;
		String filePath = Path.getPath()+File.separatorChar;
	    String nome=request.getParameter("name");
	    System.out.println(nome);

	    FileReader file1 = new FileReader(filePath+nome+"\\"+nome+".json");
		BufferedReader b = new BufferedReader(file1);
	    String s;
	    s=b.readLine();
	    Object object=null;
	    JSONArray arrayObj=null;
	    JSONParser jsonParser=new JSONParser();
	    try {
			object=jsonParser.parse(s);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    arrayObj=(JSONArray) object;
	    System.out.println("Json object :: "+arrayObj);
	    b.close();
		
		response.getWriter().write(arrayObj.toString());		
	}
	
	
	private static final long serialVersionUID = 1L;
    
    public ServletResponse() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}	

}
