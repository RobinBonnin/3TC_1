#include <map>
#include <string>

int main(){

typedef std::map<std::string, int> Conteneur;
Conteneur leConteneur;

leConteneur.insert(std::pair<std::string, int>("janvier",31));
typedef std::pair<std::string, int> Pair;
leConteneur.insert(Pair("fevrier",28));
leConteneur.insert(std::make_pair("mars",31));
leConteneur.insert(std::make_pair("avril",30));
leConteneur.insert(std::make_pair("mai",31));

return 0;

}
