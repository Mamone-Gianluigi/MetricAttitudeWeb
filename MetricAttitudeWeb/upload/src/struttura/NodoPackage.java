package struttura;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.util.ArrayList;

public class NodoPackage extends Nodo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
															
	private String parentPackage;	
	
	private int numeroLineeCodice;							//LOCp - ALTEZZA
	private int numeroClassiConcrete;						//CC
	private int numeroClassiAstratte;						//AC
	private int numeroClassi;								//Ncl=CC+AC - BASE
	private float astrattezza;								//A=AC/(AC+CC) - BORDO
	private int accoppiamentoEfferente;						//Ce
	private int accoppiamentoAfferente;						//Ca
	private float instabilità;								//Ce/(Ce+Ca) - COLORE
	
	private int metricaClassi;								//BASE
	private int metricaLinee;								//ALTEZZA
	private int metricaAstrattezza;							//BORDO
	private int metricaInstabilità;							//COLORE
	private ArrayList<NodoClasse> nodiClassiPacchetto;
	
	
	public NodoPackage(){
		super();
		parentPackage=null;
		numeroLineeCodice=0;
		numeroClassiConcrete=0;
	    numeroClassiAstratte=0;
	    numeroClassi=0;
	    astrattezza=0;
	    accoppiamentoAfferente=0;
	    accoppiamentoEfferente=0;
		instabilità=0;
		metricaClassi=0;
		metricaLinee=0;
		metricaAstrattezza=0;
		metricaInstabilità=0;  
		nodiClassiPacchetto=new ArrayList<>();
	}

	public NodoPackage(int id, String nome) {
		super(id, nome);
		nodiClassiPacchetto=new ArrayList<>();
		parentPackage=null;
		numeroLineeCodice=0;	
		numeroClassiConcrete=0;
	    numeroClassiAstratte=0;
	    metricaClassi=0;
	    metricaLinee=0;
	    instabilità=0;
	}
	
	//PACCHETTO PADRE
	public String getParentPackage() {
		return parentPackage;
	}

	public void setParentPackage(String parentPackage) {
		this.parentPackage = parentPackage;
	}

	//CLASSI
	public void setNumeroClassi(int numeroClassi) {
		this.numeroClassi = numeroClassi;
	}
	
	public int getNumeroClassi() {
		return numeroClassi;
	}
	
	public int getMetricaClassi() {
		return metricaClassi;
	}

	public void setMetricaClassi(int metricaClassi) {
		this.metricaClassi = metricaClassi;
	}
	
	//CLASSI CONCRETE
	public int getNumeroClassiConcrete() {
		return numeroClassiConcrete;
	}

	public void setNumeroClassiConcrete(int numeroClassiConcrete) {
		this.numeroClassiConcrete = numeroClassiConcrete;
	}

	public void addNumeroClassiConcrete() {
		numeroClassiConcrete = numeroClassiConcrete+1;
		numeroClassi=numeroClassi+1;
	}
	
	//CLASSI ASTRATTE
	public int getNumeroClassiAstratte() {
		return numeroClassiAstratte;
	}

	public void setNumeroClassiAstratte(int numeroClassiAstratte) {
		this.numeroClassiAstratte = numeroClassiAstratte;
	}
	
	public void addNumeroClassiAstratte() {
		numeroClassiAstratte = numeroClassiAstratte+1;
		numeroClassi=numeroClassi+1;
	}
	
	//NUMERO LINEE DI CODICE
	public int getNumeroLineeCodice() {
		return numeroLineeCodice;
	}

	public void setNumeroLineeCodice(int numeroLineeCodice) {
		this.numeroLineeCodice = numeroLineeCodice;
	}
	
	public void addNumeroLineeCodice(int numeroLineeCodice) {
		this.numeroLineeCodice = this.numeroLineeCodice+numeroLineeCodice;
	}
	
	public int getMetricaLinee() {
		return metricaLinee;
	}

	public void setMetricaLinee(int metricaLinee) {
		this.metricaLinee = metricaLinee;
	}

	//TUTTE LE CLASSI DEL PACKAGE
	public ArrayList<NodoClasse> getNodiClassiPackage() {
		return nodiClassiPacchetto;
	}
	
	public void setNodiClassePackage(ArrayList<NodoClasse> nodiPackage) {
		this.nodiClassiPacchetto = nodiPackage;
	}
	
	public void addNodiPackage(NodoClasse nodoClasse) {
		nodiClassiPacchetto.add(nodoClasse);
		if(nodoClasse.getTipoClasse()==TipoClasse.CONCRETA){
			numeroClassiConcrete=numeroClassiConcrete+1;
			numeroClassi=numeroClassi+1;
		}
		else if(nodoClasse.getTipoClasse()==TipoClasse.ASTRATTA 
					|| nodoClasse.getTipoClasse()==TipoClasse.INTERFACCIA){
			numeroClassiAstratte=numeroClassiAstratte+1;
			numeroClassi=numeroClassi+1;
		}
		numeroLineeCodice=numeroLineeCodice+nodoClasse.getNumeroLineeCodice();
		astrattezza=((float)(numeroClassiAstratte)/(getNumeroClassi()));
		
	}
	
	//ASTRATTEZZA;
	public float getAstrattezza() {
		return astrattezza;
	}

	public void setAstrattezza(float astrattezza) {
		this.astrattezza = astrattezza;
	}
	
	public int getMetricaAstrattezza() {
		return metricaAstrattezza;
	}

	public void setMetricaAstrattezza(int metricaAstrattezza) {
		this.metricaAstrattezza = metricaAstrattezza;
	}

	//ACCOPPIAMENTO EFFERENTE
		public int getAccoppiamentoEfferente() {
		return accoppiamentoEfferente;
	}

	public void setAccoppiamentoEfferente(int accoppiamentoEfferente) {
		this.accoppiamentoEfferente = accoppiamentoEfferente;
	}
	
	//ACCOPPIAMENTO AFFERENTE
	public int getAccoppiamentoAfferente() {
		return accoppiamentoAfferente;
	}

	public void setAccoppiamentoAfferente(int accoppiamentoAfferente) {
		this.accoppiamentoAfferente = accoppiamentoAfferente;
	}

	//INSTABILITA'
	public float getInstabilità() {
		return instabilità;
	}

	public void setInstabilità(float instabilità) {
		this.instabilità = instabilità;
	}

	public int getMetricaInstabilità() {
		return metricaInstabilità;
	}

	public void setMetricaInstabilità(int metricaInstabilità) {
		this.metricaInstabilità = metricaInstabilità;
	}

	
	
	
	
	public String stampa() {		
		
		//Preparo i nodi classe
		String nc="{";
		for(NodoClasse nodo : nodiClassiPacchetto){
			nc=nc+"Nome="+nodo.getNome()+", ";
		}
		nc=nc.substring(0,nc.length()-2);//
		nc=nc+"}";
		
		 DecimalFormat formatter = new DecimalFormat("#0.00");
		
		String stri ="NodoPackage [id=" + getId() + ", nome=" + getNome() + ", parentPackage=" + parentPackage + 
				", numeroLineeDiCodice="+numeroLineeCodice+", numeroClassiConcrete="+ numeroClassiConcrete+
				", numeroClassiAtratte="+ numeroClassiAstratte+", numeroClassi="+	getNumeroClassi()+
				", astrattezza="+formatter.format(astrattezza)+", accoppiamentoEfferente="+accoppiamentoEfferente+
				", accoppiamentoAfferente="+accoppiamentoAfferente+", instabilità="+instabilità+
				", metricaClassi="+metricaClassi+", metricaLinee="+metricaLinee+", metricaAstrattezza="+metricaAstrattezza+
				", metricaInstabilità="+metricaInstabilità+", classiPackage="+nc+"]";	
		return stri;
				
	}





	

	

}
