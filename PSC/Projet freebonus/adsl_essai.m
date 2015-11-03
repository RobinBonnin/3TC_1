% Exemple de cycle �mission/r�ception.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

nb_canaux=25; % Le nombre de canaux qu'on utilisera pour la simulation
pref_cycl=4; % Taille du pr�fixe cyclique (>=1)
trace=1; % trace = 1 si on veut afficher les trac�s, trace = 0 sinon
h_reel=simu_ligne(nb_canaux,pref_cycl); % R�ponse impulsionnelle r�elle du canal (en temps)

% Choix du type de canal
choice=input('1.Canal id�al\n  2.Canal de longueur pref_cycl+1\n  3.Canal plus long\n');
if choice==1 h=[1]; % Canal parfait
elseif choice==2 h=h_reel(1:pref_cycl+1); % Cas limite ISI
else h=h_reel; % Apparition des ISI
end


%%%%%%%%%
% Cycle %
%%%%%%%%%

% Evaluation de la ligne et allocation des bits
[H_eval,H_eval_abs,bruit_eval_abs,SNR]=eval_canaux(nb_canaux,h,pref_cycl); % Evaluation de la ligne
vect_alloc=repart_bits(nb_canaux,H_eval_abs,bruit_eval_abs) % Cr�ation du vecteur d'allocation

% Cr�ation de la suite de symboles � transmettre
suite_bits_in=gene_bits(sum(vect_alloc),0.5) % Cr�ation de la suite de bits � transmettre
suite_symb=gene_symb(suite_bits_in,vect_alloc); % Cr�ation des coordonn�es complexes des symboles

% Ex�cution du cycle modulation/transmission/d�modulation
x_mod=modDMT(suite_symb,nb_canaux,pref_cycl); % Modulation DMT (parall�lisation, IFFT, s�rialisation et ajout du PC)
x_mod_trans=simu_canal(x_mod,h); % Transmission
[suite_bits_out,x_demod]=demodDMT_egal(x_mod_trans,H_eval,nb_canaux,pref_cycl,vect_alloc); % D�modulation DMT (suppression du PC, parall�lisation, FFT, �galisation et s�rialisation)

% Evaluation des donn�es re�ues
suite_bits_out % Suite de bits d�modul�e
erreurs=sum(xor(suite_bits_in,suite_bits_out)) % Renvoie le nombre d'erreurs


%%%%%%%%%%
% Trac�s %
%%%%%%%%%%

if trace

% Trac� de la r�ponse impulsionnelle du canal
figure,freqz(h)
title('R�ponse impulsionnelle du canal de transmission');


% V�rification de l'estim�e de H


% Trac� de la r�partition des bits
figure,bar(vect_alloc,'w');
title('Allocation des bits');
xlabel('Canal');
ylabel('Bits/canal');


% Trac� de la r�partition des bits en fonction du SNR
figure,subplot(2,1,1),plot(log10(SNR))
title('SNR');
xlabel('Canal');
ylabel('dB');
subplot(2,1,2),bar(vect_alloc,'w');
title('Allocation des bits');
xlabel('Canal');
ylabel('Bits/canal');
axis([0 25.5 0 9])


% Comparaison signal modul�/signal d�modul�
figure,subplot(2,1,1),stem(real(suite_symb))
title('Comparaison signal entrant/signal d�modul�');
ylabel('Partie r�elle');
xlabel('Canaux');
subplot(2,1,2),stem(real(x_demod))
ylabel('Partie r�elle');
xlabel('Canaux');

figure,subplot(2,1,1),stem(imag(suite_symb))
title('Comparaison signal entrant/signal d�modul�');
ylabel('Partie imaginaire');
xlabel('Canaux');
subplot(2,1,2),stem(imag(x_demod))
ylabel('Partie imaginaire');
xlabel('Canaux');

end