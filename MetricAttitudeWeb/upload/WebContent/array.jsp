<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="struttura.Grafo,java.util.ArrayList,java.util.Enumeration,struttura.Nodo,struttura.NodoClasse,struttura.NodoPackage,struttura.Arco,java.io.FileInputStream,java.io.ObjectInputStream,java.io.File" %>

<% 
Grafo grafo=(Grafo) session.getAttribute("grafo");
String nome=request.getParameter("path");
out.print("{key:\""+"Luca" +"\"}");
%>



			
