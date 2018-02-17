package struttura;

import java.io.Serializable;

public abstract class Nodo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String nome;


	public Nodo() {
		this.id = 0;
		this.nome = null;
	}

	public Nodo(int id, String nome) {
		this.id = id;
		this.nome = nome;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String stampa() {

		return "Nodo [id=" + id + ", nome=" + nome +"]";
	}

}
