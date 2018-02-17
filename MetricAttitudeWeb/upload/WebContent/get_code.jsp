<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="struttura.Grafo,java.util.ArrayList,java.util.Enumeration,struttura.Nodo,struttura.NodoClasse,struttura.NodoPackage,struttura.Arco,java.io.FileInputStream,java.io.ObjectInputStream,java.io.File" %>

<% 

Grafo grafo=(Grafo) session.getAttribute("grafo");


String nome=request.getParameter("nome");
NodoClasse nodoClasse=grafo.cercaNodoClasse(nome);
if(nodoClasse==null){
	out.print("Il codice sorgente per : "+nome+"\n"+"Non è non disponibile!!!");
}
else{
	
	out.print(nodoClasse.getSource());
}
/*
Grafo grafo=(Grafo) session.getAttribute("grafo");


String nome=request.getParameter("nome");
ArrayList<NodoClasse> nodi=grafo.getNodiClasse();
for(NodoClasse f:nodi){
	if(f.getNome().equals(nome)){
		if(f.getSource()!=null){
			System.out.println(f.getSource());
			
		

			out.print(f.getSource());
			
		}else{
			out.print("Codice non disponibile!!!");
		}
		break;
	}
}*/

%>



			
