package struttura;

import java.io.Serializable;
import java.util.ArrayList;

import org.eclipse.jdt.core.dom.ITypeBinding;
import org.eclipse.jdt.core.dom.TypeDeclaration;

import visitor.MethodDelegation;

public class NodoClasse extends Nodo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private TipoClasse tipoClasse;	
	private String packageLoc;
	private int lunghezza;
	private String source;
	private String superclasse;
	/**QUADRATO*/
	private int numeroMetodi;		//NM - COLORE BORDO QUADRATO
	private int numeroCommenti;		//NC - BASE QUADRATO
	private int numeroLineeCodice;	//LOC - ALTEZZA QUADRATO
	private int numeroMessaggi;		//NMS - SPESSORE BORDO QUADRATO
	private int numeroFI;			//FI=L*(FAN-IN*FAN-OUT)*2 - COLORE QUADRATO
	/**METRICHE QUADRATO*/
	private int metricaNumeroMedoti;
	private int metricaNumeroCommenti;
	private int metricaNumeroLineeCodice;
	private int metricaNumeroMessaggi;
	private int metricaFI;
	
	/**OVALE*/
	private int numeroSottoclassi;		//NOC - COLORE BORDO OVALE
	private int ciclomatica;			//WMC - LARGHEZZA
	private int distanzaRadice;			//DIT - ALTEZZA
	private int metodiPotenziali;		//RFC - COLORE OVALE
	private int accoppiamentoClassi;	//CBO - SPESSORE OVALE
	/**METRICHE OVALE*/
	private int metricaNumeroSottoclassi;
	private int metricaCiclomatica;
	private int metricaDistanzaRadice;
	private int metricaMetodiPotenziali;
	private int metricaAccoppiamentoClassi;
	
	private transient ITypeBinding binding;
	private transient TypeDeclaration node;
	private transient ArrayList<MethodDelegation> delegazioni;
	

	

	public NodoClasse() {
		super();
		tipoClasse=null;
		packageLoc=null;
		lunghezza = 0;
		source=null;
		superclasse=null;
		
		numeroMetodi=0;
		numeroCommenti=0;
		numeroLineeCodice=0;	
		numeroMessaggi=0;		
		numeroFI=0;	
		
		metricaNumeroMedoti=0;
		metricaNumeroCommenti=0;
		metricaNumeroLineeCodice=0;
		metricaNumeroMessaggi=0;
		metricaFI=0;
		
		numeroSottoclassi=0;		
		ciclomatica=0;			
		distanzaRadice=0;			
		metodiPotenziali=0;		
		accoppiamentoClassi=0;	
		
		metricaNumeroSottoclassi=0;
		metricaCiclomatica=0;
		metricaDistanzaRadice=0;
		metricaMetodiPotenziali=0;
		metricaAccoppiamentoClassi=0;
		
		node=null;
		binding=null;
		delegazioni=new ArrayList<>();
	}

	public NodoClasse(int id, String nome,TipoClasse tipoClasse) {
		super(id, nome);
		this.tipoClasse=tipoClasse;
		packageLoc=null;;
		lunghezza = 0;
		source=null;
		
		numeroMetodi=0;
		numeroCommenti=0;
		numeroLineeCodice=0;	
		numeroMessaggi=0;
		numeroFI=0;
		
		metricaNumeroMedoti=0;
		metricaNumeroCommenti=0;
		metricaNumeroLineeCodice=0;
		metricaNumeroMessaggi=0;
		metricaFI=0;
		
		numeroSottoclassi=0;
		
		metricaNumeroSottoclassi=0;
		
		node=null;
		binding=null;
		delegazioni=new ArrayList<>();		
	}

	//TIPO CLASSE
	public TipoClasse getTipoClasse() {
		return tipoClasse;
	}

	public void setTipoClasse(TipoClasse tipoClasse) {
		this.tipoClasse = tipoClasse;
	}

	//PACKAGE
	public String getPackage() {
		return packageLoc;
	}

	public void setPackage(String packageLoc) {
		this.packageLoc = packageLoc;
	}

	//LUNGHEZZA
	public int getLunghezza() {
		return lunghezza;
	}
	
	public void setLunghezza(int lunghezza) {
		this.lunghezza = lunghezza;
	}

	//SOURCE
	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	//SUPERCLASSE
	public String getSuperclasse() {
		return superclasse;
	}

	public void setSuperclasse(String superclasse) {
		this.superclasse = superclasse;
	}
	
	/**QUADRATO*/
	//NUMERO METODI
	public int getNumeroMetodi() {
		return numeroMetodi;
	}
	
	public void setNumeroMetodi(int numeroMetodi) {
		this.numeroMetodi = numeroMetodi;
	}
	
	public int getMetricaNumeroMedoti() {
		return metricaNumeroMedoti;
	}

	public void setMetricaNumeroMedoti(int metricaNumeroMedoti) {
		this.metricaNumeroMedoti = metricaNumeroMedoti;
	}

	//NUMERO COMMENTI
	public int getNumeroCommenti() {
		return numeroCommenti;
	}
	
	public void setNumeroCommenti(int numeroCommenti) {
		this.numeroCommenti = numeroCommenti;
	}
	
	public int getMetricaNumeroCommenti() {
		return metricaNumeroCommenti;
	}

	public void setMetricaNumeroCommenti(int metricaNumeroCommenti) {
		this.metricaNumeroCommenti = metricaNumeroCommenti;
	}

	//LINEE DI CODICE
	public int getNumeroLineeCodice() {
		return numeroLineeCodice;
	}

	public void setNumeroLineeCodice(int numeroLineeCodice) {
		this.numeroLineeCodice = numeroLineeCodice;
	}
	
	public int getMetricaNumeroLineeCodice() {
		return metricaNumeroLineeCodice;
	}

	public void setMetricaNumeroLineeCodice(int metricaNumeroLineeCodice) {
		this.metricaNumeroLineeCodice = metricaNumeroLineeCodice;
	}


	//MESSAGGI
	public int getNumeroMessaggi() {
		return numeroMessaggi;
	}

	public void setNumeroMessaggi(int numeroMessaggi) {
		this.numeroMessaggi = numeroMessaggi;
	}

	public int getMetricaNumeroMessaggi() {
		return metricaNumeroMessaggi;
	}

	public void setMetricaNumeroMessaggi(int metricaNumeroMessaggi) {
		this.metricaNumeroMessaggi = metricaNumeroMessaggi;
	}
	
	//FI
	public int getNumeroFI() {
		return numeroFI;
	}

	public void setNumeroFI(int numeroFI) {
		this.numeroFI = numeroFI;
	}

	public int getMetricaFI() {
		return metricaFI;
	}

	public void setMetricaFI(int metricaFI) {
		this.metricaFI = metricaFI;
	}

	/**OVALE*/
	//SOTTOCLASSI
	public int getNumeroSottoclassi() {
		return numeroSottoclassi;
	}

	public void setNumeroSottoclassi(int numeroSottoclassi) {
		this.numeroSottoclassi = numeroSottoclassi;
	}
	
	public void addNumeroSottoclassi() {
		this.numeroSottoclassi = this.numeroSottoclassi+1;
	}

	public int getMetricaNumeroSottoclassi() {
		return metricaNumeroSottoclassi;
	}

	public void setMetricaNumeroSottoclassi(int metricaNumeroSottoclassi) {
		this.metricaNumeroSottoclassi = metricaNumeroSottoclassi;
	}
	
	//DISTANZA RADICE
	public int getDistanzaRadice() {
		return distanzaRadice;
	}

	public void setDistanzaRadice(int distanzaRadice) {
		this.distanzaRadice = distanzaRadice;
	}
	public int getMetricaDistanzaRadice() {
		return metricaDistanzaRadice;
	}
	
	public void setMetricaDistanzaRadice(int metricaDistanzaRadice) {
			this.metricaDistanzaRadice = metricaDistanzaRadice;
	}
	
	//METODI POTENZIALI
	public int getMetodiPotenziali() {
		return metodiPotenziali;
	}

	public void setMetodiPotenziali(int metodiPotenziali) {
		this.metodiPotenziali = metodiPotenziali;
	}
	public int getMetricaMetodiPotenziali() {
		return metricaMetodiPotenziali;
	}

	public void setMetricaMetodiPotenziali(int metricaMetodiPotenziali) {
		this.metricaMetodiPotenziali = metricaMetodiPotenziali;
	}

	//ACCOPPIAMENTO
	public int getAccoppiamentoClassi() {
		return accoppiamentoClassi;
	}

	public void setAccoppiamentoClassi(int accoppiamentoClassi) {
		this.accoppiamentoClassi = accoppiamentoClassi;
	}
	
	public void addAccoppiamentoClassi() {
		accoppiamentoClassi++;
	}
	
	public int getMetricaAccoppiamentoClassi() {
		return metricaAccoppiamentoClassi;
	}

	public void setMetricaAccoppiamentoClassi(int metricaAccoppiamentoClassi) {
		this.metricaAccoppiamentoClassi = metricaAccoppiamentoClassi;
	}
	//CICLOMATICA
	public int getMetricaCiclomatica() {
		return metricaCiclomatica;
	}

	public void setMetricaCiclomatica(int metricaCiclomatica) {
		this.metricaCiclomatica = metricaCiclomatica;
	}
	public int getCiclomatica() {
		return ciclomatica;
	}
	
	public void setCiclomatica(int ciclomatica) {
		this.ciclomatica = ciclomatica;
	}
		
	public void addCiclomatica() {
		ciclomatica++;
	}


	//BINDING
	public ITypeBinding getBinding() {
		return binding;
	}

	public void setBinding(ITypeBinding binding) {
		this.binding = binding;
	}

	//NODE
	public TypeDeclaration getNode() {
		return node;
	}

	public void setNode(TypeDeclaration node) {
		this.node = node;
	}
	
	//DELEGAZIONI
	public void setDelegazioni(ArrayList<MethodDelegation> delegazioni) {
		this.delegazioni = delegazioni;
	}
	
	public void addDelegazione(MethodDelegation delegazione) {
		delegazioni.add(delegazione);
	}

	public ArrayList<MethodDelegation> getDelegazioni() {
		return delegazioni;
	}
		
	public String stampa() {
		return "NodoClasse [id=" + getId() + ", nome=" + getNome() + ", package=" + packageLoc + 
				", tipoClasse=" + tipoClasse+", lunghezza=" + lunghezza+ 
				", superclasse="+superclasse+
				", numeroMetodi="+numeroMetodi+", metricaNumeroMetodi="+metricaNumeroMedoti+
				", numeroCommenti="+numeroCommenti+", metricaNumeroCommenti="+metricaNumeroCommenti+ 
				", numeroLineeCodice="+ numeroLineeCodice+", metricaNumeroLineeCodice="+metricaNumeroLineeCodice+
				", numeroMessaggi=" +numeroMessaggi+", metricaNumeroMessaggi="+metricaNumeroMessaggi+
				", numeroFI="+numeroFI+", metricaFI="+metricaFI+
				", numeroSottoclassi="+numeroSottoclassi+", metricaNumeroSottoclassi="+metricaNumeroSottoclassi+
				", ciclomatica="+ciclomatica+", metricaCiclomatica="+metricaCiclomatica+
				", distanzaRadice="+distanzaRadice+", metricaDistanzaRadice="+metricaDistanzaRadice+
				", metodiPotenziali="+metodiPotenziali+", metricaMetodiPotenziali="+metricaMetodiPotenziali+
				", accoppiamentoClassi="+accoppiamentoClassi+", metricaAccoppiamentoClassi="+metricaAccoppiamentoClassi+
				"]";	
	}

}
