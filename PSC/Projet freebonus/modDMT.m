function x=modDMT(suite_symb,nb_canaux,pref_cycl)

% La fonction modDMT r�alise le traitement par paral�llisation de la suite de symboles re�us.
% On r�cup�rera l'enveloppe complexe du signal.
% Les �tapes : parall�lisation, IFFT, s�rialisation, ajout du pr�fixe
% cyclique.

% suite_symb est la suite des coordonn�es complexes des symboles dans la
% constellation qui leur est associ�.
% nb_canaux est le nombre de canaux utilis�s.
% pref_cycl est la longueur du prefixe cyclique.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

N=nb_canaux; % Nombre de canaux
v=pref_cycl; % Longueur du pr�fixe cyclique


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parall�lisation et IFFT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A partir de la suite de symboles en entr�e, on va former un symbole DMT
% par parall�lisation sur les N canaux. On appliquera ensuite une IFFT.

suite_symb=[suite_symb conj(fliplr(suite_symb))]; % On concat�ne la suite de symboles avec son sym�trique
                                                  % hermitien en miroir. Les calculs montrent en effet que 
                                                  % cela revient � travailler sur la partie r�elle apr�s IFFT                                           
x_ifft=ifft(suite_symb,2*N); % On applique l'IFFT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ajout du pr�fixe cyclique %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Le pr�fixe cyclique permet d'�viter les IIS et les IIC.
% Pour le former, on r�p�te la fin du symbole DMT au d�but du m�me
% symbole.

x=[x_ifft(2*N+1-v:2*N) x_ifft]; % v >= 1