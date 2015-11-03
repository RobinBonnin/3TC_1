function [Xi,Xq]=mapADQAM(symb,M)

% La fonction mapQAM renvoie les coordonn�es du symbole symb
% dans la constellation M-QAM appropri�e.

% symb est le vecteur des symboles � moduler.
% M est le nombre de points de la constellation dans laquelle on va
% moduler les symboles.


% if M==2 Pmoy=1; % Pmoy est la Puissance moyenne des symboles qui nous servira � normaliser les coordonn�es
% else Pmoy=2/3*(sqrt(M)-1)*(sqrt(M)+1);
% end

[I,Q]=qaskenco(M); % Cr�ation de la constellation
Xi=I(symb+1); % On cr�e le vecteur des parties r�elles de la suite de symboles
Xq=Q(symb+1); % On cr�e le vecteur des parties imaginaires de la suite de symboles

% Xi=I(symb+1)/sqrt(Pmoy); % On cr�e le vecteur des parties r�elles de la suite de symboles
% Xq=Q(symb+1)/sqrt(Pmoy); % On cr�e le vecteur des parties imaginaires de la suite de symboles