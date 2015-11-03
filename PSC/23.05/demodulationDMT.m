function [suite_bits,x]=demodulationDMT(signal_recu,h_eval_mod,nombre_canaux,prefixe_cyclique,tab, nombre_trames)
 
% signal_recu signal re�u apr�s passage dans le canal
% h_eval_mod module de la r�ponse impulsionnelle du canal, identifi�e
% nombre_canaux nombre de canaux utilis�s
% prefixe_cyclique longueur du CP
% tab vecteur table allocation des bits
 

%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%
%nombre_canaux = 25;
N=nombre_canaux; % Nombre de canaux utilis�s
v = 4; % Longueur du CP

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Suppression du CP               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
taille_trame = rdivide(length(signal_recu),nombre_trames);

symboles = [];

for j = 0:(nombre_trames-1)
    signal_a_demod = signal_recu((1+(j*taille_trame)):(taille_trame + (j*taille_trame)));
    signal_sans_pref = signal_a_demod(5:taille_trame);
    x_fft = fft(signal_sans_pref);
    xt=x_fft(2:(1+N));
    xt=xt./1; %abs(fft(h_eval_mod));
    symboles = [symboles xt];
end
h_eval_mod;
x = symboles;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT et �galisation du signal % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % �galisation

M=nombre_canaux;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reconstruction des symboles et d�modulation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

symb=[]; % Contiendra les symboles sous forme d�cimale



for j=0:(nombre_trames-1)
    for i=1:M
        symb(i+(M*j)) = demodulationQAM(real(symboles(i+(nombre_canaux*j))),imag(symboles(i+(nombre_canaux*j))),2^(tab(i)));
    end
end

% suite de bits
suite_bits=[]; 

for j=0:(nombre_trames-1)
    for i=1:M
        suite_bits=[suite_bits fliplr(Decod_binaire(symb(i+(nombre_canaux*j)),tab(i)))];
    end
end
suite_bits;

