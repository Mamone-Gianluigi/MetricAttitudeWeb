package visitor;

import org.eclipse.jdt.core.dom.IMethodBinding;
import org.eclipse.jdt.core.dom.ITypeBinding;
import struttura.NodoClasse;

public class MethodDelegation {
	
	NodoClasse nodoClasse;
	ITypeBinding endClass;
	IMethodBinding startMethod;
	IMethodBinding binding;
	
	public MethodDelegation(NodoClasse nodoClasse,IMethodBinding startMethod,ITypeBinding endClass,IMethodBinding binding){
		this.nodoClasse=nodoClasse;
		this.startMethod=startMethod;
		this.endClass=endClass;
		this.binding=binding;
	}

	public NodoClasse getNodoClasse() {
		return nodoClasse;
	}

	public void setNodoClasse(NodoClasse nodoClasse) {
		this.nodoClasse = nodoClasse;
	}

	public ITypeBinding getEndClass() {
		return endClass;
	}

	public void setEndClass(ITypeBinding endClass) {
		this.endClass = endClass;
	}

	public IMethodBinding getStartMethod() {
		return startMethod;
	}

	public void setStartMethod(IMethodBinding startMethod) {
		this.startMethod = startMethod;
	}

	public IMethodBinding getBinding() {
		return binding;
	}

	public void setBinding(IMethodBinding binding) {
		this.binding = binding;
	}
	
	

}
