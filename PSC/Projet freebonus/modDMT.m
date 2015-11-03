function x=modDMT(suite_symb,nb_canaux,pref_cycl)

% La fonction modDMT réalise le traitement par paraléllisation de la suite de symboles reçus.
% On récupèrera l'enveloppe complexe du signal.
% Les étapes : parallélisation, IFFT, sérialisation, ajout du préfixe
% cyclique.

% suite_symb est la suite des coordonnées complexes des symboles dans la
% constellation qui leur est associé.
% nb_canaux est le nombre de canaux utilisés.
% pref_cycl est la longueur du prefixe cyclique.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

N=nb_canaux; % Nombre de canaux
v=pref_cycl; % Longueur du préfixe cyclique


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parallélisation et IFFT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A partir de la suite de symboles en entrée, on va former un symbole DMT
% par parallélisation sur les N canaux. On appliquera ensuite une IFFT.

suite_symb=[suite_symb conj(fliplr(suite_symb))]; % On concatène la suite de symboles avec son symétrique
                                                  % hermitien en miroir. Les calculs montrent en effet que 
                                                  % cela revient à travailler sur la partie réelle après IFFT                                           
x_ifft=ifft(suite_symb,2*N); % On applique l'IFFT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajout du préfixe cyclique %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Le préfixe cyclique permet d'éviter les IIS et les IIC.
% Pour le former, on répète la fin du symbole DMT au début du même
% symbole.

x=[x_ifft(2*N+1-v:2*N) x_ifft]; % v >= 1