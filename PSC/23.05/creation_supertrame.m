
 % N = nombre de bits par trames
 % suite_bits = génération aléaoire des bits de données
 % Code_CRC : sortie du code CRC
 % On obtient une supertrame : matrice de 69xN
        % Elle est coupée en deux : Données rapides :
                                    %-Octet Rapide
                                    %-Données 
                                    % 64 bits de codage RS
function [supertrame, buff] = creation_supertrame(suite_bits,tab,code_CRC)

%tab = [4 5 3 6 5 8 7 8 8 3 5 4 2 6 5 4 1 2 5 8 7 5 8 8 5];
%sum(tab);
%code_CRC = [1 0 0 1 1 1 0 0];
%suite_bits = gene_bits(500, 0.5);

%%%% Création trames %%%%%
 N=sum(tab);
 k=1; 
 taillecodeRS=16;
 code_RS = gene_bits(taillecodeRS,0.5);
 supertrame = [;];
 Moit = floor(N/2)
 interm = [;]; 

  p=1;
 %for i=1:8
  %   supertrame(supertrsuiame1,i)= code_CRC(i);
 %end
 for j=1:68
     v=1;
     for i=1:8 
        supertrame(j,i)=code_CRC(i);
     end
     
  %  for i=9:(Moit-taillecodeRS)
  %      supertrame(j,i)=suite_bits(k);
  %      k=k+1;
 %   end
 %   for i=(Moit-taillecodeRS+1):Moit 
 %       supertrame(j,i)=code_RS(v);
 %       v=v+1;
 %   end
    for i=1:(Moit-taillecodeRS-8)
        datac(i) = suite_bits(p);
        p = p+1;
    end
    hey = RS_encode(datac, tab);
    for i=9:Moit
        supertrame(j,i) = hey(i-8)-48;
    end
    supertrame;
    
    %données entrelacees   
    for i=(Moit+1):(Moit+8)
        supertrame(j,i) = supertrame(j, i-Moit); 
    end
    for i=(N-taillecodeRS+1):N
        supertrame(j,i) = supertrame(j, i-Moit);
    end
    
    for i=9:(Moit-taillecodeRS)
        interm(j, i-8)=supertrame(j, i);
    end
   
 end
 
 inter = interm';
 AL = aligner_entrelace(inter, (Moit-taillecodeRS-8));
 b=1;
 for j=0:67
    for i=(Moit+9):(N-taillecodeRS)
        %supertrame(j+1,i) = AL((j*(Moit-taillecodeRS-8)) + (i-Moit-8));
        datar(i-Moit-8) = AL((j*(Moit-taillecodeRS-8)) + (i-Moit-8));
    end
    datar;
    b=b+1;
    hey2 = RS_encode(datar, tab);
    for i=(Moit+9):(N-16)
        supertrame(j+1,i) = hey2(i-8-Moit)-48;
    end
 end
 supertrame;
 b;
 k;

 for i=1:N
     supertrame(69,i)=0;
 end
 supertrame ;
 
 buff = [;];
 for i=1:68
     for j=9:(Moit-taillecodeRS)
         buff(i, j-8) = supertrame(i, j);
     end
 end
 
end
 
 
 
