function suite_symboles = modulationQAM(supertrame, tableau_allocation, nombre_canaux, nombre_trames)

%trame = gene_bits(48, 0.5);
%tableau_allocation = [2 3 4 6 1]

suite_valeurs = [];
La_somme = 0; 
symbole_OFDM = [];

for j=1:nombre_trames   
    for i=1:nombre_canaux
        Nombre_symboles = 2^(tableau_allocation(i));
        Constellation = qammod(0:(Nombre_symboles-1), Nombre_symboles);
        valeur = bi2de(supertrame((La_somme+1) : (La_somme + tableau_allocation(i))));
        suite_valeurs = [suite_valeurs valeur];
        La_somme = La_somme + (tableau_allocation(i));
        symbole_OFDM = [symbole_OFDM Constellation(valeur+1)];
    end
end
suite_valeurs;
suite_symboles = symbole_OFDM;

        





