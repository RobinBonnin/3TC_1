
% ADSL project

warning('off','comm:obsolete:qaskdeco')

close all
clear all 



%%%%%%%%%%%%%%%%%%
% Initialisation %
%%%%%%%%%%%%%%%%%%


nombre_canaux = 25;
prefixe_cyclique = 4;


%evalation du canal et création de la table
[h_eval, table_SNR, supertrame_essai] = eval_canal();
tableau_allocations = table_allocation_dynamique(table_SNR, nombre_canaux);
tableau_allocation = octets(tableau_allocations);
Moit=sum(tableau_allocation)/2;

%génération aléatoire de données
suite_bits = gene_bits(10000, 0.5);

%codage CRC
code_CRC = codeurCRC(suite_bits,tableau_allocation);

%création de la supertrame
Somme = sum(tableau_allocation);
[supertrame, numero1] = creation_supertrame(suite_bits,tableau_allocation,code_CRC);
supertrame_en_ligne = aligner_supertrame(supertrame, tableau_allocation);
numero1;



%%%%%%%%%%%%%%%%%%
% Fonctionnement %
%%%%%%%%%%%%%%%%%%


% Modulation QAM
suite_symboles_in = modulationQAM(supertrame_en_ligne, tableau_allocation, nombre_canaux, 68);

% Modulation DMT (IFFT, mise en série, ajout du préfixe cyclique)
signal_module = modulationDMT(suite_symboles_in,nombre_canaux,prefixe_cyclique, tableau_allocation, Somme, 68); 

% Transmission sur le canal
signal_recu=signal_module; %canal(signal_module, nombre_canaux, h_eval);

%ajout du bruit
signal_vraiment_recu = testbruit(signal_recu);
 buff = [;];
 for i=1:68
     for j=9:(Moit-16)
         buff(i, j-8) = supertrame(i, j);
     end
 end

%démodulation DMT (suppression du CP, FFT, égalisation,mise en série)
[suite_bits_corrigee,signal_demodule]=demodulationDMT(signal_vraiment_recu, h_eval, nombre_canaux, prefixe_cyclique,tableau_allocation, 68);
 
%décodage RS
suite_bits_out = suite_bits_corrigee; %execut_decode_rs(suite_bits_corrigee, tableau_allocation);


%décodage CRC
%[crc_decode] = decode_crc(suite_bits_out)


%extraction des données

%[don1;don2] = extraction(suite_bits_out)
 bouff = [;];
 for i=1:68
     for j=(Moit+9):(2*Moit-16)
         bouff(i, j-8-Moit) = suite_bits_out((i-1)*(2*Moit)+j)-48;
     end
 end
 bouff;
bouff2 = [;];
 for i=1:68
     for j=(9):(Moit-16)
         bouff2(i, j-8) = suite_bits_out((i-1)*(2*Moit)+j)-48;
     end
 end
 bouff2;
 
 

%calcul des erreurs 
nombre_erreurs_donnees = [;];
for i=1:68
    for j=1:(Moit-24)
        nombre_erreurs_donnees(i,j) = abs(numero1(i,j) - bouff2(i,j));
    end
end
nombre_erreurs_donnees;
tix = sum(nombre_erreurs_donnees)/68;
sum(tix)*100/24

erreurs = [];
nombre_erreurs = 0;
for j=1:length(supertrame_en_ligne)
    erreurs(j) = abs(abs(48-suite_bits_out(j))-supertrame_en_ligne(j));
    nombre_erreurs = nombre_erreurs + erreurs(j);
end


nombre_erreurs_reel = nombre_erreurs;
pourcentage_erreurs = nombre_erreurs/(length(supertrame_en_ligne));
pourcentage_erreurs_reel = 100*pourcentage_erreurs;


