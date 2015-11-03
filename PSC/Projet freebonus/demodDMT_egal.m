function [suite_bits,x]=demodDMT(x_recep,h_eval,nb_canaux,pref_cycl,vect_alloc)

% La fonction demodDMT_egal r�alise la d�modulation et l'�galisation du
% signal re�u x_recep � partir de l'�valuation de la r�ponse impulsionnelle
% du canal effectu�e auparavant.
% Elle renvoie la suite de bits d�modul�e, ainsi que les coordonn�es
% complexes des symboles d�modul�s (n�cessaire pour l'�valuation des
% canaux).
% Les �tapes : suppression du pr�fixe cyclique, parall�lisation, FFT, �galisation 
% et s�rialisation.

% x_recep est le signal re�u apr�s transmission.
% h_eval est l'�valuation de la r�ponse impulsionnelle du canal.
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT et �galisation du signal % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_corr=fft(x_recep); % On applique la FFT
%x_corr=x_corr./fft(h_eval,2*N); % Egalisation (cas h_eval en temps)

x=x_corr(1:N); % On supprime les coordonn�es conjugu�es introduites avant IFFT � la modulation
x=x./h_eval; % Egalisation (cas h_eval en fr�quence)


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