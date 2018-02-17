<%@page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="it">
	<head>
	
	<link href="css/viewProgetto.css" rel="stylesheet" type="text/css" />
	
	<%@ page import="struttura.Grafo,java.util.ArrayList,
	java.io.BufferedReader,java.io.File,java.io.FileReader,java.io.IOException,
	java.util.Enumeration,struttura.Nodo,struttura.NodoClasse,struttura.NodoPackage,
	struttura.NodoClasseExternal,struttura.TipoClasse,
	struttura.Arco,java.io.FileInputStream,java.io.ObjectInputStream,java.io.File" %>
		<%
		 
		
		  	//carico il grafo e lo setto nella variabile di sessione
		    String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload"+File.separatorChar;
			//  String filePath = "C:\\Users\\Fabio\\Desktop\\FileInUpload"+File.separatorChar;
		    String nome=request.getParameter("name");
			FileInputStream fis = new FileInputStream(filePath+nome+"\\"+nome+".txt");
			ObjectInputStream ois = new ObjectInputStream(fis);
			Grafo grafo=(Grafo) ois.readObject();
			System.out.println(grafo.toString());
			session.setAttribute("nome", nome);
			session.setAttribute("grafo",grafo);
			
			
			//carico il JSON- non si utilizza perchè utilizziamo ajax
			//FileReader file1 = new FileReader(filePath+"\\"+nome+"\\"+nome+".json");
			//BufferedReader b = new BufferedReader(file1);
	       // String s;
	        //s=b.readLine();
	     	//   session.setAttribute("jsonProgetto",s);
	      //	System.out.print(s);
			
		  
		%>
	
		<title>View Progetto</title>

		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link href="css/FileCSS.css" rel="stylesheet" type="text/css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
		<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
		<script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/gojs/1.7.11/go-debug.js"></script>
		<link rel="stylesheet" href="./css/treestyle.min.css" />
		<link rel="stylesheet" href="./css/default.min.css">
		<script src="./js/highlight.min.js"></script>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	<style type="text/css">
body {
 font-family: Helvetica, Arial, sans-serif;
}
#container {
 padding: 20px;
 margin: 0 auto;
 width: 600px;
 background: #fff;
}

p:not(#foo) > input[type='radio'], /* Nasconde checkbox e radio button */
p:not(#foo) > input[type='checkbox'] {
 position: absolute;
 clip: rect(1px, 1px, 1px, 1px);
}


p:not(#foo) > input[type='radio'] + label,
p:not(#foo) > input[type='checkbox'] + label {
  margin: 0;/* Azzera i margini */
 padding: 2px 0 0px 24px; /* Crea spazio con il padding sinistro per ospitare l'immagine di sfondo */
 cursor: pointer; /* Imposta il cursore */
 background: url('images/start.png') left center no-repeat; /* Imposta lo sfondo iniziale per checkbox e radio button */
}

p:not(#foo) > input[type='radio']:checked + label { /*Modifica lo sfondo del radio button quando viene attivato */
 background-image: url('radiobutton.png');
}

p:not(#foo) > input[type='checkbox']:checked + label { /*Modifica lo sfondo del checkbox quando viene attivato */
 background-image: url('images/checkbox.png');
}

.btn span.glyphicon {    			
	opacity: 0;				
}
.btn.active span.glyphicon {				
	opacity: 1;				
}

/* Hiding the checkbox, but allowing it to be focused */
.badgebox
{
    opacity: 0;
}

.badgebox + .badge
{
    /* Move the check mark away when unchecked */
    text-indent: -999999px;
    /* Makes the badge's width stay the same checked and unchecked */
	width: 27px;
}

.badgebox:focus + .badge
{
    /* Set something to make the badge looks focused */
    /* This really depends on the application, in my case it was: */
    
    /* Adding a light border */
    box-shadow: inset 0px 0px 5px;
    /* Taking the difference out of the padding */
}

.badgebox:checked + .badge
{
    /* Move the check mark back when checked */
	text-indent: 0;
}

</style>
		
	</head>
	
	<body  id="bbb" bgcolor="black" style="background-color:#202020;" >
			<div id="colonnaSinistra" class="col-sm-3" >
				
			<div id="colonna0">
				<button type="button" class="btn btn-primary" onclick="home()" style="margin-left:30px;margin-right:50px;"><img src="./images/home-hi.png" alt="Mia Immagine" > <strong > </strong> </img></button>
				<button type="button" class="btn btn-success" onclick="lista()" ><img src="./images/lista.png" alt="Mia Immagine" > <strong > </strong> </img></button>	
			</div>
			
			
			
		
			
				<h1 style="font-size: 20px;"> <img src="./images/logoJava.png" alt="Mia Immagine" > <strong > Progetto :</strong> </img>  <em style="font-size: 28px; color:white;"> <%out.print(nome); %> </em> </h1>
				<div id="ajax" class="demo"></div>
				
				<!--<script src="highlight.pack.js"></script>-->
			   	<script> hljs.initHighlightingOnLoad();</script>
				<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
				<script src="./js/jstree.min.js"></script>
				
				<script>		 
						// Script JavaScript per gestire il treeView
						var name="<%=nome%>"; 
					
						//popolo l'albero
						$('#ajax').jstree({
							'core' : {
								'data' : {
									'url' : 'ServletResponse?name='+name
								    ,				
									"dataType" : "json" // needed only if you do not supply JSON headers
								}
							}
						});
						
						//ottengo il nome del file in base alla selezione
						$('#ajax')
						.on("changed.jstree", function (e, data) {
							if(data.selected.length) {
								
								//alert('The selected node is: ' + data.instance.get_node(data.selected[0]).text);
								var str=data.instance.get_node(data.selected[0]).text;
								var lunghezza=str.length-5
								var estensione=str.substring(lunghezza,str.length);
								if(estensione=='.java'){
									var substr = str.substring(0,lunghezza);
								
									loadXMLDoc(substr,name);
								}
							
							}
						})
						.jstree({
							'core' : {
								'multiple' : false,
								'data' : [
									{ "text" : "Root node", "children" : [
											{ "text" : "Child node 1", "id" : 1 },
											{ "text" : "Child node 2" }
									]}
								]
							}
						});
					
						//ottengo il contenuto della classe
						function loadXMLDoc(x,y)
						{
							
						  var xmlhttp;
						  var url="ServletCodice?nome="+x+"&name="+y;
						
						  if (window.XMLHttpRequest)
						  {
						      xmlhttp=new XMLHttpRequest();
						  }
						  else
						  {
						      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
						  }
						  xmlhttp.onreadystatechange=function()
						  {
						      if (xmlhttp.readyState==4 && xmlhttp.status==200)
						      {
						    	
						         document.getElementById("codeArea").innerHTML=xmlhttp.responseText;
						        	$('#codeArea').each(function() {
							    		
							    	     hljs.highlightBlock(this);
							    	});
						      }
						  }
					
						  xmlhttp.open("GET", url, true);
						  xmlhttp.send();
						}
						
						function loadXMLDocGrafo(x)
						{
							
							var xmlhttp;
							  var url="get_code.jsp?nome="+x;
							  if (window.XMLHttpRequest)
							  {
							      xmlhttp=new XMLHttpRequest();
							  }
							  else
							  {
							      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
							  }
							  xmlhttp.onreadystatechange=function()
							  {
							      if (xmlhttp.readyState==4 && xmlhttp.status==200)
							      {
							         document.getElementById("codeArea").innerHTML=xmlhttp.responseText;
							        	$('#codeArea').each(function() {
								    		
								    	     hljs.highlightBlock(this);
								    	});
							      }
							  }
						
							  xmlhttp.open("GET", url, true);
							  xmlhttp.send();
						}
						
						function loadXMLDocGrafo1(x)
						{
							
							
							         document.getElementById("codeArea").innerHTML=x;
							        	$('#codeArea').each(function() {
								    		
								    	     hljs.highlightBlock(this);
								    	});
							      
							
						}
												
			
				</script>
		
		
		
				</div>
		<div id="riga0" class="col-sm-3" >
			<!-- 
			<button type="button" class=".btn-sm btn-primary" onclick="init(true)">Layered Digraph [CLASS]</button>
			<button type="button" class=".btn-sm btn-success" onclick="init2(true)">Circle Digraph [CLASS]</button>	
			-->
			<button type="button" class=".btn-sm btn-warning" onclick="initPackage('',0,false)">Layered Digraph [PACKAGE]</button>	
			<button type="button" class=".btn-sm btn-warning" onclick="init33(true)">Layered Digraph [PACKAGE]</button>	
			<button type="button" class=".btn-sm btn-danger" onclick="init3(true)">Circle Digraph [PACKAGE]</button>	
			<button type="button" class=".btn-sm btn-primary"  onclick="init4(true)">Circle Digraph[CLASS]</button>
			<button type="button" class=".btn-sm btn-success" onclick="init3(true)">Layered Digraph [CLASS]</button>	
			
		</div>
		<div id="riga1" class="col-sm-3" >  	</div>
		<div id="riga55" class="col-sm-3" hidden>
			<div id="indietro" style="float:left;" hidden>
				<button type="button" class="btn btn-success" onclick="indietro()">&nbsp Indietro &nbsp</button>
			</div>
			<div id="cicli" style="float:left;" hidden>	
       		 	<label for="primary" class="btn btn-primary">Primary <input type="checkbox" id="primary" class="badgebox" onclick="cicli(this)"><span class="badge">&check;</span></label>
			</div>		
			
		</div>
			
		
		<!-- 	<div id="indietroDiv" style="float:left; display:block; width:70px; height:35px;" hidden=true>
				<button type="button" class=".btn-sm btn-primary" onclick="init4(true)" >Indietro</button>
				
			</div>
			<div id="cicliDiv" style="float:left; display:block; width:70px; height:35px;" hidden>
				<form action="">
					<p>
						<input type="checkbox" id="cicli" value="HTML" onchange="togl(this)" >
						<label for="cicli">CICLI </label>&nbsp &nbsp  &nbsp 
					</p>
				</form>
			</div>

-->
</div>		
		
		
	 	
		<div id="riga2" class="col-sm-3" >  
				<pre id="codeAreaPre">
	  				<code class="language-java" id="codeArea" style="margin-top:-10px;     background-color: #f5f5f5;"></code>
	  			</pre>
		</div>
			

	
	
	

<script>
function home() {
    window.location.href='/upload'
}

function lista() {
    window.location.href='/upload/listaProgetti.jsp'
}

function change(){
	window.location.href='/upload/redirect.jsp'
	
}

function change2(){
	window.location.href='/upload/redirect.jsp'
	 
	
	
}


	function pulisci(){
		var div = document.getElementById('riga1');
		while(div.firstChild){
		    div.removeChild(div.firstChild);
		}
	}
	
	function pulisci2(){
		var div = document.getElementById('codeArea');
		while(div.firstChild){
		    div.removeChild(div.firstChild);
		}
	}

	
function init(v){
	var div = document.getElementById('riga1');
	while(div.firstChild){
	    div.removeChild(div.firstChild);
	}
	
	document.getElementById('riga55').removeAttribute('hidden');
	document.cookie = "funzione=init()";
	if(v==true)
		document.getElementById('cicli').checked=true; 
	else if(v==false)
		document.getElementById('cicli').checked=false; 
	var newDiv = document.createElement("div"); 
	newDiv.setAttribute("id", "myDiagramDiv");
	div.appendChild(newDiv);
	

	
	
	//<input type="checkbox" id="cicli" checked data-toggle="toggle" onchange="toggl(this)" data-onstyle="success" data-offstyle="danger">
	
	

	var $ = go.GraphObject.make;
	var myDiagram =
	  $(go.Diagram, "myDiagramDiv",
	    {
	      initialContentAlignment: go.Spot.Center, // center Diagram contents
	      "undoManager.isEnabled": true, 
          initialAutoScale: go.Diagram.UniformToFill,
        	  layout: $(go.LayeredDigraphLayout)  
          
	    });
	
	myDiagram.model.isReadOnly = true;
	myDiagram.allowLink = false;
	myDiagram.allowClipboard = false;
	myDiagram.allowDelete = false;
	
	// define the Node template
    myDiagram.nodeTemplate =
      $(go.Node, "Auto",
        new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
        // define the node's outer shape, which will surround the TextBlock
        $(go.Shape, "RoundedRectangle",
          {
            parameter1: 20,  // the corner has a large radius
            fill: $(go.Brush, "Linear", { 0: "rgb(254, 201, 0)", 1: "rgb(254, 162, 0)" }),
            stroke: null,
            portId: "",  // this Shape is the Node's port, not the whole Node
            fromLinkable: true, fromLinkableSelfNode: true, fromLinkableDuplicates: true,
            toLinkable: true, toLinkableSelfNode: true, toLinkableDuplicates: true,
            cursor: "pointer"
          }),
        $(go.TextBlock,
          {
            font: "bold 11pt helvetica, bold arial, sans-serif",
            editable: false  // editing the text automatically updates the model data
          },
          new go.Binding("text","key").makeTwoWay())
      );
	 myDiagram.nodeTemplate.selectionChanged=function(node) { 
		 var nomeHighlight=node.data.key;
		 loadXMLDocGrafo(nomeHighlight);
		 
	 
	 };
	
    myDiagram.linkTemplate =
        $(go.Link,
          $(go.Shape),                           // this is the link shape (the line)
          $(go.Shape, { toArrow: "Standard" }),  // this is an arrowhead
          $(go.TextBlock,{stroke: "white"} ,                     
            new go.Binding("text", "text"))
        );
    
    
	
	var myModel = $(go.GraphLinksModel);
	
	 if(v==true){
		// in the model data, each node is represented by a JavaScript object:
		myModel.nodeDataArray = [
		  <%
		//grafo.puliciNodi();
		  ArrayList<NodoClasse> nodi=grafo.getNodiClasse();
		  for(NodoClasse x: nodi){ 
			  out.print("{ key: \""+x.getNome()+"\"},");
		  }
		  ArrayList<NodoClasseExternal> nodiii=grafo.getNodiClasseExternal();
		  for(NodoClasseExternal x: nodiii){ 
			  out.print("{ key: \""+x.getNome()+"\"},");
		  }
		  %>
		  
		];
		myModel.linkDataArray = [
		<%
		ArrayList<Arco> archi=grafo.getArchi();
		for(Arco x: archi){
		  out.print("{ from: \""+x.getFrom().getNome()+"\", to: \""+x.getTo().getNome()+"\", text:\""+x.getTipo()+"\"},");
		}
		%>
		  
		];
	 }
	 else if (v==false){
			// in the model data, each node is represented by a JavaScript object:
			myModel.nodeDataArray = [
			  <%
			//grafo.puliciNodi();
			  ArrayList<NodoClasse> nodip=grafo.getNodiClasse();
			  for(NodoClasse x: nodip){ 
				  out.print("{ key: \""+x.getNome()+"\"},");
			  }
			  ArrayList<NodoClasseExternal> nodiiip=grafo.getNodiClasseExternal();
			  for(NodoClasseExternal x: nodiiip){ 
				  out.print("{ key: \""+x.getNome()+"\"},");
			  }
			  %>
			  
			];
			myModel.linkDataArray = [
			<%
			ArrayList<Arco> archip=grafo.getArchi();
			for(Arco x: archip){
				//CONTROLLO CHE NON SONO SU SE STESSI
				if(!x.getFrom().getNome().equals(x.getTo().getNome()))
			  		out.print("{ from: \""+x.getFrom().getNome()+"\", to: \""+x.getTo().getNome()+"\", text:\""+x.getTipo()+"\"},");
			}
			%>
			  
			];
		 }
	
	
	
	myDiagram.model = myModel;

	
}




function init2(v){
	var div = document.getElementById('riga1');
	while(div.firstChild){
	    div.removeChild(div.firstChild);
	}

	document.getElementById('riga55').removeAttribute('hidden');
	document.cookie = "funzione=init2()";
	if(v==true)
		document.getElementById('cicli').checked=true; 
	else if(v==false)
		document.getElementById('cicli').checked=false; 
	
	var newDiv = document.createElement("div"); 
	newDiv.setAttribute("id", "myDiagramDiv2");
	 
	
	div.appendChild(newDiv);
	
//	document.getElementById("myDiagramDiv").removeAttribute("hidden");
	var $ = go.GraphObject.make;
	var myDiagram =
	  $(go.Diagram, "myDiagramDiv2",
	    {
	      initialContentAlignment: go.Spot.Center, // center Diagram contents
	      "undoManager.isEnabled": true, 
          initialAutoScale: go.Diagram.UniformToFill,
        	  layout: $(go.CircularLayout)  
          
	    });
	
	myDiagram.model.isReadOnly = true;
	myDiagram.allowLink = false;
	myDiagram.allowClipboard = false;
	myDiagram.allowDelete = false;
	
	// define the Node template
    myDiagram.nodeTemplate =
      $(go.Node, "Auto",
        new go.Binding("location", "loc", go.Point.parse).makeTwoWay(go.Point.stringify),
        // define the node's outer shape, which will surround the TextBlock
        $(go.Shape, "RoundedRectangle",
          {
            parameter1: 20,  // the corner has a large radius
            fill: $(go.Brush, "Linear", { 0: "rgb(254, 201, 0)", 1: "rgb(254, 162, 0)" }),
            stroke: null,
            portId: "",  // this Shape is the Node's port, not the whole Node
            fromLinkable: true, fromLinkableSelfNode: true, fromLinkableDuplicates: true,
            toLinkable: true, toLinkableSelfNode: true, toLinkableDuplicates: true,
            cursor: "pointer"
          }),
        $(go.TextBlock,
          {
            font: "bold 11pt helvetica, bold arial, sans-serif",
            editable: false  // editing the text automatically updates the model data
          },
          new go.Binding("text","key").makeTwoWay())
      );
	
    myDiagram.nodeTemplate.selectionChanged=function(node) { 
    	var nomeHighlight=node.data.key;
		 loadXMLDocGrafo(nomeHighlight);
    	
    
    };
	
    
	
    myDiagram.linkTemplate =
        $(go.Link,
          $(go.Shape),                           // this is the link shape (the line)
          $(go.Shape, { toArrow: "Standard" }),  // this is an arrowhead
          $(go.TextBlock,{stroke: "white"} ,                     
            new go.Binding("text", "text"))
        );
    
    
	
	var myModel = $(go.GraphLinksModel);
	
	if(v==true){
		// in the model data, each node is represented by a JavaScript object:
		myModel.nodeDataArray = [
		  <%
		//grafo.puliciNodi();
		  ArrayList<NodoClasse> nodi2=grafo.getNodiClasse();
		  for(NodoClasse x: nodi2){ 
			  out.print("{ key: \""+x.getNome()+"\"},");
		  }
		  ArrayList<NodoClasseExternal> nodiii2=grafo.getNodiClasseExternal();
		  for(NodoClasseExternal x: nodiii2){ 
			  out.print("{ key: \""+x.getNome()+"\"},");
		  }
		  %>
		  
		];
		myModel.linkDataArray = [
		<%
		ArrayList<Arco> archi2=grafo.getArchi();
		for(Arco x: archi2){
		  out.print("{ from: \""+x.getFrom().getNome()+"\", to: \""+x.getTo().getNome()+"\", text:\""+x.getTipo()+"\"},");
		}
		%>
		  
		];
	}
	else if(v==false){
		// in the model data, each node is represented by a JavaScript object:
		myModel.nodeDataArray = [
		  <%
		//grafo.puliciNodi();
		  ArrayList<NodoClasse> nodi2e=grafo.getNodiClasse();
		  for(NodoClasse x: nodi2e){ 
			  out.print("{ key: \""+x.getNome()+"\"},");
		  }
		  ArrayList<NodoClasseExternal> nodiii2e=grafo.getNodiClasseExternal();
		  for(NodoClasseExternal x: nodiii2e){ 
			  out.print("{ key: \""+x.getNome()+"\"},");
		  }
		  %>
		  
		];
		myModel.linkDataArray = [
		<%
		ArrayList<Arco> archi2e=grafo.getArchi();
		for(Arco x: archi2e){
			//CONTROLLO CHE NON SONO SU SE STESSI
			if(!x.getFrom().getNome().equals(x.getTo().getNome()))
		  		out.print("{ from: \""+x.getFrom().getNome()+"\", to: \""+x.getTo().getNome()+"\", text:\""+x.getTipo()+"\"},");
		}
		%>
		  
		];
	}
	
	
	
	myDiagram.model = myModel;

	
}

function init3(v) {
	
	var div = document.getElementById('riga1');
	while(div.firstChild){
	    div.removeChild(div.firstChild);
	}
	if(v==true)
		document.getElementById('cicli').checked=true; 
	else if(v==false)
		document.getElementById('cicli').checked=false;  
	document.getElementById('riga55').hidden=true;
	//document.getElementById('riga55').removeAttribute('hidden');
	document.cookie = "funzione=init3()";
	var newDiv = document.createElement("div"); 
	newDiv.setAttribute("id", "myDiagramDiv2");
	 document.getElementById("cicli").checked = true;
	
	div.appendChild(newDiv);
	/*
	 
	    {
	      initialContentAlignment: go.Spot.Center, // center Diagram contents
	      "undoManager.isEnabled": true, 
          initialAutoScale: go.Diagram.UniformToFill,
        	  layout: $(go.LayeredDigraphLayout)  
          
	    });
	
	myDiagram.model.isReadOnly = true;
	myDiagram.allowLink = false;
	myDiagram.allowClipboard = false;
	myDiagram.allowDelete = false;
	*/
	
	 var $ = go.GraphObject.make;  // for conciseness in defining templates

	    myDiagram = $(go.Diagram, "myDiagramDiv2",  // create a Diagram for the DIV HTML element
	      {
              initialContentAlignment: go.Spot.Center,  // center the content
	                    "undoManager.isEnabled": true,  // enable undo & redo
	                    initialAutoScale: go.Diagram.UniformToFill,
	              	  layout: $(go.CircularLayout)  
	                  });

	    // define a simple Node template
	    myDiagram.nodeTemplate =
	      $(go.Node, "Auto",  // the Shape will go around the TextBlock
	         $(go.Shape, { 
	        	 figure: "RoundedRectangle", 
	        	 width: 80, 
	        	 height: 40, 
	        	 margin: 5,
	        	 fill: "rgba(0,255,0,.3)",
                // background: "orange",
               //  fill: "rgb(0,255,0)",
                 stroke: "black", 
                 strokeWidth: 3   
              },
              new go.Binding("width", "larghezza"),
              new go.Binding("height", "altezza"),
              new go.Binding("strokeWidth", "larBordo"),
            
	          new go.Binding("fill", "color")
              ),
              $(go.TextBlock,
 			          { margin: 20,
 			        	font: "bold 11pt helvetica, bold arial, sans-serif", stroke: "white",
 		                editable: false },
	          new go.Binding("text", "key"))
	      );
	    
	    
	    

	    myDiagram.linkTemplate =
	    	 $(go.Link,               
	    	          { toShortLength: 9 },
	    	          $(go.Shape,
	    	            { stroke: "red", strokeWidth: 5 },  new go.Binding("strokeWidth", "spessore")),
	    	          $(go.Shape,
	    	            {
	    	              fill: "black",
	    	              stroke: null,
	    	              toArrow: "Standard",
	    	              scale: 2.4
	    	            }),
	    	          /*  $(go.TextBlock,{stroke: "white"} ,                     
	    	                    new go.Binding("text", "text"))*/
	    	                /*    $ (go.Panel, "Auto" ,   // questo intero pannello è un'etichetta di collegamento 
	    	                            $ (go.Shape, "Rectangle" , {fill: "yellow" , stroke: "gray" }),
	    	                            $ (go.TextBlock, {margin: 3 },
	    	                               new go.Binding ( "text" , "text" ))
	    	                          )
	    	        
	    				                  */
	    	            $ (go.TextBlock, "left" , {stroke: "white"},{segmentOffset: new go.Point ( 0 , - 10 )}, new go.Binding("text", "text"))
	    				          
	    				        
	    	 );
	    
			    

	    // but use the default Link template, by not setting Diagram.linkTemplate

	    // create the model data that will be represented by Nodes and Links
	    myDiagram.model = new go.GraphLinksModel(	    
	    [
	    	<%
		    ArrayList<NodoPackage> nodoP=grafo.getNodiPackage();
			for(NodoPackage x: nodoP){
				
				String nom=x.getNome();
				int indice = nom.indexOf('.');
				if(indice==-1){
					if(nom.equals("(default package)")){
						String nomm="(default\\npackage)";
						out.print("{ key: \""+nomm+ "\", larBordo: "+x.getMetricaAstrattezza()+
				  				", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");
					}
					else{
						out.print("{ key: \""+x.getNome()+ "\", larBordo: "+x.getMetricaAstrattezza()+
				  				", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");	
					}
					
				}	
				else{
					String[] no=x.getNome().split("\\.");
					String nomee= String.join(".\\n", no);
					out.print("{ key: \""+nomee+ "\", larBordo: "+x.getMetricaAstrattezza()+
						", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");
					/*out.print("{ key: \""+nomee+ "\", larBordo: "+x.getMetricaAstrattezza()+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");*/
				}
			}
			
			%>
	    ],
	  
	    [
	    	<%
		    ArrayList<Arco> archiP=grafo.getArchi();
			for(Arco x: archiP){
				if(x.getTipo().equals("")){
					
					String from=x.getFrom().getNome();
					int indice1 = from.indexOf('.');
					if(indice1!=-1)		{
						String[] no1=from.split("\\.");
						from= String.join(".\\n", no1);
					}	
					else{
						if(from.equals("(default package)"))
							from="(default\\npackage)";
						else
							from=x.getFrom().getNome();
					}
					String to=x.getTo().getNome();
					int indice2 = to.indexOf('.');
					if(indice2!=-1)		{
						String[] no2=to.split("\\.");
						to= String.join(".\\n", no2);
					}	
					else{
						if(to.equals("(default package)"))
							to="(default\\npackage)";
						else
							to=x.getTo().getNome();
					}
					
			  		out.print("{ from: \""+from +"\", to: \""+to+"\""+", spessore: "+x.getMetricaNumero()
			  		+", text: \""+x.getNumero()+"\""+"},");
				}
			}
			%>
		]
	    
	    );
	    

	  
}

function init33(v) {
	
	var div = document.getElementById('riga1');
	while(div.firstChild){
	    div.removeChild(div.firstChild);
	}
	if(v==true)
		document.getElementById('cicli').checked=true; 
	else if(v==false)
		document.getElementById('cicli').checked=false;  
	document.getElementById('riga55').hidden=true;
	//document.getElementById('riga55').removeAttribute('hidden');
	document.cookie = "funzione=init3()";
	var newDiv = document.createElement("div"); 
	newDiv.setAttribute("id", "myDiagramDiv2");
	 document.getElementById("cicli").checked = true;
	
	div.appendChild(newDiv);
	/*
	 
	    {
	      initialContentAlignment: go.Spot.Center, // center Diagram contents
	      "undoManager.isEnabled": true, 
          initialAutoScale: go.Diagram.UniformToFill,
        	  layout: $(go.LayeredDigraphLayout)  
          
	    });
	
	myDiagram.model.isReadOnly = true;
	myDiagram.allowLink = false;
	myDiagram.allowClipboard = false;
	myDiagram.allowDelete = false;
	*/
	
	 var $ = go.GraphObject.make;  // for conciseness in defining templates

	    myDiagram = $(go.Diagram, "myDiagramDiv2",  // create a Diagram for the DIV HTML element
	      {
              initialContentAlignment: go.Spot.Center,  // center the content
	                    "undoManager.isEnabled": true,  // enable undo & redo
	                    initialAutoScale: go.Diagram.UniformToFill,
	                    layout: $(go.LayeredDigraphLayout)  
	                  });

	    // define a simple Node template
	    myDiagram.nodeTemplate =
	      $(go.Node, "Auto",  // the Shape will go around the TextBlock
	         $(go.Shape, { 
	        	 figure: "RoundedRectangle", 
	        	 width: 80, 
	        	 height: 40, 
	        	 margin: 5,
	        	 fill: "rgba(0,255,0,.3)",
                // background: "orange",
               //  fill: "rgb(0,255,0)",
                 stroke: "black", 
                 strokeWidth: 3   
              },
              new go.Binding("width", "larghezza"),
              new go.Binding("height", "altezza"),
              new go.Binding("strokeWidth", "larBordo"),
            
	          new go.Binding("fill", "color")
              ),
              $(go.TextBlock,
 			          { margin: 20,
 			        	font: "bold 11pt helvetica, bold arial, sans-serif", stroke: "white",
 		                editable: false },
	          new go.Binding("text", "key"))
	      );
	    
	    
	    

	    myDiagram.linkTemplate =
	    	 $(go.Link,               
	    	          { toShortLength: 9 },
	    	          $(go.Shape,
	    	            { stroke: "red", strokeWidth: 5 },  new go.Binding("strokeWidth", "spessore")),
	    	          $(go.Shape,
	    	            {
	    	              fill: "black",
	    	              stroke: null,
	    	              toArrow: "Standard",
	    	              scale: 2.4
	    	            }),
	    	          /*  $(go.TextBlock,{stroke: "white"} ,                     
	    	                    new go.Binding("text", "text"))*/
	    	                /*    $ (go.Panel, "Auto" ,   // questo intero pannello è un'etichetta di collegamento 
	    	                            $ (go.Shape, "Rectangle" , {fill: "yellow" , stroke: "gray" }),
	    	                            $ (go.TextBlock, {margin: 3 },
	    	                               new go.Binding ( "text" , "text" ))
	    	                          )
	    	        
	    				                  */
	    	            $ (go.TextBlock, "left" , {stroke: "white"},{segmentOffset: new go.Point ( 0 , - 10 )}, new go.Binding("text", "text"))
	    				          
	    				        
	    	 );
	    
			    

	    // but use the default Link template, by not setting Diagram.linkTemplate

	    // create the model data that will be represented by Nodes and Links
	    myDiagram.model = new go.GraphLinksModel(	    
	    [
	    	<%
		    ArrayList<NodoPackage> nodoPy=grafo.getNodiPackage();
			for(NodoPackage x: nodoPy){
				
				String nom=x.getNome();
				int indice = nom.indexOf('.');
				if(indice==-1){
					if(nom.equals("(default package)")){
						String nomm="(default\\npackage)";
						out.print("{ key: \""+nomm+ "\", larBordo: "+x.getMetricaAstrattezza()+
				  				", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");
					}
					else{
						out.print("{ key: \""+x.getNome()+ "\", larBordo: "+x.getMetricaAstrattezza()+
				  				", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");	
					}
					
				}			
			  		
				else{
					String[] no=x.getNome().split("\\.");
					String nomee= String.join(".\\n", no);
					out.print("{ key: \""+nomee+ "\", larBordo: "+x.getMetricaAstrattezza()+
						", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");
					/*out.print("{ key: \""+nomee+ "\", larBordo: "+x.getMetricaAstrattezza()+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");*/
				}
			}
			
			%>
	    ],
	  
	    [
	    	<%
		    ArrayList<Arco> archiPy=grafo.getArchi();
			for(Arco x: archiPy){
				if(x.getTipo().equals("")){
					
					String from=x.getFrom().getNome();
					int indice1 = from.indexOf('.');
					if(indice1!=-1)		{
						String[] no1=from.split("\\.");
						from= String.join(".\\n", no1);
					}	
					else{
						if(from.equals("(default package)"))
							from="(default\\npackage)";
						else
							from=x.getFrom().getNome();
					}
					
					String to=x.getTo().getNome();
					int indice2 = to.indexOf('.');
					if(indice2!=-1)		{
						String[] no2=to.split("\\.");
						to= String.join(".\\n", no2);
					}	
					else{
						if(to.equals("(default package)"))
							to="(default\\npackage)";
						else
							to=x.getTo().getNome();
					}
				
					
			  		out.print("{ from: \""+from +"\", to: \""+to+"\""+", spessore: "+x.getMetricaNumero()
			  		+", text: \""+x.getNumero()+"\""+"},");
				}
			}
			%>
		]
	    
	    );
	    

	  
}



function init4(v) {
	
	var div = document.getElementById('riga1');
	while(div.firstChild){
	    div.removeChild(div.firstChild);
	}

	document.getElementById('riga55').removeAttribute('hidden');
	document.cookie = "funzione=init4()";
	var newDiv = document.createElement("div"); 
	newDiv.setAttribute("id", "myDiagramDiv2");
	if(v==true)
		document.getElementById('cicli').checked=true; 
	else if(v==false)
		document.getElementById('cicli').checked=false; 
	
	div.appendChild(newDiv);
	/*
	 
	    {
	      initialContentAlignment: go.Spot.Center, // center Diagram contents
	      "undoManager.isEnabled": true, 
          initialAutoScale: go.Diagram.UniformToFill,
        	  layout: $(go.LayeredDigraphLayout)  
          
	    });
	
	myDiagram.model.isReadOnly = true;
	myDiagram.allowLink = false;
	myDiagram.allowClipboard = false;
	myDiagram.allowDelete = false;
	*/
	
	 var $ = go.GraphObject.make;  // for conciseness in defining templates

	    myDiagram = $(go.Diagram, "myDiagramDiv2",  // create a Diagram for the DIV HTML element
	      {
	    	 initialContentAlignment: go.Spot.Center, // center Diagram contents
		      "undoManager.isEnabled": true, 
	          initialAutoScale: go.Diagram.UniformToFill,
	        	  layout: $(go.LayeredDigraphLayout)  
              
	                  });

	    // define a simple Node template
	    myDiagram.nodeTemplate =
	      $(go.Node, "Auto",  // the Shape will go around the TextBlock
	    		  $ (go.Panel, "Vertical" ,{  margin: 2, },  // questo intero pannello è un'etichetta di collegamento 
	    				  $(go.Shape, { 
	    			        	 figure: "Ellipse", 
	    			        	 width: 160, 
	    			        	 height: 70, 
	    			        	 margin: 2,
	    			        	 fill: "rgba(150,10,10,1)",
	    		                 //background: "orange",
	    		                 //fill: "rgb(0,255,0)",	    		         
	    		                 stroke: "black", 
	    		                 strokeWidth: 3   
	    		              }
	    				  	  ,
	    		              new go.Binding("width", "larghezza1"),
	    		              new go.Binding("height", "altezza1"),
	    		              new go.Binding("strokeWidth", "larBordo1"),           
	    			          new go.Binding("fill", "color1")
	    		              ),
	    		              
	    		              $ (go.Panel, "Auto" ,{  margin: 2},
	    		            		  
	    		            		  $(go.Shape, { 
	 		    			        	 figure: "RoundedRectangle", 
	 		    			        	 width: 180, 
	 		    			        	 height: 80, 
	 		    			        	 margin: 2,
	 		    			        	 fill: "rgba(0,255,0,.3)",
	 		    		               //  fill: "rgb(0,255,0)",
	 		    		                 stroke: "black", 
	 		    		                 strokeWidth: 3   
	 		    		              },
	 		    		              new go.Binding("width", "larghezza"),
	 		    		              new go.Binding("height", "altezza"),
	 		    		  //            new go.Binding("strokeWidth", "larBordo"),            
	 		    			          new go.Binding("fill", "color")
	 		    		              ),
	 	    		              
	 	    			        $(go.TextBlock,
	 	    			          { margin: 20,
	 	    			        	font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
	 	    		                editable: false },
	 	    			          new go.Binding("text", "key"))
	    		              
	    		              )
	    		             
                        )
	        
	      );
	    
	    myDiagram.linkTemplate =
	    	 $(go.Link,{ toShortLength: 9 },
	         $(go.Shape,{ stroke: "red", strokeWidth: 5 },  
	        		 //new go.Binding("strokeWidth", "spessore")
	         ),
	         $(go.Shape,{ fill: "black", stroke: null, toArrow: "Standard", scale: 2.4 }),
	         $(go.TextBlock, "left" , {stroke: "white"},{segmentOffset: new go.Point ( 0 , - 10 )}, 
	        		 new go.Binding("text", "text")
	         )
	    				          
	    				        
	    	 );
	   
			    

	    // but use the default Link template, by not setting Diagram.linkTemplate

	    // create the model data that will be represented by Nodes and Links
	    
	    if(v==true){
	    myDiagram.model = new go.GraphLinksModel(	    
	    [
	    	<%
		    ArrayList<NodoClasse> nodoCla=grafo.getNodiClasse();
			for(NodoClasse x: nodoCla){			
				
				out.print("{"+"altezza1: "+x.getMetricaDistanzaRadice()+ 
						", larghezza1: "+x.getMetricaCiclomatica()+ 
						", color1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
						", larBordo1: "+x.getMetricaAccoppiamentoClassi()+ 
						", key: \""+x.getNome()+"\", larghezza: "+x.getMetricaNumeroCommenti()+
						", altezza: "+x.getMetricaNumeroLineeCodice()+
						", color: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
						"},");
				
			  	/*	out.print("{ key: \""+x.getNome()+ "\", larBordo: "+x.getMetricaAstrattezza()+
			  				", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
				           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");
				  */ 	
			}
			
			%>
	    ],
	  
	    [
	    	<%	
		    ArrayList<Arco> archiPp=grafo.getArchi();
			for(Arco x: archiPp){
				//PRENDO GLI ARCHI CLASSE
				if(!x.getTipo().equals("")){
					//PRENDO GLI ARCHI TRA DUE CLASSI UTENTE
					if((x.getFrom()instanceof NodoClasse) && (x.getTo()instanceof NodoClasse))
			  				out.print("{ from: \""+x.getFrom().getNome() +"\", to: \""+x.getTo().getNome()+"\""+
							//", spessore: "+x.getMetricaNumero()+
			  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
				}
			}
			%>
		]
	    
	    );
	    }
	    else if(v==false){
		    myDiagram.model = new go.GraphLinksModel(	    
		    [
		    	<%
			    ArrayList<NodoClasse> nodoClaa=grafo.getNodiClasse();
				for(NodoClasse x: nodoClaa){			
					
					out.print("{ key: \""+x.getNome()+"\", larghezza: "+x.getMetricaNumeroCommenti()+
							", altezza: "+x.getMetricaNumeroLineeCodice()+
							", color: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
							"},");
					
				  	/*	out.print("{ key: \""+x.getNome()+ "\", larBordo: "+x.getMetricaAstrattezza()+
				  				", color: \"rgba("+x.getMetricaInstabilità()+",10,10,1)\""+
					           ", larghezza: "+x.getMetricaClassi()+", altezza: "+x.getMetricaLinee()+"},");
					  */ 	
				}
				
				%>
		    ],
		  
		    [
		    	<%	
			    ArrayList<Arco> archiPpp=grafo.getArchi();
				for(Arco x: archiPpp){
					//PRENDO GLI ARCHI CLASSE
					if(!x.getTipo().equals("")){
						//PRENDO GLI ARCHI TRA DUE CLASSI UTENTE
						if((x.getFrom()instanceof NodoClasse) && (x.getTo()instanceof NodoClasse))
							//CONTROLLO CHE NON SONO SU SE STESSI
							if(!x.getFrom().getNome().equals(x.getTo().getNome()))
				  				out.print("{ from: \""+x.getFrom().getNome() +"\", to: \""+x.getTo().getNome()+"\""+
								//", spessore: "+x.getMetricaNumero()+
				  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
					}
				}
				%>
			]
		    
		    );
		    }
	    

	  
}

function togl(a){
	//ottengo il grafo da visualizzare
	var inizio = document.cookie.indexOf("=");
	var funzione=document.cookie.substring(inizio+1);
	
	if(funzione=="init()")
		init(a.checked);
	else if(funzione=="init2()")
		init2(a.checked);
	else if(funzione=="init3()")
		init3();
	else if(funzione=="init4()")
		init4(a.checked);
}


function initPackage(path,id,cicli) {

	      var xmlhttp;
	      var name="<%=nome%>"; 
	  	  var url="ServletGo?path="+path+"&id="+id+"&name="+name;
	  	  if (window.XMLHttpRequest)
	  	  {
	  	      xmlhttp=new XMLHttpRequest();
	  	  }
	  	  else
	  	  {
	  	      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	  }
	  	  xmlhttp.onreadystatechange=function()
	  	  {
	  	      if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  	      {
	  	    	var div = document.getElementById('riga1');
	  	  		while(div.firstChild){
	  	  	    	div.removeChild(div.firstChild);
	  	  		}
	  	  	
	  	  		//SETTO COSA DEVO MOSTRARE NELLA BARRA OPZIONI
	  	  		
	  	  		if(cicli==true && path==""){
	  	  			document.getElementById('cicli').removeAttribute('hidden');
	  	  			document.getElementById('indietro').hidden=true;
	  	  			document.getElementById('riga55').removeAttribute('hidden');
	  	        }
	  	        else if(cicli==false && path==""){
	  	        	document.getElementById('riga55').hidden=true;
	  	  			document.getElementById('cicli').hidden=true;
	  	  			document.getElementById('indietro').hidden=true;
	  	        }
	  	  		else if(cicli==true && path!=""){
			  		document.getElementById('cicli').removeAttribute('hidden');
			  		document.getElementById('indietro').removeAttribute('hidden');
			  		document.getElementById('riga55').removeAttribute('hidden');
			    }
	  	  		else if(cicli==false && path!=""){
					document.getElementById('cicli').hidden=true;
					document.getElementById('indietro').removeAttribute('hidden');
					document.getElementById('riga55').removeAttribute('hidden');
				}
	  	 	
	  	  	
		  	  	//CREO IL DIV
		  	  	var newDiv = document.createElement("div"); 
		  	  	newDiv.setAttribute("id", "myDiagramDiv");
		  	  	div.appendChild(newDiv);
	  	  	
		  	  	//COOKIE
		  	  	document.cookie = "path="+path;
		  	  	document.cookie = "id="+id;
		  	  	
		  	  	var $ = go.GraphObject.make;  
		  	  	myDiagram = $(go.Diagram, "myDiagramDiv", 
		  	  	{
		  	           "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
		  	  	    "undoManager.isEnabled": true,  
		  	  	    initialContentAlignment: go.Spot.Center,
		  	          initialAutoScale: go.Diagram.UniformToFill,
		  	          layout: $ (go.CircularLayout)
		  	  	});

		  	  	myDiagram.nodeTemplate =
		  	  	   $(go.Node, "Auto",  
		  	  			   
		  	  	    $ (go.Panel, "Vertical" ,{  margin: 2, }, 
		  	  	     $(go.Shape, { 
		  	  				        figure: "Ellipse", 
		  	  				    	width: 0, 
		  	  				    	height: 0, 
		  	  				    	margin: 0,
		  	  				    	fill: "rgba(150,10,10,1)",
		  	  				    	stroke: "black", 
		  	  				    	strokeWidth: 0   
		  	  	    	          }
		  	  	    			  ,
		  	  	    		      new go.Binding("width", "larghezza1"),
		  	  	    		      new go.Binding("height", "altezza1"),
		  	  	    		      new go.Binding("strokeWidth", "larBordo1"),           
		  	  	    			  new go.Binding("fill", "color1")
		  	  	       ),
		  	  	    		              
		  	  	       $ (go.Panel, "Auto" ,{  margin: 2},
		  	  	      		  $(go.Shape, { 
		  	  	 	 			        	 figure: "RoundedRectangle", 
		  	  	 	  			        	 width: 180, 
		  	  	 	   			        	 height: 80, 
		  	  	 	   			        	 margin: 2,
		  	  	 	   			        	 fill: "rgba(0,255,0,.3)",
		  	  	 				             stroke: "black", 
		  	  	 		    	             strokeWidth: 3   
		  	  	 		    	          },
		  	  	 		    	             new go.Binding("width", "larghezza"),
		  	  	 		    	             new go.Binding("height", "altezza"),
		  	  	 		    	             new go.Binding("strokeWidth", "larBordo"),            
		  	  	 		    		         new go.Binding("fill", "color")
		  	  	               ),
		  	  	    	       $(go.TextBlock,
		  	  	 	    	         { margin: 20,
		  	  	 	    	           font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
		  	  	 	    	           editable: false 
		  	  	 	    	         },
		  	  	 	       	         new go.Binding("text", "keys"))              
		  	  	                 )	    		             
		  	                     )
		  	  	   );
		  	  	    
		  	  	    
		  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
		  	  			 if(node.data.larghezza1==0){
		  	  				 if(node.data.key==0)
		  	  			 		initPackage(node.data.keys,node.data.key,false); 
		  	  				 else
		  	  					initPackage(node.data.keys,node.data.key,true); 
		  	  			 }
		  	  			 else{
		  	  				loadXMLDocGrafo(node.data.keys);
		  	  			 }
		  	  	    };
		  	  	   
		  	  	    myDiagram.linkTemplate =
		  	  	    	 $(go.Link,               
		  	  	    	          { toShortLength: 9 },
		  	  	    	          $(go.Shape,
		  	  	    	            { stroke: "red", strokeWidth: 5 },  new go.Binding("strokeWidth", "spessore")),
		  	  	    	          $(go.Shape,
		  	  	    	            {
		  	  	    	              fill: "black",
		  	  	    	              stroke: null,
		  	  	    	              toArrow: "Standard",
		  	  	    	              scale: 2.4
		  	  	    	            }),
		  	  	    	
		  	  	    	            $ (go.TextBlock, "left" , {stroke: "white"},{segmentOffset: new go.Point ( 0 , - 10 )}, new go.Binding("text", "text"))
		  	  	    				          
		  	  	    				        
		  	  	    	 );
	  	    	 
	  	    	  var response=xmlhttp.responseText;
	  	    	 /* var resp = response.substring(0,8);
	  	    	  if(resp=="acf12345"){
	  	    		 var response1 = response.substring(8,response.length);
	  	    		 loadXMLDocGrafo1(response1);
			        
	  	    	  }
	  	    	  else{*/
	  	    		  var ris = response.split('!!');
		  	    	  var pacchetto=ris[0];	  
		  	    	  var classe=ris[1];
		  	    	
		  	    	
		  	    	  var nodeDataArray = new Array (); 
		  	    	  if(pacchetto!=""){
			  	    	  var pacchetti=pacchetto.split(';-;');
			  	    	  for(var i=0; i<pacchetti.length; i++){
			  	    		 var info=pacchetti[i].split("+");
			  	   		 nodeDataArray.push ({key: parseInt(info[0]), keys: info[1], altezza: parseInt(info[2]), larghezza: parseInt(info[3]), larBordo: parseInt(info[4]), color: "rgba("+info[5]+",10,10,1)", larghezza1: 0});
			  	    	  }
		  	    	  }
		  	    	  
		  	    	  if(classe!=""){
		  	    		var classi=classe.split(':-:');
		  	    		for(var i=0; i<classi.length; i++){
		  	    			var infoo=classi[i].split("+");
		  	    			nodeDataArray.push ({key: parseInt(infoo[0]), keys: infoo[1], larghezza: parseInt(infoo[2]), altezza: parseInt(infoo[3]), altezza1: parseInt(infoo[4]), larghezza1: parseInt(infoo[5])});
		  	    		}
		  	    	  }
		   
		  	      	  var linkDataArray = [
		  	      		<%
		    			   ArrayList<Arco> archiPyw7=grafo.getArchi();
		    				for(Arco x: archiPyw7)
		    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
	    				  		+", text: \""+x.getNumero()+"\""+"},");
		    				%>
		  	      	  ];
		  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	  	    	  }
	  	      }
	  	//  }
	  	  xmlhttp.open("GET", url, true);
	  	  xmlhttp.send();
}

function indietro(){
	//ottengo il grafo da visualizzare
	
	var percorso =document.cookie.split("; ");
	var path1=percorso[0].split('=');
	var id1=percorso[1].split('=');

	var path;
	var id;
	
	if(path1[0]=="path"){
		path=path1[1];
		id=id1[1];
	}
	else{
		path=id1[1];
		id=path1[1];
	}
	
	var indice=path.lastIndexOf('.');
	if(indice==-1){
		alert(id);
		initPackage("",id,false); 
	}
	else{
		var pat=path.substring(0,indice);
		initPackage(pat,id,true); 
	}
	
}

function cicli(){

}

</script>

	


	</body>
</html>