package visitor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Stack;
import org.eclipse.jdt.core.dom.ASTVisitor;
import org.eclipse.jdt.core.dom.ClassInstanceCreation;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.ConstructorInvocation;
import org.eclipse.jdt.core.dom.DoStatement;
import org.eclipse.jdt.core.dom.EnhancedForStatement;
import org.eclipse.jdt.core.dom.ForStatement;
import org.eclipse.jdt.core.dom.IMethodBinding;
import org.eclipse.jdt.core.dom.IPackageBinding;
import org.eclipse.jdt.core.dom.ITypeBinding;
import org.eclipse.jdt.core.dom.IfStatement;
import org.eclipse.jdt.core.dom.MethodDeclaration;
import org.eclipse.jdt.core.dom.MethodInvocation;
import org.eclipse.jdt.core.dom.Modifier;
import org.eclipse.jdt.core.dom.SuperMethodInvocation;
import org.eclipse.jdt.core.dom.SwitchCase;
import org.eclipse.jdt.core.dom.SwitchStatement;
import org.eclipse.jdt.core.dom.TypeDeclaration;
import org.eclipse.jdt.core.dom.TypeDeclarationStatement;
import org.eclipse.jdt.core.dom.WhileStatement;
import org.eclipse.jface.text.Document;
import parsing.Utils;
import struttura.Grafo;
import struttura.NodoClasse;
import struttura.NodoPackage;
import struttura.TipoClasse;


class StackClass{
	NodoClasse _node;
	Stack<IMethodBinding> _stackMethod = new Stack<>();

	public StackClass(NodoClasse node)
	{
		_node = node;
		_stackMethod = new Stack<>();
	}

	public NodoClasse getNode()
	{
		return _node;
	}

	public void push(IMethodBinding method)
	{
		_stackMethod.push(method);
	}

	public IMethodBinding pop()
	{
		if (_stackMethod.size() > 0)
			return _stackMethod.pop();

		return null;
	}

	public Stack<IMethodBinding> getMethods()
	{
		return _stackMethod;
	}

	public IMethodBinding top()
	{
		if (_stackMethod.size() > 0)
			return _stackMethod.lastElement();
		return null;
	}

}

public class MyVisitor extends ASTVisitor {

	CompilationUnit _compilation;
	Stack<StackClass> _stackClass;
	int countStack=0;
	Document _document;
	Set<String> names = new HashSet<String>();
	Grafo grafo = null;
	String fileName;
	NodoClasse nodo;

	public Grafo getGrafo() {
		return grafo;
	}

	public void setGrafo(Grafo grafo) {
		this.grafo = grafo;
	}

	public MyVisitor(CompilationUnit compilation, Document document, String fileName) {
		_stackClass = new Stack<StackClass>();
		_compilation = compilation;
		_document = document;
		this.fileName = fileName;
	}

	@Override
	public boolean visit(CompilationUnit node) {
		_compilation=node;
		return true;
	}

	@Override 
	public boolean visit(TypeDeclaration node) {
		ITypeBinding binding = node.resolveBinding();
		if(binding == null) 
			return false;
		
		//ID DEL NODO DA CREARE
		int id=Utils.getId();
		//NOME DEL NODO DA CREARE
		String nomeNodo=node.getName().toString();
		//PACCHETTO IN CUI SI TROVA IL NODO
		String pacchetto=getPacchetto(binding);
		//PACCHETTO PADRE
		String pacchettoPadre=null;
		
		if(pacchetto.equals("(default package)"))
			pacchettoPadre="";
		else{
			String list[]=binding.getPackage().getNameComponents();
			if(list.length==1)
				pacchettoPadre="";
			else{
				String pacchettoPadreTmp= String.join(".", list);
				int temp=pacchettoPadreTmp.lastIndexOf(".");
				pacchettoPadre=pacchettoPadreTmp.substring(0, temp);
				
			}
		}
		//TIPO CLASSE NODO
		TipoClasse tipoClasse=null;
		if(Modifier.isAbstract(binding.getModifiers()))
			tipoClasse=TipoClasse.ASTRATTA;
		else if(node.isInterface())
			tipoClasse=TipoClasse.INTERFACCIA;
		else 
			tipoClasse=TipoClasse.CONCRETA;
		//NUMERO LINEE DI CODICE E DEI COMMENTI 
		String item[]=node.toString().split("\\r?\\n");	
		int result[]=LineCodeAndComment.getNumberOfLines(item);
		int numeroLineeCodice=result[1];
		int numeroCommen=result[0];
		 
		//CREO IL NODO
		NodoClasse nodoClasse=new NodoClasse(id, nomeNodo, tipoClasse);
		//LUNGHEZZA
		nodoClasse.setLunghezza(node.getLength());
		//PACCHETTO
		nodoClasse.setPackage(pacchetto);
		//CODICE
		nodoClasse.setSource(node.toString());
		//NUMERO LINEE DI CODICE
		nodoClasse.setNumeroLineeCodice(numeroLineeCodice);
		//NUMERO COMMENTI
		nodoClasse.setNumeroCommenti(numeroCommen);
		//NUMERO METODI
		nodoClasse.setNumeroMetodi(node.getMethods().length);
		//BINDING
		nodoClasse.setBinding(binding);
		//NODO
		nodoClasse.setNode(node);		
		//SUPERCLASSE
		if( binding.getSuperclass()==null)
			nodoClasse.setSuperclasse(null);
		else
			nodoClasse.setSuperclasse(binding.getSuperclass().getName());
		grafo.addNodoClasse(nodoClasse);
	
		
		NodoPackage nodoPackage = grafo.cercaNodoPackage(pacchetto);
		if (nodoPackage == null) {
			nodoPackage = new NodoPackage(Utils.getId(),getPacchetto(binding));
			nodoPackage.setParentPackage(pacchettoPadre);
			grafo.addNodoPackage(nodoPackage);
		}
		
		nodoPackage.addNodiPackage(nodoClasse);
		
		_stackClass.push(new StackClass(nodoClasse));
		countStack=countStack+1;
	
		return true;
	}
	
	@Override
	public void endVisit(TypeDeclaration node)
	{
		ITypeBinding binding = node.resolveBinding();
		if (binding != null){
			_stackClass.pop();
			countStack=countStack-1;
		}
	}
	
	@Override
	public boolean visit(MethodDeclaration node) {
		IMethodBinding binding = node.resolveBinding();
		if (_stackClass.size() > 0)
		{
			_stackClass.lastElement().push(binding);
			countStack=countStack+1;
		}
		return true;
	}
	
	@Override
	public void endVisit(MethodDeclaration node) {
		if (_stackClass.size() > 0)
		{
			_stackClass.lastElement().pop();
			countStack=countStack-1;
		}
	}
	
	@Override
	public boolean visit(MethodInvocation node){
		IMethodBinding binding = node.resolveMethodBinding();
		if (binding == null)
			return false;
		MethodDelegation md = createDelegation(binding);
		if (_stackClass.size() > 0)
			if (_stackClass.lastElement().getNode() != null)
			{
				_stackClass.lastElement().getNode().addDelegazione(md);
			}		
		return true;
	}
	/*
	@Override
	public boolean visit(ConstructorInvocation node)
	{
		IMethodBinding binding = node.resolveConstructorBinding();
		if (binding == null)
			return false;

		MethodDelegation md = createDelegation(binding);
		if (_stackClass.size() > 0)
			if (_stackClass.lastElement().getNode() != null)
			{
				_stackClass.lastElement().getNode().addDelegazione(md);
			}

		return true;
	}
	
	@Override
	public boolean visit(ClassInstanceCreation node)
	{
		IMethodBinding binding = node.resolveConstructorBinding();
		if (binding == null)
		{
			return false;
		}

		MethodDelegation md = createDelegation(binding);
		if (_stackClass.size() > 0)
			if (_stackClass.lastElement().getNode() != null)
			{
				_stackClass.lastElement().getNode().addDelegazione(md);
			}

		return true;
	}*/
	
	@Override
	public boolean visit(SuperMethodInvocation node)
	{
		IMethodBinding binding = node.resolveMethodBinding();
		if (binding == null)
		{
			return false;
		}

		MethodDelegation md = createDelegation(binding);
		System.out.println("/////////////////////////////////////////"+md.getNodoClasse().getNome());
		System.out.println("/////////////////////////////////////////"+md.getStartMethod().getName());
		if (_stackClass.size() > 0)
			if (_stackClass.lastElement().getNode() != null)
			{
				_stackClass.lastElement().getNode().addDelegazione(md);
			}
		return true;
	}
	
	
	@Override 
	public boolean visit(TypeDeclarationStatement node) {
		
		ITypeBinding binding = node.resolveBinding();
		if (binding == null)
			return false;
		return true;
	}
	
	public MethodDelegation createDelegation(IMethodBinding binding)
	{
		NodoClasse nodoClasse = null;
		IMethodBinding startMethod = null;
		if (_stackClass.size() > 0)
		{
			nodoClasse = _stackClass.lastElement().getNode();
			if (_stackClass.lastElement().getMethods().size() > 0)
				startMethod = _stackClass.lastElement().getMethods().lastElement();
				if(startMethod == null) {
					System.out.println("null.....");
				}
		}
		ITypeBinding endClass = binding.getDeclaringClass();
		return new MethodDelegation(nodoClasse, startMethod, endClass, binding);
	}
	
	/*INIZIO CONTROLLO STATEMENT*/
	@Override
	public boolean visit(IfStatement node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	
	@Override
	public boolean visit(WhileStatement node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	
	@Override
	public boolean visit(DoStatement node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	
	@Override
	public boolean visit(ForStatement node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	
	@Override
	public boolean visit(EnhancedForStatement node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	
	
	@Override
	public boolean visit(SwitchCase node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	
	@Override
	public boolean visit(SwitchStatement node){
		NodoClasse nodo=null;
		if (_stackClass.size() > 0){
			if (_stackClass.lastElement().getNode() != null)
			{
				nodo=_stackClass.lastElement().getNode();
			}
			nodo.addCiclomatica();
		}
		return true;
	}
	/*FINE CONTROLLO STATEMENT*/
	
	public String getPacchetto(ITypeBinding binding){
		IPackageBinding a=binding.getPackage();
		String packageLoc = null;
		if(!a.getName().equals("")){
			
			String list[]=a.getNameComponents();
			packageLoc= String.join(".", list);
		}
		else{
			packageLoc="(default package)";
		}
		return packageLoc;
	}

}
