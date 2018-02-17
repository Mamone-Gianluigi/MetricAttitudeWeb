package struttura;

import java.io.Serializable;

public class Arco implements Serializable {

	/**
	 * Variabili d'istanza della classe Arco
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String tipo;
	private Nodo from;
	private Nodo to;
	private int numero;
	private int metricaNumero;

	public Arco(int id, String tipo, Nodo from, Nodo to) {
		this.id = id;
		this.tipo = tipo;
		this.from = from;
		this.to = to;
		numero=1;
		metricaNumero=0;
		
	}

	public Arco() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public Nodo getFrom() {
		return from;
	}

	public void setFrom(Nodo from) {
		this.from = from;
	}

	public Nodo getTo() {
		return to;
	}

	public void setTo(Nodo to) {
		this.to = to;
	}
	
	public int getNumero() {
		return numero;
	}

	public void incrementaNumero() {
		numero = numero+1;
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}
	
	public int getMetricaNumero() {
		return metricaNumero;
	}

	public void setMetricaNumero(int metricaNumero) {
		this.metricaNumero = metricaNumero;
	}

	public String stampa() {
		return "Arco [id=" + id + ", tipo=" + tipo + ", from=" + from.getNome() + ", to=" +
				to.getNome() + ", numero="+numero+", metricaNumero="+metricaNumero+"]";
	}

}
