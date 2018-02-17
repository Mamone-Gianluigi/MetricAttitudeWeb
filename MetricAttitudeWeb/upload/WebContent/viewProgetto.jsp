<%@page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="it">
	<head>
	
	<link href="css/viewProgetto.css" rel="stylesheet" type="text/css" />
	
	<%@ page import="struttura.Grafo,java.util.ArrayList,parsing.Path,
	java.io.BufferedReader,java.io.File,java.io.FileReader,java.io.IOException,
	java.util.Enumeration,struttura.Nodo,struttura.NodoClasse,struttura.NodoPackage,
	struttura.NodoClasseExternal,struttura.TipoClasse,
	struttura.Arco,java.io.FileInputStream,java.io.ObjectInputStream,java.io.File" %>
		<%
	
		
		  	//carico il grafo e lo setto nella variabile di sessione
		  //  String filePath = "C:\\Users\\Gianluigi\\Desktop\\FileInUpload"+File.separatorChar;
			String filePath = Path.getPath()+File.separatorChar;
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
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
						$('#ajax').on("changed.jstree", function (e, data) {
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
			<button type="button" class=".btn-sm btn-primary"  onclick="initClassCircolare(true,false,'normale')">Class All [Circle]</button>		
			<button type="button" class=".btn-sm btn-primary" onclick="initClassLayer(true,false,'normale')">Class All [Layered]</button>
			<button type="button" class=".btn-sm btn-danger" onclick="initPackageAll('',0,true,'normale')">Class-Package All [Circle]</button>	
			<button type="button" class=".btn-sm btn-danger" onclick="initPackageAll1('',0,true,'normale')">Class-Package All [Layered]</button>	
			
			<button type="button" class=".btn-sm btn-success" onclick="initPackageNavigation('',0,'normale')">Package Navigation [Circle]</button>	
				<button type="button" class=".btn-sm btn-success" onclick="initPackageNavigation1('',0,'normale')">Package Navigation [Layered]</button>	
			
			
			<button type="button" class=".btn-sm btn-warning" onclick="initPackagePre('',0,true,'normale')">Class-Package Navigation Preview [Circle]</button>	
			<button type="button" class=".btn-sm btn-warning" onclick="initPackagePre1('',0,true,'normale')">Class/Package Navigation Preview [Layered]</button>		
			
			
			
			<button type="button" class=".btn-sm btn-success" onclick="initPackage1('',0,true,false,'normale')">Class/Package Navigation [Layered]</button>	
			 <button type="button" class=".btn-sm btn-success" onclick="initPackage('',0,true,false,'normale')">Class-Package Navigation [Circle]</button>	
	
			
		</div>


		<div id="riga1" onresize="myFunction()" class="col-sm-3" >  	</div>
		<div id="riga55" class="col-sm-3" hidden>
			<div id="indietro" style="float:left;" hidden>
				<button type="button" class="btn btn-primary" onclick="indietro()">&nbsp Indietro &nbsp</button>
			</div>
			<div id="indietro1" style="float:left;" hidden>
				<button type="button" class="btn btn-primary" onclick="indietro1()">&nbsp Indietro &nbsp</button>
			</div>
			<div id="indietro2" style="float:left;" hidden>
				<button type="button" class="btn btn-primary" onclick="indietro2()">&nbsp Indietro &nbsp</button>
			</div>
			<div id="cicli" style="float:left;" hidden>	&nbsp
       		 	<label for="primary" class="btn btn-success">CICLI <input type="checkbox" id="primary" class="badgebox" onclick="cicli(this)" ><span class="badge">&check;</span></label>
			</div>		
			<div id="cicli1" style="float:left;" hidden>	&nbsp
       		 	<label for="primary1" class="btn btn-danger">CLASSI ESTERNE <input type="checkbox" id="primary1" class="badgebox" onclick="esterne(this)" ><span class="badge">&check;</span></label>
			</div>		
			<div id="cicli2" style="float:left;" >	&nbsp
       		 	<label for="primary2" class="btn btn-warning">Link Normale <input type="radio" name="rad" value="normale" id="primary2" class="badgebox" onclick="link(this)" ><span class="badge">&check;</span></label>
			</div>		
				<div id="cicli3" style="float:left;" >	&nbsp
       		 	<label for="primary3" class="btn btn-primary">Link Ortogonale <input type="radio" name="rad" value="ortogonale" id="primary3" class="badgebox" onclick="link(this)" ><span class="badge">&check;</span></label>
			</div>	
			<div id="cicli4" style="float:left;" >	&nbsp
       		 	<label for="primary4" class="btn btn-success">Link Curvo <input type="radio" name="rad" value="curvo" id="primary4" class="badgebox" onclick="link(this)" ><span class="badge">&check;</span></label>
			</div>	
			<div id="cicli5" style="float:left;" >	&nbsp
       		 	<label for="primary5" class="btn btn-danger">Link Evita Nodi <input type="radio" name="rad" value="evita" id="primary5" class="badgebox" onclick="link(this)" ><span class="badge">&check;</span></label>
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
	
	function initPackageAll1(path,id,cicli,link) {

	    var div = document.getElementById('riga1');
	  	while(div.firstChild){
	  	   	div.removeChild(div.firstChild);
	  	}
	  	  		
	  	document.getElementById('riga55').removeAttribute('hidden');
	  	document.getElementById('primary2').hidden=true;
	  	document.getElementById('cicli1').hidden=true;
	  	document.getElementById('primary2').removeAttribute('hidden');
	  	document.getElementById('primary3').removeAttribute('hidden');
	  	document.getElementById('primary4').removeAttribute('hidden');
	  	document.getElementById('primary5').removeAttribute('hidden');
	  	document.getElementById('cicli').removeAttribute('hidden');	
		document.getElementById('indietro').hidden=true;
		document.getElementById('indietro1').hidden=true;
		document.getElementById('indietro2').hidden=true;
	
		if(link=="normale")
			document.getElementById('primary2').checked=true;
		else if(link=="ortogonale")
			document.getElementById('primary3').checked=true;
		else if(link=="curvo")
			document.getElementById('primary4').checked=true;
		else if(link=="evita")
			document.getElementById('primary5').checked=true;
	  	  		
		document.getElementById('primary').checked=cicli;
	  	        
		  	  	
		  	    
		//CREO IL DIV
		var newDiv = document.createElement("div"); 
		newDiv.setAttribute("id", "myDiagramDiv");
		div.appendChild(newDiv);
	  	  	
		//COOKIE
		document.cookie = "path="+path;
		document.cookie = "id="+id;
	    document.cookie = "diagramma=pacchettoAll1";
		  	  	
		var $ = go.GraphObject.make;  
  	  	myDiagram = $(go.Diagram, "myDiagramDiv", 
	  	{
           "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
    	    "undoManager.isEnabled": true,  
	 	    initialContentAlignment: go.Spot.Center,
	 	    initialAutoScale: go.Diagram.UniformToFill,
	 	   layout: $ (go.LayeredDigraphLayout)
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
			  new go.Binding("fill", "color1"),
			  new go.Binding("stroke", "colorBordo1") 
			),
					  	  	    		              
			 $ (go.Panel, "Auto" ,{  margin: 2},
					   $(go.Shape, { 
					   	 figure: "RoundedRectangle", 
					   	 width: 180, 
					   	 height: 40, 
					   	 margin: 2,
					   	 fill: "rgba(255,191,24,1)",cursor: "pointer",
					     stroke: "black", 
					     strokeWidth: 2   
					  },
					    new go.Binding("width", "larghezza"),
					    new go.Binding("height", "altezza"),
					    new go.Binding("strokeWidth", "larBordo"),            
					    new go.Binding("fill", "color"),
					    new go.Binding("stroke", "colorBordo")
					 ),
					 $(go.TextBlock,
					   { margin: 20,
					     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
					     editable: false 
					   },
					     new go.Binding("text", "keys"),
					     new go.Binding("stroke", "coloreTesto"),
					     new go.Binding("font", "fonte"))   
					  )	    		             
					 )
				   );
		  	  	    
		  	    
		if(link=="normale"){
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
	    }	   
	    else if (link=="ortogonale"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			         { toShortLength: 9 },
			         {routing: go.Link.Orthogonal},
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
			  	    	 
	    }
	    else if(link=="curvo"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			         { toShortLength: 9 ,corner: 40 },
			         { curve: go.Link.Bezier },
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
			  	    	 
	    }
	    else if(link=="evita"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			  			 { toShortLength: 9 },
			  		   {routing: go.Link.AvoidsNodes},
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
			  	    	 
	    }
	  	    	 
		  
		  	  	myDiagram.groupTemplate =
		  	  	    $(go.Group, "Vertical",{ selectionObjectName: "PANEL", ungroupable: true },
		  	  	        $(go.Panel, "Auto",{ margin: 20},
		  	  	          $(go.Shape, "RoundedRectangle",  // surrounds the Placeholder
		  	  	            { parameter1: 20,
		  	  	              fill: "rgba(0,0,0,0.9)", cursor: "pointer"},
		  	  	          new go.Binding("fill", "color")),
		  	  	       		 $(go.Placeholder, { margin: 9, background: "transparent" }) 
		  	  	        ),
		  	  	        $(go.TextBlock,         // group title
		  	  	          { alignment: go.Spot.Center, font: "Bold 12pt Sans-Serif" , margin: 0},
		  	  	          new go.Binding("text", "keys"))
		  	  	      	
		  	  	      );
		  	  	    
		  	  
	  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
	  	  				loadXMLDocGrafo(node.data.keys);
	  	  	    };
		  	  	
		  		
	  	    	
	  	  	
		  	    var nodeDataArray = new Array ();  
		  	  nodeDataArray = [
		  	   		<%
		  	   			  
		    			   ArrayList<NodoPackage> nodiPa=grafo.getNodiPackage();
		    			   for(NodoPackage nod: nodiPa){	
		    				   String a1=nod.getNome();
		    				   String[] r1=a1.split("\\.");
		    				   int n=0;
		    				   if(r1.length%2==0)
		    					   n=210;
		    				   else
		    					   n=235;
		    				   if(nod.getParentPackage().equals(""))
			    				   out.print("{ key:"+nod.getId()+", keys: \""+nod.getNome()+"\", isGroup:"+true+
			    						   ", color: \"rgba("+255+","+n+","+80+",0.9)\""+   
			    				   "},");
			    			   else{
			    				   String a=nod.getParentPackage();
			    				   NodoPackage nodoPack=grafo.cercaNodoPackage(a);
			    				   String[] r=a.split(".");
			    				   out.print("{ key:"+nod.getId()+", keys: \""+nod.getNome()+"\", isGroup:"+true+", group:"+nodoPack.getId()+
				    						   ", color: \"rgba("+255+","+n+","+80+",0.9)\""+      
				    				   "},");
			    				  
			    			   }
		    				}
		    				
		    			   ArrayList<NodoClasse> nodiCl=grafo.getNodiClasse();
		    			   for(NodoClasse no: nodiCl){
		    				   String aa=no.getPackage();
	    					   NodoPackage nodoPack1=grafo.cercaNodoPackage(aa);
	    					   if(no.getMetricaFI()>180){
	    						   out.print("{"+
											"key: "+no.getId()+
											", keys: \""+no.getNome()+			
											
											"\", altezza1: "+no.getMetricaDistanzaRadice()+
											", larghezza1: "+no.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+no.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+no.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+no.getMetricaNumeroCommenti()+
											", altezza: "+no.getMetricaNumeroLineeCodice()+
											", larBordo: "+no.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+no.getMetricaFI()+","+no.getMetricaFI()+","+no.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+no.getMetricaNumeroMedoti()+",10,10,1)\""+
											", group:"+nodoPack1.getId()+
											", coloreTesto: \"black\""+
											"},");
	    					   }
	    					   else{
	    						   out.print("{"+
											"key: "+no.getId()+
											", keys: \""+no.getNome()+			
											
											"\", altezza1: "+no.getMetricaDistanzaRadice()+
											", larghezza1: "+no.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+no.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+no.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+no.getMetricaNumeroCommenti()+
											", altezza: "+no.getMetricaNumeroLineeCodice()+
											", larBordo: "+no.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+no.getMetricaFI()+","+no.getMetricaFI()+","+no.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+no.getMetricaNumeroMedoti()+",10,10,1)\""+
											", group:"+nodoPack1.getId()+
											"},");
	    					   }
		    				   
		    			   }	   
		    			   
		    				  
		    	    %>
		  	  ];
		  	      
		
		  	    var linkDataArray;
		  	    if(cicli==false){
		   		  linkDataArray = [
			  	   		<%
			    			   ArrayList<Arco> archi789w=grafo.getArchi();
			    				for(Arco x: archi789w)		
			    					if(!x.getFrom().getNome().equals(x.getTo().getNome()))
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    				
			    				
			    	    %>
			  	  ];
		  	    }
		  	    else if(cicli==true){
			   		  linkDataArray = [
				  	   		<%
				    			   ArrayList<Arco> archi7899w=grafo.getArchi();
				    				for(Arco x: archi7899w)		
				    					if((x.getFrom() instanceof NodoPackage)==false)
				    			  			out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
			    				  			+", text: \""+x.getNumero()+"\""+"},");
				    	    %>
				  	  ];
			  	    }
		   			
		   		   
		  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	   
}	
	
	function initPackageAll(path,id,cicli,link) {

	    var div = document.getElementById('riga1');
	  	while(div.firstChild){
	  	   	div.removeChild(div.firstChild);
	  	}
	  	  		
	  	document.getElementById('riga55').removeAttribute('hidden');
	  	document.getElementById('primary2').hidden=true;
	  	document.getElementById('primary2').removeAttribute('hidden');
	  	document.getElementById('primary3').removeAttribute('hidden');
	  	document.getElementById('primary4').removeAttribute('hidden');
	  	document.getElementById('primary5').removeAttribute('hidden');
	  	document.getElementById('cicli').removeAttribute('hidden');	
	  	document.getElementById('cicli1').hidden=true;
		document.getElementById('indietro').hidden=true;
		document.getElementById('indietro1').hidden=true;
		document.getElementById('indietro2').hidden=true;
	
		if(link=="normale")
			document.getElementById('primary2').checked=true;
		else if(link=="ortogonale")
			document.getElementById('primary3').checked=true;
		else if(link=="curvo")
			document.getElementById('primary4').checked=true;
		else if(link=="evita")
			document.getElementById('primary5').checked=true;
	  	  		
		document.getElementById('primary').checked=cicli;
	  	        
		  	  	
		  	    
		//CREO IL DIV
		var newDiv = document.createElement("div"); 
		newDiv.setAttribute("id", "myDiagramDiv");
		div.appendChild(newDiv);
	  	  	
		//COOKIE
		document.cookie = "path="+path;
		document.cookie = "id="+id;
	    document.cookie = "diagramma=pacchettoAll";
		  	  	
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
			  new go.Binding("fill", "color1"),
			  new go.Binding("stroke", "colorBordo1") 
			),
					  	  	    		              
			 $ (go.Panel, "Auto" ,{  margin: 2},
					   $(go.Shape, { 
					   	 figure: "RoundedRectangle", 
					   	 width: 180, 
					   	 height: 40, 
					   	 margin: 2,
					   	 fill: "rgba(255,191,24,1)",cursor: "pointer",
					     stroke: "black", 
					     strokeWidth: 2   
					  },
					    new go.Binding("width", "larghezza"),
					    new go.Binding("height", "altezza"),
					    new go.Binding("strokeWidth", "larBordo"),            
					    new go.Binding("fill", "color"),
					    new go.Binding("stroke", "colorBordo")
					 ),
					 $(go.TextBlock,
					   { margin: 20,
					     font: "normal 10pt helvetica, bold arial, sans-serif", stroke: "white",
					    
					     editable: false 
					   },
					     new go.Binding("text", "keys"),
					     new go.Binding("stroke", "coloreTesto"),
					     new go.Binding("font", "fonte"))   
					  )	    		             
					 )
				   );
		  	  	    
		  	    
		if(link=="normale"){
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
	    }	   
	    else if (link=="ortogonale"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			         { toShortLength: 9 },
			         {routing: go.Link.Orthogonal},
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
			  	    	 
	    }
	    else if(link=="curvo"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			         { toShortLength: 9 ,corner: 40 },
			         { curve: go.Link.Bezier },
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
			  	    	 
	    }
	    else if(link=="evita"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			  			 { toShortLength: 9 },
			  		   {routing: go.Link.AvoidsNodes},
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
			  	    	 
	    }
	  	    	 
		  
		  	  	myDiagram.groupTemplate =
		  	  	    $(go.Group, "Vertical",{ selectionObjectName: "PANEL", ungroupable: true },
		  	  	        $(go.Panel, "Auto",{ margin: 20},
		  	  	          $(go.Shape, "RoundedRectangle",  // surrounds the Placeholder
		  	  	            { parameter1: 20,
		  	  	              fill: "rgba(0,0,0,0.9)", cursor: "pointer"},
		  	  	          new go.Binding("fill", "color")),
		  	  	       		 $(go.Placeholder, { margin: 9, background: "transparent" }) 
		  	  	        ),
		  	  	        $(go.TextBlock,         // group title
		  	  	          { alignment: go.Spot.Center, font: "Bold 12pt Sans-Serif" , margin: 0},
		  	  	          new go.Binding("text", "keys"))
		  	  	      	
		  	  	      );
		  	  	    
		  	  
	  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
	  	  				loadXMLDocGrafo(node.data.keys);
	  	  	    };
		  	  	
		  		
	  	    	
	  	  	
		  	    var nodeDataArray = new Array ();  
		  	  nodeDataArray = [
		  	   		<%
		  	   			   
		    			   ArrayList<NodoPackage> nodiPa3=grafo.getNodiPackage();
		    			   for(NodoPackage nod: nodiPa3){	
		    				   String a1=nod.getNome();
		    				   String[] r1=a1.split("\\.");
		    				   int n=0;
		    				   if(r1.length%2==0)
		    					   n=210;
		    				   else
		    					   n=235;
		    				   if(nod.getParentPackage().equals(""))
			    				   out.print("{ key:"+nod.getId()+", keys: \""+nod.getNome()+"\", isGroup:"+true+
			    						   ", color: \"rgba("+255+","+n+","+80+",0.9)\""+   
			    				   "},");
			    			   else{
			    				   String a=nod.getParentPackage();
			    				   NodoPackage nodoPack=grafo.cercaNodoPackage(a);
			    				   String[] r=a.split(".");
			    				   out.print("{ key:"+nod.getId()+", keys: \""+nod.getNome()+"\", isGroup:"+true+", group:"+nodoPack.getId()+
				    						   ", color: \"rgba("+255+","+n+","+80+",0.9)\""+      
				    				   "},");
			    				  
			    			   }
		    				}
		    				
		    			   ArrayList<NodoClasse> nodiCl9=grafo.getNodiClasse();
		    			   for(NodoClasse no: nodiCl9){
		    				   String aa=no.getPackage();
	    					   NodoPackage nodoPack1=grafo.cercaNodoPackage(aa);
	    					   if(no.getMetricaFI()>180){
	    						   out.print("{"+
											"key: "+no.getId()+
											", keys: \""+no.getNome()+			
											
											"\", altezza1: "+no.getMetricaDistanzaRadice()+
											", larghezza1: "+no.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+no.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+no.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+no.getMetricaNumeroCommenti()+
											", altezza: "+no.getMetricaNumeroLineeCodice()+
											", larBordo: "+no.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+no.getMetricaFI()+","+no.getMetricaFI()+","+no.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+no.getMetricaNumeroMedoti()+",10,10,1)\""+
											", group:"+nodoPack1.getId()+
											", coloreTesto: \"black\""+
											"},");
	    					   }
	    					   else{
	    						   out.print("{"+
											"key: "+no.getId()+
											", keys: \""+no.getNome()+			
											
											"\", altezza1: "+no.getMetricaDistanzaRadice()+
											", larghezza1: "+no.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+no.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+","+no.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+no.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+no.getMetricaNumeroCommenti()+
											", altezza: "+no.getMetricaNumeroLineeCodice()+
											", larBordo: "+no.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+no.getMetricaFI()+","+no.getMetricaFI()+","+no.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+no.getMetricaNumeroMedoti()+",10,10,1)\""+
											", group:"+nodoPack1.getId()+
											"},");
	    					   }
		    				   
		    			   }	   
		    			   
		    				  
		    	    %>
		  	  ];
		  	      
		
		  	    var linkDataArray;
		  	    if(cicli==false){
		   		  linkDataArray = [
			  	   		<%
			    			   ArrayList<Arco> archi789w6=grafo.getArchi();
			    				for(Arco x: archi789w6)		
			    					if(!x.getFrom().getNome().equals(x.getTo().getNome()))
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    				
			    				
			    	    %>
			  	  ];
		  	    }
		  	    else if(cicli==true){
			   		  linkDataArray = [
				  	   		<%
				    			   ArrayList<Arco> archi7899w5=grafo.getArchi();
				    				for(Arco x: archi7899w5)		
				    					
				    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
			    				  		+", text: \""+x.getNumero()+"\""+"},");
				    	    %>
				  	  ];
			  	    }
		   			
		   		   
		  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	   
}	
	
function initPackagePre(path,id,cicli,link) {

	      var xmlhttp;
	      var name="<%=nome%>"; 
	  	  var url="ServletPackageClass?path="+path+"&id="+id+"&name="+name;
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
	  	  		
	  	  		document.getElementById('riga55').removeAttribute('hidden');
	  	  		document.getElementById('primary2').removeAttribute('hidden');
	  			document.getElementById('primary3').removeAttribute('hidden');
	  			document.getElementById('primary4').removeAttribute('hidden');
	  			document.getElementById('primary5').removeAttribute('hidden');
	  			document.getElementById('cicli').removeAttribute('hidden');	
	  			
	  			document.getElementById('indietro1').hidden=true;
	  			document.getElementById('indietro2').hidden=true;
	  	        if(path==""){
	  	  			document.getElementById('indietro').hidden=true;
	  	        }
	  	  		else if(path!=""){
	  	  			document.getElementById('indietro').removeAttribute('hidden');	
			    }
	  	      
		  	    if(link=="normale")
					document.getElementById('primary2').checked=true;
				else if(link=="ortogonale")
					document.getElementById('primary3').checked=true;
				else if(link=="curvo")
					document.getElementById('primary4').checked=true;
				else if(link=="evita")
					document.getElementById('primary5').checked=true;
	  	  		
		  	  	document.getElementById('primary').checked=cicli;
	  	        
		  	  	
		  	    
		  	  	//CREO IL DIV
		  	  	var newDiv = document.createElement("div"); 
		  	  	newDiv.setAttribute("id", "myDiagramDiv");
		  	  	div.appendChild(newDiv);
	  	  	
		  	  	//COOKIE
		  	  	document.cookie = "path="+path;
		  	  	document.cookie = "id="+id;
		  	    document.cookie = "diagramma=pacchettoPre";
		  	  	
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
					  new go.Binding("fill", "color1"),
					  new go.Binding("stroke", "colorBordo1") 
					),
					  	  	    		              
					 $ (go.Panel, "Auto" ,{  margin: 2},
							   $(go.Shape, { 
							   	 figure: "RoundedRectangle", 
							   	 width: 180, 
							   	 height: 40, 
							   	 margin: 2,
							   	 fill: "rgba(255,191,24,1)",cursor: "pointer",
							     stroke: "black", 
							     strokeWidth: 2   
							  },
							    new go.Binding("width", "larghezza"),
							    new go.Binding("height", "altezza"),
							    new go.Binding("strokeWidth", "larBordo"),            
							    new go.Binding("fill", "color"),
							    new go.Binding("stroke", "colorBordo")
							 ),
							 $(go.TextBlock,
							   { margin: 20,
							     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
							     editable: false 
							   },
							     new go.Binding("text", "keys"),
							     new go.Binding("stroke", "coloreTesto"),
							     new go.Binding("font", "fonte")) 
							  )	    		             
							 )
				 	  	   );
		  	  	    
		  	    
		  	  	if(link=="normale"){
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
			    }	   
			    else if (link=="ortogonale"){
			    	myDiagram.linkTemplate =
					  	 $(go.Link, 
					         { toShortLength: 9 },
					         {routing: go.Link.Orthogonal},
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
					  	    	 
			    }
			    else if(link=="curvo"){
			    	myDiagram.linkTemplate =
					  	 $(go.Link, 
					         { toShortLength: 9 ,corner: 40 },
					         { curve: go.Link.Bezier },
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
					  	    	 
			    }
			    else if(link=="evita"){
			    	myDiagram.linkTemplate =
					  	 $(go.Link, 
					  			 { toShortLength: 9 },
					  		   {routing: go.Link.AvoidsNodes},
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
					  	    	 
			    }
	  	    	 
		  
		  	  	myDiagram.groupTemplate =
		  	  	    $(go.Group, "Vertical",{ selectionObjectName: "PANEL", ungroupable: true },
		  	  	        $(go.Panel, "Auto",{ margin: 20},
		  	  	          $(go.Shape, "RoundedRectangle",  // surrounds the Placeholder
		  	  	            { parameter1: 20,
		  	  	              fill: "rgba(249,216,87,0.9)", cursor: "pointer"}),
		  	  	       		 $(go.Placeholder, { margin: 9, background: "transparent" }) 
		  	  	        ),
		  	  	        $(go.TextBlock,         // group title
		  	  	          { alignment: go.Spot.Center, font: "Bold 12pt Sans-Serif" , margin: 0},
		  	  	          new go.Binding("text", "keys"))
		  	  	      );
		  	  	    
		  	  
	  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
	  	  				loadXMLDocGrafo(node.data.keys);
	  	  	    };
		  	  	
		  		myDiagram.groupTemplate.selectionChanged=function(node) {
		  			var radio2=document.getElementById('primary2').checked;
		  			var radio3=document.getElementById('primary3').checked;
		  			var radio4=document.getElementById('primary4').checked;
		  			var radio5=document.getElementById('primary5').checked;
		  			var ci=document.getElementById('primary').checked;
		  			
		  			var link;
		  			if(radio2==true)
		  				link="normale";
		  			else if(radio3==true)
		  				link="ortogonale";
		  			else if(radio4==true)
		  				link="curvo";
		  			else if(radio5==true)
		  				link="evita";
	  	  				  			
	  	  		 	if(node.data.key==0)
	  			 		initPackagePre(node.data.keys,node.data.key,ci,link); 
	  				 else
	  					initPackagePre(node.data.keys,node.data.key,ci,link); 
	  	  			 
	  	  	    };
	  	    	
	  	  	    var response=xmlhttp.responseText;
	  	    	var pacchettiUltimi=new Array (); 
	  	    	var classiUltimi=new Array (); 
	  	    	 
	  	    	var ris = response.split('!!');
		  	    var pacchetti=ris[0];	  
		  	    var classe=ris[1];
		  	     
		  	    var nodeDataArray = new Array ();  
		  	      
		  	    if(pacchetti!="----"){
			  	    var pacchetto=pacchetti.split(';;;;');
			  	    var i=0;
			  	    for(i=0; i<pacchetto.length; i++){
			  	     	var classiPacchetto=pacchetto[i].split('***');
			  	      	var j=0;
			  	      	for(j=0; j<classiPacchetto.length; j++){
			  	      		classiUltimi.push(classiPacchetto[j]);
			  	      		var infoClassiPacchetto=classiPacchetto[j].split('//');
			  	    		var k=0;
		  	    			for(k=0; k<pacchettiUltimi.length; k++){
		  	    				if(pacchettiUltimi[k]==infoClassiPacchetto[0])
		  	    		  			break;
		  	    			}
		  	    			if(k==pacchettiUltimi.length)
		  	    				pacchettiUltimi.push(infoClassiPacchetto[0]);	
	  	    	  		}
		  	      	}
		  	    	    	
		  	      	var t=0;
		  	      	for(t=0; t<pacchettiUltimi.length; t++){
	    	  	  		var infoPa=pacchettiUltimi[t].split('+');
	    	  			nodeDataArray.push({ key: parseInt(infoPa[0]), keys: infoPa[1], isGroup: true },);
	    	  	  	}
	    	  	
		  	      	var u=0;
		  	      	for(u=0; u<classiUltimi.length; u++){
		  	    		var info77=classiUltimi[u].split('//');
		  	    		var info78=info77[0].split('+');
		  	    		var info79=info77[1].split('+');
		  	    		if(info79[5]>180){
		  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
		    		                 keys: info79[1], 
		    		                 group: parseInt(info78[0]), 
		    		                 
		    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
		    		                 
		    		                 larBordo1: parseInt(info79[2]),
		    						 larghezza1: parseInt(info79[3])/2,
		    						 altezza1: parseInt(info79[4])/2,
		    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
		    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
		    						 
		    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
		    						 altezza : parseInt(info79[7])/2,
		    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
		    						 larghezza : parseInt(info79[10])-35,
		    						 larBordo: parseInt(info79[11]),
		    						 coloreTesto: "black",
		    						 
		    	
		    		});
		  	    		}
		  	    		else{
		  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
		    		                 keys: info79[1], 
		    		                 group: parseInt(info78[0]), 
		    		                 
		    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
		    		                 
		    		                 larBordo1: parseInt(info79[2]),
		    						 larghezza1: parseInt(info79[3])/2,
		    						 altezza1: parseInt(info79[4])/2,
		    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
		    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
		    						 
		    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
		    						 altezza : parseInt(info79[7])/2,
		    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
		    						 larghezza : parseInt(info79[10])-35,
		    						 larBordo: parseInt(info79[11]),
		    						 
		    	
		    		});
		  	    		}
		  	    	
		  	      	}
		  	      }	 
		  	    	  
		  	    	
		  	      if(classe!="----"){
		  	    	var classi=classe.split("::::");
		  	    	for(var i=0; i<classi.length; i++){
		  	    		var infoo=classi[i].split("+");
		  	    		if(infoo[5]>180){
		  	    			nodeDataArray.push({ key: parseInt(infoo[0]), 
	   		                 keys: infoo[1], 
	   		              	    		                 
	   		                 larBordo1: parseInt(infoo[2]),
	   						 larghezza1: parseInt(infoo[3]),
	   						 altezza1: parseInt(infoo[4]),
	   						 colorBordo1: "rgba("+infoo[6]+",10,10,1)",
	   						 color1: "rgba("+infoo[9]+","+infoo[9]+","+infoo[9]+",1)",
	   						 
	   						 color: "rgba("+infoo[5]+","+infoo[5]+","+infoo[5]+",1)",
	   						 altezza : parseInt(infoo[7]),
	   						 colorBordo: "rgba("+infoo[8]+",10,10,1)",
	   						 larghezza : parseInt(infoo[10]),
	   						 larBordo: parseInt(infoo[11]),
	   						 coloreTesto: "black",
	   						 
	   	
	   		});
		  	    		}
		  	    		else{
		  	    			nodeDataArray.push({ key: parseInt(infoo[0]), 
	   		                 keys: infoo[1], 
	   		              	    		                 
	   		                 larBordo1: parseInt(infoo[2]),
	   						 larghezza1: parseInt(infoo[3]),
	   						 altezza1: parseInt(infoo[4]),
	   						 colorBordo1: "rgba("+infoo[6]+",10,10,1)",
	   						 color1: "rgba("+infoo[9]+","+infoo[9]+","+infoo[9]+",1)",
	   						 
	   						 color: "rgba("+infoo[5]+","+infoo[5]+","+infoo[5]+",1)",
	   						 altezza : parseInt(infoo[7]),
	   						 colorBordo: "rgba("+infoo[8]+",10,10,1)",
	   						 larghezza : parseInt(infoo[10]),
	   						 larBordo: parseInt(infoo[11]),
	   						 
	   	
	   				});
		  	    		}
		  	    	}
		  	      }
		  	    var linkDataArray;
		  	    if(cicli==false){
		   		  linkDataArray = [
			  	   		<%
			    			   ArrayList<Arco> archi789=grafo.getArchi();
			    				for(Arco x: archi789)		
			    					if(!x.getFrom().getNome().equals(x.getTo().getNome()))
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    	    %>
			  	  ];
		  	    }
		  	    else if(cicli==true){
			   		  linkDataArray = [
				  	   		<%
				    			   ArrayList<Arco> archi7899=grafo.getArchi();
				    				for(Arco x: archi7899)		
				    					
				    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
			    				  		+", text: \""+x.getNumero()+"\""+"},");
				    	    %>
				  	  ];
			  	    }
		   			
		   		   
		  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	  	    	  }
	  	      }
	  	//  }
	  	  xmlhttp.open("GET", url, true);
	  	  xmlhttp.send();
}	
	

function initPackagePre1(path,id,cicli,link) {

      var xmlhttp;
      var name="<%=nome%>"; 
  	  var url="ServletPackageClass?path="+path+"&id="+id+"&name="+name;
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
  	  		
  	  		document.getElementById('riga55').removeAttribute('hidden');
  	  		document.getElementById('primary2').removeAttribute('hidden');
  			document.getElementById('primary3').removeAttribute('hidden');
  			document.getElementById('primary4').removeAttribute('hidden');
  			document.getElementById('primary5').removeAttribute('hidden');
  			document.getElementById('cicli').removeAttribute('hidden');	
  			document.getElementById('indietro1').hidden=true;
  			document.getElementById('indietro2').hidden=true;
  		
  	        if(path==""){
  	  			document.getElementById('indietro').hidden=true;
  	        }
  	  		else if(path!=""){
  	  			document.getElementById('indietro').removeAttribute('hidden');	
		    }
  	      
	  	    if(link=="normale")
				document.getElementById('primary2').checked=true;
			else if(link=="ortogonale")
				document.getElementById('primary3').checked=true;
			else if(link=="curvo")
				document.getElementById('primary4').checked=true;
			else if(link=="evita")
				document.getElementById('primary5').checked=true;
  	  		
	  	  	document.getElementById('primary').checked=cicli;
  	        
	  	  	
	  	    
	  	  	//CREO IL DIV
	  	  	var newDiv = document.createElement("div"); 
	  	  	newDiv.setAttribute("id", "myDiagramDiv");
	  	  	div.appendChild(newDiv);
  	  	
	  	  	//COOKIE
	  	  	document.cookie = "path="+path;
	  	  	document.cookie = "id="+id;
	  	    document.cookie = "diagramma=pacchettoPre1";
	  	  	
	  	  	var $ = go.GraphObject.make;  
	  	  	myDiagram = $(go.Diagram, "myDiagramDiv", 
	  	  	{
	  	           "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
	  	  	    "undoManager.isEnabled": true,  
	  	  	    initialContentAlignment: go.Spot.Center,
	  	          initialAutoScale: go.Diagram.UniformToFill,
	  	        layout: $ (go.LayeredDigraphLayout)
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
				  new go.Binding("fill", "color1"),
				  new go.Binding("stroke", "colorBordo1") 
				),
				  	  	    		              
				 $ (go.Panel, "Auto" ,{  margin: 2},
						   $(go.Shape, { 
						   	 figure: "RoundedRectangle", 
						   	 width: 180, 
						   	 height: 40, 
						   	 margin: 2,
						   	 fill: "rgba(255,191,24,1)",cursor: "pointer",
						     stroke: "black", 
						     strokeWidth: 2   
						  },
						    new go.Binding("width", "larghezza"),
						    new go.Binding("height", "altezza"),
						    new go.Binding("strokeWidth", "larBordo"),            
						    new go.Binding("fill", "color"),
						    new go.Binding("stroke", "colorBordo")
						 ),
						 $(go.TextBlock,
						   { margin: 20,
						     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
						     editable: false 
						   },
						     new go.Binding("text", "keys"),
						     new go.Binding("stroke", "coloreTesto"),
						     new go.Binding("font", "fonte"))   
						  )	    		             
						 )
			 	  	   );
	  	  	    
	  	    
	  	  	if(link=="normale"){
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
		    }	   
		    else if (link=="ortogonale"){
		    	myDiagram.linkTemplate =
				  	 $(go.Link, 
				         { toShortLength: 9 },
				         {routing: go.Link.Orthogonal},
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
				  	    	 
		    }
		    else if(link=="curvo"){
		    	myDiagram.linkTemplate =
				  	 $(go.Link, 
				         { toShortLength: 9 ,corner: 40 },
				         { curve: go.Link.Bezier },
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
				  	    	 
		    }
		    else if(link=="evita"){
		    	myDiagram.linkTemplate =
				  	 $(go.Link, 
				  			 { toShortLength: 9 },
				  		   {routing: go.Link.AvoidsNodes},
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
				  	    	 
		    }
  	    	 
	  
	  	  	myDiagram.groupTemplate =
	  	  	    $(go.Group, "Vertical",{ selectionObjectName: "PANEL", ungroupable: true },
	  	  	        $(go.Panel, "Auto",{ margin: 20},
	  	  	          $(go.Shape, "RoundedRectangle",  // surrounds the Placeholder
	  	  	            { parameter1: 20,
	  	  	              fill: "rgba(249,216,87,0.9)", cursor: "pointer"}),
	  	  	       		 $(go.Placeholder, { margin: 9, background: "transparent" }) 
	  	  	        ),
	  	  	        $(go.TextBlock,         // group title
	  	  	          { alignment: go.Spot.Center, font: "Bold 12pt Sans-Serif" , margin: 0},
	  	  	          new go.Binding("text", "keys"))
	  	  	      );
	  	  	    
	  	  
  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
  	  				loadXMLDocGrafo(node.data.keys);
  	  	    };
	  	  	
	  		myDiagram.groupTemplate.selectionChanged=function(node) {
	  			var radio2=document.getElementById('primary2').checked;
	  			var radio3=document.getElementById('primary3').checked;
	  			var radio4=document.getElementById('primary4').checked;
	  			var radio5=document.getElementById('primary5').checked;
	  			var ci=document.getElementById('primary').checked;
	  			
	  			var link;
	  			if(radio2==true)
	  				link="normale";
	  			else if(radio3==true)
	  				link="ortogonale";
	  			else if(radio4==true)
	  				link="curvo";
	  			else if(radio5==true)
	  				link="evita";
  	  				  			
  	  		 	if(node.data.key==0)
  			 		initPackagePre1(node.data.keys,node.data.key,ci,link); 
  				 else
  					initPackagePre1(node.data.keys,node.data.key,ci,link); 
  	  			 
  	  	    };
  	    	
  	  	    var response=xmlhttp.responseText;
  	    	var pacchettiUltimi=new Array (); 
  	    	var classiUltimi=new Array (); 
  	    	 
  	    	var ris = response.split('!!');
	  	    var pacchetti=ris[0];	  
	  	    var classe=ris[1];
	  	     
	  	    var nodeDataArray = new Array ();  
	  	      
	  	    if(pacchetti!="----"){
		  	    var pacchetto=pacchetti.split(';;;;');
		  	    var i=0;
		  	    for(i=0; i<pacchetto.length; i++){
		  	     	var classiPacchetto=pacchetto[i].split('***');
		  	      	var j=0;
		  	      	for(j=0; j<classiPacchetto.length; j++){
		  	      		classiUltimi.push(classiPacchetto[j]);
		  	      		var infoClassiPacchetto=classiPacchetto[j].split('//');
		  	    		var k=0;
	  	    			for(k=0; k<pacchettiUltimi.length; k++){
	  	    				if(pacchettiUltimi[k]==infoClassiPacchetto[0])
	  	    		  			break;
	  	    			}
	  	    			if(k==pacchettiUltimi.length)
	  	    				pacchettiUltimi.push(infoClassiPacchetto[0]);	
  	    	  		}
	  	      	}
	  	    	    	
	  	      	var t=0;
	  	      	for(t=0; t<pacchettiUltimi.length; t++){
    	  	  		var infoPa=pacchettiUltimi[t].split('+');
    	  			nodeDataArray.push({ key: parseInt(infoPa[0]), keys: infoPa[1], isGroup: true },);
    	  	  	}
    	  	
	  	      	var u=0;
	  	      	for(u=0; u<classiUltimi.length; u++){
	  	    		var info77=classiUltimi[u].split('//');
	  	    		var info78=info77[0].split('+');
	  	    		var info79=info77[1].split('+');
	  	    		if(info79[5]>180){
	  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
	    		                 keys: info79[1], 
	    		                 group: parseInt(info78[0]), 
	    		                 
	    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
	    		                 
	    		                 larBordo1: parseInt(info79[2]),
	    						 larghezza1: parseInt(info79[3])/2,
	    						 altezza1: parseInt(info79[4])/2,
	    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
	    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
	    						 
	    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
	    						 altezza : parseInt(info79[7])/2,
	    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
	    						 larghezza : parseInt(info79[10])-35,
	    						 larBordo: parseInt(info79[11]),
	    						 coloreTesto: "black",
	    						 
	    	
	    		});
	  	    		}
	  	    		else{
	  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
	    		                 keys: info79[1], 
	    		                 group: parseInt(info78[0]), 
	    		                 
	    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
	    		                 
	    		                 larBordo1: parseInt(info79[2]),
	    						 larghezza1: parseInt(info79[3])/2,
	    						 altezza1: parseInt(info79[4])/2,
	    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
	    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
	    						 
	    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
	    						 altezza : parseInt(info79[7])/2,
	    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
	    						 larghezza : parseInt(info79[10])-35,
	    						 larBordo: parseInt(info79[11]),
	    						 
	    	
	    		});
	  	    		}
	  	    		
	  	    	
	  	      	}
	  	      }	 
	  	    	  
	  	    	
	  	      if(classe!="----"){
	  	    	var classi=classe.split("::::");
	  	    	for(var i=0; i<classi.length; i++){
	  	    		var infoo=classi[i].split("+");
	  	    		if(infoo[5]>180){
	  	    			nodeDataArray.push({ key: parseInt(infoo[0]), 
   		                 keys: infoo[1], 
   		              	    		                 
   		                 larBordo1: parseInt(infoo[2]),
   						 larghezza1: parseInt(infoo[3]),
   						 altezza1: parseInt(infoo[4]),
   						 colorBordo1: "rgba("+infoo[6]+",10,10,1)",
   						 color1: "rgba("+infoo[9]+","+infoo[9]+","+infoo[9]+",1)",
   						 
   						 color: "rgba("+infoo[5]+","+infoo[5]+","+infoo[5]+",1)",
   						 altezza : parseInt(infoo[7]),
   						 colorBordo: "rgba("+infoo[8]+",10,10,1)",
   						 larghezza : parseInt(infoo[10]),
   						 larBordo: parseInt(infoo[11]),
   						 coloreTesto: "black",
   						 
   	
   		});
	  	    		}
	  	    		else{
	  	    			nodeDataArray.push({ key: parseInt(infoo[0]), 
   		                 keys: infoo[1], 
   		              	    		                 
   		                 larBordo1: parseInt(infoo[2]),
   						 larghezza1: parseInt(infoo[3]),
   						 altezza1: parseInt(infoo[4]),
   						 colorBordo1: "rgba("+infoo[6]+",10,10,1)",
   						 color1: "rgba("+infoo[9]+","+infoo[9]+","+infoo[9]+",1)",
   						 
   						 color: "rgba("+infoo[5]+","+infoo[5]+","+infoo[5]+",1)",
   						 altezza : parseInt(infoo[7]),
   						 colorBordo: "rgba("+infoo[8]+",10,10,1)",
   						 larghezza : parseInt(infoo[10]),
   						 larBordo: parseInt(infoo[11]),
   						 
   	
   		});
	  	    		}
	  	    	
	  	    	}
	  	      }
	  	    var linkDataArray;
	  	    if(cicli==false){
	   		  linkDataArray = [
		  	   		<%
		    			   ArrayList<Arco> archi78977=grafo.getArchi();
		    				for(Arco x: archi78977)		
		    					if(!x.getFrom().getNome().equals(x.getTo().getNome()))
		    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
	    				  		+", text: \""+x.getNumero()+"\""+"},");
		    	    %>
		  	  ];
	  	    }
	  	    else if(cicli==true){
		   		  linkDataArray = [
			  	   		<%
			    			   ArrayList<Arco> archi789988=grafo.getArchi();
			    				for(Arco x: archi789988)		
			    					
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    	    %>
			  	  ];
		  	    }
	   			
	   		   
	  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
  	    	  }
  	      }
  	//  }
  	  xmlhttp.open("GET", url, true);
  	  xmlhttp.send();
}	
	

function indietro(){
	
	var radio2=document.getElementById('primary2').checked;
	var radio3=document.getElementById('primary3').checked;
	var radio4=document.getElementById('primary4').checked;
	var radio5=document.getElementById('primary5').checked;
	var ci=document.getElementById('primary').checked;
	
	var link;
	if(radio2==true)
		link="normale";
	else if(radio3==true)
		link="ortogonale";
	else if(radio4==true)
		link="curvo";
	else if(radio5==true)
		link="evita";
	
	var percorso =document.cookie.split("; ");
	var path1=percorso[0].split('=');
	var id1=percorso[1].split('=');
	var diagramma1=percorso[2].split('=');


	var path;
	var id;
	var diagramma;
	
	if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
		path=path1[1];
		id=id1[1];
		diagramma=diagramma1[1];
	}
	else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
		path=path1[1];
		id=diagramma1[1];
		diagramma=id1[1];
	}
	else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
		path=id1[1];
		id=path1[1];
		diagramma=diagramma1[1];
	}
	else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
		path=diagramma1[1];
		id=path1[1];
		diagramma=id1[1];
	}
	else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
		path=id1[1];
		id=diagramma1[1];
		diagramma=path1[1];
	}
	else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
		path=diagramma1[1];
		id=id1[1];
		diagramma=path1[1];
	}
	
	var indice=path.lastIndexOf('.');
	if(indice==-1){
		if(diagramma=="pacchettoPre"){
			initPackagePre("",id,ci,link);
		}
		else if(diagramma=="pacchettoPre1"){
			initPackagePre1("",id,ci,link); 
		}
	}
	else{
		var pat=path.substring(0,indice);
		if(diagramma=="pacchettoPre")
			initPackagePre(pat,id,ci,link); 
		else if(diagramma=="pacchettoPre1")
			initPackagePre1(pat,id,ci,link); 
	}
	
}	


function initPackage1(path,id,cicli,esterne,link) {

    var xmlhttp;
    var name="<%=nome%>"; 
	  var url="ServletGo?path="+path+"&id="+id+"&name="+name+"&esterne="+esterne;
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
	  		
	  		
	  		document.getElementById('riga55').removeAttribute('hidden');
			document.getElementById('cicli').removeAttribute('hidden');
			document.getElementById('cicli1').hidden=true;
			document.getElementById('indietro').hidden=true;
			document.getElementById('indietro1').hidden=true;
			
			if(cicli==true)
				document.getElementById('primary').checked=true;
			else
				document.getElementById('primary').checked=false;
			
			if(esterne==true)
				document.getElementById('primary1').checked=true;
			else
				document.getElementById('primary1').checked=false;

			if(link=="normale")
				document.getElementById('primary2').checked=true;
			else if(link=="ortogonale")
				document.getElementById('primary3').checked=true;
			else if(link=="curvo")
				document.getElementById('primary4').checked=true;
			else if(link=="evita")
				document.getElementById('primary5').checked=true;
	   		
	  		if(path=="")
	  			document.getElementById('indietro2').hidden=true;
	  		else if(path!="")
	  			document.getElementById('indietro2').removeAttribute("hidden");
  		
	  	  	//CREO IL DIV
	  	  	var newDiv = document.createElement("div"); 
	  	  	newDiv.setAttribute("id", "myDiagramDiv");
	  	  	div.appendChild(newDiv);
	  	
	  	  	//COOKIE
	  	  	document.cookie = "path="+path;
	  	  	document.cookie = "id="+id;
	  	    document.cookie = "diagramma=pacchettoClassi1";
	  	  	
	  	  	var $ = go.GraphObject.make;  
	  	  	myDiagram = $(go.Diagram, "myDiagramDiv", 
	  	  	{
	  	           "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
	  	  	       "undoManager.isEnabled": true,  
	  	  	       initialContentAlignment: go.Spot.Center,
	  	           initialAutoScale: go.Diagram.UniformToFill,
	  	           layout: $ (go.LayeredDigraphLayout)
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
				 	cursor: "pointer",
				   	stroke: "black", 
				  	strokeWidth: 0   
				 }
				 ,
				  new go.Binding("width", "larghezza1"),
				  new go.Binding("height", "altezza1"),
				  new go.Binding("strokeWidth", "larBordo1"),           
				  new go.Binding("fill", "color1"),
				  new go.Binding("stroke", "colorBordo1") 
				),
				  	  	    		              
				 $ (go.Panel, "Auto" ,{  margin: 2},
						   $(go.Shape, { 
						   	 figure: "RoundedRectangle", 
						   	 width: 180, 
						   	 height: 40, 
						   	 margin: 2,
						   	 fill: "rgba(255,191,24,1)",
						   	 cursor: "pointer",
						     stroke: "black", 
						     strokeWidth: 2   
						  },
						    new go.Binding("width", "larghezza"),
						    new go.Binding("height", "altezza"),
						    new go.Binding("strokeWidth", "larBordo"),            
						    new go.Binding("fill", "color"),
						    new go.Binding("stroke", "colorBordo")
						 ),
						 $(go.TextBlock,
						   { margin: 20,
						     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
						     editable: false 
						   },
						     new go.Binding("text", "keys"),
						     new go.Binding("stroke", "coloreTesto"))   
						  )	    		             
						 )
			 	  	   );
	  	  	
	  	  	
	  	  	
	  	  	    
	  	  	    
	  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
	  	  			 if(node.data.larghezza1==0){
	  	  				 
	  	  				var radio2=document.getElementById('primary2').checked;
	  		  			var radio3=document.getElementById('primary3').checked;
	  		  			var radio4=document.getElementById('primary4').checked;
	  		  			var radio5=document.getElementById('primary5').checked;
	  		  			var ci=document.getElementById('primary').checked;
	  		  			var este=document.getElementById('primary1').checked;
	  		  			
	  		  			var link;
	  		  			if(radio2==true)
	  		  				link="normale";
	  		  			else if(radio3==true)
	  		  				link="ortogonale";
	  		  			else if(radio4==true)
	  		  				link="curvo";
	  		  			else if(radio5==true)
	  		  				link="evita";
	  	  				 
	  	  				 
	  	  				 if(node.data.key==0)
	  	  			 		initPackage1(node.data.keys,node.data.key,ci,este,link); 
	  	  				 else
	  	  					initPackage1(node.data.keys,node.data.key,ci,este,link); 
	  	  			 }
	  	  			 else{
	  	  				loadXMLDocGrafo(node.data.keys);
	  	  			 }
	  	  	    };
	  	  	   
	  	  	 if(link=="normale"){
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
	 	    }	   
	 	    else if (link=="ortogonale"){
	 	    	myDiagram.linkTemplate =
	 			  	 $(go.Link, 
	 			         { toShortLength: 9 },
	 			         {routing: go.Link.Orthogonal},
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
	 			  	    	 
	 	    }
	 	    else if(link=="curvo"){
	 	    	myDiagram.linkTemplate =
	 			  	 $(go.Link, 
	 			  			 { toShortLength: 9 ,corner: 10 },
	 			         { curve: go.Link.Bezier ,adjusting: go.Link.Stretch,
	 			  		          reshapable: true, relinkableFrom: true, relinkableTo: true,
	 			  		          toShortLength: 3},
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
	 			  	    	 
	 	    }
	 	    else if(link=="evita"){
	 	    	myDiagram.linkTemplate =
	 			  	 $(go.Link, 
	 			  			 { toShortLength: 9 },
	 			  		   {routing: go.Link.AvoidsNodes},
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
	 			  	    	 
	 	    }
	    	 
	    	  var response=xmlhttp.responseText;
	    	
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
	  	    			var info79=classi[i].split("+");
	  	    			if(info79[5]>180){
		  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
		    		                 keys: info79[1], 
		    		              
		    		                 
		    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
		    		                 
		    		                 larBordo1: parseInt(info79[2]),
		    						 larghezza1: parseInt(info79[3]),
		    						 altezza1: parseInt(info79[4]),
		    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
		    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
		    						 
		    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
		    						 altezza : parseInt(info79[7]),
		    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
		    						 larghezza : parseInt(info79[10]),
		    						 larBordo: parseInt(info79[11]),
		    						 coloreTesto: "black",
		    						 
		    	
		    		});
		  	    		}
		  	    		else{
		  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
		    		                 keys: info79[1], 
		    		                 
		    		                 
		    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
		    		                 
		    		                 larBordo1: parseInt(info79[2]),
		    						 larghezza1: parseInt(info79[3]),
		    						 altezza1: parseInt(info79[4]),
		    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
		    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
		    						 
		    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
		    						 altezza : parseInt(info79[7]),
		    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
		    						 larghezza : parseInt(info79[10]),
		    						 larBordo: parseInt(info79[11]),
		    						 
		    	
		    		});
		  	    		}
	  	    		}
	  	    	  }
	  	    	  
	  	    	
	  	    	  
	  	    	  var linkDataArray;
	   			  if(cicli==true){
	   				linkDataArray = [
		  	      		<%
		    			   ArrayList<Arco> archiPyw722=grafo.getArchi();
		    				for(Arco x: archiPyw722)
		    					
		    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
	    				  		+", text: \""+x.getNumero()+"\""+"},");
		    				%>
		  	      	  ];
	   			  }
	   			  else{
	   				 
	  	      	  	linkDataArray = [
	  	      		<%
	    			   ArrayList<Arco> archiPyw7866=grafo.getArchi();
	    				for(Arco x: archiPyw7866)
	    					if(!x.getFrom().getNome().equals(x.getTo().getNome()))
	    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
  				  		+", text: \""+x.getNumero()+"\""+"},");
	    				%>
	  	      	  ];
	   			  }
	  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	    	  }
	      }
	// }
	  xmlhttp.open("GET", url, true);
	  xmlhttp.send();
}

	function initPackage(path,id,cicli,esterne,link) {

		      var xmlhttp;
		      var name="<%=nome%>"; 
		  	  var url="ServletGo?path="+path+"&id="+id+"&name="+name+"&esterne="+esterne;
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
		  	  		
		  	  		
		  	  		document.getElementById('riga55').removeAttribute('hidden');
					document.getElementById('cicli').removeAttribute('hidden');
					document.getElementById('cicli1').hidden=true;
					document.getElementById('indietro').hidden=true;
					document.getElementById('indietro1').hidden=true;
					
					if(cicli==true)
		  				document.getElementById('primary').checked=true;
					else
		  				document.getElementById('primary').checked=false;
					
					if(esterne==true)
		  				document.getElementById('primary1').checked=true;
					else
		  				document.getElementById('primary1').checked=false;
	
					if(link=="normale")
						document.getElementById('primary2').checked=true;
					else if(link=="ortogonale")
						document.getElementById('primary3').checked=true;
					else if(link=="curvo")
						document.getElementById('primary4').checked=true;
					else if(link=="evita")
						document.getElementById('primary5').checked=true;
		  	   		
		  	  		if(path=="")
		  	  			document.getElementById('indietro2').hidden=true;
		  	  		else if(path!="")
		  	  			document.getElementById('indietro2').removeAttribute("hidden");
	  	  		
			  	  	//CREO IL DIV
			  	  	var newDiv = document.createElement("div"); 
			  	  	newDiv.setAttribute("id", "myDiagramDiv");
			  	  	div.appendChild(newDiv);
		  	  	
			  	  	//COOKIE
			  	  	document.cookie = "path="+path;
			  	  	document.cookie = "id="+id;
			  	    document.cookie = "diagramma=pacchettoClassi";
			  	  	
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
						 	cursor: "pointer",
						   	stroke: "black", 
						  	strokeWidth: 0   
						 }
						 ,
						  new go.Binding("width", "larghezza1"),
						  new go.Binding("height", "altezza1"),
						  new go.Binding("strokeWidth", "larBordo1"),           
						  new go.Binding("fill", "color1"),
						  new go.Binding("stroke", "colorBordo1") 
						),
						  	  	    		              
						 $ (go.Panel, "Auto" ,{  margin: 2},
								   $(go.Shape, { 
								   	 figure: "RoundedRectangle", 
								   	 width: 180, 
								   	 height: 40, 
								   	 margin: 2,
								   	 fill: "rgba(255,191,24,1)",
								   	 cursor: "pointer",
								     stroke: "black", 
								     strokeWidth: 2   
								  },
								    new go.Binding("width", "larghezza"),
								    new go.Binding("height", "altezza"),
								    new go.Binding("strokeWidth", "larBordo"),            
								    new go.Binding("fill", "color"),
								    new go.Binding("stroke", "colorBordo")
								 ),
								 $(go.TextBlock,
								   { margin: 20,
								     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
								     editable: false 
								   },
								     new go.Binding("text", "keys"),
								     new go.Binding("stroke", "coloreTesto"))   
								  )	    		             
								 )
					 	  	   );
			  	  	
			  	  	
			  	  	
			  	  	    
			  	  	    
			  	  		myDiagram.nodeTemplate.selectionChanged=function(node) {
			  	  			 if(node.data.larghezza1==0){
			  	  				 
			  	  				var radio2=document.getElementById('primary2').checked;
			  		  			var radio3=document.getElementById('primary3').checked;
			  		  			var radio4=document.getElementById('primary4').checked;
			  		  			var radio5=document.getElementById('primary5').checked;
			  		  			var ci=document.getElementById('primary').checked;
			  		  			var este=document.getElementById('primary1').checked;
			  		  			
			  		  			var link;
			  		  			if(radio2==true)
			  		  				link="normale";
			  		  			else if(radio3==true)
			  		  				link="ortogonale";
			  		  			else if(radio4==true)
			  		  				link="curvo";
			  		  			else if(radio5==true)
			  		  				link="evita";
			  	  				 
			  	  				 
			  	  				 if(node.data.key==0)
			  	  			 		initPackage(node.data.keys,node.data.key,ci,este,link); 
			  	  				 else
			  	  					initPackage(node.data.keys,node.data.key,ci,este,link); 
			  	  			 }
			  	  			 else{
			  	  				loadXMLDocGrafo(node.data.keys);
			  	  			 }
			  	  	    };
			  	  	   
			  	  	 if(link=="normale"){
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
			 	    }	   
			 	    else if (link=="ortogonale"){
			 	    	myDiagram.linkTemplate =
			 			  	 $(go.Link, 
			 			         { toShortLength: 9 },
			 			         {routing: go.Link.Orthogonal},
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
			 			  	    	 
			 	    }
			 	    else if(link=="curvo"){
			 	    	myDiagram.linkTemplate =
			 			  	 $(go.Link, 
			 			  			 { toShortLength: 9 ,corner: 10 },
			 			         { curve: go.Link.Bezier ,adjusting: go.Link.Stretch,
			 			  		          reshapable: true, relinkableFrom: true, relinkableTo: true,
			 			  		          toShortLength: 3},
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
			 			  	    	 
			 	    }
			 	    else if(link=="evita"){
			 	    	myDiagram.linkTemplate =
			 			  	 $(go.Link, 
			 			  			 { toShortLength: 9 },
			 			  		   {routing: go.Link.AvoidsNodes},
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
			 			  	    	 
			 	    }
		  	    	 
		  	    	  var response=xmlhttp.responseText;
		  	    	
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
			  	    			var info79=classi[i].split("+");
			  	    			if(info79[5]>180){
				  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
				    		                 keys: info79[1], 
				    		              
				    		                 
				    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
				    		                 
				    		                 larBordo1: parseInt(info79[2]),
				    						 larghezza1: parseInt(info79[3]),
				    						 altezza1: parseInt(info79[4]),
				    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
				    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
				    						 
				    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
				    						 altezza : parseInt(info79[7]),
				    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
				    						 larghezza : parseInt(info79[10]),
				    						 larBordo: parseInt(info79[11]),
				    						 coloreTesto: "black",
				    						 
				    	
				    		});
				  	    		}
				  	    		else{
				  	    			nodeDataArray.push({ key: parseInt(info79[0]), 
				    		                 keys: info79[1], 
				    		                 
				    		                 
				    		                 fonte: "normal 8pt helvetica, normal arial, sans-serif",
				    		                 
				    		                 larBordo1: parseInt(info79[2]),
				    						 larghezza1: parseInt(info79[3]),
				    						 altezza1: parseInt(info79[4]),
				    						 colorBordo1: "rgba("+info79[6]+",10,10,1)",
				    						 color1: "rgba("+info79[9]+","+info79[9]+","+info79[9]+",1)",
				    						 
				    						 color: "rgba("+info79[5]+","+info79[5]+","+info79[5]+",1)",
				    						 altezza : parseInt(info79[7]),
				    						 colorBordo: "rgba("+info79[8]+",10,10,1)",
				    						 larghezza : parseInt(info79[10]),
				    						 larBordo: parseInt(info79[11]),
				    						 
				    	
				    		});
				  	    		}
			  	    		}
			  	    	  }
			  	    	  
			  	    	
			  	    	  
			  	    	  var linkDataArray;
			   			  if(cicli==true){
			   				linkDataArray = [
				  	      		<%
				    			   ArrayList<Arco> archiPyw7=grafo.getArchi();
				    				for(Arco x: archiPyw7)
				    					
				    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
			    				  		+", text: \""+x.getNumero()+"\""+"},");
				    				%>
				  	      	  ];
			   			  }
			   			  else{
			   				 
			  	      	  	linkDataArray = [
			  	      		<%
			    			   ArrayList<Arco> archiPyw78=grafo.getArchi();
			    				for(Arco x: archiPyw78)
			    					if(!x.getFrom().getNome().equals(x.getTo().getNome()))
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    				%>
			  	      	  ];
			   			  }
			  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
		  	    	  }
		  	      }
		  	// }
		  	  xmlhttp.open("GET", url, true);
		  	  xmlhttp.send();
	}

	function indietro2(){
		//ottengo il grafo da visualizzare

		var radio2=document.getElementById('primary2').checked;
		var radio3=document.getElementById('primary3').checked;
		var radio4=document.getElementById('primary4').checked;
		var radio5=document.getElementById('primary5').checked;
		var ci=document.getElementById('primary').checked;
		var este=document.getElementById('primary1').checked;
	
		var link;
		if(radio2==true)
			link="normale";
		else if(radio3==true)
			link="ortogonale";
		else if(radio4==true)
			link="curvo";
		else if(radio5==true)
			link="evita";
		
		var percorso =document.cookie.split("; ");
		var path1=percorso[0].split('=');
		var id1=percorso[1].split('=');
		var diagramma1=percorso[2].split('=');


		var path;
		var id;
		var diagramma;
		
		if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
			path=path1[1];
			id=id1[1];
			diagramma=diagramma1[1];
		}
		else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
			path=path1[1];
			id=diagramma1[1];
			diagramma=id1[1];
		}
		else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
			path=id1[1];
			id=path1[1];
			diagramma=diagramma1[1];
		}
		else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
			path=diagramma1[1];
			id=path1[1];
			diagramma=id1[1];
		}
		else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
			path=id1[1];
			id=diagramma1[1];
			diagramma=path1[1];
		}
		else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
			path=diagramma1[1];
			id=id1[1];
			diagramma=path1[1];
		}
	
		var indice=path.lastIndexOf('.');
		if(indice==-1){
			if(diagramma=="pacchettoClassi")
				initPackage("",id,ci,este,link); 
			else if(diagramma=="pacchettoClassi1")
				initPackage1("",id,ci,este,link); 
		}
		else{
			var pat=path.substring(0,indice);
			if(diagramma=="pacchettoClassi")
				initPackage(pat,id,ci,este,link); 
			else if(diagramma=="pacchettoClassi1")
				initPackage1(pat,id,ci,este,link); 
		}
		
	}	
	
	
	

function initClassCircolare(cicli,esterna,link) {

		var div = document.getElementById('riga1');
		while(div.firstChild){
		   	div.removeChild(div.firstChild);
		}
		  	  	
		//SETTO COSA DEVO MOSTRARE NELLA BARRA OPZIONI
		document.getElementById('riga55').removeAttribute('hidden');
		document.getElementById('cicli').removeAttribute('hidden');
		document.getElementById('cicli1').removeAttribute('hidden');  
		document.getElementById('indietro').hidden=true;
		document.getElementById('indietro1').hidden=true;
		document.getElementById('indietro2').hidden=true;
		if(cicli==true)
		  	document.getElementById('primary').checked=true;
		else
		  	document.getElementById('primary').checked=false;
		if(esterna==true)
		  	document.getElementById('primary1').checked=true;
		else
		  	document.getElementById('primary1').checked=false;
	
		if(link=="normale")
			document.getElementById('primary2').checked=true;
		else if(link=="ortogonale")
			document.getElementById('primary3').checked=true;
		else if(link=="curvo")
			document.getElementById('primary4').checked=true;
		else if(link=="evita")
			document.getElementById('primary5').checked=true;
		
		//CREO IL DIV
		var newDiv = document.createElement("div"); 
		newDiv.setAttribute("id", "myDiagramDiv");
		div.appendChild(newDiv);
		  	  	
		//SETTO IL COOKIE
		document.cookie = "diagramma=circolare";
		
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
			 	cursor: "pointer",
			   	stroke: "black", 
			  	strokeWidth: 0   
			 }
			 ,
			  new go.Binding("width", "larghezza1"),
			  new go.Binding("height", "altezza1"),
			  new go.Binding("strokeWidth", "larBordo1"),           
			  new go.Binding("fill", "color1"),
			  new go.Binding("stroke", "colorBordo1") 
			),
			  	  	    		              
			 $ (go.Panel, "Auto" ,{  margin: 2},
			   $(go.Shape, { 
			   	 figure: "RoundedRectangle", 
			   	 width: 180, 
			   	 height: 40, 
			   	 margin: 2,
			   	 fill: "rgba(255,191,24,1)",
			   	 cursor: "pointer",
			     stroke: "black", 
			     strokeWidth: 2   
			  },
			    new go.Binding("width", "larghezza"),
			    new go.Binding("height", "altezza"),
			    new go.Binding("strokeWidth", "larBordo"),            
			    new go.Binding("fill", "color"),
			    new go.Binding("stroke", "colorBordo")
			 ),
			 $(go.TextBlock,
			   { margin: 20,
			     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
			     editable: false 
			   },
			     new go.Binding("text", "keys"),
			     new go.Binding("stroke", "coloreTesto"))   
			  )	    		             
			 )
 	  	   );
			  	  	    
						  	  	    
			  	  	    
    	   myDiagram.nodeTemplate.selectionChanged=function(node) {
			    loadXMLDocGrafo(node.data.keys);
		   };
			  	  	  
	    if(link=="normale"){
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
	    }	   
	    else if (link=="ortogonale"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			         { toShortLength: 9 },
			         {routing: go.Link.Orthogonal},
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
			  	    	 
	    }
	    else if(link=="curvo"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			  			 { toShortLength: 9 ,corner: 10 },
			         { curve: go.Link.Bezier ,adjusting: go.Link.Stretch,
			  		          reshapable: true, relinkableFrom: true, relinkableTo: true,
			  		          toShortLength: 3},
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
			  	    	 
	    }
	    else if(link=="evita"){
	    	myDiagram.linkTemplate =
			  	 $(go.Link, 
			  			 { toShortLength: 9 },
			  		   {routing: go.Link.AvoidsNodes},
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
			  	    	 
	    }
	
		if(cicli==true){
		    if(esterna==false){
		    	myDiagram.model = new go.GraphLinksModel(	    
					    [
					    	<%
						    ArrayList<NodoClasse> nodoClaw=grafo.getNodiClasse();
							for(NodoClasse x: nodoClaw){			
								if(x.getMetricaFI()>180){
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											", coloreTesto: \"black\""+
											"},");
								}
								else{
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											
											"},");
								}
							}
							%>
					    ],
					    [
					    	<%	
						    ArrayList<Arco> archiPpww=grafo.getArchi();
							for(Arco x: archiPpww){
								//PRENDO GLI ARCHI CLASSE
								if(!x.getTipo().equals("")){
							  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
											", spessore: "+x.getMetricaNumero()+
							  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
								}
							}
							%>
						]
					    
					    );
		    }
		    else{
		    	myDiagram.model = new go.GraphLinksModel(	    
					    [
					    	<%
						    ArrayList<NodoClasse> nodoClaweee=grafo.getNodiClasse();
							for(NodoClasse x: nodoClaweee){			
								if(x.getMetricaFI()>180){
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											", coloreTesto: \"black\""+
											"},");
								}
								else{
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											
											"},");
								}
							}
							ArrayList<NodoClasseExternal> nodoClaweeee=grafo.getNodiClasseExternal();
							for(NodoClasseExternal x: nodoClaweeee){			
								out.print("{"+
										"keys: \""+x.getNome()+"\""+
										 ", coloreTesto: \" black\" "+
										", key: "+x.getId()+
						
										"},");
							}
							%>
					    ],
					    [
					    	<%	
						    ArrayList<Arco> archiPpww9=grafo.getArchi();
							for(Arco x: archiPpww9){
								//PRENDO GLI ARCHI CLASSE
								if(!x.getTipo().equals("")){
							  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
											", spessore: "+x.getMetricaNumero()+
							  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
								}
							}
							%>
						]
					    
					    );
		    }
	}
	else if(cicli==false){
			if(esterna==false){
				myDiagram.model = new go.GraphLinksModel(	    
					    [
					    	<%
					    ArrayList<NodoClasse> nodoClaye=grafo.getNodiClasse();
						for(NodoClasse x: nodoClaye){
							if(x.getMetricaFI()>180){
								out.print("{"+
										"key: "+x.getId()+
										", keys: \""+x.getNome()+			
										
										"\", altezza1: "+x.getMetricaDistanzaRadice()+
										", larghezza1: "+x.getMetricaCiclomatica()+ 
										", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
										", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
										", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
							
										", larghezza: "+x.getMetricaNumeroCommenti()+
										", altezza: "+x.getMetricaNumeroLineeCodice()+
										", larBordo: "+x.getMetricaNumeroMessaggi()+ 
										", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
										", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
										", coloreTesto: \"black\""+
										"},");
							}
							else{
								out.print("{"+
										"key: "+x.getId()+
										", keys: \""+x.getNome()+			
										
										"\", altezza1: "+x.getMetricaDistanzaRadice()+
										", larghezza1: "+x.getMetricaCiclomatica()+ 
										", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
										", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
										", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
							
										", larghezza: "+x.getMetricaNumeroCommenti()+
										", altezza: "+x.getMetricaNumeroLineeCodice()+
										", larBordo: "+x.getMetricaNumeroMessaggi()+ 
										", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
										", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
										
										"},");
							}
						}
						%>
				    ],
				    [
				    	<%	
					    ArrayList<Arco> archiPpye=grafo.getArchi();
						for(Arco x: archiPpye){
							//PRENDO GLI ARCHI CLASSE
							if(!x.getTipo().equals("")){
									if(!x.getFrom().getNome().equals(x.getTo().getNome()))
						  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
										", spessore: "+x.getMetricaNumero()+
						  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
							}
						}
						%>
						]
					    );
			}
			else{
				myDiagram.model = new go.GraphLinksModel(	    
					    [
					    	<%
					    ArrayList<NodoClasse> nodoClayerr=grafo.getNodiClasse();
						for(NodoClasse x: nodoClayerr){
							if(x.getMetricaFI()>180){
								out.print("{"+
										"key: "+x.getId()+
										", keys: \""+x.getNome()+			
										
										"\", altezza1: "+x.getMetricaDistanzaRadice()+
										", larghezza1: "+x.getMetricaCiclomatica()+ 
										", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
										", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
										", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
							
										", larghezza: "+x.getMetricaNumeroCommenti()+
										", altezza: "+x.getMetricaNumeroLineeCodice()+
										", larBordo: "+x.getMetricaNumeroMessaggi()+ 
										", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
										", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
										", coloreTesto: \"black\""+
										"},");
							}
							else{
								out.print("{"+
										"key: "+x.getId()+
										", keys: \""+x.getNome()+			
										
										"\", altezza1: "+x.getMetricaDistanzaRadice()+
										", larghezza1: "+x.getMetricaCiclomatica()+ 
										", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
										", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
										", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
							
										", larghezza: "+x.getMetricaNumeroCommenti()+
										", altezza: "+x.getMetricaNumeroLineeCodice()+
										", larBordo: "+x.getMetricaNumeroMessaggi()+ 
										", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
										", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
										
										"},");
							}
						}
						ArrayList<NodoClasseExternal> nodoClaweeee4=grafo.getNodiClasseExternal();
						for(NodoClasseExternal x: nodoClaweeee4){			
							out.print("{"+
									"keys: \""+x.getNome()+"\""+
									 ", coloreTesto: \" black\" "+
									", key: "+x.getId()+
					
									"},");
						}
						%>
				    ],
				    [
				    	<%	
					    ArrayList<Arco> archiPpyerr=grafo.getArchi();
						for(Arco x: archiPpyerr){
							//PRENDO GLI ARCHI CLASSE
							if(!x.getTipo().equals("")){
									if(!x.getFrom().getNome().equals(x.getTo().getNome()))
						  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
										", spessore: "+x.getMetricaNumero()+
						  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
							}
						}
						%>
						]
					    );
			}
			    
	}
}

function initClassLayer(cicli,esterna,link) {

		var div = document.getElementById('riga1');
		while(div.firstChild){
		   	div.removeChild(div.firstChild);
		}
		  	  	
		//SETTO COSA DEVO MOSTRARE NELLA BARRA OPZIONI
		document.getElementById('riga55').removeAttribute('hidden');
		document.getElementById('cicli').removeAttribute('hidden');  
		document.getElementById('cicli1').removeAttribute('hidden');  
		document.getElementById('indietro').hidden=true;
		document.getElementById('indietro1').hidden=true;
		document.getElementById('indietro2').hidden=true;
		if(cicli==true)
		  	document.getElementById('primary').checked=true;
		else
		  	document.getElementById('primary').checked=false;
		if(esterna==true)
		  	document.getElementById('primary1').checked=true;
		else
		  	document.getElementById('primary1').checked=false;
		
		if(link=="normale")
			document.getElementById('primary2').checked=true;
		else if(link=="ortogonale")
			document.getElementById('primary3').checked=true;
		else if(link=="curvo")
			document.getElementById('primary4').checked=true;
		else if(link=="evita")
			document.getElementById('primary5').checked=true;
		  	  	
		//CREO IL DIV
		var newDiv = document.createElement("div"); 
		newDiv.setAttribute("id", "myDiagramDiv");
		div.appendChild(newDiv);
		  	  	
		//SETTO IL COOKIE
		document.cookie = "diagramma=layer";
		
		var $ = go.GraphObject.make;  
		
		myDiagram = $(go.Diagram, "myDiagramDiv", 
			{
				  "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
				  "undoManager.isEnabled": true,  
				  initialContentAlignment: go.Spot.Center,
				  initialAutoScale: go.Diagram.UniformToFill,
				  layout: $ (go.LayeredDigraphLayout)
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
			 	cursor: "pointer",
			   	stroke: "black", 
			  	strokeWidth: 0   
			 }
			 ,
			  new go.Binding("width", "larghezza1"),
			  new go.Binding("height", "altezza1"),
			  new go.Binding("strokeWidth", "larBordo1"),           
			  new go.Binding("fill", "color1"),
			  new go.Binding("stroke", "colorBordo1") 
			),
			  	  	    		              
			 $ (go.Panel, "Auto" ,{  margin: 2},
					   $(go.Shape, { 
					   	 figure: "RoundedRectangle", 
					   	 width: 180, 
					   	 height: 40, 
					   	 margin: 2,
					   	 fill: "rgba(255,191,24,1)",
					   	 cursor: "pointer",
					     stroke: "black", 
					     strokeWidth: 2   
					  },
					    new go.Binding("width", "larghezza"),
					    new go.Binding("height", "altezza"),
					    new go.Binding("strokeWidth", "larBordo"),            
					    new go.Binding("fill", "color"),
					    new go.Binding("stroke", "colorBordo")
					 ),
					 $(go.TextBlock,
					   { margin: 20,
					     font: "bold 9pt helvetica, bold arial, sans-serif", stroke: "white",
					     editable: false 
					   },
					     new go.Binding("text", "keys"),
					     new go.Binding("stroke", "coloreTesto"))   
					  )	    		             
					 )
		 	  	   );
			  	  	    
			  	  	    
    	   myDiagram.nodeTemplate.selectionChanged=function(node) {
			    loadXMLDocGrafo(node.data.keys);
		   };
			  	  	   
		   if(link=="normale"){
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
		    }	   
		    else if (link=="ortogonale"){
		    	myDiagram.linkTemplate =
				  	 $(go.Link, 
				         { toShortLength: 9 },
				         {routing: go.Link.Orthogonal},
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
				  	    	 
		    }
		    else if(link=="curvo"){
		    	myDiagram.linkTemplate =
				  	 $(go.Link, 
				         { toShortLength: 9 ,corner: 40 },
				         { curve: go.Link.Bezier },
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
				  	    	 
		    }
		    else if(link=="evita"){
		    	myDiagram.linkTemplate =
				  	 $(go.Link, 
				  			 { toShortLength: 9 },
				  		   {routing: go.Link.AvoidsNodes},
				         $(go.Shape,
				         { stroke: "red", strokeWidth: 5 },  new go.Binding("strokeWidth", "spessore")),
				         $(go.Shape,
				         {
				            fill: "black",
				            stroke: null,
				            toArrow: "Standard",
				            scale: 2.4
				         }),
					  	  	    	
				         $ (go.TextBlock, "left" , {stroke: "white"},{segmentOffset: new go.Point ( 0 , - 10 )}, 
				        		 new go.Binding("text", "text"))
			  	  	    				        
				  	 );
				  	    	 
		    }
		  	    	 
		 if(cicli==true){
			    if(esterna==false){
			    	myDiagram.model = new go.GraphLinksModel(	    
						    [
						    	<%
							    ArrayList<NodoClasse> nodoClaw1=grafo.getNodiClasse();
								for(NodoClasse x: nodoClaw1){
									if(x.getMetricaFI()>180){
										out.print("{"+
												"key: "+x.getId()+
												", keys: \""+x.getNome()+			
												
												"\", altezza1: "+x.getMetricaDistanzaRadice()+
												", larghezza1: "+x.getMetricaCiclomatica()+ 
												", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
												", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
												", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
									
												", larghezza: "+x.getMetricaNumeroCommenti()+
												", altezza: "+x.getMetricaNumeroLineeCodice()+
												", larBordo: "+x.getMetricaNumeroMessaggi()+ 
												", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
												", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
												", coloreTesto: \"black\""+
												"},");
									}
									else{
										out.print("{"+
												"key: "+x.getId()+
												", keys: \""+x.getNome()+			
												
												"\", altezza1: "+x.getMetricaDistanzaRadice()+
												", larghezza1: "+x.getMetricaCiclomatica()+ 
												", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
												", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
												", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
									
												", larghezza: "+x.getMetricaNumeroCommenti()+
												", altezza: "+x.getMetricaNumeroLineeCodice()+
												", larBordo: "+x.getMetricaNumeroMessaggi()+ 
												", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
												", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
												
												"},");
									}
									
								}
								%>
						    ],
						    [
						    	<%	
							    ArrayList<Arco> archiPpww11=grafo.getArchi();
								for(Arco x: archiPpww11){
									//PRENDO GLI ARCHI CLASSE
									if(!x.getTipo().equals("")){
								  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
												", spessore: "+x.getMetricaNumero()+
								  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
									}
								}
								%>
							]
						    
						    );
			    }
			    else{
			    	myDiagram.model = new go.GraphLinksModel(	    
						    [
						    	<%
							    ArrayList<NodoClasse> nodoClaweee445=grafo.getNodiClasse();
								for(NodoClasse x: nodoClaweee445){			
									if(x.getMetricaFI()>180){
										out.print("{"+
												"key: "+x.getId()+
												", keys: \""+x.getNome()+			
												
												"\", altezza1: "+x.getMetricaDistanzaRadice()+
												", larghezza1: "+x.getMetricaCiclomatica()+ 
												", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
												", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
												", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
									
												", larghezza: "+x.getMetricaNumeroCommenti()+
												", altezza: "+x.getMetricaNumeroLineeCodice()+
												", larBordo: "+x.getMetricaNumeroMessaggi()+ 
												", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
												", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
												", coloreTesto: \"black\""+
												"},");
									}
									else{
										out.print("{"+
												"key: "+x.getId()+
												", keys: \""+x.getNome()+			
												
												"\", altezza1: "+x.getMetricaDistanzaRadice()+
												", larghezza1: "+x.getMetricaCiclomatica()+ 
												", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
												", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
												", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
									
												", larghezza: "+x.getMetricaNumeroCommenti()+
												", altezza: "+x.getMetricaNumeroLineeCodice()+
												", larBordo: "+x.getMetricaNumeroMessaggi()+ 
												", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
												", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
												
												"},");
									}
								}
								ArrayList<NodoClasseExternal> nodoClaweeeeoo=grafo.getNodiClasseExternal();
								for(NodoClasseExternal x: nodoClaweeeeoo){			
									out.print("{"+
											"keys: \""+x.getNome()+"\""+
											 ", coloreTesto: \" black\" "+
											", key: "+x.getId()+
							
											"},");
								}
								%>
						    ],
						    [
						    	<%	
							    ArrayList<Arco> archiPpww9oo=grafo.getArchi();
								for(Arco x: archiPpww9oo){
									//PRENDO GLI ARCHI CLASSE
									if(!x.getTipo().equals("")){
								  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
												", spessore: "+x.getMetricaNumero()+
								  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
									}
								}
								%>
							]
						    
						    );
			    }
		}
		else if(cicli==false){
				if(esterna==false){
					myDiagram.model = new go.GraphLinksModel(	    
						    [
						    	<%
						    ArrayList<NodoClasse> nodoClayeii=grafo.getNodiClasse();
							for(NodoClasse x: nodoClayeii){
								if(x.getMetricaFI()>180){
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											", coloreTesto: \"black\""+
											"},");
								}
								else{
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											
											"},");
								}
							}
							%>
					    ],
					    [
					    	<%	
						    ArrayList<Arco> archiPpyev=grafo.getArchi();
							for(Arco x: archiPpyev){
								//PRENDO GLI ARCHI CLASSE
								if(!x.getTipo().equals("")){
										if(!x.getFrom().getNome().equals(x.getTo().getNome()))
							  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
											", spessore: "+x.getMetricaNumero()+
							  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
								}
							}
							%>
							]
						    );
				}
				else{
					myDiagram.model = new go.GraphLinksModel(	    
						    [
						    	<%
						    ArrayList<NodoClasse> nodoClayerrvv=grafo.getNodiClasse();
							for(NodoClasse x: nodoClayerrvv){
								if(x.getMetricaFI()>180){
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											", coloreTesto: \"black\""+
											"},");
								}
								else{
									out.print("{"+
											"key: "+x.getId()+
											", keys: \""+x.getNome()+			
											
											"\", altezza1: "+x.getMetricaDistanzaRadice()+
											", larghezza1: "+x.getMetricaCiclomatica()+ 
											", colorBordo1: \"rgba("+x.getMetricaNumeroSottoclassi()+",10,10,1)\""+
											", color1: \"rgba("+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+","+x.getMetricaMetodiPotenziali()+",1)\""+
											", larBordo1: "+x.getMetricaAccoppiamentoClassi()+
								
											", larghezza: "+x.getMetricaNumeroCommenti()+
											", altezza: "+x.getMetricaNumeroLineeCodice()+
											", larBordo: "+x.getMetricaNumeroMessaggi()+ 
											", color: \"rgba("+x.getMetricaFI()+","+x.getMetricaFI()+","+x.getMetricaFI()+",1)\""+
											", colorBordo: \"rgba("+x.getMetricaNumeroMedoti()+",10,10,1)\""+
											
											"},");
								}
							}
							ArrayList<NodoClasseExternal> nodoClaweeee4ii=grafo.getNodiClasseExternal();
							for(NodoClasseExternal x: nodoClaweeee4ii){			
								out.print("{"+
										"keys: \""+x.getNome()+"\""+
										 ", coloreTesto: \" black\" "+
										", key: "+x.getId()+
						
										"},");
							}
							%>
					    ],
					    [
					    	<%	
						    ArrayList<Arco> archiPpyerrq=grafo.getArchi();
							for(Arco x: archiPpyerrq){
								//PRENDO GLI ARCHI CLASSE
								if(!x.getTipo().equals("")){
										if(!x.getFrom().getNome().equals(x.getTo().getNome()))
							  				out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+
											", spessore: "+x.getMetricaNumero()+
							  				", text: \""+x.getTipo()+" - ("+x.getNumero()+")"+"\""+"},");
								}
							}
							%>
							]
						    );
				}
				    
		}
	}

		
function link(s){
	
	var cicli=document.getElementById('primary').checked;
	var esterne=document.getElementById('primary1').checked;

	document.getElementById('primary').checked=cicli;
	document.getElementById('primary1').checked=esterne;
		
	var percorso =document.cookie.split("; ");
		
	if(percorso.length==3){
		var path1=percorso[0].split('=');
		var id1=percorso[1].split('=');
		var diagramma1=percorso[2].split('=');
			
		var diagramma;
		var id;
		var path;
				
		if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
			path=path1;
			id=id1;
			diagramma=diagramma1;
		}
		else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
			path=path1;
			id=diagramma1;
			diagramma=id1;
		}
		else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
			path=id1;
			id=path1;
			diagramma=diagramma1;
		}
		else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
			path=diagramma1;
			id=path1;
			diagramma=id1;
		}
		else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
			path=id1;
			id=diagramma1;
			diagramma=path1;
		}
		else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
			path=diagramma1;
			id=id1;
			diagramma=path1;
		}
		
		if(diagramma[1]=="layer"){
			initClassLayer(cicli,esterne,s.value);
		}
		else if(diagramma[1]=="circolare"){	
			initClassCircolare(cicli,esterne,s.value);
		}	
		else if(diagramma[1]=="pacchetto"){
			initPackageNavigation(path[1],id[1],s.value);
		}
		else if(diagramma[1]=="pacchetto1"){
			initPackageNavigation1(path[1],id[1],s.value);
		}
		else if(diagramma[1]=="pacchettoPre"){
			initPackagePre(path[1],id[1],cicli,s.value);
		}
		else if(diagramma[1]=="pacchettoAll"){
			initPackageAll(path[1],id[1],cicli,s.value);
		}
		else if(diagramma[1]=="pacchettoPre1"){
			initPackagePre1(path[1],id[1],cicli,s.value);
		}
		else if(diagramma[1]=="pacchettoAll1"){
			initPackageAll1(path[1],id[1],cicli,s.value);
		}
		else if(diagramma[1]=="pacchettoClassi"){
			initPackage(path[1],id[1],cicli,esterne,s.value);
		}
		else if(diagramma[1]=="pacchettoClassi1"){
			initPackage1(path[1],id[1],cicli,esterne,s.value);
		}
	}
	else if(percorso.length==1){
		var percorso1=percorso[0].split('=');
		if(percorso1[1]=="layer"){
			initClassLayer(cicli,esterne,s.value);
		}
		else if(percorso1[1]=="circolare"){	
			initClassCircolare(cicli,esterne,s.value);
		}
	}
}

function cicli(a){
	var este=document.getElementById('primary1').checked;
	var radio2=document.getElementById('primary2').checked;
	var radio3=document.getElementById('primary3').checked;
	var radio4=document.getElementById('primary4').checked;
	var radio5=document.getElementById('primary5').checked;

	var link;
	if(radio2==true)
		link="normale";
	else if(radio3==true)
		link="ortogonale";
	else if(radio4==true)
		link="curvo";
	else if(radio5==true)
		link="evita";
	
	if(a.checked==true){
		document.getElementById('primary').checked=true;
		document.getElementById('primary1').checked=este;
		document.getElementById('primary2').checked=radio2;
		document.getElementById('primary3').checked=radio3;
		document.getElementById('primary4').checked=radio4;
		document.getElementById('primary5').checked=radio5;
		
		var percorso =document.cookie.split("; ");
		
		if(percorso.length==3){
			var path1=percorso[0].split('=');
			var id1=percorso[1].split('=');
			var diagramma1=percorso[2].split('=');
			
			var diagramma;
			var id;
			var path;
				
			if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
				path=path1;
				id=id1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
				path=path1;
				id=diagramma1;
				diagramma=id1;
			}
			else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
				path=id1;
				id=path1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
				path=diagramma1;
				id=path1;
				diagramma=id1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
				path=id1;
				id=diagramma1;
				diagramma=path1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
				path=diagramma1;
				id=id1;
				diagramma=path1;
			}
			
			if(diagramma[1]=="pacchettoClassi"){
				initPackage(path[1],id[1],true,este,link); 
			}
			else if(diagramma[1]=="pacchettoClassi1"){
				initPackage1(path[1],id[1],true,este,link); 
			}
			else if(diagramma[1]=="layer"){
				initClassLayer(true,este,link);
			}
			else if(diagramma[1]=="circolare"){	
				initClassCircolare(true,este,link);
			}	
			else if(diagramma[1]=="pacchettoPre"){
				initPackagePre(path[1],id[1],true,link);
			}
			else if(diagramma[1]=="pacchettoPre1"){
				initPackagePre1(path[1],id[1],true,link);
			}
			else if(diagramma[1]=="pacchettoAll"){
				initPackageAll(path[1],id[1],true,link);
			}
			else if(diagramma[1]=="pacchettoAll1"){
				initPackageAll1(path[1],id[1],true,link);
			}
		}
		else if(percorso.length==1){
			var percorso1=percorso[0].split('=');
			if(percorso1[1]=="layer"){
				initClassLayer(true,este,link);
			}
			else if(percorso1[1]=="circolare"){	
				initClassCircolare(true,este,link);
			}
		}
				
	}
	else{
		document.getElementById('primary').checked=false;
		document.getElementById('primary1').checked=este;
		document.getElementById('primary2').checked=radio2;
		document.getElementById('primary3').checked=radio3;
		document.getElementById('primary4').checked=radio4;
		document.getElementById('primary5').checked=radio5;
		
		var percorso =document.cookie.split("; ");
		
		if(percorso.length==3){
			var path1=percorso[0].split('=');
			var id1=percorso[1].split('=');
			var diagramma1=percorso[2].split('=');
			
			var diagramma;
			var id;
			var path;
				
			if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
				path=path1;
				id=id1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
				path=path1;
				id=diagramma1;
				diagramma=id1;
			}
			else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
				path=id1;
				id=path1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
				path=diagramma1;
				id=path1;
				diagramma=id1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
				path=id1;
				id=diagramma1;
				diagramma=path1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
				path=diagramma1;
				id=id1;
				diagramma=path1;
			}
			
			if(diagramma[1]=="pacchettoClassi"){
				initPackage(path[1],id[1],false,este,link); 
			}
			else if(diagramma[1]=="pacchettoClassi1"){
				initPackage1(path[1],id[1],false,este,link); 
			}
			else if(diagramma[1]=="layer"){
				initClassLayer(false,este,link);
			}
			else if(diagramma[1]=="circolare"){	
				initClassCircolare(false,este,link);
			}
			else if(diagramma[1]=="pacchettoPre"){
				initPackagePre(path[1],id[1],false,link);
			}
			else if(diagramma[1]=="pacchettoPre1"){
				initPackagePre1(path[1],id[1],false,link);
			}
			else if(diagramma[1]=="pacchettoAll"){
				initPackageAll(path[1],id[1],false,link);
			}
			else if(diagramma[1]=="pacchettoAll1"){
				initPackageAll1(path[1],id[1],false,link);
			}
		}
		else if(percorso.length==1){
			var percorso1=percorso[0].split('=');
			if(percorso1[1]=="layer"){
				initClassLayer(false,este,link);
			}
			else if(percorso1[1]=="circolare"){	
				initClassCircolare(false,este,link);
			}
		}
		
	}
	
}


function esterne(a){
	var cicli=document.getElementById('primary').checked;
	var radio2=document.getElementById('primary2').checked;
	var radio3=document.getElementById('primary3').checked;
	var radio4=document.getElementById('primary4').checked;
	var radio5=document.getElementById('primary5').checked;
	var link;
	if(radio2==true)
		link="normale";
	else if(radio3==true)
		link="ortogonale";
	else if(radio4==true)
		link="curvo";
	else if(radio5==true)
		link="evita";
	
	if(a.checked==true){
		document.getElementById('primary1').checked=true;
		document.getElementById('primary').checked=cicli;
		document.getElementById('primary2').checked=radio2;
		document.getElementById('primary3').checked=radio3;
		document.getElementById('primary4').checked=radio4;
		document.getElementById('primary5').checked=radio5;
		
		
		var percorso =document.cookie.split("; ");
		if(percorso.length==3){
			var path1=percorso[0].split('=');
			var id1=percorso[1].split('=');
			var diagramma1=percorso[2].split('=');
			
			var diagramma;
			var id;
			var path;
				
			if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
				path=path1;
				id=id1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
				path=path1;
				id=diagramma1;
				diagramma=id1;
			}
			else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
				path=id1;
				id=path1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
				path=diagramma1;
				id=path1;
				diagramma=id1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
				path=id1;
				id=diagramma1;
				diagramma=path1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
				path=diagramma1;
				id=id1;
				diagramma=path1;
			}
			
			if(diagramma[1]=="pacchettoClassi"){
				initPackage(path[1],id[1],cicli,true,link); 
			}
			else if(diagramma[1]=="pacchettoClassi1"){
				initPackage1(path[1],id[1],cicli,true,link); 
			}
			else if(diagramma[1]=="layer"){
				initClassLayer(cicli,true,link);
			}
			else if(diagramma[1]=="circolare"){	
				initClassCircolare(cicli,true,link);
			}
		}
		else if(percorso.length==1){
			var percorso1=percorso[0].split('=');
			if(percorso1[1]=="layer"){
				initClassLayer(cicli,true,link);
			}
			else if(percorso1[1]=="circolare"){	
				initClassCircolare(cicli,true,link);
			}
		}
		
		
				
	}
	else{
		document.getElementById('primary1').checked=false;
		document.getElementById('primary').checked=cicli;
		document.getElementById('primary2').checked=radio2;
		document.getElementById('primary3').checked=radio3;
		document.getElementById('primary4').checked=radio4;
		document.getElementById('primary5').checked=radio5;
		
		var percorso =document.cookie.split("; ");
		if(percorso.length==3){
			var path1=percorso[0].split('=');
			var id1=percorso[1].split('=');
			var diagramma1=percorso[2].split('=');
			
			var diagramma;
			var id;
			var path;
				
			if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
				path=path1;
				id=id1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
				path=path1;
				id=diagramma1;
				diagramma=id1;
			}
			else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
				path=id1;
				id=path1;
				diagramma=diagramma1;
			}
			else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
				path=diagramma1;
				id=path1;
				diagramma=id1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
				path=id1;
				id=diagramma1;
				diagramma=path1;
			}
			else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
				path=diagramma1;
				id=id1;
				diagramma=path1;
			}
		
			if(diagramma[1]=="pacchettoClassi"){
				initPackage(path[1],id[1],cicli,false,link); 
			}
			else if(diagramma[1]=="pacchettoClassi1"){
				initPackage1(path[1],id[1],cicli,false,link);
			}
			else if(diagramma[1]=="layer"){
				initClassLayer(cicli,false,link);
			}
			else if(diagramma[1]=="circolare"){	
				initClassCircolare(cicli,false,link);
			}	
		}
		else if(percorso.length==1){
			var percorso1=percorso[0].split('=');
			if(percorso1[1]=="layer"){
				initClassLayer(cicli,false,link);
			}
			else if(percorso1[1]=="circolare"){	
				initClassCircolare(cicli,false,link);
			}
		}
	}
	
}


function initPackageNavigation(path,id,link) {

	 var xmlhttp;
	 var name="<%=nome%>"; 
	 var url="ServletPackageNavigation?path="+path+"&id="+id;
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
	  	  		if(link=="normale")
					document.getElementById('primary2').checked=true;
				else if(link=="ortogonale")
					document.getElementById('primary3').checked=true;
				else if(link=="curvo")
					document.getElementById('primary4').checked=true;
				else if(link=="evita")
					document.getElementById('primary5').checked=true;
	  	  		
	  	  		document.getElementById('riga55').removeAttribute('hidden');
	  	  		if(path==""){
	  	  			document.getElementById('cicli').hidden=true;
	  	  			document.getElementById('cicli1').hidden=true;
	  	  			document.getElementById('indietro').hidden=true;
  	  				document.getElementById('indietro2').hidden=true;
  	  				document.getElementById('indietro1').hidden=true;
	  	  		}
	  	  		else if(path!=""){
			  		document.getElementById('indietro1').removeAttribute('hidden');
			  		document.getElementById('cicli1').hidden=true;
			  		document.getElementById('indietro').hidden=true;
			  		document.getElementById('indietro2').hidden=true;
			  		document.getElementById('cicli').hidden=true;
			    }
	  	  	
		  	  	//CREO IL DIV
		  	  	var newDiv = document.createElement("div"); 
		  	  	newDiv.setAttribute("id", "myDiagramDiv");
		  	  	div.appendChild(newDiv);
	  	  	
		  	  	//COOKIE
		  	  	document.cookie = "path="+path;
		  	  	document.cookie = "id="+id;
		  	    document.cookie = "diagramma=pacchetto";
		  	  	
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
		  	  				        cursor: "pointer",
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
		  	  	 	   			             cursor: "pointer",
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
		  	  		if(link=="normale")
		  	  			initPackageNavigation(node.data.keys,node.data.key,"normale");  
					else if(link=="ortogonale")
						initPackageNavigation(node.data.keys,node.data.key,"ortogonale");  
					else if(link=="curvo")
						initPackageNavigation(node.data.keys,node.data.key,"curvo");  
					else if(link=="evita")
						initPackageNavigation(node.data.keys,node.data.key,"evita");  
		  	  	 		 
		  	  	    };
		  	  	    
		  	  	  if(link=="normale"){
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
				    }	   
				    else if (link=="ortogonale"){
				    	myDiagram.linkTemplate =
						  	 $(go.Link, 
						         { toShortLength: 9 },
						         {routing: go.Link.Orthogonal},
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
						  	    	 
				    }
				    else if(link=="curvo"){
				    	myDiagram.linkTemplate =
						  	 $(go.Link, 
						         { toShortLength: 9 ,corner: 40 },
						         { curve: go.Link.Bezier },
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
						  	    	 
				    }
				    else if(link=="evita"){
				    	myDiagram.linkTemplate =
						  	 $(go.Link, 
						  			 { toShortLength: 9 },
						  		   {routing: go.Link.AvoidsNodes},
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
						  	    	 
				    }
		  	  	    
		  	  	    
		  	  	    
		  	  	    
	  	    	 
	  	    	  var response=xmlhttp.responseText;
	  	    	  if(response=="---!!---"){
	  	    		 var linkDataArray;
					 var nodeDataArray=new Array;
	  	    		 nodeDataArray.push ({key: -1, keys: "NON SONO\nPRESENTI\nPACKAGE", altezza: 70, larghezza: 70, larBordo: 0, color: "rgba(150,10,10,0)", larghezza1: 0});
	  	    		 myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	  	    	  }
	  	    	  else{
	  	    	  	  var nodeDataArray = new Array (); 
		  	    	  var pacchetti=response.split(';-;');
			  	    	  for(var i=0; i<pacchetti.length; i++){
			  	    		 var info=pacchetti[i].split("+");
			  	   		     nodeDataArray.push ({key: parseInt(info[0]), keys: info[1], altezza: parseInt(info[2]), larghezza: parseInt(info[3]), larBordo: parseInt(info[4]), color: "rgba("+info[5]+",10,10,1)", larghezza1: 0});
			  	    	  }
		  	    	  
		  	    	  var linkDataArray;
		   			  linkDataArray = [
			  	      		<%
			    			   ArrayList<Arco> archiPyw766=grafo.getArchi();
			    				for(Arco x: archiPyw766)
			    					
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    				%>
			  	      	  ];
		   			  }
		   			 
		  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	  	    	  }
	  	      	 
	  	      
	  	  }
	  	  xmlhttp.open("GET", url, true);
	  	  xmlhttp.send();
}

function initPackageNavigation1(path,id,link) {

	 var xmlhttp;
	 var name="<%=nome%>"; 
	 var url="ServletPackageNavigation?path="+path+"&id="+id;
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
	  	  		if(link=="normale")
					document.getElementById('primary2').checked=true;
				else if(link=="ortogonale")
					document.getElementById('primary3').checked=true;
				else if(link=="curvo")
					document.getElementById('primary4').checked=true;
				else if(link=="evita")
					document.getElementById('primary5').checked=true;
	  	  		document.getElementById('riga55').removeAttribute('hidden');
	  	  		if(path==""){
	  	  			document.getElementById('cicli').hidden=true;
	  	  			document.getElementById('cicli1').hidden=true;
	  	  			document.getElementById('indietro').hidden=true;
	  	  			document.getElementById('indietro2').hidden=true;
	  	  			document.getElementById('indietro1').hidden=true;
	  	        }
	  	  		else if(path!=""){
			  		document.getElementById('indietro1').removeAttribute('hidden');
			  		document.getElementById('cicli1').hidden=true;
			  		document.getElementById('indietro').hidden=true;
			  		document.getElementById('indietro2').hidden=true;
			  		document.getElementById('cicli').hidden=true;
			    }
	  	  	
		  	  	//CREO IL DIV
		  	  	var newDiv = document.createElement("div"); 
		  	  	newDiv.setAttribute("id", "myDiagramDiv");
		  	  	div.appendChild(newDiv);
	  	  	
		  	  	//COOKIE
		  	  	document.cookie = "path="+path;
		  	  	document.cookie = "id="+id;
		  	    document.cookie = "diagramma=pacchetto1";
		  	  	
		  	  	var $ = go.GraphObject.make;  
		  	  	myDiagram = $(go.Diagram, "myDiagramDiv", 
		  	  	{
		  	           "toolManager.mouseWheelBehavior": go.ToolManager.WheelZoom,
		  	  	    "undoManager.isEnabled": true,  
		  	  	    initialContentAlignment: go.Spot.Center,
		  	          initialAutoScale: go.Diagram.UniformToFill,
		  	          layout: $ (go.LayeredDigraphLayout)
		  	          
		  	          
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
		  	  				        cursor: "pointer",
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
		  	  	 	   			             cursor: "pointer",
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
			 			initPackageNavigation1(node.data.keys,node.data.key,link);  
		  	  			 
		  	  	    };
		  	  	   
		  	  	  if(link=="normale"){
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
				    }	   
				    else if (link=="ortogonale"){
				    	myDiagram.linkTemplate =
						  	 $(go.Link, 
						         { toShortLength: 9 },
						         {routing: go.Link.Orthogonal},
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
						  	    	 
				    }
				    else if(link=="curvo"){
				    	myDiagram.linkTemplate =
						  	 $(go.Link, 
						         { toShortLength: 9 ,corner: 40 },
						         { curve: go.Link.Bezier },
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
						  	    	 
				    }
				    else if(link=="evita"){
				    	myDiagram.linkTemplate =
						  	 $(go.Link, 
						  			 { toShortLength: 9 },
						  		   {routing: go.Link.AvoidsNodes},
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
						  	    	 
				    }
	  	    	 
	  	    	  var response=xmlhttp.responseText;
	  	    	  if(response=="---!!---"){
	  	    		 var linkDataArray;
					 var nodeDataArray=new Array;
	  	    		 nodeDataArray.push ({key: -1, keys: "NON SONO\nPRESENTI\nPACKAGE", altezza: 70, larghezza: 70, larBordo: 0, color: "rgba(150,10,10,0)", larghezza1: 0});
	  	    		 myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	  	    	  }
	  	    	  else{
	  	    	  	  var nodeDataArray = new Array (); 
		  	    	  var pacchetti=response.split(';-;');
			  	    	  for(var i=0; i<pacchetti.length; i++){
			  	    		 var info=pacchetti[i].split("+");
			  	   		     nodeDataArray.push ({key: parseInt(info[0]), keys: info[1], altezza: parseInt(info[2]), larghezza: parseInt(info[3]), larBordo: parseInt(info[4]), color: "rgba("+info[5]+",10,10,1)", larghezza1: 0});
			  	    	  }
		  	    	  
		  	    	  var linkDataArray;
		   			  linkDataArray = [
			  	      		<%
			    			   ArrayList<Arco> archiPyw766RR=grafo.getArchi();
			    				for(Arco x: archiPyw766RR)
			    					
			    			  		out.print("{ from: \""+x.getFrom().getId() +"\", to: \""+x.getTo().getId()+"\""+", spessore: "+x.getMetricaNumero()
		    				  		+", text: \""+x.getNumero()+"\""+"},");
			    				%>
			  	      	  ];
		   			  }
		   			 
		  	      	  myDiagram.model = new go.GraphLinksModel (nodeDataArray, linkDataArray);
	  	    	  }
	  	      	 
	  	      
	  	  }
	  	  xmlhttp.open("GET", url, true);
	  	  xmlhttp.send();
}


function indietro1(){
	//ottengo il grafo da visualizzare
	var radio2=document.getElementById('primary2').checked;
	var radio3=document.getElementById('primary3').checked;
	var radio4=document.getElementById('primary4').checked;
	var radio5=document.getElementById('primary5').checked;
	var link;
	if(radio2==true)
		link="normale";
	else if(radio3==true)
		link="ortogonale";
	else if(radio4==true)
		link="curvo";
	else if(radio5==true)
		link="evita";
	
	var percorso =document.cookie.split("; ");
	var path1=percorso[0].split('=');
	var id1=percorso[1].split('=');
	var diagramma1=percorso[2].split('=');


	var path;
	var id;
	var diagramma;
	
	if(path1[0]=="path" && id1[0]=="id" && diagramma1[0]=="diagramma"){
		path=path1[1];
		id=id1[1];
		diagramma=diagramma1[1];
	}
	else if(path1[0]=="path" && id1[0]=="diagramma" && diagramma1[0]=="id"){
		path=path1[1];
		id=diagramma1[1];
		diagramma=id1[1];
	}
	else if(path1[0]=="id" && id1[0]=="path" && diagramma1[0]=="diagramma"){
		path=id1[1];
		id=path1[1];
		diagramma=diagramma1[1];
	}
	else if(path1[0]=="id" && id1[0]=="diagramma" && diagramma1[0]=="path"){
		path=diagramma1[1];
		id=path1[1];
		diagramma=id1[1];
	}
	else if(path1[0]=="diagramma" && id1[0]=="path" && diagramma1[0]=="id"){
		path=id1[1];
		id=diagramma1[1];
		diagramma=path1[1];
	}
	else if(path1[0]=="diagramma" && id1[0]=="id" && diagramma1[0]=="path"){
		path=diagramma1[1];
		id=id1[1];
		diagramma=path1[1];
	}
	
	
	var indice=path.lastIndexOf('.');
	if(diagramma=="pacchetto"){
		if(indice==-1){
			initPackageNavigation("",id,link);
		}
		else{
			var pat=path.substring(0,indice);
			initPackageNavigation(pat,id,link);
		}
	}
	if(diagramma=="pacchetto1"){
		if(indice==-1){
			initPackageNavigation1("",id,link);
		}
		else{
			var pat=path.substring(0,indice);
			initPackageNavigation1(pat,id,link);
		}
	}
	
}



</script>


	</body>
</html>