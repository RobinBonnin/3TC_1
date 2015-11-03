Array<string> stringList = nex ArrayList<String>; Generaic array lsit to store only string
stringlist.add("Item"); // no error cause we are storing string
int index = stringList.indexOf("Item");
for(String item:stringList){
System.out.println("retrieved element : " + item);
}

if(stringList.size() == 0){
System.out.println("Ararylist is empty");
}

StringList.remove(0);
Stringlist.remove(item)

static Arraylist<Personne> recherche(Collection <Personne> collection, Critererecherche critere) { 
	ArrayList<Personne> res = new ArrayList<Personne>
	for (Personne mec:collection){
		switch (critere instanceof):
			case nom: 
					if(mec.nom=critere){
						res.add(mec)
						}
					break;
			case prenom:
				if(mec.prenom=critere) {
					res.add(mec);
				break;
				}
	}
	return res;
}

abstract class CritereRecherche {
	private String value;
	CritereRecherche(String tmp) {
		this.value=tmp;
	}
	public String get_value(){
		return this.value
	}
}

class ID extends CritereRecherche{ 
	ID(int tmp){
		super(Integer.toString(tmp))
	}
}
class  extends CritereRecherche{}
class prenom extends CritereRecherche{}+
