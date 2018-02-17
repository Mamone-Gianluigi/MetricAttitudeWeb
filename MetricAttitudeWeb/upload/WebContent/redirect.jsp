<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String tipo=(String) session.getAttribute("tipo");
String name=(String) session.getAttribute("nome");
session.removeAttribute("tipo");
session.removeAttribute("nome");
if(tipo.equals("layered")){
	String redirectURL = "/upload/output.jsp?name="+name+"&type=circle";
	response.sendRedirect(redirectURL);
}else{
	String redirectURL = "/upload/output.jsp?name="+name+"&type=layered";
	response.sendRedirect(redirectURL);
}/*

if(tipo.equals("layered")){
	String redirectURL = "/upload/viewProgetto.jsp?name="+name+"&type=circle";
	response.sendRedirect(redirectURL);
}else{
	String redirectURL = "/upload/viewProgetto.jsp?name="+name+"&type=layered";
	response.sendRedirect(redirectURL);
}
*/
%>
</body>
</html>