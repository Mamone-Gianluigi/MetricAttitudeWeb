package parsing;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import org.eclipse.jdt.core.JavaCore;
import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTParser;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jface.text.Document;
import struttura.Grafo;
import visitor.MyVisitor;

public class Parser {

	private String _javaVersion = JavaCore.VERSION_1_7;
	private String _separator = "";
	private String[] _classpath;
	private Grafo grafo;
	

	public Grafo getGrafo() {
		return grafo;
	}

	public void setGrafo(Grafo grafo) {
		this.grafo = grafo;
	}

	public Parser(int javaVersion) {
		Utils.print("File parsing.");
		_separator = System.getProperty("path.separator");
		_classpath = java.lang.System.getProperty("java.class.path").split(_separator);

		switch (javaVersion) {
		case 1:
			_javaVersion = JavaCore.VERSION_1_1;
			break;
		case 2:
			_javaVersion = JavaCore.VERSION_1_2;
			break;
		case 3:
			_javaVersion = JavaCore.VERSION_1_3;
			break;
		case 4:
			_javaVersion = JavaCore.VERSION_1_4;
			break;
		case 5:
			_javaVersion = JavaCore.VERSION_1_5;
			break;
		case 6:
			_javaVersion = JavaCore.VERSION_1_6;
			break;
		case 7:
			_javaVersion = JavaCore.VERSION_1_7;
			break;
		// case 8: _javaVersion = JavaCore.VERSION_1_8;break;
		default:
			_javaVersion = JavaCore.VERSION_1_7;
			break;
		}
	}

	public void addClasspaths(String path) {
		if (FileManager.directoryExists(path)) {
			File[] dirContents = new File(path).listFiles(new JarFilenameFilter());
			String[] nClasspath = new String[_classpath.length + dirContents.length];
			System.arraycopy(_classpath, 0, nClasspath, 0, _classpath.length);

			int i = 0;
			for (File f : dirContents) {
				nClasspath[_classpath.length + (i++)] = f.getAbsolutePath();
			}

			_classpath = new String[nClasspath.length];
			System.arraycopy(nClasspath, 0, _classpath, 0, nClasspath.length);
		}
	}

	public void addClasspath(String path) {
		//if (FileManager.fileExists(path)) {
			String[] nClasspath = new String[_classpath.length + 1];
			System.arraycopy(_classpath, 0, nClasspath, 0, _classpath.length);
			nClasspath[_classpath.length] = new File(path).getAbsolutePath();
			_classpath = new String[nClasspath.length];
			System.arraycopy(nClasspath, 0, _classpath, 0, nClasspath.length);
		//}
	}

	public String getClasspath() {
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < _classpath.length; i++) {
			if (i == (_classpath.length - 1))
				sb.append(_classpath[i]);
			else
				sb.append(_classpath[i] + _separator);
		}

		return sb.toString();
	}

	
	public void parse(int type, String projectPath, String project, String filePath, String fileName)
			throws LocalException {

		Utils.print("Parsing del file:" + fileName);

		try {
			String str = FileManager.readFileToString(filePath + File.separator + fileName);
			
			ASTParser parser = ASTParser.newParser(AST.JLS4);
			parser.setKind(ASTParser.K_COMPILATION_UNIT);
			parser.setSource(str.toCharArray());
			parser.setResolveBindings(true);
			parser.setBindingsRecovery(false);
			
			parser.setUnitName(project + File.separator + fileName);
		    parser.setEnvironment(_classpath, new String[] { filePath }, new
		    String[] { "UTF8" }, true);

			Map<?, ?> options = JavaCore.getOptions();
			JavaCore.setComplianceOptions(_javaVersion, options);
			parser.setCompilerOptions(options);

			Document document = new Document(str);

			final CompilationUnit compilation = (CompilationUnit) parser.createAST(null);
			

			compilation.recordModifications();

			// COMPILATION CONTIENE IL CODICE DELLA CLASSE
			// System.out.println("COMPILATION "+compilation);
			System.out.println("DOCUMENT " + document);
			System.out.println("FILE NAME " + fileName);
			// System.out.println("9999999999999999999999999999999999999999999999999999999999999");

			MyVisitor visitor = new MyVisitor(compilation, document, fileName);
			visitor.setGrafo(grafo);
			compilation.accept(visitor);
			

		} catch (IOException ioe) {
			ioe.printStackTrace();
			throw new LocalException("Error parsing file '" + fileName + "'");

		}
	}
	
	public void print() {
		Utils.print("Classpath.");
		Utils.print(this.getClasspath());
	}
}
