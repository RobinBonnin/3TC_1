function h_reel=simu_ligne(nb_canaux,pref_cycl)

% Cette fonction simule les r�ponse impulsionnelles en temps du canal.
% Cette r�ponse sera exponentiellement d�croissante et �chantillonn�e au
% temps Te.
% 
% nb_canaux est le nombre de canaux utilis�s.
% pref_cycl est la longueur du pr�fixe cyclique.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

N=nb_canaux;
v=pref_cycl;
W=4312.5; % Largeur de bande d'un canal en Hz
Tdmt=1/W; % Temps DMT
Ts=Tdmt/N; % Temps symbole: Tdmt=N*Ts
K=10; % Facteur de sur�chantillonage
Te=Ts/K; % P�riode d'�chantillonage
n=v+4; % Nombre d'�chantillons voulus (n>v)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cr�ation de la r�ponse impulsionnelle %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha=log(0.01)/(v*Te); % Calcul du coefficient de l'exponentielle permettant d'avoir une r�ponse impulsionelle 
                        % proche de 0 pour le v+1-�me �chantillon (pour �viter les interf�rences entre symboles)
t=[0:Te:(n-1)*Te]; % Vecteur temps
h_reel=exp(alpha*t);