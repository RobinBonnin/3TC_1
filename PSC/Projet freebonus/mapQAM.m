function [Xi,Xq]=mapQAM(symb,M)

% La fonction mapQAM renvoie les coordonnées du symbole symb
% dans la constellation M-QAM appropriée.

% symb est le vecteur des symboles à moduler.
% M est le nombre de points de la constellation dans laquelle on va
% moduler les symboles.


% if M==2 Pmoy=1; % Pmoy est la Puissance moyenne des symboles qui nous servira à normaliser les coordonnées
% else Pmoy=2/3*(sqrt(M)-1)*(sqrt(M)+1);
% end

[I,Q]=qaskenco(M); % Création de la constellation
Xi=I(symb+1); % On crée le vecteur des parties réelles de la suite de symboles
Xq=Q(symb+1); % On crée le vecteur des parties imaginaires de la suite de symboles

% Xi=I(symb+1)/sqrt(Pmoy); % On crée le vecteur des parties réelles de la suite de symboles
% Xq=Q(symb+1)/sqrt(Pmoy); % On crée le vecteur des parties imaginaires de la suite de symboles