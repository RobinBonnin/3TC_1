function x_recep=simu_canal(x_trans,h)

% La fonction simu_canal permet de simuler un canal réel bruité.
% Toutes les informations qui sortiront du modulateur DMT transiteront par
% ce canal pour finalement être envoyées au démodulateur.

% x_trans est le vecteur de données reçu en sortie du modulateur.
% h est la réponse impulsionnelle en temps du canal.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

% On veut créer un bruit coloré dont la densité spectrale diminue
% exponentiellement avec la fréquence et on peut le modéliser par un bruit
% blanc dans chaque bande de fréquence porteuse. N'ayant pas trouvé
% de solution satisfaisante, nous allons simplement ajouter du bruit blanc sur
% les échantillons.
l=length(x_trans)+length(h)-1;
bruit=exp(-0.7*[0:l-1]).*randn(1,l);


%%%%%%%%%%%%%%%%
% Transmission %
%%%%%%%%%%%%%%%%

% On convolue le signal reçu à la fonction de transfert du canal en temps
% et on ajoute le bruit.
x_recep=conv(x_trans,h)+bruit; 