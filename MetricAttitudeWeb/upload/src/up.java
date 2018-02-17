import java.io.File;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.eclipse.jdt.core.dom.FieldDeclaration;
import org.eclipse.jdt.core.dom.ITypeBinding;
import org.eclipse.jdt.core.dom.Type;
import org.eclipse.jdt.core.dom.TypeDeclaration;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import parsing.Parser;
import parsing.Project;
import parsing.Utils;
import struttura.Arco;
import struttura.Grafo;
import struttura.NodoClasse;
import struttura.NodoClasseExternal;
import struttura.NodoPackage;
import struttura.TipoClasseExternal;
import visitor.MethodDelegation;
import decompressione.UnzipUtility;

/**
 * Servlet implementation class up
 */
@WebServlet(name = "up", urlPatterns = { "/up" })
@MultipartConfig
public class up extends HttpServlet implements javax.servlet.Servlet {
	// Variables
	private static final long serialVersionUID = 1L;
	private UnzipUtility unzipper;
	private Project project;
	private Parser parser;
	private Grafo grafo;

	// Constructor
	public up() {
		unzipper = new UnzipUtility();
		parser = new Parser(4);

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unused")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (!ServletFileUpload.isMultipartContent(request)) {
			throw new ServletException("Content type is not multipart/form-data");
		}

		// UPLOAD TRAMITE IL FILEUPLOADER
		parser.setGrafo(new Grafo());
		String filePath=Path.getPath();
		filePath = filePath + File.separatorChar;
		//String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload" + File.separatorChar;
		// String filePath =
		// "C:\\Users\\Fabio\\Desktop\\FileInUpload"+File.separatorChar;
		File file;
		FileItemFactory factory = (FileItemFactory) new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			// PARSING REQUEST AND UPLOAD
			List<FileItem> fields = upload.parseRequest(request);
			Iterator<FileItem> it = fields.iterator();
			FileItem fileItem = it.next();
			if (!fileItem.isFormField()) {
				// GET THE UPLOADED FILE PARAMETERS
				String fieldName = fileItem.getFieldName();
				String fileName = fileItem.getName();
				String contentType = fileItem.getContentType();
				boolean isInMemory = fileItem.isInMemory();
				long sizeInBytes = fileItem.getSize();
				// WRITE THE FILE
				//File destDir = new File("C:\\Users\\Gianluigi\\Desktop\\FileInUpload");
				File destDir = new File(Path.getPath());
				
				// File destDir = new
				// File("C:\\Users\\Fabio\\Desktop\\FileInUpload");
				if (fileName.lastIndexOf("\\") >= 0) {
					file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
				} else {
					file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
				}
				fileItem.write(file);
				System.out.println("File in upload: " + fileName);
				// DECOMPRESS THE FILE BY UnzipUtility
				unzipper.unzip(file, filePath);
				// DELETE THE FILE ZIP
				File x = new File(filePath);
				File[] files = x.listFiles(new FilenameFilter() {
					public boolean accept(File dir, String name) {
						return name.toLowerCase().endsWith(".zip");
					}
				});
				for (File y : files) {
					y.delete();
				}
				System.out.println("Eliminato file .zip superfluo!");
				System.out.println("File decompresso disponibile nella directory FileInUpload!");

				// GET THE SOURCE DIRECTORY
				String directoryProject = fileName.substring(0, fileName.length() - 4);
				System.out.println("Nome file = " + directoryProject);
				String nuovoPath = filePath + directoryProject;
				project = new Project(nuovoPath);
				
				//ottengo una lista di tutti gli elementi presenti in una lista...
				List<String> sourceFiles = project.getSourceFiles();
				// System.out.println(sourceFiles.toString());

				for (String fileNam : sourceFiles) {
					System.out.println("*---> " + fileNam);
				}

				System.out.println("fin qui ---------------------------------");

				// PARSE THE PROJECT
				parser.addClasspath(project.getSourcePath());
				parser.addClasspaths(project.getLibraryPath());		
				parser.addClasspaths(project.getBinaryPath());
				
				System.out.println(parser.getClasspath());

				for (String srcFile : sourceFiles) {
					// Operazioni per ottenere i path corretti
					int begin = srcFile.lastIndexOf(File.separatorChar);
					String nameSRC = srcFile.substring(begin + 1, srcFile.length());

					String percorsoFile;
					if (begin == -1) {
						percorsoFile = nuovoPath + File.separatorChar + "src" + File.separatorChar;
						System.out.println("AAAAAAAAAAAA");
					} else {
						percorsoFile = nuovoPath + File.separatorChar + "src" + File.separatorChar
								+ srcFile.substring(0, begin);
						System.out.println("BBBBBBBBBBB");
					}
					parser.parse(0, nuovoPath, directoryProject, percorsoFile, nameSRC);
					

					// path relativo di tutti i file presenti nella directory
					// src
					System.out.println("++--SRCFILE--++" + srcFile);
					// path della directory di progetto
					System.out.println("++-NUOVOPATH--++" + nuovoPath);
					// nome del file presente nella directory src
					System.out.println("++--NAMESRC--++" + nameSRC);
					// path del file presente nella directory src
					System.out.println("++--PERCORSOFILE--++" + percorsoFile);
					// nome delle directory di progetto
					System.out.println("++--DIRECTORYPROJECT--++" + directoryProject);
				}

				grafo = parser.getGrafo();
				
				ArrayList<NodoClasse> nodiClasse=grafo.getNodiClasse();
				
				for(NodoClasse nod:nodiClasse){
					interfacce(nod);
					estensioni(nod);
					delegazioni(nod);	
					fan(nod);
					numeroMessaggi(nod);
					nod.setDistanzaRadice(altezza(nod));
					metodiPotenziali(nod);
				}
				normalizzazioneMetricheClasse();	
				instabilit‡Pacchetto();
				composizioneNodo();
				normalizzazioneMetrichePacchetto();
				
				
				
				
				System.out.println(grafo.toString());
				// DA COMPLETARE

				// DELETE THE DIRECTORY
				/**
				 * FileUtils.deleteDirectory(destDir);
				 * System.out.println("Cartella temporanea cancellata!");
				 */

				// SETTING THE SESSION FOR THE JSP AND REDIRECT
				/**
				 * HttpSession session = request.getSession();
				 * session.setAttribute("Struttura", grafo); RequestDispatcher
				 * dispatcher = request.getRequestDispatcher("/output.jsp");
				 * dispatcher.forward(request, response);
				 */

				File grpFile = new File(filePath + directoryProject+File.separatorChar+directoryProject+ ".txt");
				grpFile.createNewFile();
				FileOutputStream fos = new FileOutputStream(grpFile.getAbsolutePath());
				// NOTA: l'estensione Ë del tutto arbitraria... Ovviamente,
				// evitate di scegliere estensioni quali .exe o .bat :-)
				// Ora posso scrivere l'oggetto sotto forma di stream di byte e
				// passarlo al file
				ObjectOutputStream oos = new ObjectOutputStream(fos);
				//Trasformazione dei dati in stream di byte
				oos.writeObject(grafo);
				oos.flush();
				oos.close();
				fos.close();
				response.sendRedirect(response.encodeRedirectURL("/upload?flag=1"));
				

			  /**
			   * NEL CASO IN CUI SI VUOLE SCRIVERE IL GRAFO NON CON LA SERIALIZZAZIONE MA CON JSON
				 Gson gson = new Gson();
			     String json = gson.toJson(grafo);
			     
			  // CREAZIONE DEL FILE JSON
				try {
					FileOutputStream fileJson = new FileOutputStream(nuovoPath+ "\\"+directoryProject+"Grafo.json");
				} catch (IOException e) {
					System.out.println("Errore: " + e);
					System.exit(1);
				}
				try (FileWriter fileJson = new FileWriter(nuovoPath+ "\\"+directoryProject+"Grafo.json")) {
					fileJson.write(json);
					fileJson.flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
				*/
				// CREO json
				ProgectJSON.scansiona(new File(nuovoPath));
			}
		} catch (FileUploadException e) {

			e.printStackTrace();

		} catch (Exception e2) {

			e2.printStackTrace();

		}

	}
	
	//CREO GLI ARCHI UTILIZZA 
	public void interfacce(NodoClasse nod){
	
			ITypeBinding binding=nod.getBinding();
			ITypeBinding[] interfacce=binding.getInterfaces();
			for(ITypeBinding interfaccia :interfacce){
				String nome=interfaccia.getName();
				
				NodoClasse no=grafo.cercaNodoClasse(nome);
				//Ë un'interfaccia di JAVA
				if(no==null){
					//controllo se l'interfaccia JAVA gi‡ Ë presente
					NodoClasseExternal nodo=grafo.cercaNodoClasseExternal(nome,TipoClasseExternal.INTERFACCIA);
					//l'interfaccia Java non Ë presente 
					if(nodo==null){
						NodoClasseExternal nodoEs=new NodoClasseExternal(Utils.getId(),nome,TipoClasseExternal.INTERFACCIA);
						grafo.addNodoClasseExternal(nodoEs);
						Arco coll = new Arco(Utils.getId(), "implementa", nod, nodoEs);
						grafo.addArco(coll);
					}
					else{
						Arco coll = new Arco(Utils.getId(), "implementa", nod, nodo);
						grafo.addArco(coll);
					}					
				}
				//E' un'interfaccia Utente
				else{
					Arco coll = new Arco(Utils.getId(), "implementa", nod, no);
					grafo.addArco(coll);
				}
			
			}
	}

	//CREO GLI ARCHI ESTENDE - CALCOLO ANCHE IL NUMERO DI SOTTOCLASSI DELLA CLASSE NOC
	public void estensioni(NodoClasse nod){
			
			TypeDeclaration node=nod.getNode();
			Type superC=node.getSuperclassType();
		
			if (superC != null){
				//CERCO LA CLASSE ESTESA
				String nome=superC.toString();
				NodoClasse nodoEsteso=grafo.cercaNodoClasse(nome);
				if(nodoEsteso==null){
					//vuol dire che Ë una classe esterna estesa
					
					//controllo se la classe JAVA gi‡ Ë presente
					NodoClasseExternal nodo=grafo.cercaNodoClasseExternal(nome,TipoClasseExternal.CLASSE);
					//la classe Java non Ë presente 
					if(nodo==null){
						NodoClasseExternal nodoEs=new NodoClasseExternal(Utils.getId(),nome,TipoClasseExternal.CLASSE);
						grafo.addNodoClasseExternal(nodoEs);
						Arco coll = new Arco(Utils.getId(), "estende", nod, nodoEs);
						grafo.addArco(coll);
					}
					else{
						Arco coll = new Arco(Utils.getId(), "estende", nod, nodo);
						grafo.addArco(coll);
					}					
				}
				else{
					// vuol dire che Ë una classe utente
					Arco coll = new Arco(Utils.getId(), "estende", nod, nodoEsteso);
					nodoEsteso.addNumeroSottoclassi();
					grafo.addArco(coll);
				}
			} 
	}
	
	//CREO GLI ARCHI UTILIZZA - CALCOLO ANCHE L'ACCOPPIAMENTO DELLA CLASSE : CBO
	public void delegazioni(NodoClasse nod){
		ArrayList<MethodDelegation> delegazioni =nod.getDelegazioni();
			
			for(MethodDelegation md:delegazioni){
				
				//INVOCAZIONE DI UN METODO DI UNA CLASSE UTENTE o DI UNA CLASSE JAVA
				NodoClasse link = grafo.cercaNodoClasse(md.getEndClass().getName());
				
				//SE VIENE INVOCATO UN METODO DI UNA CLASSE UTENTE
				if (link != null) {
					//CONTROLLO SE E' PRESENTE L'ARCO
					ArrayList<Arco> archiUtilizza=grafo.getArchiDiTipo("utilizza");
					Arco arco=null;
					for(Arco ar:archiUtilizza){
						if(ar.getFrom().getNome().equals(nod.getNome()) && ar.getTo().getNome().equals(link.getNome()))
							arco=ar;	
					}					
					//SE L'ARCO NON E' PRESENTE LO CREO
					if(arco==null){
						Arco coll = new Arco(Utils.getId(), "utilizza", nod, link);
						coll.incrementaNumero();
						grafo.addArco(coll);
						/**incremento l'accoppiamente solo quando creo un nuovo arco utilizza per due classi UTENTE*/
						nod.addAccoppiamentoClassi();
					}
					//SE L'ARCO E' PRESENTE INCREMENTO SOLO IL NUMERO
					else
						arco.incrementaNumero();
				}
				else{
					//CERCO LA CLASSE JAVA
					NodoClasseExternal nodo=grafo.cercaNodoClasseExternal(md.getEndClass().getName());
					//SE LA CLASSE JAVA NON E' PRESENTE
					if(nodo==null){
						//CREO LA CLASSE JAVA
						NodoClasseExternal newNodo;
						if(md.getEndClass().isInterface())
							newNodo = new NodoClasseExternal(Utils.getId(), md.getEndClass().getName(),TipoClasseExternal.INTERFACCIA);
						else
							newNodo = new NodoClasseExternal(Utils.getId(), md.getEndClass().getName(),TipoClasseExternal.CLASSE);
						grafo.addNodoClasseExternal(newNodo);
						//CONTROLLO SE E' PRESENTE L'ARCO
						ArrayList<Arco> archiUtilizza=grafo.getArchiDiTipo("utilizza");
						Arco arco=null;
						for(Arco ar:archiUtilizza){
							if(ar.getFrom().getNome().equals(nod.getNome()) && ar.getTo().getNome().equals(newNodo.getNome()))
								arco=ar;	
						}					
						//SE L'ARCO NON E' PRESENTE LO CREO
						if(arco==null){
							Arco coll = new Arco(Utils.getId(), "utilizza", nod, newNodo);
							coll.incrementaNumero();
							grafo.addArco(coll);
						}
						//SE L'ARCO E' PRESENTE INCREMENTO SOLO IL NUMERO
						else
							arco.incrementaNumero();
					}
					//SE LA CLASSE JAVA E' PRESENTE
					else{
						//CONTROLLO SE E' PRESENTE L'ARCO
						ArrayList<Arco> archiUtilizza=grafo.getArchiDiTipo("utilizza");
						Arco arco=null;
						for(Arco ar:archiUtilizza){
							if(ar.getFrom().getNome().equals(nod.getNome()) && ar.getTo().getNome().equals(nodo.getNome()))
								arco=ar;	
						}					
						//SE L'ARCO NON E' PRESENTE LO CREO
						if(arco==null){
							Arco coll = new Arco(Utils.getId(), "utilizza", nod, nodo);
							coll.incrementaNumero();
							grafo.addArco(coll);
						}
						//SE L'ARCO E' PRESENTE INCREMENTO SOLO IL NUMERO
						else
							arco.incrementaNumero();
					}
				}
				
				/**
				System.out.println(">>>>>>>>>> nodoClasse: "+md.getNodoClasse().getNome());
				System.out.println(">>>>>>>>>> startMethod: "+md.getStartMethod().toString());
				System.out.println(">>>>>>>>>> endClass: "+md.getEndClass().getName());
				System.out.println(">>>>>>>>>> binding: "+md.getBinding().getName());
				
				System.out.println(" ----------------------------------------------------------------------------------- ");
				*/
			}
	}
	
	//METODO CHE NORMALIZZA LE METRICHE DELLA CLASSE
	public void normalizzazioneMetricheClasse(){
	
		ArrayList<NodoClasse> classi=grafo.getNodiClasse();
		/**QUADRATO*/
		int massimoNumeroLineeCodice=0;
		int massimoNumeroCommenti=0;
		int massimoNumeroMetodi=0;
		int massimoNumeroFi=0;
		int massimoNumeroMessaggi=0;
		/**OVALE*/
		int massimoCiclomatica=0;
		int massimoSottoclassi=0;
		int massimoDistanzaRadice=0;
		int massimoAccoppiamento=0;
		int massimoMetodiPotenziali=0;
		
		//OTTENGO IL MASSIMO
		for(NodoClasse classe:classi){
			/**QUADRATO*/
			if(classe.getNumeroLineeCodice()>massimoNumeroLineeCodice)
				massimoNumeroLineeCodice=classe.getNumeroLineeCodice();
			if(classe.getNumeroCommenti()>massimoNumeroCommenti)
				massimoNumeroCommenti=classe.getNumeroCommenti();
			if(classe.getNumeroMetodi()>massimoNumeroMetodi)
				massimoNumeroMetodi=classe.getNumeroMetodi();
			if(classe.getNumeroFI()>massimoNumeroFi)
				massimoNumeroFi=classe.getNumeroFI();
			if(classe.getNumeroMessaggi()>massimoNumeroMessaggi)
				massimoNumeroMessaggi=classe.getNumeroMessaggi();
			/**OVALE*/
			if(classe.getCiclomatica()>massimoCiclomatica)
				massimoCiclomatica=classe.getCiclomatica();
			if(classe.getNumeroSottoclassi()>massimoSottoclassi)
				massimoSottoclassi=classe.getNumeroSottoclassi();
			if(classe.getDistanzaRadice()>massimoDistanzaRadice)
				massimoDistanzaRadice=classe.getDistanzaRadice();
			if(classe.getAccoppiamentoClassi()>massimoAccoppiamento)
				massimoAccoppiamento=classe.getAccoppiamentoClassi();
			if(classe.getMetodiPotenziali()>massimoMetodiPotenziali)
				massimoMetodiPotenziali=classe.getMetodiPotenziali();
		}
		
		/**QUADRATO*/
		float altezzaMassimaRettangolo=125;
		float altezzaMinimaRettangolo=75;
		float baseMassimaRettangolo=175;
		float baseMinimaRettangolo=145;
		int coloreMinimoRettangolo=100;
		int coloreMassimoRettangolo=210;
		int coloreSfondoMinimoRettangolo=57;
		int coloreSfondoMassimoRettangolo=210;
		float bordoMassimoRettangolo=9;
		float bordoMinimoRettangolo=2;
		/**OVALE*/
		float baseMassimaOvale=175;
		float baseMinimaOvale=145;
		int coloreMinimoOvale=100;
		int coloreMassimoOvale=210;
		float altezzaMassimaOvale=105;
		float altezzaMinimaOvale=55;
		float bordoMassimoOvale=9;
		float bordoMinimoOvale=2;
		int coloreSfondoMinimoOvale=57;
		int coloreSfondoMassimoOvale=210;
		
		for(NodoClasse classe:classi){
			
			/**QUADRATO*/
			//NORMALIZZAZIONE PER LE LINEE DI CODICE - altezza - quadrato
			float dif=(float) (classe.getNumeroLineeCodice()/(float)massimoNumeroLineeCodice);
			float prod=dif*(altezzaMassimaRettangolo-altezzaMinimaRettangolo);
			float metricaLinee=prod+altezzaMinimaRettangolo;
			classe.setMetricaNumeroLineeCodice((int)metricaLinee);
			
			//NORMALIZZAZIONE PER NUMERO COMMENTI - base - quadrato 
			float dif1=(float) (classe.getNumeroCommenti()/(float)massimoNumeroCommenti);
			float prod1=dif1*(baseMassimaRettangolo-baseMinimaRettangolo);
			float metricaCommenti=prod1+baseMinimaRettangolo;
			classe.setMetricaNumeroCommenti((int)metricaCommenti);
			
			//NORMALIZZAZIONE NUMERO METODI' - colore bordo - quadrato
			float dif3=(float)(classe.getNumeroMetodi()/(float)massimoNumeroMetodi);
			float prod3=dif3*(coloreMassimoRettangolo-coloreMinimoRettangolo);
			float metricaNumeroMetodi=prod3+coloreMinimoRettangolo;
			classe.setMetricaNumeroMedoti((int) metricaNumeroMetodi);
			
			//NORMALIZZAZIONE FI' - colore - quadrato
			float dif44=(float)(classe.getNumeroFI()/(float)massimoNumeroFi);
			float prod44=dif44*(coloreSfondoMassimoRettangolo-coloreSfondoMinimoRettangolo);
			float metricaNumeroFI=prod44+coloreSfondoMinimoRettangolo;
			classe.setMetricaFI((int) metricaNumeroFI);
			
			//NORMALIZZAZIONE NMS' - spessore bordo - quadrato
			float dif445=(float)(classe.getNumeroMessaggi()/(float)massimoNumeroMessaggi);
			float prod445=dif445*(bordoMassimoRettangolo-bordoMinimoRettangolo);
			float metricaNumeroMessaggi=prod445+bordoMinimoRettangolo;
			classe.setMetricaNumeroMessaggi((int) metricaNumeroMessaggi);
			
			/**OVALE*/
			//NORMALIZZAZIONE CICLOMATICA' - base - ovale
			float dif4=(float)(classe.getCiclomatica()/(float)massimoCiclomatica);
			float prod4=dif4*(baseMassimaOvale-baseMinimaOvale);
			float metricaCiclomatica=prod4+baseMinimaOvale;
			classe.setMetricaCiclomatica((int) metricaCiclomatica);
			
			//NORMALIZZAZIONE PER DISTANZA RADICE - altezza - ovale
			float dif6=(float) (classe.getDistanzaRadice()/(float)massimoDistanzaRadice);
			float prod6=dif6*(altezzaMassimaOvale-altezzaMinimaOvale);
			float metricaDistanzaRadice=prod6+altezzaMinimaOvale;
			classe.setMetricaDistanzaRadice((int)metricaDistanzaRadice);
			
			//NORMALIZZAZIONE NUMERO SOTTOCLASSI - colore bordo - ovale
			float dif5=(float)(classe.getNumeroSottoclassi()/(float)massimoSottoclassi);
			float prod5=dif5*(coloreMassimoOvale-coloreMinimoOvale);
			float metricaSottoclassi=prod5+coloreMinimoOvale;
			classe.setMetricaNumeroSottoclassi((int) metricaSottoclassi);
			
			//NORMALIZZAZIONE PER ACCOPPIAMENTO CLASSI - spessore bordo - ovale
			float dif7=(float) (classe.getAccoppiamentoClassi()/(float)massimoAccoppiamento);
			float prod7=dif7*(bordoMassimoOvale-bordoMinimoOvale);
			float metricaAccoppiamento=prod7+bordoMinimoOvale;
			classe.setMetricaAccoppiamentoClassi((int)metricaAccoppiamento);
			
			//NORMALIZZAZIONE PER METODI POTENZIALI - colore - ovale
			float dif78=(float) (classe.getMetodiPotenziali()/(float)massimoMetodiPotenziali);
			float prod78=dif78*(coloreSfondoMassimoOvale-coloreSfondoMinimoOvale);
			float metricaMetodiPotenziali=prod78+coloreSfondoMinimoOvale;
			classe.setMetricaMetodiPotenziali((int)metricaMetodiPotenziali);
		}
		
		//OTTENGO IL MASSIMO SPESSORE PRESENTE
		int massimoSpessore=0;
		ArrayList<Arco> arcoP=grafo.getArchi();
		for(Arco arcp:arcoP){
			if(!arcp.getTipo().equals(""))
				if(arcp.getNumero()>massimoSpessore)
					massimoSpessore=arcp.getNumero();
		}
				
		float spessoreMinimo=1;
		float spessoreMassimo=7;
		for(Arco arcp:arcoP){
			if(!arcp.getTipo().equals("")){
				//NORMALIZZAZIONE NUMERO' - SPESSORE FRECCIA
				float dif4=((float)arcp.getNumero()/massimoSpessore);
				float prod4=dif4*(spessoreMassimo-spessoreMinimo);
				float metricaNumero=prod4+spessoreMinimo;
				arcp.setMetricaNumero((int)metricaNumero);
			}
		}
		
		
	}	
	
	//CALCOLO FI
	public void fan(NodoClasse nod){
		
		//ARCHI USCENTI-INVOCAZIONE DEI METODI AL DI FUORI DELLA CLASSE
		ArrayList<Arco> archiU=grafo.uscentiNodo(nod.getNome());
		int fanIn=0;
		for(Arco ar:archiU)
				fanIn=fanIn+ar.getNumero();
		
		//INVOCAZIONE DI METODI DELLA STESSA CLASSE
		int fanOut=0;
		ArrayList<Arco> archiO=grafo.entrantiNodo(nod.getNome());
		for(Arco ar:archiO)
			if(ar.getFrom().getNome().equals(ar.getTo().getNome()))
				fanOut=fanOut+ar.getNumero();
			
		//LOC NUMERO LINEE CODICE
		int L=nod.getNumeroLineeCodice();
		
		int fan=L*(fanIn*fanOut);
		nod.setNumeroFI(fan);
		
	}
	
	//USATO PER CALCOLARE NUMERO MESSAGGI - NMS
	public void numeroMessaggi(NodoClasse nod){
		//ARCHI USCENTI-INVOCAZIONE DEI METODI AL DI FUORI DELLA CLASSE
		ArrayList<Arco> archiU=grafo.uscentiNodo(nod.getNome());
		int numeroMessaggi=0;
		for(Arco ar:archiU)
			numeroMessaggi=numeroMessaggi+ar.getNumero();
		nod.setNumeroMessaggi(numeroMessaggi);
	}
	
	//USATO PER CALCOLARE LA MASSIMO DISTANZA DALLA RADICE - DIT
	public int altezza(NodoClasse nod){
		String nome=nod.getSuperclasse();
		NodoClasse nodo=grafo.cercaNodoClasse(nome);
		if(nodo==null)
			return 0;
		else
			return altezza(nodo)+1;
	}

	//USATO PER CALCOLARE I METODI POTENZIALMENTE INVOCABILI - RFC
	public void metodiPotenziali(NodoClasse nod){
		ArrayList<Arco> archi=grafo.entrantiNodo(nod.getNome());
		int rfc=0;
		for(Arco ar:archi)
			rfc=rfc+ar.getNumero();
		nod.setMetodiPotenziali(rfc);
	}
	
	//CREO GLI ARCHI PACKAGE
	public void composizioneNodo(){
		//OTTENGO TUTTI I PACCHETTI DEL PROGETTO
		ArrayList<NodoPackage> nodiPackage=grafo.getNodiPackage();
		
		//PER OGNI PACCHETTO
		for(NodoPackage nodoPacchetto:nodiPackage){
			
			//OTTENGO LE CLASSI DEL PACCHETTO
			ArrayList<NodoClasse> nodiClassiPacchetto=nodoPacchetto.getNodiClassiPackage();
			//PER OGNI CLASSE DEL PACCHETTO OTTENGO GLI ARCHI USCENTI
			for(NodoClasse nod:nodiClassiPacchetto){
				ArrayList<Arco> archi=grafo.uscentiNodo(nod.getNome());
				//PER OGNI ARCO 
				for(Arco arco:archi){
					//SE L'ARCO E' FRA DUE CLASSI UTENTE
					if(arco.getTo() instanceof NodoClasse){
						NodoClasse nodoClasseTo=(NodoClasse) arco.getTo();
						//SE NON SI TROVANO NELLO STESSO PACCHETTO 
						if(!(nodoPacchetto.getNome()).equals((nodoClasseTo.getPackage()))){
							NodoPackage nodoPacchettoTo=grafo.getNodoPackage(nodoClasseTo.getPackage());
							
							//PRENDO TUTTI GLI ARCHI PACKAGE
							ArrayList<Arco> arch=grafo.getArchiDiTipo("");
							Arco presente=null;
							for(Arco arc:arch){
								//CONTROLLO SE L'ARCO E' GIA' PRESENTE
								if(arc.getFrom().getNome().equals(nodoPacchetto.getNome()) && 
										arc.getTo().getNome().equals(nodoPacchettoTo.getNome())){
										presente=arc;
										break;
								}
							}
							//SE L'ARCO NON E' PRESENTE
							if(presente==null){
								Arco arcoPacchetto=new Arco(Utils.getId(),"",nodoPacchetto,nodoPacchettoTo);
								arcoPacchetto.incrementaNumero();
								grafo.addArco(arcoPacchetto);
							}
							//SE L'ARCO E' GIA' PRESENTE
							else{
								presente.incrementaNumero();
							}
						}
						
					}
				}
			}
		}
		
	
	}

	//CALCOLO L'INSTABILITA' DI UN PACCHETTO 
	public void instabilit‡Pacchetto(){
		ArrayList<NodoPackage> nodiPackage=grafo.getNodiPackage();
		
		//PER OGNI PACCHETTO
		for(NodoPackage nodoPacchetto:nodiPackage){
			int accoppiamentoEfferente=0;
			int accoppiamentoAfferente=0;
			//OTTENGO LA LISTA DELLE CLASSI DEL PACCHETTO
			ArrayList<NodoClasse> classiPacchetto=nodoPacchetto.getNodiClassiPackage();
			//PER OGNI CLASSE DEL PACCHETTO
			for(NodoClasse classe:classiPacchetto){
				//OOTENGO GLI ARCHI USCENTI DI OGNI CLASSE DEL PACCHETTO
				ArrayList<Arco> archi=grafo.uscentiNodo(classe.getNome());
				//PER OGNI USCENTE
				for(Arco ar:archi){
					//SE L'ARCO E' FRA DUE CLASSI UTENTE
					if(ar.getTo() instanceof NodoClasse){
						//SE LE DUE CLASSI NON SI TROVANO NELLO STESSO PACCHETTO
						NodoClasse n=(NodoClasse) ar.getTo();
						if(!classe.getPackage().equals(n.getPackage()))
							accoppiamentoEfferente++;
					}
				}
				//OTENGO GLI ARCHI ENTRANTI DI OGNI CLASSE DEL PACCHETTO
				ArrayList<Arco> archi1=grafo.entrantiNodo(classe.getNome());
				//PER OGNI ENTRANTE
				for(Arco ar:archi1){
					//E' IL NODO CLASSE CHE HA UNA FRECCIA NELLA CLASSE SELEZIONATA
					NodoClasse from=(NodoClasse) ar.getFrom();
					if(!from.getPackage().equals(classe.getPackage()))
						accoppiamentoAfferente++;
				
				}
			}
			nodoPacchetto.setAccoppiamentoEfferente(accoppiamentoEfferente);
			nodoPacchetto.setAccoppiamentoAfferente(accoppiamentoAfferente);
			if(accoppiamentoAfferente==0 || accoppiamentoEfferente==0){
				System.out.println("zero");
				nodoPacchetto.setInstabilit‡(0);
			}
			else{
				
				float instabilit‡=((float)accoppiamentoEfferente/(accoppiamentoAfferente+accoppiamentoEfferente));
				nodoPacchetto.setInstabilit‡(instabilit‡);
			}
		}
	}
	
	//METODO CHE NORMALIZZA LE METRICHE DEL PACCHETTO
	public void normalizzazioneMetrichePacchetto(){
		/*
		PER NORMALIZZARE LE METRICHE
		( (V / VMAX) * (MAX - MIN) ) + MIN

		dove
		V Ë il valore del nodo da normalizzare,
		VMAX Ë il massimo valore ottenuto da tutti i nodi,
		MAX Ë il massimo valore rappresentabile (es. 100)
		MIN Ë il minimo valore rappresentabile (es. 10).
		
		*/
		//OTTENGO IL MASSIMO NUMERO DI CLASSI E DI LINEE DI CODICE
		ArrayList<NodoPackage> pacchetti=grafo.getNodiPackage();
		int massimoNumeroClassi=0;
		int massimoNumeroLinee=0;
		float massimoAstrattezza=0;
		float massimoInstabilit‡=0;
		for(NodoPackage pacc:pacchetti){
			if(pacc.getNumeroClassi()>massimoNumeroClassi)
				massimoNumeroClassi=pacc.getNumeroClassi();
			if(pacc.getNumeroLineeCodice()>massimoNumeroLinee)
				massimoNumeroLinee=pacc.getNumeroLineeCodice();
			int retval = Float.compare(pacc.getAstrattezza(),massimoAstrattezza);
			if(retval>0)
				massimoAstrattezza=pacc.getAstrattezza();
			int retval1 = Float.compare(pacc.getInstabilit‡(),massimoInstabilit‡);
			if(retval1>0)
				massimoInstabilit‡=pacc.getInstabilit‡();
		}
		
		float baseMassima=138;
		float baseMinima=88;
		float altezzaMassima=138;
		float altezzaMinima=88;
		float bordoMassimo=9;
		float bordoMinimo=2;
		int coloreMinimo=100;
		int coloreMassimo=210;
		for(NodoPackage pacc:pacchetti){
			//NORMALIZZAZIONE PER LE LINEE DI CODICE - altezza
			float dif=(float) (pacc.getNumeroLineeCodice()/(float)massimoNumeroLinee);
			float prod=dif*(altezzaMassima-altezzaMinima);
			float metricaLinee=prod+altezzaMinima;
			pacc.setMetricaLinee((int)metricaLinee);
			
			//NORMALIZZAZIONE PER IL NUMERO DI CLASSI - LARGHEZZA
			float dif1=(float) (pacc.getNumeroClassi()/(float)massimoNumeroClassi);
			float prod1=dif1*(baseMassima-baseMinima);
			float metricaClassi=prod1+baseMinima;
			pacc.setMetricaClassi((int)metricaClassi);
			
			//NORMALIZZAZIONE ASTRATTEZZA - BORDO
			float dif2=(pacc.getAstrattezza()/massimoAstrattezza);
			float prod2=dif2*(bordoMassimo-bordoMinimo);
			float metricaAstrattezza=prod2+bordoMinimo;
			pacc.setMetricaAstrattezza((int)metricaAstrattezza);
			
			//NORMALIZZAZIONE INSTABILITA' - COLORE
			float dif3=(pacc.getInstabilit‡()/massimoInstabilit‡);
			float prod3=dif3*(coloreMassimo-coloreMinimo);
			float metricaInstabilit‡=prod3+coloreMinimo;
			pacc.setMetricaInstabilit‡((int)metricaInstabilit‡);
		
		
		}
		
		//OTTENGO IL MASSIMO SPESSORE PRESENTE
		int massimoSpessore=0;
		ArrayList<Arco> arcoP=grafo.getArchiDiTipo("");
		for(Arco arcp:arcoP){
			if(arcp.getNumero()>massimoSpessore)
			massimoSpessore=arcp.getNumero();
		}
		
		float spessoreMinimo=1;
		float spessoreMassimo=7;
		for(Arco arcp:arcoP){
			//NORMALIZZAZIONE NUMERO' - SPESSORE FRECCIA
			float dif4=((float)arcp.getNumero()/massimoSpessore);
			float prod4=dif4*(spessoreMassimo-spessoreMinimo);
			float metricaNumero=prod4+spessoreMinimo;
			arcp.setMetricaNumero((int)metricaNumero);
		}
		
	}

	/**NON UTILIZZATO - VECCHIA SOLUZIONE*/
	public void composizioneClasse(NodoClasse nod){
				
			TypeDeclaration node=nod.getNode();
			FieldDeclaration[] dichiarazioni=node.getFields();
			for (FieldDeclaration s : dichiarazioni) { 
				
					// OTTENGO LE VARIABILI DICHIARATE
					String tipo = s.getType().toString();
					if (!tipo.equals("byte") && !tipo.equals("short") && !tipo.equals("int") && !tipo.equals("List")
							&& !tipo.equals("Integer") && !tipo.equals("String[]") && !tipo.equals("List<String>")
							&& !tipo.equals("Set<String>") && !tipo.equals("long") && !tipo.equals("float")
							&& !tipo.equals("double") && !tipo.equals("boolean") && !tipo.equals("char")
							&& !tipo.equals("String")&& !tipo.equals("Boolean")) {
						
						System.out.println(tipo);
						// Non Ë un tipo fondamentale
						NodoClasse link = grafo.cercaNodoClasse(tipo);
						
						//UTILIZZA UNA CLASSE DEL PROGETTO
						if (link != null) {
							Arco coll = new Arco(Utils.getId(), "utilizza", nod, link);
							grafo.addArco(coll);
						} 
						//UTILIZZA UNA CLASSE JAVA
						else {
							
							//controllo se la classe JAVA gi‡ Ë presente
							NodoClasseExternal nodo=grafo.cercaNodoClasseExternal(tipo,TipoClasseExternal.CLASSE);
							if(nodo==null){
								NodoClasseExternal newNodo = new NodoClasseExternal(Utils.getId(), tipo,TipoClasseExternal.CLASSE);
								grafo.addNodoClasseExternal(newNodo);
								Arco coll = new Arco(Utils.getId(), "utilizza", nod, newNodo);
								grafo.addArco(coll);
							}
							else{
								Arco coll = new Arco(Utils.getId(), "utilizza", nod, nodo);
								grafo.addArco(coll);
							}
							
							
						}
					}
				}
	}
	
	/**NON UTILIZZATO - VECCHIA SOLUZIONE*/
	public void interfacce2(NodoClasse nod){
		
			String implementato = null;
			// Contiene la lista delle interfaccie implementate dalla classe
			ArrayList<String> implementati = new ArrayList<String>();
			
		//	System.out.println("<<<<<<<<"+nod.getNome()+"<<<<<<< : "+nod.getSource());
			
			int indice = nod.getSource().indexOf("implements ");
			char testChar = 'a';
			int r = indice;
			while (testChar == '{') {
				testChar = nod.getSource().charAt(r++);
				if (testChar == '\n') {
					indice = -1;
					break;
				}
			}
			if (indice != -1) {
				int indice2 = nod.getSource().indexOf('{', indice);
				implementato = nod.getSource().substring(indice + 11, indice2 - 1);
				implementato = implementato.replaceAll("\\s+", "");
				if (implementato.contains(",")) {
					String[] parts = implementato.split(",");
					for (int s = 0; s < parts.length; s++)
						implementati.add(parts[s]);
			
				} 
				else
					implementati.add(implementato);
			}
			// IMPLEMENTS
			if (!implementati.isEmpty()) {
				for (String nome : implementati) {
					
					NodoClasse no=grafo.cercaNodoClasse(nome);
					//Ë un'interfaccia di JAVA
					if(no==null){
						//controllo se l'interfaccia JAVA gi‡ Ë presente
						NodoClasseExternal nodo=grafo.cercaNodoClasseExternal(nome,TipoClasseExternal.INTERFACCIA);
						//l'interfaccia Java non Ë presente 
						if(nodo==null){
							NodoClasseExternal nodoEs=new NodoClasseExternal(Utils.getId(),nome,TipoClasseExternal.INTERFACCIA);
							grafo.addNodoClasseExternal(nodoEs);
							Arco coll = new Arco(Utils.getId(), "implementa", nod, nodoEs);
							grafo.addArco(coll);
						}
						else{
							Arco coll = new Arco(Utils.getId(), "implementa", nod, nodo);
							grafo.addArco(coll);
						}					
					}
					//E' un'interfaccia Utente
					else{
						Arco coll = new Arco(Utils.getId(), "implementa", nod, no);
						grafo.addArco(coll);
					}		
				}
			}	
	}
	

	
}
