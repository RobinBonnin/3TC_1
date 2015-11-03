function h_reel=simu_ligne(nb_canaux,pref_cycl)

% Cette fonction simule les réponse impulsionnelles en temps du canal.
% Cette réponse sera exponentiellement décroissante et échantillonnée au
% temps Te.
% 
% nb_canaux est le nombre de canaux utilisés.
% pref_cycl est la longueur du préfixe cyclique.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

N=nb_canaux;
v=pref_cycl;
W=4312.5; % Largeur de bande d'un canal en Hz
Tdmt=1/W; % Temps DMT
Ts=Tdmt/N; % Temps symbole: Tdmt=N*Ts
K=10; % Facteur de suréchantillonage
Te=Ts/K; % Période d'échantillonage
n=v+4; % Nombre d'échantillons voulus (n>v)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création de la réponse impulsionnelle %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha=log(0.01)/(v*Te); % Calcul du coefficient de l'exponentielle permettant d'avoir une réponse impulsionelle 
                        % proche de 0 pour le v+1-ème échantillon (pour éviter les interférences entre symboles)
t=[0:Te:(n-1)*Te]; % Vecteur temps
h_reel=exp(alpha*t);