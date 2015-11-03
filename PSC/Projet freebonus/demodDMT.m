function [suite_bits,x]=demodDMT(x_recep,nb_canaux,pref_cycl,vect_alloc)

% La fonction demodDMT r�alise la d�modulation du signal re�u x_recep.
% Elle renvoie la suite de bits d�modul�e, ainsi que les coordonn�es
% complexes des symboles d�modul�s (n�cessaire pour l'�valuation des
% canaux).
% Les �tapes : suppression du pr�fixe cyclique, parall�lisation, FFT et
% s�rialisation.

% x_recep est le vecteur re�u apr�s transmission.
% nb_canaux est le nombre de canaux utilis�s.
% pref_cycl est la longueur du prefixe cyclique.
% vect_alloc est le vecteur d'allocation des bits sur les sous-canaux.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

N=nb_canaux; % Nombre de canaux
v=pref_cycl; % Longueur du pr�fixe cyclique


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suppression du pr�fixe cyclique %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_recep=x_recep(v+1:2*N+v); % On r�cup�re le symbole DMT sans le pr�fixe


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Egalisation du signal apr�s transmission et FFT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_corr=fft(x_recep); % On applique la FFT au signal
x=x_corr(1:N); % On supprime les coordonn�es conjugu�es introduites avant IFFT � la modulation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction des symboles et d�modulation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On retrouve le num�ro du symbole en fonction de ses coordonn�es
symb=[]; % Contiendra les symboles sous forme d�cimale
for i=1:N
    symb(i)=demapQAM(real(x(i)),imag(x(i)),2^(vect_alloc(i)));
end

% On reconstitue la suite de bits
suite_bits=[]; % Contiendra la suite de bits en sortie
for j=1:N
    suite_bits=[suite_bits deco_symb(symb(j),2^(vect_alloc(j)))]; % On reconstitue la suite de bits
end