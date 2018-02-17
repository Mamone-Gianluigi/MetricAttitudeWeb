package struttura;

import java.io.Serializable;


public class NodoClasseExternal extends Nodo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
		String source;
		TipoClasseExternal tipoClasseExternal;
	
	public NodoClasseExternal() {
		super();			
		source=null;
		tipoClasseExternal=null;
	}

	public NodoClasseExternal(int id, String nome,TipoClasseExternal tipoClasseExternal) {
		super(id, nome);
		source=null;
		this.tipoClasseExternal=tipoClasseExternal;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public TipoClasseExternal getTipoClasseExternal() {
		return tipoClasseExternal;
	}

	public void setTipoClasseExternal(TipoClasseExternal tipoClasseExternal) {
		this.tipoClasseExternal = tipoClasseExternal;
	}

	public String stampa() {
		return "NodoClasseExternal [id=" + getId() + ", nome=" + getNome()+
					", tipoClasseExternal=" + tipoClasseExternal +", source="+source+"]";
	}

	

}
