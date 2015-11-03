function [H_moy,H_moy_abs,noise_moy_abs,SNR]=eval_canaux(nb_canaux,h_reel,pref_cycl)

% La fonction eval_cabaux réalise une estimation unique des canaux en calculant
% leur SNR(RSB) pour connaitre la qualité des canaux.
% Les étapes : calcul des estimations des coefficients des fonctions de transfert
% et du bruit dans chaque canal.

% nb_canaux est le nombre de canaux utilisés.
% h_reel est la réponse impulsionnelle réelle du canal de transmission.
% pref_cycl est la longueur du prefixe cyclique.


%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%

SNR=[]; % Vecteur qui contiendra la valeur du RSB des canaux     
H=zeros(1,nb_canaux); % Contiendra les réponses fréquentielles temporaires des canaux
H_moy=[]; % Vecteur comportant à l'indice k la valeur du coefficient de la fonction de transfert du k-ème canal 
noise=zeros(1,nb_canaux); % Contiendra les valeurs du bruit temporaires sur les canaux
noise_moy=[]; % Vecteur comportant à l'indice k la valeur du bruit sur le k-ème canal


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Construction de la trame d'initialisation %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vect_alloc=2*ones(1,nb_canaux); % On utilise des symboles d'une constellation 4-QAM pour l'initialisation...
suite_bits=gene_bits(2*nb_canaux,0.5); % ...donc on va tester avec une suite de 2*N bits
suite_symb=gene_symb(suite_bits,vect_alloc); % Voilà les coordonnées des symboles


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul des vecteurs estimateurs des coefficients et des bruits des canaux %
% Initialisation avec 30 trames                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ss_k=[]; % Contiendra toutes les valeurs du symbole démodulé du k-ème canal selon les 30 trames

for k=1:nb_canaux
    
    for i=1:30
        x_mod=modDMT(suite_symb,nb_canaux,pref_cycl); % On module 
        x_mod_trans=simu_canal(x_mod,h_reel); % On ajoute l'effet de la transmission par le canal
        [sb,ss]=demodDMT(x_mod_trans,nb_canaux,pref_cycl,vect_alloc); % On démodule
        ss_k(i)=ss(k); % On remplit le vecteur par les différentes valeurs du symbole du k-ème canal
        H(k)=H(k)+ss(k)/suite_symb(k); % On somme les coefficients trouvés au fil des trames
    end
    H_moy(k)=H(k)/30; % L'estimation du coefficient du k-ème canal
    
    for j=1:30
        noise(k)=noise(k)+ss_k(j)-suite_symb(k)*H_moy(k); % On somme les différents bruits trouvés au fil des trames
    end
    noise_moy(k)=noise(k)/30; % L'estimation du bruit dans le k-ème canal
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Construction du vecteur SNR %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H_moy_abs=(abs(H_moy)).^2; % Calcul du module au carré de h_moy : |h_moy|²
suite_symb_abs=(abs(suite_symb)).^2; % Vecteur des puissances des symboles en entrée 
noise_moy_abs=(abs(noise_moy)).^2; % Vecteur des puissances des bruits des canaux 

for i=1:nb_canaux
    SNR(i)=suite_symb_abs(i)*H_moy_abs(i)/noise_moy_abs(i);
end