function [suite_bits,x]=demodDMT(x_recep,nb_canaux,pref_cycl,vect_alloc)

% La fonction demodDMT réalise la démodulation du signal reçu x_recep.
% Elle renvoie la suite de bits démodulée, ainsi que les coordonnées
% complexes des symboles démodulés (nécessaire pour l'évaluation des
% canaux).
% Les étapes : suppression du préfixe cyclique, parallélisation, FFT et
% sérialisation.

% x_recep est le vecteur reçu après transmission.
% nb_canaux est le nombre de canaux utilisés.
% pref_cycl est la longueur du prefixe cyclique.
% vect_alloc est le vecteur d'allocation des bits sur les sous-canaux.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

N=nb_canaux; % Nombre de canaux
v=pref_cycl; % Longueur du préfixe cyclique


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suppression du préfixe cyclique %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_recep=x_recep(v+1:2*N+v); % On récupère le symbole DMT sans le préfixe


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Egalisation du signal après transmission et FFT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_corr=fft(x_recep); % On applique la FFT au signal
x=x_corr(1:N); % On supprime les coordonnées conjuguées introduites avant IFFT à la modulation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction des symboles et démodulation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On retrouve le numéro du symbole en fonction de ses coordonnées
symb=[]; % Contiendra les symboles sous forme décimale
for i=1:N
    symb(i)=demapQAM(real(x(i)),imag(x(i)),2^(vect_alloc(i)));
end

% On reconstitue la suite de bits
suite_bits=[]; % Contiendra la suite de bits en sortie
for j=1:N
    suite_bits=[suite_bits deco_symb(symb(j),2^(vect_alloc(j)))]; % On reconstitue la suite de bits
end