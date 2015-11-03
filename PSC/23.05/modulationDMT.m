function x=modulationDMT(suite_symboles_in, nombre_canaux, prefixe_cyclique, tableau_allocation, Somme, nombre_trames)

%tableau_allocation = [2 3 4 6 1];
trame = [];
%Somme = 16;
%suite_symboles_in = [1.0000 - 1.0000i  -1.0000 + 1.0000i  -1.0000 + 1.0000i   5.0000 - 3.0000i   1.0000 + 0.0000 2.0000 - 1.0000i  -1.0000 + 1.0000i  -1.0000 + 1.0000i   5.0000 - 3.0000i   1.0000 + 0.0000 5.0000 - 1.0000i  -1.0000 + 1.0000i  -1.0000 + 1.0000i   5.0000 - 3.0000i   1.0000 + 0.0000];
T = nombre_canaux;
pos = 1;

sortie_avec_prefixe = [];
supertrame_au_canal = [];

for j = 0:(nombre_trames-1)
    for k=1:T
         trame(k) = suite_symboles_in(k + (j*T));
    end
    trame;
    Y = fliplr(conj(trame));
    trame_double = [0 trame 0 Y];
    sortie_sans_prefixe = ifft(trame_double);
    taille = length(sortie_sans_prefixe);
    pref_cyclique = sortie_sans_prefixe((taille-(prefixe_cyclique-1)):taille);
    sortie_avec_prefixe = [pref_cyclique sortie_sans_prefixe]; 
    supertrame_au_canal = [supertrame_au_canal sortie_avec_prefixe];
end

x = supertrame_au_canal;

%trame(i) = suite_symboles_in((1+(j*T)):(T+(j*T)))
