function [h_eval, table_SNR, supertrame_essai] = eval_canal()

taille_trame_essai = 50; 
nombre_trames_essai = 30; 
supertrame_essai = [;]; 
for i=1:nombre_trames_essai
    supertrame_essai(i, 1:taille_trame_essai) = gene_bits(taille_trame_essai, 0.5);
end
supertrame_essai;

nombre_canaux = 25;
fake_table = [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
Somme = sum(fake_table);
prefixe_cyclique = 4;

%on aligne la supertrame créée

en_ligne = [];
I = taille_trame_essai; 
for i=1:30
    for j=1:I
        en_ligne(((i-1)*I)+j) = supertrame_essai(i,j);
    end
end

supertrame_en_ligne = en_ligne; 



SNR=[]; % Vecteur qui contiendra la valeur du RSB des canaux     
H=zeros(1,nombre_canaux); % Contiendra les réponses fréquentielles temporaires des canaux
H_moy=[]; % Vecteur comportant à l'indice i la valeur du coefficient de la fonction de transfert du i-ème canal 
noise=zeros(1,nombre_canaux); % Contiendra les valeurs du bruit temporaires sur les canaux
noise_moy=[]; % Vecteur comportant à l'indice i la valeur du bruit sur le i-ème canal

ss_i=[]; % Contiendra toutes les valeurs du symbole démodulé du i-ème canal selon les 30 trames


% Modulation QAM
suite_symboles_in = modulationQAM(supertrame_en_ligne, fake_table, nombre_canaux, 30);
% Modulation DMT (IFFT, mise en s�rie, ajout du CP)
signal_module = modulationDMT(suite_symboles_in,nombre_canaux,prefixe_cyclique, fake_table, Somme, 30); 
% Transmission sur le canal
signal_recu = canal(signal_module, nombre_canaux,0);
HHHH = length(signal_recu);




% d�modulation DMT (suppression du CP, FFT, �galisation,mise en s�rie)
[suite_bits_out,signal_demodule]=demodulationDMT(signal_recu, 1, nombre_canaux, prefixe_cyclique,fake_table, 30);


for i=1:nombre_canaux
   for j=0:29
        ss_i(j+1)=fft(signal_demodule(i+(j*nombre_canaux))); % On remplit le vecteur par les différentes valeurs du symbole du i-ème canal
        H(i)=H(i)+fft(signal_demodule(i))/fft(suite_symboles_in(i)); % On somme les coefficients trouvés au fil des trames
    end
    H_moy(i)=H(i)/nombre_trames_essai; % L'estimation du coefficient du i-ème canal
    
    for j=1:30
        noise(i)=noise(i)+ss_i(j)-fft(suite_symboles_in(i))*H_moy(i); % On somme les différents bruits trouvés au fil des trames
    end
    noise_moy(i)=noise(i)/30; % L'estimation du bruit dans le i-ème canal
end
figure(1);
h_eval = ifft(abs(H_moy));

heval = [];
for i=1:10
    heval(i) = h_eval(i+15);
end
for i=11:25
    heval(i)=h_eval(i-10);
end
h_eval = heval;

figure(8);
plot(abs(h_eval));

figure(9); 
plot(abs(H_moy));

H_moy_abs=(abs(H_moy)).^2; % Calcul du module au carré de h_moy : |h_moy|²
suite_symb_abs=(abs(suite_symboles_in)).^2; % Vecteur des puissances des symboles en entrée 
noise_moy_abs=(abs(noise_moy)).^2; % Vecteur des puissances des bruits des canaux 

for i=1:nombre_canaux
    table_SNR(i)=suite_symb_abs(i)*H_moy_abs(i)/noise_moy_abs(i);
end
table_SNR;
figure(3);
plot(table_SNR);
end
