<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>elimina</title>
<%@ page import="java.io.File,org.apache.commons.io.FileUtils" %>
<%

String param = request.getParameter("name");
out.print(param);
String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload"+File.separatorChar;
//String filePath = "C:\\Users\\Fabio\\Desktop\\FileInUpload"+File.separatorChar;
File file= new File(filePath);
File[] files = file.listFiles();
for(File x:files){
	String name=x.getName();
	if(name.equals(param)){
		FileUtils.deleteDirectory(x);
	}
	if(name.equals(param+".txt")){
		x.delete();
	}
}

String redirectURL = "/upload/lista.jsp?flag=2";
response.sendRedirect(redirectURL);



%>
</head>
<body>

</body>
</html>