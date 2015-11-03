% ADSL project

warning('off','comm:obsolete:qaskdeco')
!
%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

nombre_canaux=25; % Nombre de canaux pour la simulation
prefixe_cyclique=4; % Taille du pr�fixe cyclique
h=[1] % r�ponse impulsionnelle du canal

%%%%%%%%%%%%%%%%%%
% Fonctionnement %
%%%%%%%%%%%%%%%%%%
 
% Analyse de la ligne et tab
%[h_iden,h_iden_mod,bruit_iden_carre,SNR]=eval_ligne(nombre_canaux,h,prefixe_cyclique,l); 
% Analyse de la ligne: identification de la fonction de transfert de la ligne (1 coeft par canal), 
% la puissance du bruit (1 valeur par canal), le SNR sur chaque canal

%tab=repartition_bits(nombre_canaux,h_iden_carre,bruit_iden_carre) % cr�ation de la TAB


% Cr�ation de la suite de symboles � transmettre
%suite_bits_in=generation_bits(sum(tab),0.5) % cr�ation de la suite des bits � transmettre
%suite_symb=generation_symb(suite_bits_in,tab); 
% Cr�ation des symboles complexes � transmettre sur chaque porteuse

% Modulation/transmission/d�modulation
signal_module=modulationDMT(suite_symboles_in,nombre_canaux,prefixe_cyclique); 
% Modulation DMT (IFFT, mise en s�rie, ajout du CP)
signal_recu=canal(signal_module,h); 
% Transmission sur le canal
[suite_bits_out,signal_demodule]=demodulationDMT(signal_recu,h_eval_mod,nombre_canaux,prefixe_cyclique,tab); 
% d�modulation DMT (suppression du CP, FFT, �galisation,mise en s�rie)
 
% analyse des donn�es re�ues
suite_bits_out % Suite de bits re�us
erreurs=sum(xor(suite_bits_in,suite_bits_out)) % nombre d?erreur


