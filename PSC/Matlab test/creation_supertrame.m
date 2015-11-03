
 % N = nombre de bits par trames
 % suite_bits = génération aléaoire des bits de données
 % Code_CRC : sortie du code CRC
 % On obtient une supertrame : matrice de 69xN
        % Elle est coupée en deux : Données rapides :
                                    %-Octet Rapide
                                    %-Données 
                                    % 64 bits de codage RS
function supertrame = creation_supertrame(suite_bits,tab,code_CRC)

%%%% Création trames %%%%%
N=sum(tab);
 k=1; 
 v=1;
 taillecodeRS=64;
 code_RS = gene_bits(64,0.5);
 supertrame(69,N)=0;
  
 for i=1:8
     supertrame(1,i)= code_CRC(i);
 end
 for j=2:68
     v=1;
     for i=1:8 
         supertrame(j,i)=code_CRC(i);
     end
    for i=9:N/2-taillecodeRS
        supertrame(j,i)=suite_bits(k);
        k=k+1;
    end
    for i=floor(N/2-taillecodeRS+1):floor(N/2) 
        supertrame(j,i)=code_RS(v);
        v=v+1;
    end
 end
 
 for i=1:N
     supertrame(69,i)=0;
 end
 
