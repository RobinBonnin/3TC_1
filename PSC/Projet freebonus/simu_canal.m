function x_recep=simu_canal(x_trans,h)

% La fonction simu_canal permet de simuler un canal r�el bruit�.
% Toutes les informations qui sortiront du modulateur DMT transiteront par
% ce canal pour finalement �tre envoy�es au d�modulateur.

% x_trans est le vecteur de donn�es re�u en sortie du modulateur.
% h est la r�ponse impulsionnelle en temps du canal.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

% On veut cr�er un bruit color� dont la densit� spectrale diminue
% exponentiellement avec la fr�quence et on peut le mod�liser par un bruit
% blanc dans chaque bande de fr�quence porteuse. N'ayant pas trouv�
% de solution satisfaisante, nous allons simplement ajouter du bruit blanc sur
% les �chantillons.
l=length(x_trans)+length(h)-1;
bruit=exp(-0.7*[0:l-1]).*randn(1,l);


%%%%%%%%%%%%%%%%
% Transmission %
%%%%%%%%%%%%%%%%

% On convolue le signal re�u � la fonction de transfert du canal en temps
% et on ajoute le bruit.
x_recep=conv(x_trans,h)+bruit; 