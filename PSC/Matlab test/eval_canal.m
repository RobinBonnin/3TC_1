function [H_moy,H_moy_abs, SNR]=eval_canaux(nb_canaux,h_reel,pref_cycl)

SNR=[];
H=zeros(1,nb_canaux);
noise=[1,nb_canaux];
noise_moy=[]:

% ----- Construction trame d'initialisation ------

vect_alloc=2*ones(1,nb_canaux);
suite_bits=gene_bits(2*nb_canaux,vect_alloc);

ss_k=[];

for k=1:nb_canaux
    


end

