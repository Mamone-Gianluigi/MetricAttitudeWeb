package struttura;

import java.io.Serializable;
import java.util.ArrayList;

import parsing.Utils;

public class Grafo implements Serializable {

	private static final long serialVersionUID = 1L;
	private ArrayList<NodoClasseExternal> nodiClasseEsterne; 
	private ArrayList<NodoClasse> nodiClasse; 
	private ArrayList<NodoPackage> nodiPackage; 
	private ArrayList<Arco> archi;
	private int numArchi;
	private int numNodi;

	public Grafo() {
		nodiClasse = new ArrayList<NodoClasse>();
		nodiPackage = new ArrayList<NodoPackage>();
		nodiClasseEsterne=new ArrayList<NodoClasseExternal>();
		archi = new ArrayList<Arco>();
		numArchi = 0;
		numNodi = 0;
	}

	public int getNumArchi() {
		return numArchi;
	}

	public int getNumNodi() {
		return numNodi;
	}

	public ArrayList<NodoClasse> getNodiClasse() {
		return nodiClasse;
	}
	
	public ArrayList<NodoClasseExternal> getNodiClasseExternal() {
		return nodiClasseEsterne;
	}
	
	public ArrayList<NodoPackage> getNodiPackage() {
		return nodiPackage;
	}

	public ArrayList<Arco> getArchi() {
		return archi;
	}

	public NodoClasse getNodoClasse(int id) {
		for (NodoClasse s : nodiClasse) {
			if (s.getId() == id) {
				return s;
			}
		}
		return null;
	}

	public NodoClasse getNodoClasse(String nome) {
		for (NodoClasse s : nodiClasse) {
			if (s.getNome().equals(nome)) {
				return s;
			}
		}
		return null;
	}

	public NodoClasseExternal getNodoClasseExternal(int id) {
		for (NodoClasseExternal s : nodiClasseEsterne) {
			if (s.getId() == id) {
				return s;
			}
		}
		return null;
	}

	public NodoClasseExternal getNodoClasseExternal(String nome) {
		for (NodoClasseExternal s : nodiClasseEsterne) {
			if (s.getNome().equals(nome)) {
				return s;
			}
		}
		return null;
	}
	
	public NodoPackage getNodoPackage(int id) {
		for (NodoPackage s : nodiPackage) {
			if (s.getId() == id) {
				return s;
			}
		}
		return null;
	}

	public NodoPackage getNodoPackage(String nome) {
		for (NodoPackage s : nodiPackage) {
			if (s.getNome().equals(nome)) {
				return s;
			}
		}
		return null;
	}
	
	public NodoClasse cercaNodoClasse(String nome) {
		if (nome == null) {
			return null;
		}
		for (NodoClasse x : nodiClasse) {
			if (x.getNome().equals(nome)) {
				return x;
			}
		}
		return null;
	}

	public NodoClasseExternal cercaNodoClasseExternal(String nome,TipoClasseExternal tipo) {
		if (nome == null) {
			return null;
		}
		ArrayList<NodoClasseExternal> nodiClassiEsterneSelezionate=new ArrayList<>();
		for (NodoClasseExternal x : nodiClasseEsterne)
			if(x.getTipoClasseExternal()==tipo)
				nodiClassiEsterneSelezionate.add(x);
				
		for (NodoClasseExternal x : nodiClassiEsterneSelezionate) {
			if (x.getNome().equals(nome)) {
				return x;
			}
		}
		return null;
	}
	
	public NodoClasseExternal cercaNodoClasseExternal(String nome) {
		if (nome == null) {
			return null;
		}				
		for (NodoClasseExternal x : nodiClasseEsterne) {
			if (x.getNome().equals(nome)) {
				return x;
			}
		}
		return null;
	}
	
	public NodoPackage cercaNodoPackage(String nome) {
		if (nome == null) {
			return null;
		}
		for (NodoPackage x : nodiPackage) {
			if (x.getNome().equals(nome)) {
				return x;
			}
		}
		return null;
	}
		
	public Arco getArco(int id) {
		for (Arco s : archi) {
			if (s.getId() == id) {
				return s;
			}
		}
		return null;
	}
	
	public Arco getArco(String tipo) {
		for (Arco s : archi) {
			if (s.getTipo().equals(tipo)) {
				return s;
			}
		}
		return null;
	}

	public ArrayList<Arco> uscentiNodo(int id) {
		ArrayList<Arco> toReturn = new ArrayList<Arco>();
		for (Arco s : archi) {
			if (s.getFrom().getId() == id) {
				toReturn.add(s);
			}
		}
		return toReturn;
	}

	public ArrayList<Arco> uscentiNodo(String nome) {
		ArrayList<Arco> toReturn = new ArrayList<Arco>();
		for (Arco s : archi) {
			if (s.getFrom().getNome().equals(nome)) {
				toReturn.add(s);
			}
		}
		return toReturn;
	}

	public ArrayList<Arco> entrantiNodo(int id) {
		ArrayList<Arco> toReturn = new ArrayList<Arco>();
		for (Arco s : archi) {
			if (s.getTo().getId() == id) {
				toReturn.add(s);
			}
		}
		return toReturn;
	}

	public ArrayList<Arco> entrantiNodo(String nome) {
		ArrayList<Arco> toReturn = new ArrayList<Arco>();
		for (Arco s : archi) {
			if (s.getTo().getNome().equals(nome)) {
				toReturn.add(s);
			}
		}
		return toReturn;
	}

	public NodoClasse addNodoClasse(NodoClasse s) {
		if (getNodoClasse(s.getId()) == null) {
			nodiClasse.add(s);
			numNodi++;
			return s;
		} else {
			return null;
		}
	}
	
	public NodoClasseExternal addNodoClasseExternal(NodoClasseExternal s) {
		if (getNodoClasseExternal(s.getId()) == null) {
			nodiClasseEsterne.add(s);
			numNodi++;
			return s;
		} else {
			return null;
		}
	}
	
	public NodoPackage addNodoPackage(NodoPackage s) {
		if (getNodoPackage(s.getId()) == null) {
			nodiPackage.add(s);
			numNodi++;
			return s; 
		} else {
			return null;
		}
	}

	public Arco addArco(Arco s) {
		Arco q = getArco(s.getId());
		if (q == null) {
			archi.add(s);
			numArchi++;
			return s;
		} else {
			return null;
		}

	}
	
	public String toString() {
		String toReturn = "Grafo-->";
		for (NodoPackage x : nodiPackage) {
			toReturn = toReturn + "\n" + x.stampa();
		}
		for (NodoClasse x : nodiClasse) {
			toReturn = toReturn + "\n" + x.stampa();
		}
		for (NodoClasseExternal x : nodiClasseEsterne) {
			toReturn = toReturn + "\n" + x.stampa();
		}
		for (Arco x : archi) {
			toReturn = toReturn + "\n" + x.stampa();
		}
		return toReturn;
	}

	public String toString2() {
		String toReturn = "Grafo-->";
		for (NodoPackage x : nodiPackage) {
			toReturn = toReturn + "\n <br>" + x.stampa();
		}
		for (NodoClasse x : nodiClasse) {
			toReturn = toReturn + "\n <br>" + x.stampa();
		}
		for (NodoClasseExternal x : nodiClasseEsterne) {
			toReturn = toReturn + "\n <br>" + x.stampa();
		}
		for (Arco x : archi) {
			toReturn = toReturn + "\n <br>" + x.stampa();
		}
		return toReturn;
	}

	public Arco aggiungiUscenteDa(NodoClasse da, NodoClasse nuovo, String tipo) {
		if (getNodoClasse(da.getNome()) != null) {
			if (getNodoClasse(nuovo.getNome()) == null) {
				addNodoClasse(nuovo);
				numNodi++;
			}
			Arco arc = new Arco(Utils.getId(), tipo, da, nuovo);
			addArco(arc);
			return arc;
		}
		return null;
	}

	public ArrayList<Arco> getArchiDiTipo(String tipo) {
		ArrayList<Arco> toReturn = new ArrayList<Arco>();
		for (Arco x : archi) {
			if (x.getTipo().equals(tipo)) {
				toReturn.add(x);
			}
		}
		return toReturn;
	}

	public void pulisci() {
		nodiClasse.clear();
		archi.clear();
		numArchi = 0;
		numNodi = 0;
	}

	public void puliciNodi() {
		ArrayList<NodoClasse> daCancellare = new ArrayList<NodoClasse>();
		for (NodoClasse x : nodiClasse) {
			int test = 0;
			for (Arco y : archi) {
				if (x.getNome().equals(y.getFrom().getNome())) {
					test = 1;
				}
				if (x.getNome().equals(y.getTo().getNome())) {
					test = 1;
				}
			}
			if (test == 0) {
				daCancellare.add(x);
			}
		}
		for (NodoClasse h : daCancellare) {
			nodiClasse.remove(h);
			numNodi--;
		}
	}

}
