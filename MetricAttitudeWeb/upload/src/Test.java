import parsing.LocalException;
import parsing.Parser;
import struttura.Grafo;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
			try {
			Parser parser = new Parser(7);
			parser.setGrafo(new Grafo());
						
			parser.addClasspath("C:\\Users\\Gianluigi\\Desktop\\FileInUpload\\Manager\\src");		
			parser.addClasspaths("C:\\Users\\Gianluigi\\Desktop\\FileInUpload\\Manager\\lib");
			parser.addClasspaths("C:\\Users\\Gianluigi\\Desktop\\FileInUpload\\Manager\\bin");
			
			parser.parse(0, "C:\\Users\\Gianluigi\\Desktop\\FileInUpload\\Manager", "Manager", 
					"C:\\Users\\Gianluigi\\Desktop\\FileInUpload\\Manager\\src\\core\\cerca", "Cittadino.java");
			} catch (LocalException e) {}
		}
}
