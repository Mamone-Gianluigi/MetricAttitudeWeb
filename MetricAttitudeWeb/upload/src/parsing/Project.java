package parsing;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class Project {
	private String _projectName;
	private String _projectDir;
	private String _projectPath;
	private String _sourcePath;
	private String _libraryPath;
	private String _binaryPath;

	private List<String> _sourceFiles;
	private String[] _package;

	public Project(String path) throws LocalException {

		// stampo la directory corrente
		try {
			Utils.print("Directory Corrente:" + new File(".").getCanonicalPath());
		} catch (IOException e) {
			throw new LocalException("Impossibile indivuare la directory di lavoro corrente.");
		}

		if (path == null)
			throw new LocalException("Il path del progetto è vuoto.");
		if (!FileManager.directoryExists(path))
			throw new LocalException("La path del progetto non è valida.");

		Utils.print("Impostazione del Progetto.");
		// nel caso c'è lo / finale lo elimino
		if (path.endsWith(File.separator))
			path = path.substring(0, path.length() - 1);
		_projectPath = path;
		// ottengo il nome del progetto e la path della directory in cui è
		// contenuto
		int pos = path.lastIndexOf(File.separator);
		if (pos > -1) {
			_projectDir = path.substring(0, pos);
			_projectName = path.substring(pos + 1);
		} else {
			_projectDir = ".";
			_projectName = path;
		}

		// cerco la directory src all'interno del progetto
		_sourcePath = _projectPath + File.separator + Constants.sourcePath;
		System.out.println(_sourcePath);
		if (!FileManager.directoryExists(_sourcePath)) {
			throw new LocalException("La directory src non è presente.");
		}

		// cerco la directory lib all'interno del progetto
		_libraryPath = _projectPath + File.separator + Constants.libraryPath;
		System.out.println(_libraryPath);
		if (!FileManager.directoryExists(_libraryPath)) {
			if (!FileManager.createDirectory(_libraryPath))
				throw new LocalException("La Directory lib non è presente.");
		}

		// cerco la directory bin all'interno del progetto
		_binaryPath = _projectPath + File.separator + Constants.binaryPath;
		System.out.println(_binaryPath);
		if (!FileManager.directoryExists(_binaryPath)) {
			if (!FileManager.createDirectory(_binaryPath))
				throw new LocalException("La directory bin non è presente");
		}

		scan();
		// aggiunta per i package
		scanDir();
	}

	public String getProjectName() {
		return _projectName;
	}

	public String getProjectDir() {
		return _projectDir;
	}

	public String getProjectPath() {
		return _projectPath;
	}

	public String getSourcePath() {
		return _sourcePath;
	}

	public String getLibraryPath() {
		return _libraryPath;
	}

	public String getBinaryPath() {
		return _binaryPath;
	}

	// stampa le diverse informazioni riguardanti un progetto
	public void print() {
		Utils.print("Project name:" + _projectName);
		Utils.print("Project directory:" + _projectDir);
		Utils.print("Project path:" + _projectPath);
		Utils.print("Source path:" + _sourcePath);
		Utils.print("Library path:" + _libraryPath);
		Utils.print("Binary path:" + _binaryPath);
	}

	// inserisce in una lista il path relativo di tutti i file presenti nella
	// directory src
	private void scan() {
		Utils.print("File scanning.");
		Utils.print("Source directory:" + getSourcePath());
		// _sourceFiles = FileManager.scanProject(getSourcePath());
		_sourceFiles = FileManager.scanProject(getSourcePath());
		// Utils.print(_sourceFiles.size()+"");
	}

	private void scanDir() {
		Utils.print("Dir scanning.");
		Utils.print("Source directory:" + getSourcePath());

		_package = FileManager.listDir(_sourcePath);
		System.out.println(_package.length);
		// Utils.print(_sourceFiles.size()+"");
	}

	// restituisce la lista che contiene il path relativo dei file presenti
	// nella directory src
	public List<String> getSourceFiles() {
		return _sourceFiles;
	}

	public String[] getPackage() {
		return _package;
	}

}
