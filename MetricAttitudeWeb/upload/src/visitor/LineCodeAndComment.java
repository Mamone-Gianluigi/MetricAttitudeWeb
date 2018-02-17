package visitor;

/**
* Questa classe conta il numero di righe del codice sorgente escludendo i commenti, in un file Java
* Lo pseudocodice è il seguente
* 
* Iniziale: set count = 0, commentBegan = false
* Inizio: Leggi linea
* Inizia: se la riga non è nulla, vai a Verifica, altrimenti vai a Fine
* Verifica: se la linea è una linea banale (dopo il ritaglio, inizia con // o è ""), vai a Inizio
* Se commentBegan = true
* se il commento non è terminato in linea 
* vai su Start
* altro 
* line = ciò che rimane nella riga dopo che il commento finisce
* commenBegan = false
* se la linea è banale
* vai su Start
* Se line è una linea di codice sorgente valida, count ++
* Se il commento è iniziato nella riga, imposta commentBegan = true
* vai su Start
* Fine: numero di stampe
*/
public class LineCodeAndComment {
	//public static int getNumberOfLines(BufferedReader bReader) throws IOException {
	public static int[] getNumberOfLines(String item[]){	
		int count = 0;
		int i=0;
		int result[]=new int[2];
		boolean commentBegan = false;
		//String line = null;

		//while ((line = bReader.readLine()) != null) {
		for(String line : item){
			//System.out.println("LINEA : "+line);
			line = line.trim();
			if ("".equals(line) || line.startsWith("//")) {
				i++;
				continue;
			}
			if (commentBegan) {
				if (commentEnded(line)) {
					line = line.substring(line.indexOf("*/") + 2).trim();
					commentBegan = false;
					if ("".equals(line) || line.startsWith("//")) {
						i++;
						continue;
					}
					i++;
				} 
				else{
					//i++;
					continue;
				}
			}
			if (isSourceCodeLine(line)) {
				count++;
			}
			if (commentBegan(line)) {
				commentBegan = true;
			}
		}
		result[0]=i;
		result[1]=count;
		return result;
	}
	
	/**
	 * 
	 * @param line
	 * @return Questo metodo controlla se nella riga indicata è iniziato un commento e non è terminato
	 */
	private static boolean commentBegan(String line) {
		// If line = /* */, this method will return false
		// If line = /* */ /*, this method will return true
		int index = line.indexOf("/*");
		if (index < 0) {
			return false;
		}
		int quoteStartIndex = line.indexOf("\"");
		if (quoteStartIndex != -1 && quoteStartIndex < index) {
			while (quoteStartIndex > -1) {
				line = line.substring(quoteStartIndex + 1);
				int quoteEndIndex = line.indexOf("\"");
				line = line.substring(quoteEndIndex + 1);
				quoteStartIndex = line.indexOf("\"");
			}
			return commentBegan(line);
		}
		return !commentEnded(line.substring(index + 2));
	}
	
	/**
	 * 
	 * @param line
	 * @return Questo metodo controlla se nella riga indicata è terminato un 
	 * commento e non è stato avviato alcun nuovo commento
	 */  
	private static boolean commentEnded(String line) {
		// If line = */ /* , this method will return false
		// If line = */ /* */, this method will return true
		int index = line.indexOf("*/");
		if (index < 0) {
			return false;
		} else {
			String subString = line.substring(index + 2).trim();
			if ("".equals(subString) || subString.startsWith("//")) {
				return true;
			}
			if(commentBegan(subString))
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}

	/** 
	 * @param line
	 * @return Questo metodo restituisce true se è presente un codice sorgente valido nella riga di input specificata. Non ti preoccupare se il commento è iniziato o meno.
	 * Questo metodo funzionerà solo se siamo sicuri che il commento non sia già iniziato in precedenza. Quindi, questo metodo dovrebbe essere chiamato solo dopo che è stato chiamato {@link #commentBegan (String)}
	 */
	private static boolean isSourceCodeLine(String line) {
		boolean isSourceCodeLine = false;
		line = line.trim();
		if ("".equals(line) || line.startsWith("//")) {
			return isSourceCodeLine;
		}
		if (line.length() == 1) {
			return true;
		}
		int index = line.indexOf("/*");
		if (index != 0) {
			return true;
		} else {
			while (line.length() > 0) {
				line = line.substring(index + 2);
				int endCommentPosition = line.indexOf("*/");
				if (endCommentPosition < 0) {
					return false;
				}
				if (endCommentPosition == line.length() - 2) {
					return false;
				} else {
					String subString = line.substring(endCommentPosition + 2)
							.trim();
					if ("".equals(subString) || subString.indexOf("//") == 0) {
						return false;
					} else {
						if (subString.startsWith("/*")) {
							line = subString;
							continue;
						}
						return true;
					}
				}

			}
		}
		return isSourceCodeLine;
	}
}