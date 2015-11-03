#include <map>
#include <vector>
#include <iostream>
#include <algorithm>

int main(){
	typedef std::vector<int> Conteneur;
	Conteneur leConteneur;
	
	for (int i = 0; i<50; i++)
	leConteneur.push_back(2*i);
	
	Conteneur::const_reverse_iterator it2;
	for (it2 = leConteneur.rbegin(); it2 != leConteneur.rend(); it2++)
	{
		std::cout<<*it2<< ", ";
	}
	
	std::cout << std::endl;
	
	int tab[50];
	std::fill( tab, (tab+50), 0 );
	int* ptr = tab;
	for (it2 = leConteneur.rbegin(); it2 != leConteneur.rend(); it2++, ptr++){
		*ptr= *it2;
		
		}
		
		bool isEqual = std::equal(leConteneur.begin(), leConteneur.end(), tab);
		std::string res = (isEqual)? "Ok" : "KO";
		std::cout << res << std::endl;
	
	return 0;
}
