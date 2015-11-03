function suite_symb=demapQAM(Xi,Xq,M)

% Cette fonction permet d'associer aux symboles leur écriture décimale en fonction 
% de leurs coordonnées complexes Xi (partie réelle) et Xq (partie imaginaire)
% dans la cas d'une démodulation M-QAM.

% Xi est la partie réelle du vecteur des coordonnées complexes.
% Xq est la partie imaginaire du vecteur des coordonnées complexes.
% M est le nombre de points de la constellation dans laquelle on démodule.


suite_symb=qaskdeco(Xi,Xq,M); % Démodule les symboles dans une constellation de M points