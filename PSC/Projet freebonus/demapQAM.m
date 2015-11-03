function suite_symb=demapQAM(Xi,Xq,M)

% Cette fonction permet d'associer aux symboles leur �criture d�cimale en fonction 
% de leurs coordonn�es complexes Xi (partie r�elle) et Xq (partie imaginaire)
% dans la cas d'une d�modulation M-QAM.

% Xi est la partie r�elle du vecteur des coordonn�es complexes.
% Xq est la partie imaginaire du vecteur des coordonn�es complexes.
% M est le nombre de points de la constellation dans laquelle on d�module.


suite_symb=qaskdeco(Xi,Xq,M); % D�module les symboles dans une constellation de M points