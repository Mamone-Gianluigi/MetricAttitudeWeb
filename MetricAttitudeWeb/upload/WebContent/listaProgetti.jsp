<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Lista progetti</title>
	<meta name="keywords" content="software company, free css template, website layout, css, xhtml" />
	<meta name="description" content="software company, free css template, website layout, xhtml css design" />
	
	<link href="css/FileCSS.css" rel="stylesheet" type="text/css" />

	<script language="javascript" type="text/javascript">
		function clearText(field)
		{
    		if (field.defaultValue == field.value) field.value = '';
    else if (field.value == '') field.value = field.defaultValue;
}
</script>
</head>
<body onload="flags()">
		
		<div id="templatemo_banner_section">
        	<h1>Lista progetti</h1>
          <p>
            Di seguito viene riportata la lista dei progetti già caricati all'interno della WebApp.<br> Per ogni progetto è disponibile il grafo diretto delle gerarchie.</p>
          
        
        </div>   
		<%@ page import="java.io.File" %> 
		<div id="templatemo_menu_section">
            <ul>
		<%
			String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload"+File.separatorChar;
		//  String filePath = "C:\\Users\\Fabio\\Desktop\\FileInUpload"+File.separatorChar;
			int cont = 1; 
			File file=new File(filePath);
			File[] files = file.listFiles();
			if(files.length==0){
				out.print("<h1>La lista è vuota!!!</h1>");	
			}else{
			for(File x: files){
				if(x.isDirectory()){
					String nome=x.getName();
					String nome2="'"+nome+"'";
					
					out.print("<div id=\"abc\"><li style=\"width:250px\"><a>"+cont+"<span>"+nome+"</span></a></li>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp<button style=\"border: 2px solid #fff; border-radius: .7em;\" onclick=\"grafo("+nome2+");\">Visualizza</button>&nbsp &nbsp &nbsp &nbsp &nbsp<button style=\"border: 2px solid #fff; border-radius: .7em;\" onclick=\"elimina("+nome2+")\">Elimina</button><br><br/></div><br>");
					cont++;
				}
			}
			}
		%> 
		</ul> 
        </div> 
        <br></br>
        <input type="button" style="border: 2px solid #fff; border-radius: .7em;" onclick="window.location='/upload/'" name="home99" id="home99" value="Home" />  <br></br>    
         
    
   
</body>
<script>
function elimina(nome){
	window.location.href='/upload/elimina.jsp?name='+nome
}

function grafo(nome){
	window.location.href='/upload/viewProgetto.jsp?name='+nome
}

function flags(){
	var currentLocation = window.location.href;
	var index =currentLocation.indexOf("?flag=2");
	if(index>=0){
		tempAlert("FILE ELIMINATO CORRETTAMENTE!",3000);
		history.pushState({}, null, "/upload/lista.jsp");
	}
}

function tempAlert(msg,duration){
 	var el = document.createElement("div");
 	el.setAttribute("style","position:absolute;top:5%;right:0.5%;background-color:black;color: red;");
 	el.innerHTML = msg;
 	setTimeout(function(){
  	el.parentNode.removeChild(el);
 	},duration);
 	document.body.appendChild(el);
}



</script>
</html>